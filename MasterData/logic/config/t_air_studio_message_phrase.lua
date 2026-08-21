-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_air_studio_message_phrase.lua

module("logic.config.t_air_studio_message_phrase", package.seeall)

local title = {
	id = 1,
	content = 2
}
local dataList = {
	{
		1001,
		"请相信%s"
	},
	{
		1002,
		"前有%s"
	},
	{
		1003,
		"前无%s"
	},
	{
		1004,
		"%s跃跃欲试"
	},
	{
		1005,
		"此情况下需要%s"
	},
	{
		1006,
		"%s很有用"
	},
	{
		1007,
		"%s出没，请注意"
	},
	{
		1008,
		"%s试图寻求帮助"
	},
	{
		1009,
		"是%s的时候了"
	},
	{
		1010,
		"%s的终结"
	},
	{
		1011,
		"小心探险，%s"
	},
	{
		1012,
		"%s正在等待"
	},
	{
		1013,
		"在这里，%s是正常的"
	},
	{
		1014,
		"%s的策略是有效的"
	},
	{
		1015,
		"提个醒吧，%s"
	},
	{
		1016,
		"无条件信任%s"
	},
	{
		1017,
		"不要%s"
	},
	{
		1018,
		"重要的是%s"
	},
	{
		1019,
		"当看到%s时"
	},
	{
		1020,
		"如果%s已经行动"
	},
	{
		1021,
		"保持%s"
	},
	{
		1022,
		"%s是真实的"
	},
	{
		1023,
		"%s有问题"
	},
	{
		1024,
		"有难度，推荐使用%s"
	},
	{
		1025,
		"从这里%s"
	},
	{
		1026,
		"%s不存在"
	},
	{
		1027,
		"本回合%s先行动"
	},
	{
		1028,
		"立即%s"
	},
	{
		1029,
		"注意地图上%s的位置"
	},
	{
		1030,
		"%s是通关的一部分"
	}
}
local t_air_studio_message_phrase = {}

t_air_studio_message_phrase.dataList = dataList

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
	t_air_studio_message_phrase[v[1]] = v

	setmetatable(v, mt)
end

return t_air_studio_message_phrase
