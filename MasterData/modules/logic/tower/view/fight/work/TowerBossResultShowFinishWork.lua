-- chunkname: @modules/logic/tower/view/fight/work/TowerBossResultShowFinishWork.lua

module("modules.logic.tower.view.fight.work.TowerBossResultShowFinishWork", package.seeall)

local TowerBossResultShowFinishWork = class("TowerBossResultShowFinishWork", BaseWork)
local SHOW_TIME = 2

function TowerBossResultShowFinishWork:ctor(goFinish, audioId)
	self.goFinish = goFinish
	self.audioId = audioId
end

function TowerBossResultShowFinishWork:onStart()
	gohelper.setActive(self.goFinish, true)

	if self.audioId then
		AudioMgr.instance:trigger(self.audioId)
	end

	TaskDispatcher.runDelay(self._delayFinish, self, SHOW_TIME)
end

function TowerBossResultShowFinishWork:_delayFinish()
	self:onDone(true)
end

function TowerBossResultShowFinishWork:clearWork()
	gohelper.setActive(self.goFinish, false)
	TaskDispatcher.cancelTask(self._delayFinish, self)
end

return TowerBossResultShowFinishWork
