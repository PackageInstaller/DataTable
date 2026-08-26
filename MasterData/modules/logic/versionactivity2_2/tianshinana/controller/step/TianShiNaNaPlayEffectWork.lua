-- chunkname: @modules/logic/versionactivity2_2/tianshinana/controller/step/TianShiNaNaPlayEffectWork.lua

module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaPlayEffectWork", package.seeall)

local TianShiNaNaPlayEffectWork = class("TianShiNaNaPlayEffectWork", BaseWork)

function TianShiNaNaPlayEffectWork:setWalkPath(playerWalkPaths)
	self._playerWalkPaths = playerWalkPaths
end

function TianShiNaNaPlayEffectWork:onStart(context)
	local len = #self._playerWalkPaths

	if len == 0 then
		self:onDone(true)
	else
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.play_ui_youyu_paving_succeed)

		for i = 1, len do
			local point = self._playerWalkPaths[i]

			TianShiNaNaEffectPool.instance:getFromPool(point.x, point.y, 2, (i - 1) * 0.1, 0.1)
		end

		TaskDispatcher.runDelay(self._delayDone, self, len * 0.1)
	end
end

function TianShiNaNaPlayEffectWork:_delayDone()
	self:onDone(true)
end

function TianShiNaNaPlayEffectWork:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return TianShiNaNaPlayEffectWork
