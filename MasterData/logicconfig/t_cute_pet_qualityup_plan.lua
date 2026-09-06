-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cute_pet_qualityup_plan.lua

module("logicconfig.config.t_cute_pet_qualityup_plan", package.seeall)

local title = {
	materialCost = 4,
	quality = 2,
	propsRate = 3,
	newActivePropTypes = 5,
	planId = 1
}
local dataList = {
	{
		1,
		1,
		0,
		"",
		{
			"生命",
			"攻击",
			"物防",
			"魔防"
		}
	},
	{
		1,
		2,
		0.2,
		"4:11002:5000",
		{
			"破击率"
		}
	},
	{
		1,
		3,
		0.4,
		"4:11002:10000",
		{
			"暴击率"
		}
	},
	{
		1,
		4,
		0.6,
		"4:11002:18000",
		{}
	},
	{
		1,
		5,
		0.8,
		"4:11002:30000",
		{}
	},
	{
		2,
		1,
		0,
		"",
		{
			"生命",
			"攻击",
			"物防",
			"魔防"
		}
	},
	{
		2,
		2,
		0.2,
		"4:11002:5000",
		{
			"破击率"
		}
	},
	{
		2,
		3,
		0.4,
		"4:11002:10000",
		{
			"命中率"
		}
	},
	{
		2,
		4,
		0.6,
		"4:11002:18000",
		{}
	},
	{
		2,
		5,
		0.8,
		"4:11002:30000",
		{}
	},
	{
		3,
		1,
		0,
		"",
		{
			"生命",
			"攻击",
			"物防",
			"魔防"
		}
	},
	{
		3,
		2,
		0.2,
		"4:11002:5000",
		{
			"格挡率"
		}
	},
	{
		3,
		3,
		0.4,
		"4:11002:10000",
		{
			"防暴率"
		}
	},
	{
		3,
		4,
		0.6,
		"4:11002:18000",
		{}
	},
	{
		3,
		5,
		0.8,
		"4:11002:30000",
		{}
	},
	{
		4,
		1,
		0,
		"",
		{
			"生命",
			"攻击",
			"物防",
			"魔防"
		}
	},
	{
		4,
		2,
		0.2,
		"4:11002:5000",
		{
			"格挡率"
		}
	},
	{
		4,
		3,
		0.4,
		"4:11002:10000",
		{
			"闪避率"
		}
	},
	{
		4,
		4,
		0.6,
		"4:11002:18000",
		{}
	},
	{
		4,
		5,
		0.8,
		"4:11002:30000",
		{}
	}
}
local t_cute_pet_qualityup_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	},
	{
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_cute_pet_qualityup_plan.dataList = dataList

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

return t_cute_pet_qualityup_plan
