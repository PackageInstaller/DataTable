-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_collect_clothes_prize.lua

module("logicconfig.config.t_collect_clothes_prize", package.seeall)

local title = {
	prizeId = 1,
	icon = 5,
	title = 6,
	prizePlanId = 2,
	num = 3,
	prize = 4,
	desc = 7
}
local dataList = {
	{
		1,
		1,
		5,
		"1:300028:-1:1",
		"dress/icon_bg_qjqm",
		"曲尽其妙",
		"集齐以下服装&坐骑后赠送"
	},
	{
		1,
		2,
		5,
		"1:300028:-1:1",
		"dress/icon_bg_qjqm",
		"曲尽其妙",
		"集齐以下服装&坐骑后赠送"
	}
}
local t_collect_clothes_prize = {
	{
		dataList[1],
		dataList[2]
	}
}

t_collect_clothes_prize.dataList = dataList

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

return t_collect_clothes_prize
