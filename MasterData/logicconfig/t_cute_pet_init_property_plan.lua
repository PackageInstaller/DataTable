-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cute_pet_init_property_plan.lua

module("logicconfig.config.t_cute_pet_init_property_plan", package.seeall)

local title = {
	genRange = 3,
	planId = 1,
	propertyType = 2,
	strengthRandomRange = 4
}
local dataList = {
	{
		1,
		"生命",
		{
			1569,
			6276
		},
		{
			63,
			188
		}
	},
	{
		1,
		"攻击",
		{
			295,
			1181
		},
		{
			12,
			35
		}
	},
	{
		1,
		"物防",
		{
			96,
			387
		},
		{
			4,
			12
		}
	},
	{
		1,
		"魔防",
		{
			96,
			387
		},
		{
			4,
			12
		}
	},
	{
		1,
		"速度",
		{
			41,
			166
		},
		{}
	},
	{
		1,
		"命中率",
		{
			0,
			0
		},
		{}
	},
	{
		1,
		"闪避率",
		{
			0,
			0
		},
		{}
	},
	{
		1,
		"破击率",
		{
			0,
			0
		},
		{}
	},
	{
		1,
		"格挡率",
		{
			0,
			0
		},
		{}
	},
	{
		1,
		"暴击率",
		{
			0,
			0
		},
		{}
	},
	{
		1,
		"防暴率",
		{
			0,
			0
		},
		{}
	}
}
local t_cute_pet_init_property_plan = {
	{
		生命 = dataList[1],
		攻击 = dataList[2],
		物防 = dataList[3],
		魔防 = dataList[4],
		速度 = dataList[5],
		命中率 = dataList[6],
		闪避率 = dataList[7],
		破击率 = dataList[8],
		格挡率 = dataList[9],
		暴击率 = dataList[10],
		防暴率 = dataList[11]
	}
}

t_cute_pet_init_property_plan.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_cute_pet_init_property_plan
