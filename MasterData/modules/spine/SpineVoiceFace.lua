-- chunkname: @modules/spine/SpineVoiceFace.lua

module("modules.spine.SpineVoiceFace", package.seeall)

local SpineVoiceFace = class("SpineVoiceFace")
local biYanName = "_biyan"

function SpineVoiceFace:ctor()
	return
end

function SpineVoiceFace:onDestroy()
	self:removeTaskActions()
	TaskDispatcher.cancelTask(self._stopTransition, self)

	self._spineVoice = nil
	self._voiceConfig = nil
	self._spine = nil
end

function SpineVoiceFace:setFaceAnimation(name, loop)
	if string.find(name, biYanName) then
		loop = false
	end

	self._loop = loop

	TaskDispatcher.cancelTask(self._nonLoopFaceEnd, self)

	self._lastFaceName = name

	self:_doSetFaceAnimation(name, loop)
end

function SpineVoiceFace:_doSetFaceAnimation(name, loop)
	if name ~= self._spine:getCurFace() then
		if not self._mixTime then
			local time = 0.5

			if string.find(name, biYanName) then
				time = 0.3
			end

			self._spine:setFaceAnimation(name, loop, self._mixTime)
		end
	end
end

function SpineVoiceFace:init(spineVoice, voiceConfig, spine)
	self._spineVoice = spineVoice
	self._voiceConfig = voiceConfig
	self._spine = spine

	local face = self:getFace(voiceConfig)

	self:playFaceActionList(face)
end

function SpineVoiceFace:getFace(voiceCo)
	local shortcut = self._spineVoice:getVoiceLang()

	if shortcut == "zh" then
		return voiceCo.face
	else
		return voiceCo[shortcut .. "face"] or voiceCo.face
	end
end

function SpineVoiceFace:_configValidity(list, spine)
	for i = #list, 1, -1 do
		local action = list[i]
		local actionParam = string.split(action, "#")
		local invalid = true

		if #actionParam >= 3 then
			local str = "e_" .. actionParam[1]

			if spine:hasAnimation(str) then
				invalid = false
			end
		end

		if invalid then
			logError(string.format("id：%s 语音 face 无效的配置：%s face:%s", self._voiceConfig.audio, action, self:getFace(self._voiceConfig)))
			table.remove(list, i)
		end
	end
end

function SpineVoiceFace:playFaceActionList(face)
	self._faceStart = 0

	if not string.nilorempty(face) then
		self._faceList = string.split(face, "|")

		self:_configValidity(self._faceList, self._spine)
	else
		self._faceList = {}
	end

	self:_playFaceAction(self._diffFaceBiYan)
end

function SpineVoiceFace:_playFaceAction(setTransition)
	self._faceActionName = nil

	local showNormal = true

	self:removeTaskActions()

	local isEnd = true

	if #self._faceList > 0 then
		local action = table.remove(self._faceList, 1)
		local actionParam = string.split(action, "#")

		if #actionParam >= 3 then
			self._faceActionName = "e_" .. actionParam[1]

			local startTime = tonumber(actionParam[2])
			local endTime = tonumber(actionParam[3])

			self._faceActionDuration = endTime - startTime
			self._mixTime = tonumber(actionParam[4])
			self._setLoop = actionParam[5] == nil
			self._delayTime = startTime - self._faceStart
			self._faceStart = endTime
			self._faceActionStartTime = Time.time

			if self._delayTime > 0 then
				TaskDispatcher.runDelay(self._faceActionDelay, self, self._delayTime)
			else
				showNormal = false

				self:_faceActionDelay()
			end

			isEnd = false
		end
	end

	if showNormal then
		local needBiyan = self:_needBiYan(StoryAnimName.E_ZhengChang)

		self:setNormal()

		if setTransition then
			self:setBiYan(needBiyan)
		end
	end

	if isEnd then
		self:_onFaceEnd()
	end
end

function SpineVoiceFace:_onFaceEnd()
	self._spineVoice:_onComponentStop(self)
end

function SpineVoiceFace:setNormal()
	self:setFaceAnimation(StoryAnimName.E_ZhengChang, true)
end

function SpineVoiceFace:_faceActionDelay()
	local needBiyan = self:_needBiYan(self._faceActionName)

	self:setFaceAnimation(self._faceActionName, self._setLoop)

	if not string.find(self._faceActionName, biYanName) then
		self:setBiYan(needBiyan)
	end
end

function SpineVoiceFace:setBiYan(needBiyan)
	if not self._spine then
		return
	end

	if needBiyan then
		self._spine:setTransition(StoryAnimName.H_BiYan, false, 0)
	elseif needBiyan == false then
		self._spine:setTransition(StoryAnimName.H_ZhengYan, false, 0)
	end

	TaskDispatcher.cancelTask(self._stopTransition, self)
	TaskDispatcher.runDelay(self._stopTransition, self, 1)
end

function SpineVoiceFace:_stopTransition()
	self._spine:stopTransition()
end

function SpineVoiceFace:_needBiYan(targetFaceName)
	if self._diffFaceBiYan then
		if not self._lastFaceName then
			local faceName = self._spine:getCurFace()
			local biyan = faceName and not string.find(faceName, biYanName)

			if biyan and self._diffFaceBiYan then
				biyan = targetFaceName ~= self._lastFaceName and true or nil
			end

			return biyan
		end
	end
end

function SpineVoiceFace:setDiffFaceBiYan(value)
	self._diffFaceBiYan = value
end

function SpineVoiceFace:checkFaceEnd(actName)
	if actName == self._faceActionName then
		local endTime = self._faceActionStartTime + self._faceActionDuration + self._delayTime
		local curTime = Time.time

		if endTime <= curTime then
			self:_playFaceAction(true)

			return true
		end

		if not self._loop then
			local delayTime = endTime - curTime

			TaskDispatcher.runDelay(self._nonLoopFaceEnd, self, delayTime)
		end

		return true
	end
end

function SpineVoiceFace:_nonLoopFaceEnd()
	self:_playFaceAction(true)
end

function SpineVoiceFace:removeTaskActions()
	TaskDispatcher.cancelTask(self._faceActionDelay, self)
	TaskDispatcher.cancelTask(self._nonLoopFaceEnd, self)
end

function SpineVoiceFace:onVoiceStop()
	self:removeTaskActions()
	self:_doSetFaceAnimation(StoryAnimName.E_ZhengChang, true)
end

return SpineVoiceFace
