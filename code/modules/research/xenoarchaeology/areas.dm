
/area/research_outpost
	name = "Research Outpost"
	icon_state = "anomaly"

	general_area = /area/research_outpost
	general_area_name = "Research Outpost"

	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	shuttle_can_crush = FALSE

/area/research_outpost/hallway
	name = "Research Outpost Hallway"
	icon_state = "hallC"

/area/research_outpost/gearstore
	name = "Expedition Preparation"
	icon_state = "anog"

/area/research_outpost/power
	name = "Research Outpost Power"
	icon_state = "engine"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	ambient_sounds = list(/datum/ambience/engi1,/datum/ambience/engi2,/datum/ambience/engi3,/datum/ambience/engi4)

/area/research_outpost/atmos
	name = "Research Outpost Atmospherics"
	icon_state = "atmos"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	ambient_sounds = list(/datum/ambience/engi1,/datum/ambience/engi2,/datum/ambience/engi3,/datum/ambience/engi4)

/area/research_outpost/maint
	name = "Research Outpost Maintenance"
	icon_state = "maintcentral"
	ambient_sounds = list(
		/datum/ambience/maint1,
		/datum/ambience/maint2)

/area/research_outpost/iso1
	name = "Isolation Cell"
	icon_state = "iso1"

/area/research_outpost/iso2
	name = "Isolation Cell"
	icon_state = "iso2"

/area/research_outpost/iso3
	name = "Isolation Cell"
	icon_state = "iso3"

/area/research_outpost/harvesting
	name = "Exotic Particles Collection"
	icon_state = "anolab"

/area/research_outpost/sample
	name = "Sample Preparation Room"
	icon_state = "anosample"

/area/research_outpost/spectro
	name = "Mass Spectrometry Lab"
	icon_state = "anospectro"
	ambient_sounds = list(
		/datum/ambience/ded2)

/area/research_outpost/anomaly
	name = "Anomalous Materials Lab"
	icon_state = "anolab"

/area/research_outpost/med
	name = "Research Outpost Medbay"
	icon_state = "medbay3"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/research_outpost/entry
	name = "Research Outpost Shuttle Dock"
	icon_state = "entry"

/area/research_outpost/longtermstorage
	name = "Long-Term Storage"
	icon_state = "primarystorage"

/area/research_outpost/tempstorage
	name = "Temporary Storage"
	icon_state = "storage"
	ambient_sounds = list(
		/datum/ambience/maint1,
		/datum/ambience/maint2)

/area/research_outpost/maintstore1
	name = "Auxiliary Storage"
	icon_state = "auxstorage"
	ambient_sounds = list(
		/datum/ambience/maint1,
		/datum/ambience/maint2)

/area/research_outpost/maintstore2
	name = "Maintenance Storage"
	icon_state = "auxstorage"
	ambient_sounds = list(
		/datum/ambience/maint1,
		/datum/ambience/maint2)

/area/research_outpost/breakroom
	name = "Break Room"
	icon_state = "outpost_breakroom"

/area/research_outpost/dorm1
	name = "Dormitory 1"
	icon_state = "outpost_dorm1"

/area/research_outpost/dorm2
	name = "Dormitory 2"
	icon_state = "outpost_dorm2"

/area/research_outpost/bathroom
	name = "Bathroom"
	icon_state = "outpost_bathroom"

/area/research_outpost/solars
	name = "Research Outpost Solar Array"
	icon_state = "outpost_solars"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/research_outpost/xenobot
	name = "Research Outpost Xenobotany"
	icon_state = "outpost_xenobot"
