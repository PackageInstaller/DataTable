-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/audio/SoloAudioMgr.lua

module(..., package.seeall)

local SoloAudioMgr = class("SoloAudioMgr")
local UnityTime = UnityEngine.Time

function SoloAudioMgr:ctor()
	self._playingSoloEffTime = 0
	self._playingSoloEff = nil
	self._isPause = false
	self._isStop = false
end

function SoloAudioMgr:playByEvtName(evtName, callbackHandler, callbackTarget)
	self:stopEvt()

	self._isStop = false
	self._playingSoloEff = evtName
	self.lastEvt = nil

	local volum = AudioPlayerEx.instance:getVoiceVolume()

	AudioPlayerEx.instance:playOneShotAttach(evtName, volum, 1, function(evt)
		self._playingSoloEffTime = AudioPlayerEx.instance:getAudioLengthByEvt(evtName) * 0.001
		self.lastEvt = evt

		if callbackHandler then
			if callbackTarget then
				callbackHandler(callbackTarget, evt)
			else
				callbackHandler(evt)
			end
		end

		if self._isStop == true and self.lastEvt then
			AudioPlayerEx.instance:stopEvent(self.lastEvt)

			self.lastEvt = nil
		end
	end)
end

function SoloAudioMgr:pause(pause)
	self._isPause = pause
end

function SoloAudioMgr:stopEvt()
	self._isPause = false

	if not self._playingSoloEff then
		return
	end

	if self.lastEvt then
		AudioPlayerEx.instance:stopEvent(self.lastEvt)

		self.lastEvt = nil
	end

	self._isStop = true
	self._playingSoloEff = nil
	self._playingSoloEffTime = 0
end

function SoloAudioMgr:update()
	if self._isPause == false and self._playingSoloEffTime > 0 then
		self._playingSoloEffTime = self._playingSoloEffTime - UnityTime.unscaledDeltaTime

		if self._playingSoloEffTime <= 0 then
			self._playingSoloEff = nil
			self.lastEvt = nil
		end
	end
end

SoloAudioMgr.instance = SoloAudioMgr.New()

return SoloAudioMgr
