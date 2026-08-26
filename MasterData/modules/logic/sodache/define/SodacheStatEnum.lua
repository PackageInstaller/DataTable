-- chunkname: @modules/logic/sodache/define/SodacheStatEnum.lua

module("modules.logic.sodache.define.SodacheStatEnum", package.seeall)

local SodacheStatEnum = _M
local StatEnum = StatEnum

SodacheStatEnum.EventName = {
	Sodache = "soudache_settlement"
}
SodacheStatEnum.EventProperties = {
	Sodache_Patience = "soudache_patience",
	Sodache_UseTime = "useTime",
	Sodache_Materials = "soudache_materials",
	Sodache_BuyGoods = "buy_goods",
	Sodache_Skill = "soudache_skill",
	Sodache_UsedCard = "used_card",
	Sodache_MaterialsList = "soudache_materials_list",
	Sodache_Tickets = "soudache_tickets",
	Sodache_UsedPatience = "used_patience",
	Sodache_WaypointNum = "waypoint_num",
	Sodache_TotalGoldNum = "total_gold_num",
	Sodache_CompletedEventId = "completed_event_id",
	Sodache_Level = "soudache_level",
	Sodache_Faith = "soudache_faith",
	Sodache_MaterialsValue = "materials_value",
	Sodache_TimeSlot = "soudache_time_slot",
	Sodache_EvacuateMaterials = "evacuate_materials",
	Sodache_MatchId = "match_id",
	Sodache_Difficulty = "soudache_difficulty",
	Sodache_InterruptReason = "interrupt_reason",
	Sodache_CompletedEventNum = "completed_event_num",
	Sodache_Result = "soudache_result"
}
SodacheStatEnum.PropertyTypes = {
	[SodacheStatEnum.EventProperties.Sodache_MatchId] = StatEnum.Type.Number,
	[SodacheStatEnum.EventProperties.Sodache_Level] = StatEnum.Type.Number,
	[SodacheStatEnum.EventProperties.Sodache_Difficulty] = StatEnum.Type.String,
	[SodacheStatEnum.EventProperties.Sodache_Tickets] = StatEnum.Type.String,
	[SodacheStatEnum.EventProperties.Sodache_TimeSlot] = StatEnum.Type.String,
	[SodacheStatEnum.EventProperties.Sodache_Patience] = StatEnum.Type.Number,
	[SodacheStatEnum.EventProperties.Sodache_MaterialsList] = StatEnum.Type.List,
	[SodacheStatEnum.EventProperties.Sodache_Materials] = StatEnum.Type.Array,
	[SodacheStatEnum.EventProperties.Sodache_Skill] = StatEnum.Type.Array,
	[SodacheStatEnum.EventProperties.Sodache_Faith] = StatEnum.Type.Number,
	[SodacheStatEnum.EventProperties.Sodache_Result] = StatEnum.Type.String,
	[SodacheStatEnum.EventProperties.Sodache_UseTime] = StatEnum.Type.Number,
	[SodacheStatEnum.EventProperties.Sodache_InterruptReason] = StatEnum.Type.String,
	[SodacheStatEnum.EventProperties.Sodache_CompletedEventId] = StatEnum.Type.List,
	[SodacheStatEnum.EventProperties.Sodache_WaypointNum] = StatEnum.Type.Number,
	[SodacheStatEnum.EventProperties.Sodache_CompletedEventNum] = StatEnum.Type.Number,
	[SodacheStatEnum.EventProperties.Sodache_BuyGoods] = StatEnum.Type.Array,
	[SodacheStatEnum.EventProperties.Sodache_UsedCard] = StatEnum.Type.List,
	[SodacheStatEnum.EventProperties.Sodache_UsedPatience] = StatEnum.Type.Number,
	[SodacheStatEnum.EventProperties.Sodache_EvacuateMaterials] = StatEnum.Type.Array,
	[SodacheStatEnum.EventProperties.Sodache_MaterialsValue] = StatEnum.Type.Number,
	[SodacheStatEnum.EventProperties.Sodache_TotalGoldNum] = StatEnum.Type.Number
}

local function repeatError(key, val1, val2)
	logError("重复定义Key！" .. key)
end

local function repeatError2(key, val1, val2)
	if val1 == val2 then
		return
	end

	logError("Key 对应的值不一致！" .. key .. " " .. val1 .. " " .. val2)
end

local repeatKeyFunc = {
	EventName = repeatError,
	EventProperties = repeatError,
	PropertyTypes = repeatError2
}

for k, v in pairs(repeatKeyFunc) do
	local tb = StatEnum[k]

	if tb then
		for k2, v2 in pairs(SodacheStatEnum[k]) do
			if tb[k2] then
				v(k2, tb[k2], v2)
			end

			tb[k2] = v2
		end
	else
		logError("未定义的Key！" .. k)
	end
end

return SodacheStatEnum
