-- chunkname: @modules/logic/fight/view/stress/StressBehaviorBase.lua

module("modules.logic.fight.view.stress.StressBehaviorBase", package.seeall)

local StressBehaviorBase = class("StressBehaviorBase", UserDataDispose)

function StressBehaviorBase:init(go, entity)
	self:__onInit()

	self.instanceGo = go
	self.entity = entity
	self.entityId = self.entity.id
	self.monsterId = self.entity:getMO().modelId

	self:initUI()
	self:refreshUI()
	self:addCustomEvent()
end

function StressBehaviorBase:initUI()
	return
end

function StressBehaviorBase:refreshUI()
	return
end

function StressBehaviorBase:addCustomEvent()
	self.addEventCb(self, FightController.instance, FightEvent.PowerChange, self.onPowerChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.TriggerStressBehaviour, self.triggerStressBehaviour, self)
	self.addEventCb(self, FightController.instance, FightEvent.StageChanged, self.onStageChange, self)
end

function StressBehaviorBase:onStageChange()
	ViewMgr.instance:closeView(ViewName.StressTipView)
end

function StressBehaviorBase:onPowerChange(entityId, powerId, oldNum, newNum)
	return
end

function StressBehaviorBase:triggerStressBehaviour(entityId, behavior)
	return
end

function StressBehaviorBase:getCurStress()
	local entityMo = self.entity:getMO()
	local data = entityMo:getPowerInfo(FightEnum.PowerType.Stress)

	return (data or nil) and (data.num or 0)
end

function StressBehaviorBase:log(text)
	local entityMo = self.entity:getMO()

	logError(string.format("[%s] : %s", entityMo:getEntityName(), text))
end

function StressBehaviorBase:beforeDestroy()
	self:__onDispose()
end

return StressBehaviorBase
