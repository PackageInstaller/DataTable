-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bigOrange_dialog.lua

module("logicconfig.config.t_bigOrange_dialog", package.seeall)

local title = {
	id = 2,
	content = 3,
	types = 1
}
local dataList = {
	{
		1,
		1,
		"<color=#556fb5><size=24>猜猜下一只精灵是谁？</size></color>"
	},
	{
		1,
		2,
		"<color=#556fb5><size=24>你们不老，奥奇不倒！</size></color>"
	},
	{
		1,
		3,
		"<color=#556fb5><size=24>我要悄悄优化，\r\n然后惊艳所有人！</size></color>"
	},
	{
		1,
		4,
		"<color=#556fb5><size=24>策划不秃，美术不服。</size></color>"
	},
	{
		2,
		1,
		"<color=#556fb5><size=24>绞尽橙汁，\r\n也要给大家一个回复才行</size></color>"
	},
	{
		2,
		2,
		"<color=#556fb5><size=24>小奥奇的难题，\r\n必须优先解决！</size></color>"
	},
	{
		2,
		3,
		"<color=#556fb5><size=25>要想奥奇做的好，\r\n周末加班少不了。</size></color>"
	},
	{
		3,
		1,
		"<color=#556fb5><size=24>头可秃，身可胖，\r\n玩家福利不能少。</size></color>"
	},
	{
		3,
		2,
		"<color=#556fb5><size=25>玩奥奇，他不香吗？！</size></color>"
	},
	{
		3,
		3,
		"<color=#556fb5><size=26>爆肝人，爆肝魂，\r\n爆肝人都是人上人！</size></color>"
	}
}
local t_bigOrange_dialog = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7]
	},
	{
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_bigOrange_dialog.dataList = dataList

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

return t_bigOrange_dialog
