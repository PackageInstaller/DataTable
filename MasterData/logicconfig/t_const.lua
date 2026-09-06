-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_const.lua

module("logicconfig.config.t_const", package.seeall)

local title = {
	strValue = 3,
	key = 1,
	numValue = 2
}
local dataList = {
	{
		"MainPlayerSpeed",
		4.5,
		""
	},
	{
		"PetFollowSpeed",
		1.8,
		""
	},
	{
		"SendSurveyInterval",
		30,
		""
	},
	{
		"LoadingBgCount",
		16,
		""
	},
	{
		"XingLanLongRecPower",
		10000,
		""
	},
	{
		"MainPetChatTime",
		30,
		""
	},
	{
		"bagSpiritLimit",
		3000,
		"你的精灵太多啦！无法进行精灵排序，可前往时间之轮进行分解~"
	}
}
local t_const = {
	MainPlayerSpeed = dataList[1],
	PetFollowSpeed = dataList[2],
	SendSurveyInterval = dataList[3],
	LoadingBgCount = dataList[4],
	XingLanLongRecPower = dataList[5],
	MainPetChatTime = dataList[6],
	bagSpiritLimit = dataList[7]
}

t_const.dataList = dataList

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

return t_const
