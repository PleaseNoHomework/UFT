extends Node

enum mapchangestatus {
	default,
	fadeout,
	mapchange,
	fadein
}


var mapstatus = mapchangestatus.default

var nextscene : String
