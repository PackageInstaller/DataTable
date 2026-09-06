-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ultimate_trial_main.lua

module("logicconfig.config.t_ultimate_trial_main", package.seeall)

local title = {
	clgIndex = 2,
	bgPath = 5,
	tabPath = 6,
	skinId = 3,
	formatScore = 4,
	activityId = 1
}
local dataList = {
	{
		472001,
		1,
		14033,
		"最高超杀：%s",
		"views/darknessspring/bg_anshizhiquan_02",
		"ultimatetrial/btn_wushangshenlian_05"
	},
	{
		472001,
		2,
		14032,
		"最高群攻：%s",
		"views/xiongdijijie/bg_xdjj",
		"ultimatetrial/btn_wushangshenlian_03"
	},
	{
		472001,
		3,
		16034,
		"最低战力和：%s",
		"views/challenges/yuhui/bg_yuhui_02",
		"ultimatetrial/btn_wushangshenlian_04"
	}
}
local t_ultimate_trial_main = {
	[472001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_ultimate_trial_main.dataList = dataList

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

return t_ultimate_trial_main
