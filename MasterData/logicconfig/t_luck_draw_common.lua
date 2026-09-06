-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_luck_draw_common.lua

module("logicconfig.config.t_luck_draw_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"TIME_STATE_ACTID",
		"25026"
	},
	{
		"TIME_STATE_ADD_ACTID",
		"25019"
	},
	{
		"SCORE_STATE_ACTID",
		"25022"
	},
	{
		"SKIN_PREVIEW_ACTID",
		"25020"
	},
	{
		"Client_Big_Prize_Name",
		"特别的奖"
	},
	{
		"CustomJump25057",
		"免费获取,func#1312"
	}
}
local t_luck_draw_common = {
	TIME_STATE_ACTID = dataList[1],
	TIME_STATE_ADD_ACTID = dataList[2],
	SCORE_STATE_ACTID = dataList[3],
	SKIN_PREVIEW_ACTID = dataList[4],
	Client_Big_Prize_Name = dataList[5],
	CustomJump25057 = dataList[6]
}

t_luck_draw_common.dataList = dataList

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

return t_luck_draw_common
