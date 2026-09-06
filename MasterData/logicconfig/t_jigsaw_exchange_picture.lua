-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_jigsaw_exchange_picture.lua

module("logicconfig.config.t_jigsaw_exchange_picture", package.seeall)

local title = {
	relativeOpenDays = 3,
	picturePlanId = 1,
	pictureId = 2,
	bigPrize = 7,
	jigsawPlanId = 4,
	groupPrizePlanId = 5,
	iconPath = 8,
	activateJigsawPrize = 6
}
local dataList = {
	{
		1,
		1,
		0,
		101,
		101,
		"8:1:10000",
		"4:90177:1",
		"board_dlwl_09"
	},
	{
		1,
		2,
		0,
		101,
		101,
		"8:1:10000",
		"4:70023:1",
		"board_dlwl_10"
	},
	{
		1,
		3,
		7,
		101,
		101,
		"8:1:10000",
		"4:90137:5",
		"board_dlwl_11"
	},
	{
		1,
		4,
		7,
		101,
		101,
		"8:1:10000",
		"4:90182:1",
		"board_dlwl_12"
	},
	{
		2,
		1,
		0,
		101,
		201,
		"8:1:10000",
		"10:17087:2000",
		"board_yyjk_01"
	}
}
local t_jigsaw_exchange_picture = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5]
	}
}

t_jigsaw_exchange_picture.dataList = dataList

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

return t_jigsaw_exchange_picture
