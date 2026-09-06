-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/buff/OriMatGameBuffBase.lua

module("logic.extensions.orimatgame.model.buff.OriMatGameBuffBase", package.seeall)

local OriMatGameBuffBase = class("OriMatGameBuffBase")

function OriMatGameBuffBase:ctor(name)
	self.buffName = name
	self.buffCfgId = 0
	self.triggerStage = 0
	self.isAdded = false
	self._layerCount = 0
	self._layerLimit = 1
	self._paramIdx = 1
end

function OriMatGameBuffBase:gPId()
	self._paramIdx = self._paramIdx + 1

	return self._paramIdx
end

function OriMatGameBuffBase:resetParamIdx()
	self._paramIdx = 1
end

function OriMatGameBuffBase:initData(unit, buffCfgId, triggerStage, data)
	self._paramIdx = 1
	self._unit = unit
	self.buffCfgId = buffCfgId
	self.triggerStage = triggerStage
	self.data = data
	self._conditionType = data.conditionType
	self._conditionParam = data.conditionParam
	self._tiggerParam = OriMatGameBuffMgr.instance:getTriggerParam(data.TriggerParam)
	self._layerCount = 0
	self._layerLimit = math.max(1, checknumber(data.triggerCount))

	self:initComplete()
	self:_clearLast()
end

function OriMatGameBuffBase:initComplete()
	self.isAdded = false
end

function OriMatGameBuffBase:setIsAdded()
	self.isAdded = true
end

function OriMatGameBuffBase:getIsAdded()
	return self.isAdded
end

function OriMatGameBuffBase:_clearLast()
	self._target = nil
end

function OriMatGameBuffBase:addLayerCount()
	self._layerCount = self._layerCount + 1
	self._layerCount = math.min(self._layerLimit, self._layerCount)
end

function OriMatGameBuffBase:onUpdate(dt)
	return
end

function OriMatGameBuffBase:onAdd(target)
	self:_clearLast()

	self._target = target

	self:checkStageAndDone(OriMatGameBuffMgr.TRIGGER_STAGE_CREATE)
end

function OriMatGameBuffBase:onAttack(target)
	self:_clearLast()

	self._target = target

	self:checkStageAndDone(OriMatGameBuffMgr.TRIGGER_STAGE_ATTACK)
end

function OriMatGameBuffBase:onHit(target)
	self:_clearLast()

	self._target = target

	self:checkStageAndDone(OriMatGameBuffMgr.TRIGGER_STAGE_HIT)
end

function OriMatGameBuffBase:onBeHit(target)
	self:_clearLast()

	self._target = target

	self:checkStageAndDone(OriMatGameBuffMgr.TRIGGER_STAGE_BEHIT)
end

function OriMatGameBuffBase:onBeforeDoDamage(target)
	self:_clearLast()

	self._target = target

	self:checkStageAndDone(OriMatGameBuffMgr.TRIGGER_STAGE_CAUSE_DAMAGE_BF)
end

function OriMatGameBuffBase:onAfterDoDamage(target, damage)
	self:_clearLast()

	self._target = target
	self._damage = damage

	self:checkStageAndDone(OriMatGameBuffMgr.TRIGGER_STAGE_DAMAGE_BF)
end

function OriMatGameBuffBase:onBeforeBeDamage(target, damage)
	self:_clearLast()

	self._target = target
	self._damage = damage

	self:checkStageAndDone(OriMatGameBuffMgr.TRIGGER_STAGE_DAMAGE_AF)
end

function OriMatGameBuffBase:onAfterBeDamage(unit, damage)
	self:_clearLast()

	self._target = unit
	self._damage = damage

	self:checkStageAndDone(OriMatGameBuffMgr.TRIGGER_STAGE_CAUSE_DAMAGE_AF)
end

function OriMatGameBuffBase:checkStageAndDone(stage)
	if self.triggerStage == stage and self:_checkCondition() then
		self:onBuffTrigger()
	end
end

function OriMatGameBuffBase:onRemove(unit)
	self:_clearLast()
end

function OriMatGameBuffBase:onBuffTrigger()
	return
end

function OriMatGameBuffBase:_checkCondition()
	if self._conditionType == nil then
		return true
	elseif self._conditionType == "" then
		return true
	end
end

return OriMatGameBuffBase
