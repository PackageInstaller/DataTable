-- chunkname: @modules/configs/huidiaolan/lua_huidiaolan_map_2005.lua

return {
	gameConfig = {
		moveBorn = 2,
		planeWidthCount = 7,
		mapId = 2005,
		fourMergeBorn = 3,
		targetNum = 20,
		stepNum = 99,
		planeHeightCount = 7,
		treeMergeBorn = 1
	},
	planeConfig = {
		{
			id = 1,
			posIndexList = "3#2|4#2|5#2|3#3|4#3|5#3|3#4|4#4|5#4",
			planeType = 3
		},
		{
			id = 2,
			posIndexList = "1#5|2#5|2#6|2#7|3#7",
			planeType = 2
		},
		{
			id = 3,
			posIndexList = "7#5|6#5|6#6|6#7|5#7",
			planeType = 2
		}
	},
	elementConfig = {
		{
			posIndex = "3#2",
			id = 0,
			color = 1,
			level = 1
		},
		{
			posIndex = "5#2",
			id = 1,
			color = 1,
			level = 1
		},
		{
			posIndex = "4#3",
			id = 2,
			color = 2,
			level = 1
		},
		{
			posIndex = "3#4",
			id = 3,
			color = 3,
			level = 1
		},
		{
			posIndex = "5#4",
			id = 4,
			color = 3,
			level = 1
		},
		{
			posIndex = "1#5",
			id = 5,
			color = 1,
			level = 1
		},
		{
			posIndex = "2#5",
			id = 6,
			color = 2,
			level = 1
		},
		{
			posIndex = "3#5",
			id = 7,
			color = 2,
			level = 1
		},
		{
			posIndex = "5#5",
			id = 8,
			color = 2,
			level = 1
		},
		{
			posIndex = "6#5",
			id = 9,
			color = 2,
			level = 1
		},
		{
			posIndex = "7#5",
			id = 10,
			color = 1,
			level = 1
		},
		{
			posIndex = "2#6",
			id = 11,
			color = 3,
			level = 1
		},
		{
			posIndex = "6#6",
			id = 12,
			color = 3,
			level = 1
		},
		{
			posIndex = "4#7",
			id = 13,
			color = 3,
			level = 1
		}
	}
}
