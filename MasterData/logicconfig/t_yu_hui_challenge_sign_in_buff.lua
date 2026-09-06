-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_yu_hui_challenge_sign_in_buff.lua

module("logicconfig.config.t_yu_hui_challenge_sign_in_buff", package.seeall)

local title = {
	desc = 3,
	signInBuffPlanId = 1,
	level = 2
}
local dataList = {
	{
		180,
		1,
		"最大生命&全属性+10%"
	},
	{
		180,
		2,
		"最大生命&全属性+30%"
	},
	{
		180,
		3,
		"最大生命&全属性+50%"
	},
	{
		180,
		4,
		"最大生命&全属性+150%"
	},
	{
		180,
		5,
		"最大生命&全属性+300%"
	},
	{
		180,
		6,
		"最大生命&全属性+500%"
	},
	{
		180,
		7,
		"最大生命&全属性+800%"
	},
	{
		270,
		1,
		"最大生命&全属性+10%"
	},
	{
		270,
		2,
		"最大生命&全属性+30%"
	},
	{
		270,
		3,
		"最大生命&全属性+50%"
	},
	{
		270,
		4,
		"最大生命&全属性+150%"
	},
	{
		270,
		5,
		"最大生命&全属性+300%"
	},
	{
		270,
		6,
		"最大生命&全属性+500%"
	},
	{
		270,
		7,
		"最大生命&全属性+800%"
	}
}
local t_yu_hui_challenge_sign_in_buff = {
	[180] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	[270] = {
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	}
}

t_yu_hui_challenge_sign_in_buff.dataList = dataList

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

return t_yu_hui_challenge_sign_in_buff
