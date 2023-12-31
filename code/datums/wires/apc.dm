/datum/wires/apc
	holder_type = /obj/machinery/power/apc
	wire_count = 4

/datum/wires/apc/New()
	wire_names=list(
		"[APC_WIRE_IDSCAN]" 		= "ID scan",
		"[APC_WIRE_MAIN_POWER1]" 	= "Power 1",
		"[APC_WIRE_MAIN_POWER2]" 	= "Power 2",
		"[APC_WIRE_AI_CONTROL]" 	= "AI Control"
	)
	..()

var/const/APC_WIRE_IDSCAN = 1
var/const/APC_WIRE_MAIN_POWER1 = 2
var/const/APC_WIRE_MAIN_POWER2 = 4
var/const/APC_WIRE_AI_CONTROL = 8

/datum/wires/apc/GetInteractWindow()
	var/obj/machinery/power/apc/A = holder
	. += ..()
	. += text("<br>\n[(A.locked ? "The APC is locked." : "The APC is unlocked.")]<br>\n[(A.shorted ? "The APCs power has been shorted." : "The APC is working properly!")]<br>\n[(A.stat & NOAICONTROL ? "The 'AI control allowed' light is off." : "The 'AI control allowed' light is on.")]")


/datum/wires/apc/CanUse(var/mob/living/L)
	if(!..())
		return 0
	var/obj/machinery/power/apc/A = holder
	if(A.wiresexposed)
		return 1
	return 0

/datum/wires/apc/UpdatePulsed(var/index)
	..()
	var/obj/machinery/power/apc/A = holder

	switch(index)

		if(APC_WIRE_IDSCAN)
			if(A.emagged)
				return
			A.locked = 0

			spawn(300)
				if(A)
					A.locked = 1
					A.updateDialog()

		if (APC_WIRE_MAIN_POWER1, APC_WIRE_MAIN_POWER2)
			if(A.shorted == 0)
				A.shorted = 1

				spawn(1200)
					if(A && !IsIndexCut(APC_WIRE_MAIN_POWER1) && !IsIndexCut(APC_WIRE_MAIN_POWER2))
						A.shorted = 0
						A.updateDialog()

		if (APC_WIRE_AI_CONTROL)
			A.disable_AI_control(disrupt = FALSE)

			spawn(10)
				if(A && !IsIndexCut(APC_WIRE_AI_CONTROL))
					A.enable_AI_control()

	A.updateDialog()

/datum/wires/apc/UpdateCut(var/index, var/mended, var/mob/user)
	var/obj/machinery/power/apc/A = holder
	..()
	var/obj/I = user.get_active_hand()
	switch(index)
		if(APC_WIRE_MAIN_POWER1, APC_WIRE_MAIN_POWER2)

			if(!mended)
				A.shock(user, 50,get_conductivity(I))
				A.shorted = 1

			else if(!IsIndexCut(APC_WIRE_MAIN_POWER1) && !IsIndexCut(APC_WIRE_MAIN_POWER2))
				A.shorted = 0
				A.shock(user, 50,get_conductivity(I))

		if(APC_WIRE_AI_CONTROL)

			mended ? A.enable_AI_control() : A.disable_AI_control()

	A.updateDialog()
