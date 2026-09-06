-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chuang_zhengli_sign_in_buff.lua

module("logicconfig.config.t_chuang_zhengli_sign_in_buff", package.seeall)

local title = {
	desc = 3,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		398001,
		1,
		"全属性+10%"
	},
	{
		398001,
		2,
		"全属性+30%"
	},
	{
		398001,
		3,
		"全属性+80%"
	},
	{
		398001,
		4,
		"全属性+200%"
	},
	{
		398001,
		5,
		"全属性+400%"
	},
	{
		398001,
		6,
		"全属性+600%"
	},
	{
		398001,
		7,
		"全属性+1000%"
	}
}
local t_chuang_zhengli_sign_in_buff = {
	[398001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_chuang_zhengli_sign_in_buff.dataList = dataList

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

return t_chuang_zhengli_sign_in_buff
