-- chunkname: @modules/logic/tower/view/fight/work/TowerBossResultShowLevChangeWork.lua

module("modules.logic.tower.view.fight.work.TowerBossResultShowLevChangeWork", package.seeall)

local TowerBossResultShowLevChangeWork = class("TowerBossResultShowLevChangeWork", BaseWork)
local SHOW_TIME = 2

function TowerBossResultShowLevChangeWork:ctor(goBossLevChange, goBoss, isBossLevChange)
	self.goBossLevChange = goBossLevChange
	self.goBoss = goBoss
	self.isBossLevChange = isBossLevChange
end

function TowerBossResultShowLevChangeWork:onStart()
	gohelper.setActive(self.goBossLevChange, true)
	gohelper.setActive(self.goBoss, true)

	if not self.isBossLevChange then
		self:onDone(true)
	else
		TaskDispatcher.runDelay(self._triggerAudio, self, 0.8)
	end

	TaskDispatcher.runDelay(self._delayFinish, self, SHOW_TIME)
end

function TowerBossResultShowLevChangeWork:_triggerAudio()
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_level_up)
end

function TowerBossResultShowLevChangeWork:_delayFinish()
	self:onDone(true)
end

function TowerBossResultShowLevChangeWork:clearWork()
	gohelper.setActive(self.goBossLevChange, false)
	TaskDispatcher.cancelTask(self._delayFinish, self)
	TaskDispatcher.cancelTask(self._triggerAudio, self)
end

return TowerBossResultShowLevChangeWork
