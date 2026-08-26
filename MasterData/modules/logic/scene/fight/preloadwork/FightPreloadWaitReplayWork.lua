-- chunkname: @modules/logic/scene/fight/preloadwork/FightPreloadWaitReplayWork.lua

module("modules.logic.scene.fight.preloadwork.FightPreloadWaitReplayWork", package.seeall)

local FightPreloadWaitReplayWork = class("FightPreloadWaitReplayWork", BaseWork)

function FightPreloadWaitReplayWork:onStart(context)
	local fightParam = FightModel.instance:getFightParam()

	if fightParam and fightParam.isReplay then
		if FightDataHelper.stateMgr.isReplay then
			self:onDone(true)
		else
			FightController.instance:registerCallback(FightEvent.StartReplay, self._onStartReplay, self)
		end
	else
		self:onDone(true)
	end
end

function FightPreloadWaitReplayWork:_onStartReplay()
	self:onDone(true)
end

function FightPreloadWaitReplayWork:clearWork()
	FightController.instance:unregisterCallback(FightEvent.StartReplay, self._onStartReplay, self)
end

return FightPreloadWaitReplayWork
