-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_hand_welfare_privilege_view.lua

module("logicconfig.config.t_new_hand_welfare_privilege_view", package.seeall)

local title = {
	id = 1,
	jumpTo = 3,
	iconPath = 4,
	tabName = 2
}
local dataList = {
	{
		1,
		"金钻特权新手免费体验",
		"func#322",
		"summerdouble/board_xiajifanbei_01"
	},
	{
		2,
		"米其林餐厅体力翻倍",
		"func#3#3",
		"summerdouble/board_xiajifanbei_02"
	},
	{
		3,
		"失落遗迹奖励翻倍",
		"func#52",
		"summerdouble/board_xiajifanbei_03"
	},
	{
		4,
		"泰坦试炼回溯次数翻倍",
		"func#1286",
		"summerdouble/board_xiajifanbei_21"
	},
	{
		5,
		"暗影来袭次数翻倍",
		"func#178",
		"summerdouble/board_xiajifanbei_04"
	},
	{
		6,
		"家族护送奖励翻倍",
		"func#91",
		"summerdouble/board_xiajifanbei_05"
	},
	{
		7,
		"派遣奖励翻倍",
		"func#74",
		"summerdouble/board_xiajifanbei_06"
	}
}
local t_new_hand_welfare_privilege_view = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_new_hand_welfare_privilege_view.dataList = dataList

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

return t_new_hand_welfare_privilege_view
