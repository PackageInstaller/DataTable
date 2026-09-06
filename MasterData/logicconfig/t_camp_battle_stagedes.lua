-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_camp_battle_stagedes.lua

module("logicconfig.config.t_camp_battle_stagedes", package.seeall)

local title = {
	id = 1,
	name = 2,
	desc = 4,
	path = 3
}
local dataList = {
	{
		1,
		"阵营选择",
		"funcamp1",
		"选择心仪的活动阵营，每个阵营都拥有不同的助阵精灵和战斗加成"
	},
	{
		2,
		"阵营鼓舞",
		"funcamp2",
		"通过捐赠和小游戏为阵营鼓舞，达到对应鼓舞值可享受阵营鼓舞效果"
	},
	{
		3,
		"阵营比拼",
		"funcamp3",
		"通过比拼玩法为阵营增加积分，活动结束后，根据阵营积分结算奖励"
	},
	{
		4,
		"瓜分大奖",
		"funcamp4",
		"决出三大阵营中的胜者，每个阵营表现优越的人都将获得额外嘉奖！"
	}
}
local t_camp_battle_stagedes = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_camp_battle_stagedes.dataList = dataList

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

return t_camp_battle_stagedes
