#ifndef MAP_OVERRIDE
//**************************************************************
// Map Datum -- Metaclub
//**************************************************************

/datum/map/active
	nameShort = "meta"
	nameLong = "Meta Club"
	map_dir = "metaclub"
	zLevels = list(
		/datum/zLevel/station,
		/datum/zLevel/centcomm,
		/datum/zLevel/space{
			name = "spaceOldSat" ;
			},
		/datum/zLevel/space{
			name = "derelict" ;
			},
		/datum/zLevel/mining,
		/datum/zLevel/space{
			name = "spaceEmpty1" ;
			}
		)

	enabled_jobs = list(/datum/job/trader)

	load_map_elements = list(
	/datum/map_element/dungeon/holodeck
	)

/datum/map/active/New()
	. = ..()
	security_shuttle.req_access = list(access_sec_doors)

// Metaclub areas
/area/science/xenobiology/specimen_7
	name = "\improper Xenobiology Specimen Cage 7"
	icon_state = "xenocell7"

/datum/shuttle/trade/initialize()
	.=..()
	add_dock(/obj/docking_port/destination/trade/start)
	add_dock(/obj/docking_port/destination/trade/station)
	add_dock(/obj/docking_port/destination/trade/extra)

////////////////////////////////////////////////////////////////
#include "metaclub.dmm"
#endif
