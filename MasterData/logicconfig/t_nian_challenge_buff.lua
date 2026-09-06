-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_nian_challenge_buff.lua

module("logicconfig.config.t_nian_challenge_buff", package.seeall)

local title = {
	des = 2,
	level = 1
}
local dataList = {
	{
		1,
		"己方精灵全属性+10%"
	},
	{
		2,
		"己方精灵全属性+20%"
	},
	{
		3,
		"己方精灵全属性+30%"
	},
	{
		4,
		"己方精灵全属性+40%"
	},
	{
		5,
		"己方精灵全属性+50%"
	},
	{
		6,
		"己方精灵全属性+60%"
	},
	{
		7,
		"己方精灵全属性+70%"
	},
	{
		8,
		"己方精灵全属性+80%"
	},
	{
		9,
		"己方精灵全属性+90%"
	},
	{
		10,
		"己方精灵全属性+100%"
	},
	{
		11,
		"己方精灵全属性+110%"
	},
	{
		12,
		"己方精灵全属性+120%"
	},
	{
		13,
		"己方精灵全属性+130%"
	},
	{
		14,
		"己方精灵全属性+140%"
	},
	{
		15,
		"己方精灵全属性+150%"
	}
}
local t_nian_challenge_buff = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15]
}

t_nian_challenge_buff.dataList = dataList

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

return t_nian_challenge_buff
