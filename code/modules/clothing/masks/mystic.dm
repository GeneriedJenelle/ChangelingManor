/obj/item/clothing/mask/happy
	name = "Happiest Mask"
	desc = "<span class=warning>\"I'm happy! I'M HAPPY! SEE! I SAID I'M HAPPY PLEASE DON'T\"<span>"
	icon_state = "happiest"
	item_state = "happiest"
	species_fit = list(INSECT_SHAPED)
	clothing_flags = MASKINTERNALS
	body_parts_covered = FACE
	w_class = W_CLASS_SMALL
	siemens_coefficient = 3.0
	gas_transfer_coefficient = 0.90

/obj/item/clothing/mask/happy/equipped(M as mob, wear_mask)
	var/mob/living/carbon/human/H = M
	if(!istype(H))
		return
	if(H.wear_mask == src)
		flick("happiest_flash", src)
		to_chat(H, "<span class='sinister'>Your thoughts are bombarded by incessant laughter.</span>")
		H << sound('sound/effects/hellclown.ogg')
		canremove = 0

/obj/item/clothing/mask/happy/attack_hand(mob/user as mob)
	if(user.wear_mask == src)
		to_chat(user, "<span class='sinister'>It won't come off.</span>")
		flick("happiest_flash", src)
	else
		..()

/obj/item/clothing/mask/happy/pickup(mob/user as mob)
	flick("happiest_flash", src)
	to_chat(user, "<span class=warning><B>The mask's eyesockets briefly flash with a foreboding red glare.</span></B>")

/obj/item/clothing/mask/happy/OnMobLife(var/mob/living/carbon/human/wearer)
	var/mob/living/carbon/human/W = wearer
	if(W.wear_mask == src)
		RaiseShade(W)
		if(prob(5))
			switch(pick(1,2,3))
				if(1)
					W.say(pick("I'M SO HAPPY!", "SMILE!", "ISN'T EVERYTHING SO WONDERFUL?", "EVERYONE SHOULD SMILE!"))
				if(2)
					var/list/laughtypes = list("funny", "disturbing", "creepy", "horrid", "bloodcurdling", "freaky", "scary", "childish", "deranged", "airy", "snorting")
					var/laughtype = pick(laughtypes)
					W.visible_message("[W] makes \a [laughtype] laugh.")
				if(3)
					W.emote(pick("laugh", "chuckle", "giggle", "grin", "smile"))

/obj/item/clothing/mask/happy/OnMobDeath(var/mob/living/carbon/human/wearer)
	var/mob/living/carbon/human/W = wearer
	W.visible_message("<span class=warning>The mask lets go of [W]'s corpse.</span>")
	W.drop_from_inventory(src)
	flick("happiest_flash", src)
	canremove = 1

var/list/has_been_shade = list()

/obj/item/clothing/mask/happy/proc/RaiseShade(var/mob/living/carbon/human/H)
	for(var/mob/living/carbon/human/M in view(4, H))
		if(!M)
			return
		if(M.stat != 2)
			continue
		if(M.client == null)
			continue
		if(!M.mind)
			continue
		if(M.mind in has_been_shade)
			continue
		flick("happiest_flash", src)
		has_been_shade.Add(M.mind)
		var/mob/dead/observer/G = M.ghostize(1)
		var/mob/living/simple_animal/shade/noncult/happiest/S = G.transmogrify(/mob/living/simple_animal/shade/noncult/happiest, TRUE)
		S.name = "[M.real_name] the Shade"
		S.real_name = "[M.real_name]"
		S.cancel_camera()
		flick("happiest_flash", src)
		to_chat(H, "<span class='sinister'>Oh joy! [M.real_name]'s decided to join the party!</span>")
		to_chat(S, "<span class='sinister'>You have been given form by the power of the happiest mask! Go forth and carry out [H.real_name]'s bidding with joy!</span>")

/obj/item/clothing/mask/happy/dissolvable()
	return 0
