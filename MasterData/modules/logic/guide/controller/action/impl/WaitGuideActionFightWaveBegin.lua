-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionFightWaveBegin.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionFightWaveBegin", package.seeall)

local WaitGuideActionFightWaveBegin = class("WaitGuideActionFightWaveBegin", BaseGuideAction)

function WaitGuideActionFightWaveBegin:onStart(context)
	WaitGuideActionFightWaveBegin.super.onStart(self, context)
	FightController.instance:registerCallback(FightEvent.OnBeginWave, self._onBeginWave, self)

	self._groundId = tonumber(self.actionParam)
end

function WaitGuideActionFightWaveBegin:_onBeginWave()
	if self._groundId and FightModel.instance:getCurMonsterGroupId() ~= self._groundId then
		return
	end

	FightController.instance:unregisterCallback(FightEvent.OnBeginWave, self._onBeginWave, self)
	self:onDone(true)
end

function WaitGuideActionFightWaveBegin:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnBeginWave, self._onBeginWave, self)
end

return WaitGuideActionFightWaveBegin
