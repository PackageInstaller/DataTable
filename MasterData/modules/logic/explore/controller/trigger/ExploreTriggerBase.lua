-- chunkname: @modules/logic/explore/controller/trigger/ExploreTriggerBase.lua

module("modules.logic.explore.controller.trigger.ExploreTriggerBase", package.seeall)

local ExploreTriggerBase = class("ExploreTriggerBase", BaseWork)

function ExploreTriggerBase:onStart()
	if self.isCancel then
		self:cancel(self._param, self._unit)
	else
		self:handle(self._param, self._unit)
	end
end

function ExploreTriggerBase:setParam(v, unit, stepIndex, clientOnly, isCancel)
	self._recordLen = 0
	self._param = v
	self._unit = unit
	self.unitId = unit.id
	self.unitType = self._unit:getUnitType()
	self.stepIndex = stepIndex
	self.clientOnly = clientOnly
	self.isCancel = isCancel
end

function ExploreTriggerBase:onReply(cmd, resultCode, msg)
	self:onDone(true)
end

function ExploreTriggerBase:sendTriggerRequest(params)
	if not self.stepIndex then
		self:onDone(false)

		return
	end

	ExploreRpc.instance:sendExploreInteractRequest(self.unitId, self.stepIndex, params or "", self.onRequestCallBack, self)
end

function ExploreTriggerBase:onRequestCallBack(cmd, resultCode, msg)
	if resultCode == 0 then
		self:onReply(cmd, resultCode, msg)
	else
		self:onDone(false)
	end
end

function ExploreTriggerBase:onStepDone(v)
	self:onDone(v)
end

function ExploreTriggerBase:handle()
	self:onDone(true)
end

function ExploreTriggerBase:cancel()
	self:onDone(true)
end

return ExploreTriggerBase
