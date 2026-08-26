-- chunkname: @modules/logic/versionactivity3_8/echosong/view/comp/V3a8EchoSongTipComp.lua

module("modules.logic.versionactivity3_8.echosong.view.comp.V3a8EchoSongTipComp", package.seeall)

local V3a8EchoSongTipComp = class("V3a8EchoSongTipComp", V3a8EchoSongBaseComp)

function V3a8EchoSongTipComp:getRecordInfo()
	return nil
end

function V3a8EchoSongTipComp:rollback(info)
	self._lastTriggerTime = Time.time
end

function V3a8EchoSongTipComp:_onInitComp()
	self._tempPos = Vector3()
	self._lastTriggerTime = Time.time

	TaskDispatcher.runRepeat(self._frameUpdate, self, 0)
	self.addEventCb(self, V3a8EchoSongController.instance, V3a8EchoSongEvent.PauseGame, self._onPauseGame, self)
	self.addEventCb(self, V3a8EchoSongController.instance, V3a8EchoSongEvent.ResumeGame, self._onResumeGame, self)
end

function V3a8EchoSongTipComp:_frameUpdate()
	if Time.time - self._lastTriggerTime >= 3 then
		self:_showEffect()
	end
end

function V3a8EchoSongTipComp:_showEffect()
	self._lastTriggerTime = Time.time

	local posX, posY = transformhelper.getPos(self._go.transform)

	self._tempPos.x = posX
	self._tempPos.y = posY

	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.EmittedParticle, self._tempPos, V3a8EchoSongEnum.ParticleType.Tip, V3a8EchoSongEnum.ParticleLifeTime.Tip)
end

function V3a8EchoSongTipComp:_onPauseGame()
	self._pauseTime = Time.time

	TaskDispatcher.cancelTask(self._frameUpdate, self)
end

function V3a8EchoSongTipComp:_onResumeGame()
	if self._pauseTime then
		local pauseDuration = Time.time - self._pauseTime

		if pauseDuration > 0 and self._lastTriggerTime then
			self._lastTriggerTime = self._lastTriggerTime + pauseDuration
		end

		self._pauseTime = nil
	end

	TaskDispatcher.cancelTask(self._frameUpdate, self)
	TaskDispatcher.runRepeat(self._frameUpdate, self, 0)
end

function V3a8EchoSongTipComp:onDestroy()
	TaskDispatcher.cancelTask(self._frameUpdate, self)
end

return V3a8EchoSongTipComp
