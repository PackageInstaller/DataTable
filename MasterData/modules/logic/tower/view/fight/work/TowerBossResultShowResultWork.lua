-- chunkname: @modules/logic/tower/view/fight/work/TowerBossResultShowResultWork.lua

module("modules.logic.tower.view.fight.work.TowerBossResultShowResultWork", package.seeall)

local TowerBossResultShowResultWork = class("TowerBossResultShowResultWork", BaseWork)
local SHOW_TIME = 1

function TowerBossResultShowResultWork:ctor(goResult, audioId, callback, callbackObj)
	self.goResult = goResult
	self.audioId = audioId
	self.callback = callback
	self.callbackObj = callbackObj
end

function TowerBossResultShowResultWork:onStart()
	gohelper.setActive(self.goResult, true)

	if self.audioId then
		AudioMgr.instance:trigger(self.audioId)
	end

	if self.callback then
		self.callback(self.callbackObj)
	end

	TaskDispatcher.runDelay(self._delayFinish, self, SHOW_TIME)
end

function TowerBossResultShowResultWork:_delayFinish()
	self:onDone(true)
end

function TowerBossResultShowResultWork:clearWork()
	TaskDispatcher.cancelTask(self._delayFinish, self)
end

return TowerBossResultShowResultWork
