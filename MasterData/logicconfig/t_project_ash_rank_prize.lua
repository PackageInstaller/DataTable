-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_project_ash_rank_prize.lua

module("logicconfig.config.t_project_ash_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		265001,
		{
			1,
			1
		},
		"第1名",
		"4:510154:1#104:2:1500#4:510126:5"
	},
	{
		265001,
		{
			2,
			10
		},
		"第2-10名",
		"4:510154:1#104:2:1200#4:510126:4"
	},
	{
		265001,
		{
			11,
			50
		},
		"第11-50名",
		"4:510154:1#104:2:800#4:510126:3"
	},
	{
		265001,
		{
			51,
			100
		},
		"第51-100名",
		"4:510154:1#104:2:500#4:510126:2"
	}
}
local t_project_ash_rank_prize = {
	[265001] = {
		[{
			1,
			1
		}] = dataList[1],
		[{
			2,
			10
		}] = dataList[2],
		[{
			11,
			50
		}] = dataList[3],
		[{
			51,
			100
		}] = dataList[4]
	}
}

t_project_ash_rank_prize.dataList = dataList

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

return t_project_ash_rank_prize
