-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_mi_rui_ke_clg_buff.lua

module("logicconfig.config.t_divine_mi_rui_ke_clg_buff", package.seeall)

local title = {
	raceId = 2,
	activityId = 1,
	desc = 3
}
local dataList = {
	{
		381001,
		12022,
		"根据已拥有的奇迹五王数量，除助战精灵外己阵精灵全属性对应增加20%，50%，100%，300%，700%"
	},
	{
		381001,
		13019,
		"根据已拥有的奇迹五王数量，除助战精灵外己阵精灵全属性对应增加20%，50%，100%，300%，700%"
	},
	{
		381001,
		14025,
		"根据已拥有的奇迹五王数量，除助战精灵外己阵精灵全属性对应增加20%，50%，100%，300%，700%"
	},
	{
		381001,
		11024,
		"根据已拥有的奇迹五王数量，除助战精灵外己阵精灵全属性对应增加20%，50%，100%，300%，700%"
	},
	{
		381001,
		15025,
		"根据已拥有的奇迹五王数量，除助战精灵外己阵精灵全属性对应增加20%，50%，100%，300%，700%"
	}
}
local t_divine_mi_rui_ke_clg_buff = {
	[381001] = {
		[12022] = dataList[1],
		[13019] = dataList[2],
		[14025] = dataList[3],
		[11024] = dataList[4],
		[15025] = dataList[5]
	}
}

t_divine_mi_rui_ke_clg_buff.dataList = dataList

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

return t_divine_mi_rui_ke_clg_buff
