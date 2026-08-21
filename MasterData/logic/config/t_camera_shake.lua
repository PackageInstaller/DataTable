-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_camera_shake.lua

module("logic.config.t_camera_shake", package.seeall)

local title = {
	lifeTime = 3,
	magnitude = 4,
	shakeMode = 2,
	name = 6,
	code = 1,
	decreaseRate = 5
}
local dataList = {
	{
		10001,
		1,
		0.4,
		0.4,
		0.3,
		"震动1"
	},
	{
		10002,
		2,
		0.2,
		0.5,
		0,
		"震动2"
	},
	{
		10003,
		2,
		0.1,
		0.1,
		0.3,
		"震屏极小"
	},
	{
		10004,
		1,
		0.3,
		0.1,
		0.1,
		"Npc对话UI震动"
	},
	{
		10005,
		5,
		0.5,
		0.6,
		0.2,
		"战斗震动大"
	},
	{
		20001,
		5,
		999999,
		0.25,
		0.1,
		"类似于地震的震动，如果不配置停止时间的话，会一直震动下去"
	},
	{
		20002,
		5,
		2,
		0.3,
		0.2,
		"怪物咆哮，表现出怪物强有力的威慑感"
	},
	{
		20003,
		5,
		0.15,
		0.3,
		0.1,
		"用于表现角色生气地跳起来，踩一下地"
	},
	{
		20004,
		5,
		0.2,
		0.2,
		0.1,
		"目标对象受到攻击时的震动"
	},
	{
		20005,
		5,
		1,
		0.2,
		0.1,
		"正弦水平"
	},
	{
		20006,
		6,
		1,
		0.2,
		0.1,
		"正弦竖直"
	}
}
local t_camera_shake = {}

t_camera_shake.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_camera_shake[v[1]] = v

	setmetatable(v, mt)
end

return t_camera_shake
