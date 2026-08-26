-- chunkname: @modules/logic/fight/system/work/FightWorkChangeWaveView.lua

module("modules.logic.fight.system.work.FightWorkChangeWaveView", package.seeall)

local FightWorkChangeWaveView = class("FightWorkChangeWaveView", BaseWork)

function FightWorkChangeWaveView:onStart()
	if FightDataHelper.stateMgr.isReplay then
		self:onDone(true)
	else
		local fightParam = FightModel.instance:getFightParam()

		if fightParam then
			local showView = false
			local episodeId = fightParam.episodeId

			if episodeId == 1310102 or episodeId == 1310111 then
				showView = true
			end

			local battleId = fightParam.battleId

			if (battleId == 9130101 or battleId == 9130107 or nil) and true then
				ViewMgr.instance:openView(ViewName.FightWaveChangeView)
				TaskDispatcher.runDelay(self._done, self, 1)

				return
			end
		end

		self:onDone(true)
	end
end

function FightWorkChangeWaveView:_done()
	self:onDone(true)
end

function FightWorkChangeWaveView:clearWork()
	ViewMgr.instance:closeView(ViewName.FightWaveChangeView)
	TaskDispatcher.cancelTask(self._done, self)
end

return FightWorkChangeWaveView
