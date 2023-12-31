//  Tiny babby plant critter plus procs.
//Holders have been moved to code/modules/mob/living/holders.dm

//Mob defines.
/mob/living/carbon/monkey/diona
	name = "diona nymph"
	voice_name = "diona nymph"
	speak_emote = list("chirrups")
	icon_state = "nymph1"
	meat_amount = 1
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/nymphmeat
	species_type = /mob/living/carbon/monkey/diona
	holder_type = /obj/item/weapon/holder/diona
	var/list/donors = list()
	var/ready_evolve = FALSE
	canWearHats = TRUE
	canWearClothes = FALSE
	canWearGlasses = FALSE
	burn_damage_modifier = 2.5 //TREEEEEES
	languagetoadd = LANGUAGE_ROOTSPEAK
	flag = NO_BREATHE
	canPossess = TRUE

/mob/living/carbon/monkey/diona/attack_hand(mob/living/carbon/human/M as mob)
	//Let people pick the little buggers up.
	if((M.a_intent == I_HELP) && !(locked_to) && (isturf(src.loc)) && (M.get_active_hand() == null)) //Unless their location isn't a turf!
		scoop_up(M)
	..()

/mob/living/carbon/monkey/diona/New()
	..()
	setGender(NEUTER)
	dna.mutantrace = "plant"
	greaterform = "Diona"
	alien = TRUE

//Verbs after this point.

/mob/living/carbon/monkey/diona/verb/fertilize_plant()
	set category = "Diona"
	set name = "Fertilize plant"
	set desc = "Turn your food into nutrients for plants."

	var/list/trays = list()
	for(var/obj/machinery/portable_atmospherics/hydroponics/tray in range(1))
		if(tray.get_nutrientlevel() < 100)
			trays += tray
	if(length(trays))
		var/obj/machinery/portable_atmospherics/hydroponics/target = pick(trays)
		//these values don't matter really
		nutrition -= 25
		target.add_nutrientlevel(100)
		visible_message("<span class='warning'>[src] secretes a trickle of green liquid from its tail, refilling [target]'s nutrient tray.</span>","<span class='warning'>You secrete a trickle of green liquid from your tail, refilling [target]'s nutrient tray.</span>")
	else
		to_chat(src, "<span class='notice'>No plants require ferilization.</span>")

/mob/living/carbon/monkey/diona/verb/eat_weeds()
	set category = "Diona"
	set name = "Eat Weeds"
	set desc = "Clean the weeds out of soil or a hydroponics tray."

	var/list/trays = list()
	for(var/obj/machinery/portable_atmospherics/hydroponics/tray in range(1))
		if(tray.get_weedlevel() > 0)
			trays += tray
	if(length(trays))
		var/obj/machinery/portable_atmospherics/hydroponics/target = pick(trays)
		target.add_weedlevel(-50)
		visible_message("<span class='warning'>[src] begins rooting through [target], ripping out weeds and eating them noisily.</span>","<span class='warning'>You begin rooting through [target], ripping out weeds and eating them noisily.</span>")
	else
		to_chat(src, "<span class='notice'>No trays contain weeds.</span>")

/mob/living/carbon/monkey/diona/verb/evolve()
	set category = "Diona"
	set name = "Evolve"
	set desc = "Grow to a more complex form."

	if(stat == DEAD)
		to_chat(src, "You cannot evolve if you are dead!")
		return

	if(donors.len < 5)
		to_chat(src, "You are not yet ready for your growth...")
		return

	if(nutrition < 400)
		to_chat(src, "You have not yet consumed enough to grow...")
		return

	visible_message("<span class='warning'>[src] begins to shift and quiver, and erupts in a shower of shed bark and twigs!</span>","<span class='warning'>You begin to shift and quiver, then erupt in a shower of shed bark and twigs, attaining your adult form!</span>")

	var/mob/living/carbon/human/adult = new(get_turf(src.loc))
	adult.set_species("Diona")

	transferImplantsTo(adult)
	transferBorers(adult)

	if(istype(loc,/obj/item/weapon/holder/diona))
		var/obj/item/weapon/holder/diona/L = loc
		forceMove(get_turf(L))
		L = null
		qdel(L)

	for(var/datum/language/L in languages)
		adult.add_language(L.name)

	adult.regenerate_icons()
	mind.transfer_to(adult)
	adult.fully_replace_character_name(newname = src.real_name)
	drop_all()
	qdel(src)

/mob/living/carbon/monkey/diona/say_understands(var/mob/other,var/datum/language/speaking = null)
	if(other)
		other = other.GetSource()
	if (istype(other, /mob/living/carbon/human))
		if(speaking && speaking.name == LANGUAGE_GALACTIC_COMMON)
			if(donors.len >= 2) // They have sucked down some blood.
				return TRUE
	return ..()

/mob/living/carbon/monkey/diona/can_read()
	if(donors.len >= 2) // They have sucked down some blood.
		return TRUE
	return ..()

/mob/living/carbon/monkey/diona/verb/steal_blood()
	set category = "Diona"
	set name = "Take Blood Sample"
	set desc = "Take a blood sample from a suitable donor to help understand those around you and evolve."

	var/list/choices = list()
	for(var/mob/living/carbon/human/C in view(1,src))
		if(C.real_name != real_name)
			choices += C

	var/mob/living/M = input(src,"Who do you wish to take a sample from?") in null|choices

	if(!M || !src)
		return
	if(!Adjacent(M))
		return
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.species && H.species.anatomy_flags & NO_BLOOD)
			to_chat(src, "<span class='warning'>That donor has no blood!</span>")
			return
	if(donors.Find(M.real_name))
		to_chat(src, "<span class='warning'>That donor offers you nothing new.</span>")
		return

	src.visible_message("<span class='warning'>[src] flicks out a feeler and neatly steals a sample of [M]'s blood.</span>","<span class='warning'>You flick out a feeler and neatly steal a sample of [M]'s blood.</span>")
	donors += M.real_name
	var/progress = donors.len //Get value here so it isn't changed from under us
	spawn(25)
		update_progression(progress)

/mob/living/carbon/monkey/diona/proc/update_progression(var/progress)

	switch(progress) //Stop them from skipping levels
		if(5)
			ready_evolve = TRUE
			to_chat(src, "<span class='good'>You feel ready to move on to your next stage of growth.</span>")
		if(4)
			to_chat(src, "<span class='good'>You feel your vocal range expand, and realize you know how to speak with the creatures around you.</span>")
			add_language(LANGUAGE_GALACTIC_COMMON)
			default_language = all_languages[LANGUAGE_GALACTIC_COMMON]
		if(3)
			to_chat(src, "<span class='good'>More blood seeps into you, continuing to expand your growing collection of memories.</span>")
		if(2)
			to_chat(src, "<span class='good'>You feel your awareness expand, and realize you know how to understand the creatures around you.</span>")
			//say_understands() effectively lets us understand common language at this point
		if(1)
			to_chat(src, "<span class='good'>The blood seeps into your small form, and you draw out the echoes of memories and personality from it, working them into your budding mind.</span>")

/mob/living/carbon/monkey/diona/dexterity_check()
	return FALSE

/mob/living/carbon/monkey/diona/update_icons()
	update_hud()
	lying_prev = lying	//so we don't update overlays for lying/standing unless our stance changes again
	overlays.Cut()
	var/matrix/M = matrix()
	for(var/image/I in overlays_standing)
		overlays += I

	if(stat == DEAD)
		icon_state = "[initial(icon_state)]_dead"
		transform = M
	else if(resting)
		icon_state = "[initial(icon_state)]_sleep"
	else if(lying || stunned)
		icon_state = "[initial(icon_state)]_sleep"
		M.Turn(90)
		M.Translate(1,-6)
		transform = M
	else
		icon_state = "[initial(icon_state)]"
		transform = M

/mob/living/carbon/monkey/diona/death(gibbed)
	..()
	for (var/obj/item/I in get_all_slots())
		drop_from_inventory(I) // Floating hat, mask and bag looks silly as fuck
