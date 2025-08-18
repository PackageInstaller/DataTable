-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResHeroResetMisc.lua

local RT = {}

RT[1] = {
	{
		id = 100002,
		num = 10
	}
}

local Data = {
	{
		id = 1,
		ratio = 10000,
		consume = RT[1]
	},
	{
		id = 2,
		ratio = 10000,
		condition_id = {
			0,
			180,
			181
		},
		consume = RT[1]
	},
	{
		id = 3,
		ratio = 10000,
		consume = {
			{
				id = 100002,
				num = 20
			}
		}
	}
}

return Data
