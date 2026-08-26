-- chunkname: @modules/logic/versionactivity3_7/travelgo/controller/work/event/TravelGoBattleEventWork.lua

module("modules.logic.versionactivity3_7.travelgo.controller.work.event.TravelGoBattleEventWork", package.seeall)

local TravelGoBattleEventWork = class("TravelGoBattleEventWork", BaseWork)

function TravelGoBattleEventWork:ctor()
	return
end

function TravelGoBattleEventWork:onStart()
	TravelGoController.instance:registerCallback(TravelGoEvent.OnBattleEventFinish, self.onBattleEventFinish, self)
	self:createEnemy()

	self.flow = FlowSequence.New()

	TravelGoController.instance:dispatchEvent(TravelGoEvent.OnPlayerStopMove)

	local uidStr = self.enemyUid

	self.flow:addWork(WaitEventWork.New("TravelGoController;TravelGoEvent;OnCreateEntityComplete;" .. uidStr))
	self.flow:addWork(TravelGoDispatchEventWork.New(TravelGoEvent.OnPlayerMoveToEventPos, {
		isBattle = true
	}))
	self.flow:addWork(TimerWork.New(TravelGoController.instance.PlayerMoveToTime))
	self.flow:addWork(TravelGoDispatchEventWork.New(TravelGoEvent.OnStartBattleEvent))
	self.flow:start()
end

function TravelGoBattleEventWork:createEnemy()
	local travelGoEventMO = TravelGoModel.instance.travelGoEventMO
	local enemyCfgId = travelGoEventMO.cfg.npc
	local entity = TravelGoController.instance.travelGoEntityMgr:createEnemyEntity(enemyCfgId)

	self.enemyUid = entity.uid
end

function TravelGoBattleEventWork:onBattleEventFinish()
	self:onDone(true)
end

function TravelGoBattleEventWork:clearWork()
	TravelGoController.instance:unregisterCallback(TravelGoEvent.OnBattleEventFinish, self.onBattleEventFinish, self)

	if self.enemyUid then
		TravelGoController.instance.travelGoEntityMgr:removeEnemy(self.enemyUid)

		self.enemyUid = nil
	end

	TravelGoController.instance:dispatchEvent(TravelGoEvent.OnPlayerStartMove)
end

return TravelGoBattleEventWork
