-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResEquipReturn.lua

local RT = {}

RT[1] = {
	{
		id = 100001,
		num = 2400000
	},
	{
		id = 500001,
		num = 3000
	},
	{
		id = 520061,
		num = 30
	},
	{
		id = 520062,
		num = 30
	},
	{
		id = 520063,
		num = 30
	}
}
RT[2] = {
	{
		id = 100001,
		num = 12600000
	},
	{
		id = 500001,
		num = 6000
	},
	{
		id = 520061,
		num = 60
	},
	{
		id = 520062,
		num = 60
	},
	{
		id = 520063,
		num = 60
	},
	{
		id = 520064,
		num = 300
	}
}
RT[3] = {
	id = 100001,
	num = 12600000
}
RT[4] = {
	id = 500001,
	num = 6000
}
RT[5] = {
	id = 520061,
	num = 60
}
RT[6] = {
	id = 520062,
	num = 60
}
RT[7] = {
	id = 520063,
	num = 60
}
RT[8] = {
	{
		id = 100001,
		num = 12600000
	},
	{
		id = 500001,
		num = 6000
	},
	{
		id = 520061,
		num = 60
	},
	{
		id = 520062,
		num = 60
	},
	{
		id = 520063,
		num = 60
	},
	{
		id = 520065,
		num = 300
	}
}
RT[9] = {
	{
		id = 100001,
		num = 12600000
	},
	{
		id = 500001,
		num = 6000
	},
	{
		id = 520061,
		num = 60
	},
	{
		id = 520062,
		num = 60
	},
	{
		id = 520063,
		num = 60
	},
	{
		id = 520066,
		num = 300
	}
}

local Data = {
	{
		{
			position = 1,
			level = 1,
			ret_item = RT[1]
		},
		{
			position = 2,
			level = 1,
			ret_item = RT[1]
		},
		{
			position = 3,
			level = 1,
			ret_item = RT[1]
		},
		{
			position = 4,
			level = 1,
			ret_item = RT[1]
		},
		{
			position = 5,
			level = 1,
			ret_item = RT[1]
		},
		{
			position = 6,
			level = 1,
			ret_item = RT[1]
		}
	},
	{
		{
			position = 1,
			level = 2,
			ret_item = RT[2]
		},
		{
			position = 2,
			level = 2,
			ret_item = RT[8]
		},
		{
			position = 3,
			level = 2,
			ret_item = RT[9]
		},
		{
			position = 4,
			level = 2,
			ret_item = RT[2]
		},
		{
			position = 5,
			level = 2,
			ret_item = RT[8]
		},
		{
			position = 6,
			level = 2,
			ret_item = RT[9]
		}
	}
}

return Data
