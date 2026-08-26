-- chunkname: @modules/live2d/Live2dVoiceFace.lua

module("modules.live2d.Live2dVoiceFace", package.seeall)

local Live2dVoiceFace = class("Live2dVoiceFace")

function Live2dVoiceFace:ctor()
	return
end

function Live2dVoiceFace:onDestroy()
	self:removeTaskActions()
	TaskDispatcher.cancelTask(self._voiceStopPlayNormal, self)

	self._spineVoice = nil
	self._voiceConfig = nil
	self._spine = nil
end

function Live2dVoiceFace:setFaceAnimation(name, loop)
	if string.find(name, "_biyan") then
		loop = false
	end

	self._loop = loop

	TaskDispatcher.cancelTask(self._nonLoopFaceEnd, self)

	self._lastFaceName = name

	self:_doSetFaceAnimation(name, loop)
end

function Live2dVoiceFace:_doSetFaceAnimation(name, loop)
	if name ~= self._spine:getCurFace() then
		self._spine:setFaceAnimation(name, loop, self._mixTime or 0.5)
	end
end

function Live2dVoiceFace:init(spineVoice, voiceConfig, spine)
	self._spineVoice = spineVoice
	self._inStory = self._spineVoice:getInStory()
	self._voiceConfig = voiceConfig
	self._spine = spine

	local face = self:getFace(voiceConfig)

	self:playFaceActionList(face)
end

function Live2dVoiceFace:getFace(voiceCo)
	local shortcut = self._spineVoice:getVoiceLang()

	if shortcut == "zh" then
		return voiceCo.face
	else
		return voiceCo[shortcut .. "face"] or voiceCo.face
	end
end

function Live2dVoiceFace:_configValidity(list, spine)
	for i = #list, 1, -1 do
		local action = list[i]
		local actionParam = string.split(action, "#")
		local invalid = true

		if #actionParam >= 3 then
			local str = "e_" .. actionParam[1]

			if spine:hasExpression(str) then
				invalid = false
			end
		end

		if invalid then
			logError(string.format("id：%s 语音 face 无效的配置：%s face:%s", self._voiceConfig.audio, action, self:getFace(self._voiceConfig)))
			table.remove(list, i)
		end
	end
end

function Live2dVoiceFace:playFaceActionList(face)
	self._faceStart = 0
	self._time = Time.time

	if not string.nilorempty(face) then
		self._faceList = string.split(face, "|")

		self:_configValidity(self._faceList, self._spine)
	else
		self._faceList = {}
	end

	self:removeTaskActions()
	TaskDispatcher.runRepeat(self._check, self, 0.1)

	if self._inStory then
		TaskDispatcher.cancelTask(self._voiceStopPlayNormal, self)

		if #self._faceList == 0 then
			self:_voiceStopPlayNormal()
		end
	end
end

function Live2dVoiceFace:_check()
	local action = self._faceList[1]

	if action then
		local actionParam = string.split(action, "#")

		if #actionParam >= 3 then
			local faceActionName = "e_" .. actionParam[1]
			local startTime = tonumber(actionParam[2])
			local endTime = tonumber(actionParam[3])
			local time = Time.time - self._time

			if time < startTime then
				self:_doSetFaceAnimation(StoryAnimName.E_ZhengChang)
			elseif time < endTime then
				self:_doSetFaceAnimation(faceActionName)
			else
				table.remove(self._faceList, 1)
			end

			return
		end

		return
	end

	self:removeTaskActions()
	self:_onFaceEnd()
	self:_doSetFaceAnimation(StoryAnimName.E_ZhengChang, true)
end

function Live2dVoiceFace:_playFaceAction(setTransition)
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

function Live2dVoiceFace:_onFaceEnd()
	self._spineVoice:_onComponentStop(self)
end

function Live2dVoiceFace:setNormal()
	self:setFaceAnimation(StoryAnimName.E_ZhengChang, true)
end

function Live2dVoiceFace:_faceActionDelay()
	local needBiyan = self:_needBiYan(self._faceActionName)

	self:setFaceAnimation(self._faceActionName, self._setLoop)

	if not string.find(self._faceActionName, "_biyan") then
		self:setBiYan(needBiyan)
	end
end

function Live2dVoiceFace:setBiYan(needBiyan)
	if not self._spine then
		return
	end

	if needBiyan then
		self._spine:setTransition(StoryAnimName.H_BiYan, false, 0)
	elseif needBiyan == false then
		self._spine:setTransition(StoryAnimName.H_ZhengYan, false, 0)
	end
end

function Live2dVoiceFace:_needBiYan(targetFaceName)
	local faceName = self._spine:getCurFace()
	local biyan = faceName and not string.find(faceName, "_biyan")

	if biyan and self._diffFaceBiYan then
		biyan = targetFaceName ~= self._lastFaceName and true or nil
	end

	return biyan
end

function Live2dVoiceFace:setDiffFaceBiYan(value)
	self._diffFaceBiYan = value
end

function Live2dVoiceFace:checkFaceEnd(actName)
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

function Live2dVoiceFace:_nonLoopFaceEnd()
	self:_playFaceAction(true)
end

function Live2dVoiceFace:removeTaskActions()
	TaskDispatcher.cancelTask(self._faceActionDelay, self)
	TaskDispatcher.cancelTask(self._nonLoopFaceEnd, self)
	TaskDispatcher.cancelTask(self._check, self)
end

function Live2dVoiceFace:onVoiceStop()
	self:removeTaskActions()

	if self._inStory then
		TaskDispatcher.cancelTask(self._voiceStopPlayNormal, self)
		TaskDispatcher.runDelay(self._voiceStopPlayNormal, self, 0)
	else
		self:_voiceStopPlayNormal()
	end
end

function Live2dVoiceFace:_voiceStopPlayNormal()
	self:_doSetFaceAnimation(StoryAnimName.E_ZhengChang, true)
end

return Live2dVoiceFace
