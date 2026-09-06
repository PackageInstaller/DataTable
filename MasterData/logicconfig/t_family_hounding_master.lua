-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_hounding_master.lua

module("logicconfig.config.t_family_hounding_master", package.seeall)

local title = {
	creepMasterHeadIcon = 3,
	name = 2,
	WinDesc = 4,
	skipTime = 6,
	btlMode = 9,
	btlBg = 7,
	selfBuffProviderId = 10,
	winId = 5,
	creepsMasterId = 1,
	heroSkillId = 8
}
local dataList = {
	{
		1,
		"神罚·秩序圣龙",
		11002,
		"指定10个大回合内尽量造成伤害",
		110,
		5,
		"",
		"",
		"",
		0
	},
	{
		2,
		"烈焰·无烬圣龙",
		10314,
		"指定10个大回合内尽量造成伤害",
		110,
		5,
		"",
		"",
		"",
		0
	},
	{
		3,
		"不朽枯木·永恒圣龙",
		13008,
		"指定10个大回合内尽量造成伤害",
		110,
		5,
		"",
		"",
		"",
		0
	},
	{
		4,
		"万象·次元圣龙",
		10313,
		"指定10个大回合内尽量造成伤害",
		110,
		5,
		"",
		"",
		"",
		0
	},
	{
		5,
		"无限时空·龙尊",
		15006,
		"指定10个大回合内尽量造成伤害",
		110,
		5,
		"",
		"",
		"",
		0
	},
	{
		6,
		"星宙·超神圣龙",
		16004,
		"指定10个大回合内尽量造成伤害",
		110,
		5,
		"",
		"",
		"",
		0
	},
	{
		7,
		"神爵·龙尊圣主",
		17002,
		"指定10个大回合内尽量造成伤害",
		110,
		5,
		"",
		"",
		"",
		0
	}
}
local t_family_hounding_master = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_family_hounding_master.dataList = dataList

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

return t_family_hounding_master
