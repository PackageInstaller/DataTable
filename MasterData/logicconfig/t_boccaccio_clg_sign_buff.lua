-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_boccaccio_clg_sign_buff.lua

module("logicconfig.config.t_boccaccio_clg_sign_buff", package.seeall)

local title = {
	name = 5,
	buffType = 2,
	buffId = 3,
	scoreWanPercent = 4,
	activityId = 1,
	desc = 6
}
local dataList = {
	{
		578001,
		1,
		20070903,
		1000,
		"噬血",
		"攻击时吸收目标<color=#3cb859>10%</color>的最大生命值，永久提升自身等量的最大血量上限，积分系数为<color=#3cb859>0.1</color>\n"
	},
	{
		578001,
		2,
		20070906,
		1000,
		"噬攻",
		"攻击时吸收目标<color=#3cb859>25%</color>的攻击，永久提升自身等值的攻击，积分系数为<color=#3cb859>0.1</color>\n"
	},
	{
		578001,
		3,
		20070909,
		2000,
		"噬防",
		"攻击时吸收目标<color=#3cb859>25%</color>的双防，永久提升自身等值的双防，积分系数为<color=#3cb859>0.2</color>\n"
	}
}
local t_boccaccio_clg_sign_buff = {
	[578001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_boccaccio_clg_sign_buff.dataList = dataList

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

return t_boccaccio_clg_sign_buff
