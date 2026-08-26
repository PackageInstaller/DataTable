-- chunkname: @modules/logic/rouge/map/map/event/RougeMapEventComp.lua

module("modules.logic.rouge.map.map.event.RougeMapEventComp", package.seeall)

local RougeMapEventComp = class("RougeMapEventComp", UserDataDispose)

function RougeMapEventComp:init()
	return
end

function RougeMapEventComp:handleEvent(eventCo)
	self.eventCo = eventCo

	local eventType = self.eventCo.type
	local handle = RougeMapEventComp.EventHandleDict[eventType]

	if not handle then
		logError("not handle event type : " .. tostring(eventType))

		return
	end

	handle(self)
end

function RougeMapEventComp:emptyHandle()
	logWarn("empty handle")
end

function RougeMapEventComp:fightHandle()
	logError("进入战斗")
end

function RougeMapEventComp:storeHandle()
	logError("打开商店")
end

function RougeMapEventComp:choiceHandle()
	logError("打开选项")
end

RougeMapEventComp.EventHandleDict = {
	[RougeMapEnum.EventType.Empty] = RougeMapEventComp.emptyHandle,
	[RougeMapEnum.EventType.NormalFight] = RougeMapEventComp.fightHandle,
	[RougeMapEnum.EventType.HardFight] = RougeMapEventComp.fightHandle,
	[RougeMapEnum.EventType.EliteFight] = RougeMapEventComp.fightHandle,
	[RougeMapEnum.EventType.BossFight] = RougeMapEventComp.fightHandle,
	[RougeMapEnum.EventType.Reward] = RougeMapEventComp.choiceHandle,
	[RougeMapEnum.EventType.Choice] = RougeMapEventComp.choiceHandle,
	[RougeMapEnum.EventType.Store] = RougeMapEventComp.storeHandle,
	[RougeMapEnum.EventType.Rest] = RougeMapEventComp.choiceHandle
}

function RougeMapEventComp:destroy()
	return
end

return RougeMapEventComp
