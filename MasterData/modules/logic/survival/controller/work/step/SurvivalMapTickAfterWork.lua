-- chunkname: @modules/logic/survival/controller/work/step/SurvivalMapTickAfterWork.lua

module("modules.logic.survival.controller.work.step.SurvivalMapTickAfterWork", package.seeall)

local SurvivalMapTickAfterWork = class("SurvivalMapTickAfterWork", SurvivalStepBaseWork)

function SurvivalMapTickAfterWork:onStart2(context)
	if not self._stepMo.paramInt[1] then
		if not self._stepMo.paramInt[2] then
			local totalRound = 0

			if not self._stepMo.paramInt[3] then
				local reason = 0

				self._curRound = self._stepMo.paramInt[1]
				self._totalRound = totalRound

				if reason == 2 and not self.context.fastExecute then
					SurvivalController.instance:dispatchEvent(SurvivalEvent.ShowSurvivalHeroTick, self._stepMo.paramInt[1], totalRound)
					TaskDispatcher.runDelay(self._delayDone, self, SurvivalConst.PlayerMoveSpeed)
					ViewMgr.instance:closeAllPopupViews()

					local player = SurvivalMapModel.instance:getSceneMo().player
					local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(player.pos.q, player.pos.r)

					SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, Vector3(x, y, z))
					UIBlockMgrExtend.setNeedCircleMv(false)

					if self._stepMo.paramInt[1] == 1 then
						AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_dutiao_loop)
					end

					UIBlockHelper.instance:startBlock("SurvivalMapTickAfterWork", SurvivalConst.PlayerMoveSpeed)
				else
					self:onDone(true)
				end
			end
		end
	end
end

function SurvivalMapTickAfterWork:_delayDone()
	if self._curRound == self._totalRound then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.stop_ui_fuleyuan_tansuo_dutiao_loop)
	end

	self:onDone(true)
end

function SurvivalMapTickAfterWork:clearWork()
	UIBlockMgrExtend.setNeedCircleMv(true)
	TaskDispatcher.cancelTask(self._delayDone, self)
end

function SurvivalMapTickAfterWork:getRunOrder(params, flow)
	return SurvivalEnum.StepRunOrder.Before
end

return SurvivalMapTickAfterWork
