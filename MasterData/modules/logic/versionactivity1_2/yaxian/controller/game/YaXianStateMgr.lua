-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/YaXianStateMgr.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.YaXianStateMgr", package.seeall)

local YaXianStateMgr = class("YaXianStateMgr")

function YaXianStateMgr:ctor()
	self._curEventData = nil
	self._curEvent = nil
end

YaXianStateMgr.EventClzMap = {
	[YaXianGameEnum.GameStateType.Battle] = YaXianStateBattle,
	[YaXianGameEnum.GameStateType.UseItem] = YaXianStateUseItem,
	[YaXianGameEnum.GameStateType.FinishEvent] = YaXianStateFinishEvent
}

function YaXianStateMgr:setCurEvent(serverEvt)
	self._curEventData = serverEvt ~= nil and not string.nilorempty(serverEvt.param) and cjson.decode(serverEvt.param) or nil

	self:buildEventState()
end

function YaXianStateMgr:setCurEventByObj(obj)
	self._curEventData = obj and obj or nil

	self:buildEventState()
end

function YaXianStateMgr:buildEventState()
	local eventType = not self._curEventData and YaXianGameEnum.GameStateType.Normal or self._curEventData.eventType

	if self._curEvent and self._curEvent:getStateType() == eventType then
		return
	end

	local clz = YaXianStateMgr.EventClzMap[eventType]

	if clz then
		self:disposeEventState()

		self._curEvent = clz.New()

		self._curEvent:init(self._curEventData)
		self._curEvent:start()
	end
end

function YaXianStateMgr:setLockState()
	self:disposeEventState()

	self._curEventData = nil
	self._curEvent = YaXianStateLock.New()

	self._curEvent:init()
	self._curEvent:start()
end

function YaXianStateMgr:disposeEventState()
	if self._curEvent ~= nil then
		self._curEvent:dispose()

		self._curEvent = nil
	end
end

function YaXianStateMgr:getCurEvent()
	return self._curEvent
end

function YaXianStateMgr:removeAll()
	self:disposeEventState()
end

return YaXianStateMgr
