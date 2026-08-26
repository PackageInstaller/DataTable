-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionFightEndPause.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionFightEndPause", package.seeall)

local WaitGuideActionFightEndPause = class("WaitGuideActionFightEndPause", BaseGuideAction)

function WaitGuideActionFightEndPause:onStart(context)
	WaitGuideActionFightEndPause.super.onStart(self, context)

	self._needSuccess = self.actionParam == "1"

	if self.actionParam and string.find(self.actionParam, ",") then
		local actionParams = string.splitToNumber(self.actionParam, ",")

		self._needSuccess = actionParams[1]
		self._episodeId = actionParams[2]
	end

	FightController.instance:registerCallback(FightEvent.OnGuideFightEndPause, self._onGuideFightEndPause, self)
end

function WaitGuideActionFightEndPause:_onGuideFightEndPause(guideParam)
	local fightRecordMO = FightModel.instance:getRecordMO()

	if self._episodeId then
		local fightParam = FightModel.instance:getFightParam()

		if self._episodeId == fightParam.episodeId then
			if self._needSuccess then
				if fightRecordMO.fightResult == FightEnum.FightResult.Succ then
					guideParam.OnGuideFightEndPause = true

					FightController.instance:unregisterCallback(FightEvent.OnGuideFightEndPause, self._onGuideFightEndPause, self)
					self:onDone(true)
				end
			else
				guideParam.OnGuideFightEndPause = true

				FightController.instance:unregisterCallback(FightEvent.OnGuideFightEndPause, self._onGuideFightEndPause, self)
				self:onDone(true)
			end
		end
	elseif self._needSuccess then
		if fightRecordMO.fightResult == FightEnum.FightResult.Succ then
			guideParam.OnGuideFightEndPause = true

			FightController.instance:unregisterCallback(FightEvent.OnGuideFightEndPause, self._onGuideFightEndPause, self)
			self:onDone(true)
		end
	else
		guideParam.OnGuideFightEndPause = true

		FightController.instance:unregisterCallback(FightEvent.OnGuideFightEndPause, self._onGuideFightEndPause, self)
		self:onDone(true)
	end
end

function WaitGuideActionFightEndPause:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnGuideFightEndPause, self._onGuideFightEndPause, self)
end

return WaitGuideActionFightEndPause
