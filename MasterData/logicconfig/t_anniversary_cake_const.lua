-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_anniversary_cake_const.lua

module("logicconfig.config.t_anniversary_cake_const", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"TAP1",
		"制作蛋糕"
	},
	{
		"TAP2",
		"享用蛋糕"
	},
	{
		"NUMBER OF CHECKPOINTS",
		"10"
	},
	{
		"NUMBER OF CHECKPOINTS2",
		"3"
	},
	{
		"EAT_TIME",
		"10"
	},
	{
		"EAT_TIME2",
		"9999"
	},
	{
		"SPECIAL_DESC",
		"通关全部关卡可获得300万金币+召唤券*10"
	},
	{
		"SPECIAL_REWARD",
		"8:1:3000000"
	},
	{
		"SPECIAL_DESC2",
		"通关全部关卡可获得150万金币+满级宝箱*1"
	},
	{
		"SPECIAL_REWARD2",
		"4:90111:1"
	},
	{
		"ClickCakeMark",
		"1"
	},
	{
		"ChangeCakePic",
		"50000,150000,250000,350000"
	}
}
local t_anniversary_cake_const = {
	TAP1 = dataList[1],
	TAP2 = dataList[2],
	["NUMBER OF CHECKPOINTS"] = dataList[3],
	["NUMBER OF CHECKPOINTS2"] = dataList[4],
	EAT_TIME = dataList[5],
	EAT_TIME2 = dataList[6],
	SPECIAL_DESC = dataList[7],
	SPECIAL_REWARD = dataList[8],
	SPECIAL_DESC2 = dataList[9],
	SPECIAL_REWARD2 = dataList[10],
	ClickCakeMark = dataList[11],
	ChangeCakePic = dataList[12]
}

t_anniversary_cake_const.dataList = dataList

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

return t_anniversary_cake_const
