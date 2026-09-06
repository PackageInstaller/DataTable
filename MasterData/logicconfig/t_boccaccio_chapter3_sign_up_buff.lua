-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_boccaccio_chapter3_sign_up_buff.lua

module("logicconfig.config.t_boccaccio_chapter3_sign_up_buff", package.seeall)

local title = {
	activityId = 1,
	buffDesc = 4,
	buffId = 2,
	signUpDay = 3
}
local dataList = {
	{
		580001,
		1,
		1,
		"己阵精灵攻击伤害增加50%"
	},
	{
		580001,
		2,
		2,
		"己阵精灵攻击附带自身攻击力*120%的伤害"
	},
	{
		580001,
		3,
		3,
		"己阵精灵攻击无视目标50%防御"
	},
	{
		580001,
		4,
		4,
		"全属性及最大生命值+300%"
	},
	{
		580001,
		5,
		5,
		"全属性及最大生命值+800%"
	}
}
local t_boccaccio_chapter3_sign_up_buff = {
	[580001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_boccaccio_chapter3_sign_up_buff.dataList = dataList

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

return t_boccaccio_chapter3_sign_up_buff
