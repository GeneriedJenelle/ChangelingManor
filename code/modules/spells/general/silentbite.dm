/spell/silentbite
	name = "Sleight of teeth"
	desc = "Allows you to drain blood quietly with a special maneuver, at the cost of a lower drain speed. Scrape, and lick."
	abbreviation = "ST"

	school = "vampire"
	user_type = USER_TYPE_VAMPIRE

	charge_type = Sp_RECHARGE
	charge_max = 1 SECONDS
	invocation_type = SpI_NONE
	range = 0
	spell_flags = STATALLOWED | NEEDSHUMAN
	cooldown_min = 1 SECONDS

	override_base = "vamp"
	hud_state = "vampire_cloak"

	var/blood_cost = 0

/spell/silentbite/cast_check(var/skipcharge = 0, var/mob/user = usr)
	. = ..()
	if (!.) // No need to go further.
		return FALSE
	if (!user.vampire_power(blood_cost, UNCONSCIOUS))
		return FALSE
	if (!isvampire(user))
		return FALSE

/spell/silentbite/choose_targets(var/mob/user = usr)
	return list(user) // Self-cast

/spell/silentbite/cast(var/list/targets, var/mob/user)
	var/datum/role/vampire/V = user.mind.GetRole(VAMPIRE)
	V.silentbite = !V.silentbite
	to_chat(user, "<span class='notice'>You will now bite people's necks [V.silentbite ? "silently" : "normally"].</span>")
