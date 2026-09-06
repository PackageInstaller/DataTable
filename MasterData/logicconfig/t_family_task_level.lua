-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_task_level.lua

module("logicconfig.config.t_family_task_level", package.seeall)

local title = {
	startScore = 2,
	icon = 3,
	addDesc = 4,
	level = 1
}
local dataList = {
	{
		0,
		0,
		"btn_jzrw_01",
		"全族家族币获得+<color=#60fbbb>0</color>%"
	},
	{
		1,
		50,
		"btn_jzrw_01",
		"全族家族币获得+<color=#60fbbb>2</color>%"
	},
	{
		2,
		100,
		"btn_jzrw_01",
		"全族家族币获得+<color=#60fbbb>4</color>%"
	},
	{
		3,
		150,
		"btn_jzrw_01",
		"全族家族币获得+<color=#60fbbb>6</color>%"
	},
	{
		4,
		200,
		"btn_jzrw_01",
		"全族家族币获得+<color=#60fbbb>8</color>%"
	},
	{
		5,
		250,
		"btn_jzrw_01",
		"全族家族币获得+<color=#60fbbb>10</color>%"
	},
	{
		6,
		300,
		"btn_jzrw_01",
		"全族家族币获得+<color=#60fbbb>12</color>%"
	}
}
local t_family_task_level = {
	[0] = dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_family_task_level.dataList = dataList

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

return t_family_task_level
