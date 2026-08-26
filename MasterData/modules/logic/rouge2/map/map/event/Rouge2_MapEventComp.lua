-- chunkname: @modules/logic/rouge2/map/map/event/Rouge2_MapEventComp.lua

module("modules.logic.rouge2.map.map.event.Rouge2_MapEventComp", package.seeall)

local Rouge2_MapEventComp = class("Rouge2_MapEventComp", UserDataDispose)

function Rouge2_MapEventComp:init()
	return
end

function Rouge2_MapEventComp:handleEvent(eventCo)
	self.eventCo = eventCo

	local eventType = self.eventCo.type
	local handle = Rouge2_MapEventComp.EventHandleDict[eventType]

	if not handle then
		logError("not handle event type : " .. tostring(eventType))

		return
	end

	handle(self)
end

function Rouge2_MapEventComp:emptyHandle()
	logWarn("empty handle")
end

function Rouge2_MapEventComp:fightHandle()
	logError("进入战斗")
end

function Rouge2_MapEventComp:storeHandle()
	logError("打开商店")
end

function Rouge2_MapEventComp:choiceHandle()
	logError("打开选项")
end

Rouge2_MapEventComp.EventHandleDict = {
	[Rouge2_MapEnum.EventType.Empty] = Rouge2_MapEventComp.emptyHandle,
	[Rouge2_MapEnum.EventType.NormalFight] = Rouge2_MapEventComp.fightHandle,
	[Rouge2_MapEnum.EventType.HardFight] = Rouge2_MapEventComp.fightHandle,
	[Rouge2_MapEnum.EventType.EliteFight] = Rouge2_MapEventComp.fightHandle,
	[Rouge2_MapEnum.EventType.BossFight] = Rouge2_MapEventComp.fightHandle,
	[Rouge2_MapEnum.EventType.Reward] = Rouge2_MapEventComp.choiceHandle,
	[Rouge2_MapEnum.EventType.Choice] = Rouge2_MapEventComp.choiceHandle,
	[Rouge2_MapEnum.EventType.Store] = Rouge2_MapEventComp.storeHandle,
	[Rouge2_MapEnum.EventType.Rest] = Rouge2_MapEventComp.choiceHandle
}

function Rouge2_MapEventComp:destroy()
	return
end

return Rouge2_MapEventComp
