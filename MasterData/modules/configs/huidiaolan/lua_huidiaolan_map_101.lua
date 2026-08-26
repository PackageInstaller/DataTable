-- chunkname: @modules/configs/huidiaolan/lua_huidiaolan_map_101.lua

return {
	gameConfig = {
		moveBorn = 2,
		planeWidthCount = 6,
		mapId = 101,
		fourMergeBorn = 3,
		targetNum = 10,
		stepNum = 0,
		planeHeightCount = 6,
		treeMergeBorn = 3
	},
	planeConfig = {
		{
			id = 1,
			posIndexList = "1#1|2#1|2#2|3#2|3#3|4#3",
			planeType = 2
		},
		{
			id = 2,
			posIndexList = "5#1|6#1|5#2|6#2",
			planeType = 3
		}
	},
	elementConfig = {
		{
			posIndex = "4#1",
			id = 0,
			color = 2,
			level = 1
		},
		{
			posIndex = "1#2",
			id = 1,
			color = 1,
			level = 1
		},
		{
			posIndex = "3#2",
			id = 2,
			color = 3,
			level = 1
		},
		{
			posIndex = "5#3",
			id = 3,
			color = 1,
			level = 1
		}
	}
}
