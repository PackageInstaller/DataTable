-- chunkname: @modules/configs/huidiaolan/lua_huidiaolan_map_2008.lua

return {
	gameConfig = {
		moveBorn = 2,
		planeWidthCount = 7,
		mapId = 2008,
		fourMergeBorn = 3,
		targetNum = 0,
		stepNum = 30,
		planeHeightCount = 7,
		treeMergeBorn = 2
	},
	planeConfig = {
		{
			id = 1,
			posIndexList = "1#2|2#2|3#2|1#3|2#3|3#3",
			planeType = 3
		},
		{
			id = 2,
			posIndexList = "5#2|6#2|7#2|5#3|6#3|7#3",
			planeType = 3
		},
		{
			id = 3,
			posIndexList = "1#5|2#5|3#5|3#6|3#7",
			planeType = 2
		},
		{
			id = 4,
			posIndexList = "7#5|6#5|5#5|5#6|5#7",
			planeType = 2
		}
	},
	elementConfig = {
		{
			posIndex = "1#2",
			id = 0,
			color = 2,
			level = 1
		},
		{
			posIndex = "2#2",
			id = 1,
			color = 2,
			level = 1
		},
		{
			posIndex = "6#2",
			id = 2,
			color = 2,
			level = 1
		},
		{
			posIndex = "7#2",
			id = 3,
			color = 2,
			level = 1
		},
		{
			posIndex = "3#4",
			id = 4,
			color = 3,
			level = 1
		},
		{
			posIndex = "5#4",
			id = 5,
			color = 3,
			level = 1
		},
		{
			posIndex = "1#5",
			id = 6,
			color = 1,
			level = 1
		},
		{
			posIndex = "4#5",
			id = 7,
			color = 3,
			level = 1
		},
		{
			posIndex = "7#5",
			id = 8,
			color = 1,
			level = 1
		},
		{
			posIndex = "1#6",
			id = 9,
			color = 3,
			level = 1
		},
		{
			posIndex = "2#6",
			id = 10,
			color = 1,
			level = 1
		},
		{
			posIndex = "4#6",
			id = 11,
			color = 2,
			level = 1
		},
		{
			posIndex = "6#6",
			id = 12,
			color = 1,
			level = 1
		},
		{
			posIndex = "7#6",
			id = 13,
			color = 3,
			level = 1
		},
		{
			posIndex = "4#7",
			id = 14,
			color = 1,
			level = 1
		}
	}
}
