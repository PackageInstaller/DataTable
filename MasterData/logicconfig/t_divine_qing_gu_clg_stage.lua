-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_qing_gu_clg_stage.lua

module("logicconfig.config.t_divine_qing_gu_clg_stage", package.seeall)

local title = {
	stageId = 2,
	name = 3,
	prize = 5,
	creepsMasterId = 4,
	activityId = 1
}
local dataList = {
	{
		372001,
		1,
		"化器道",
		1001,
		"4:235:15"
	},
	{
		372001,
		2,
		"束鬼道",
		1002,
		"4:235:15"
	},
	{
		372001,
		3,
		"缚神道",
		1003,
		"4:235:15"
	},
	{
		372001,
		4,
		"无人道",
		1004,
		"4:235:15"
	},
	{
		372001,
		5,
		"堕心道",
		1005,
		"4:235:20"
	},
	{
		372001,
		6,
		"修罗道",
		1006,
		"4:235:20"
	}
}
local t_divine_qing_gu_clg_stage = {
	[372001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_qing_gu_clg_stage.dataList = dataList

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

return t_divine_qing_gu_clg_stage
