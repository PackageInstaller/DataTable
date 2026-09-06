-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_noah_clg_progress_prize.lua

module("logicconfig.config.t_divine_king_noah_clg_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	passStageCount = 3,
	prize = 4,
	prizePlanId = 1
}
local dataList = {
	{
		1,
		1,
		2,
		"4:280:10"
	},
	{
		1,
		2,
		4,
		"4:280:20"
	},
	{
		1,
		3,
		6,
		"4:280:20"
	},
	{
		1,
		4,
		9,
		"4:280:20"
	},
	{
		1,
		5,
		14,
		"4:280:30"
	}
}
local t_divine_king_noah_clg_progress_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_divine_king_noah_clg_progress_prize.dataList = dataList

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

return t_divine_king_noah_clg_progress_prize
