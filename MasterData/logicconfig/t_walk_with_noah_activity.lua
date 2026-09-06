-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_walk_with_noah_activity.lua

module("logicconfig.config.t_walk_with_noah_activity", package.seeall)

local title = {
	pieceCount = 3,
	progressItemKey = 2,
	baseIcon = 4,
	taskJump = 5,
	redPointId = 6,
	activityId = 1
}
local dataList = {
	{
		425001,
		"10:425001",
		40,
		"board_kcyr_pintu01",
		"ui#commongrouptaskmainview#425001",
		0
	},
	{
		425002,
		"10:425002",
		40,
		"board_kcyr_pintu01",
		"",
		686
	},
	{
		425003,
		"10:425003",
		40,
		"board_kcyr_pintu11",
		"ui#commongrouptaskmainview#242011",
		686
	},
	{
		425004,
		"10:425004",
		40,
		"board_kcyr_pintu12",
		"ui#commongrouptaskmainview#242011",
		686
	},
	{
		425005,
		"10:425005",
		40,
		"board_kcyr_pintu13",
		"ui#commongrouptaskmainview#242011",
		686
	},
	{
		425006,
		"10:425006",
		40,
		"board_kcyr_pintu14",
		"ui#commongrouptaskmainview#425006",
		686
	},
	{
		425007,
		"10:425007",
		40,
		"board_kcyr_pintu15",
		"ui#commongrouptaskmainview#425007",
		686
	}
}
local t_walk_with_noah_activity = {
	[425001] = dataList[1],
	[425002] = dataList[2],
	[425003] = dataList[3],
	[425004] = dataList[4],
	[425005] = dataList[5],
	[425006] = dataList[6],
	[425007] = dataList[7]
}

t_walk_with_noah_activity.dataList = dataList

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

return t_walk_with_noah_activity
