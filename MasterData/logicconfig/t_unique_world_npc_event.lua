-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_unique_world_npc_event.lua

module("logicconfig.config.t_unique_world_npc_event", package.seeall)

local title = {
	effects = 3,
	optionId = 2,
	optionDesc = 5,
	eventId = 1,
	prize = 4
}
local dataList = {
	{
		3001,
		1,
		"coin$-100&addItem$1#10",
		"",
		"出手相助（银票-100，回血丹+10）"
	},
	{
		3001,
		2,
		"coin$-100&addItem$2#1",
		"",
		"索要报酬（银票-100，复活丹+1）"
	},
	{
		3001,
		3,
		"addItem$1#2",
		"",
		"转身离去（回血丹+1）"
	},
	{
		3002,
		1,
		"addPet$32",
		"",
		"赠予干粮（精灵+1）"
	},
	{
		3002,
		2,
		"addEvent$4#4010",
		"",
		"分文不取（地图商店+1）"
	},
	{
		3002,
		3,
		"addEvent$2#2001",
		"",
		"冷眼旁观（地图矿点+1）"
	},
	{
		3003,
		1,
		"coin$-100&addItem$1#10",
		"",
		"拱手道谢（银票-100，回血丹+10）"
	},
	{
		3003,
		2,
		"coin$-100&addItem$2#1",
		"",
		"恐有蹊跷（银票-100，复活丹+1）"
	},
	{
		3003,
		3,
		"addItem$1#2",
		"",
		"直接抢走（回血丹+1）"
	},
	{
		3004,
		1,
		"addPet$34",
		"",
		"合力开门（精灵+1）"
	},
	{
		3004,
		2,
		"addEvent$4#4010",
		"",
		"暗中蓄力（地图商店+1）"
	},
	{
		3004,
		3,
		"addEvent$2#2001",
		"",
		"绕道而行（地图矿点+1）"
	},
	{
		3005,
		1,
		"coin$-100&addItem$1#10",
		"",
		"如实相告（银票-100，回血丹+10）"
	},
	{
		3005,
		2,
		"coin$-100&addItem$2#1",
		"",
		"故弄玄虚（银票-100，复活丹+1）"
	},
	{
		3005,
		3,
		"addItem$1#2",
		"",
		"闭口不言（回血丹+1）"
	},
	{
		3006,
		1,
		"addPet$37",
		"",
		"结伴而行（精灵+1）"
	},
	{
		3006,
		2,
		"addEvent$4#4010",
		"",
		"分道扬镳（地图商店+1）"
	},
	{
		3006,
		3,
		"addEvent$2#2001",
		"",
		"暗中提防（地图矿点+1）"
	},
	{
		3007,
		1,
		"coin$-100&addItem$1#10",
		"",
		"仗义护送（银票-100，回血丹+10）"
	},
	{
		3007,
		2,
		"coin$-100&addItem$2#1",
		"",
		"指路离开（银票-100，复活丹+1）"
	},
	{
		3007,
		3,
		"addItem$1#2",
		"",
		"自顾不暇（回血丹+1）"
	},
	{
		3008,
		1,
		"addPet$35",
		"",
		"洗耳恭听（精灵+1）"
	},
	{
		3008,
		2,
		"addEvent$4#4010",
		"",
		"匆匆告辞（地图商店+1）"
	},
	{
		3008,
		3,
		"addEvent$2#2001",
		"",
		"疑心拖延（地图矿点+1）"
	},
	{
		3009,
		1,
		"addPet$36",
		"",
		"承认师门（精灵+1）"
	},
	{
		3009,
		2,
		"addEvent$4#4010",
		"",
		"反问其名（地图商店+1）"
	},
	{
		3009,
		3,
		"addEvent$2#2001",
		"",
		"避而不答（地图矿点+1）"
	}
}
local t_unique_world_npc_event = {
	[3001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[3002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[3003] = {
		dataList[7],
		dataList[8],
		dataList[9]
	},
	[3004] = {
		dataList[10],
		dataList[11],
		dataList[12]
	},
	[3005] = {
		dataList[13],
		dataList[14],
		dataList[15]
	},
	[3006] = {
		dataList[16],
		dataList[17],
		dataList[18]
	},
	[3007] = {
		dataList[19],
		dataList[20],
		dataList[21]
	},
	[3008] = {
		dataList[22],
		dataList[23],
		dataList[24]
	},
	[3009] = {
		dataList[25],
		dataList[26],
		dataList[27]
	}
}

t_unique_world_npc_event.dataList = dataList

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

return t_unique_world_npc_event
