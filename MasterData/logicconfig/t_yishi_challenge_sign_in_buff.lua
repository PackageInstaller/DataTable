-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_yishi_challenge_sign_in_buff.lua

module("logicconfig.config.t_yishi_challenge_sign_in_buff", package.seeall)

local title = {
	challengeId = 1,
	desc = 3,
	level = 2
}
local dataList = {
	{
		226,
		1,
		"最大生命&全属性+10%"
	},
	{
		226,
		2,
		"最大生命&全属性+30%"
	},
	{
		226,
		3,
		"最大生命&全属性+50%"
	},
	{
		226,
		4,
		"最大生命&全属性+150%"
	},
	{
		226,
		5,
		"最大生命&全属性+300%"
	},
	{
		226,
		6,
		"最大生命&全属性+500%"
	},
	{
		226,
		7,
		"最大生命&全属性+800%"
	},
	{
		226,
		8,
		"最大生命&全属性+1000%"
	}
}
local t_yishi_challenge_sign_in_buff = {
	[226] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_yishi_challenge_sign_in_buff.dataList = dataList

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

return t_yishi_challenge_sign_in_buff
