-- chunkname: @modules/live2d/Live2dVoiceMouthOfflineAuto.lua

module("modules.live2d.Live2dVoiceMouthOfflineAuto", package.seeall)

local Live2dVoiceMouthOfflineAuto = class("Live2dVoiceMouthOfflineAuto", SpineVoiceMouth)

Live2dVoiceMouthOfflineAuto.AutoActionName = "_auto"
Live2dVoiceMouthOfflineAuto.AutoMouthThreshold = 0.1

function Live2dVoiceMouthOfflineAuto:_playMouthActionList(mouth)
	self._lastMouthId = nil
	self._lastFaceAction = nil
	self._faceActionSpList = nil
	self._voiceStartTime = Time.time
	self._autoMouthRunning = false
	self._manualMouthRunning = false
	self._forceFace = nil

	if self._forceNoMouth then
		self:_onMouthEnd()

		return
	end

	if self._voiceConfig.heroId == 3038 and not self._hasAudio then
		self:_onMouthEnd()
	end

	logNormal("start audio mouth: " .. tostring(mouth))
	logNormal("start audio face: " .. self:getFace(self._voiceConfig))

	if LuaUtil.isEmptyStr(mouth) then
		if self._hasAudio then
			TaskDispatcher.runRepeat(self._mouthRepeat, self, 0.03, 2000)
		else
			self:_onMouthEnd()
		end
	else
		self._mouthDelayCallbackList = {}

		local mouthActionList

		if not string.nilorempty(mouth) then
			mouthActionList = string.split(mouth, "|")

			self:_configValidity(mouthActionList, self._spine)
		else
			mouthActionList = {}
		end

		self:startLipSync()

		local count = #mouthActionList

		for i, v in ipairs(mouthActionList) do
			local param = string.split(v, "#")
			local mouthAction = param[1]
			local mouthStart = tonumber(param[2])
			local mouthEnd = tonumber(param[3])

			if self:_hasAuto(mouthAction) and mouthAction ~= Live2dVoiceMouthOfflineAuto.AutoActionName then
				self._forceFace = string.gsub(mouthAction, Live2dVoiceMouthOfflineAuto.AutoActionName, "")
				mouthAction = Live2dVoiceMouthOfflineAuto.AutoActionName
			end

			if not self:_hasAuto(mouthAction) then
				self:_addMouth(i == count, mouthAction, mouthStart, mouthEnd)
			end
		end

		if count <= 0 then
			self:_onMouthEnd()
		end
	end
end

function Live2dVoiceMouthOfflineAuto:_hasAuto(action)
	return string.find(action, Live2dVoiceMouthOfflineAuto.AutoActionName)
end

function Live2dVoiceMouthOfflineAuto:_configValidity(list, spine)
	for i = #list, 1, -1 do
		local action = list[i]
		local actionParam = string.split(action, "#")
		local invalid = true

		if #actionParam == 3 then
			local str = "t_" .. actionParam[1]

			if spine:hasAnimation(str) or self:_hasAuto(actionParam[1]) then
				invalid = false
			end
		end

		if invalid then
			logError(string.format("id：%s 语音 mouth 无效的配置：%s mouth:%s", self._voiceConfig.audio, action, self._voiceConfig.mouth))
			table.remove(list, i)
		end
	end
end

function Live2dVoiceMouthOfflineAuto:_addMouth(lastOne, mouthAction, mouthStart, mouthEnd)
	local function startCallback()
		if self._spine then
			self._curMouth = "t_" .. mouthAction
			self._lastFaceAction = mouthAction or self._lastFaceAction
			self._curMouthEnd = nil

			self._spine:setMouthAnimation(self._curMouth, true, 0)

			self._manualMouthRunning = true
		end
	end

	local function stopCallback()
		if self._spine then
			self:stopMouthCallback(true)

			self._manualMouthRunning = false

			if self._autoMouthRunning then
				-- block empty
			end
		end
	end

	table.insert(self._mouthDelayCallbackList, startCallback)
	table.insert(self._mouthDelayCallbackList, stopCallback)

	if mouthStart > 0 then
		TaskDispatcher.runDelay(startCallback, nil, mouthStart)
	else
		startCallback()
	end

	TaskDispatcher.runDelay(stopCallback, nil, mouthEnd)
end

function Live2dVoiceMouthOfflineAuto:startLipSync()
	if self._spine then
		local ctrl = self._spine:getMouthController()

		if not gohelper.isNil(self._spine) then
			self._spine:StartListen()
			TaskDispatcher.runRepeat(self._lipSyncUpdate, self, 0.01, 2000)
		end
	end
end

function Live2dVoiceMouthOfflineAuto:stopLipSync()
	if self._spine then
		local ctrl = self._spine:getMouthController()

		if not gohelper.isNil(self._spine) then
			self._spine:Stop()
		end

		TaskDispatcher.cancelTask(self._lipSyncUpdate, self)
	end
end

function Live2dVoiceMouthOfflineAuto:_lipSyncUpdate()
	local evaluateValue = self._spine._cubismMouthController.MouthValue

	if self._manualMouthRunning then
		return
	end

	local t = Time.time - self._voiceStartTime
	local faceActionList = self:_getFaceActionList()
	local faceAction

	for _, one in ipairs(faceActionList) do
		if t >= one[2] and t < one[3] then
			faceAction = one[1]
		end
	end

	if self._forceFace then
		faceAction = self._forceFace
	end

	local mouthAction = faceAction and "t_" .. faceAction

	self._lastFaceAction = faceAction or self._lastFaceAction

	if evaluateValue > Live2dVoiceMouthOfflineAuto.AutoMouthThreshold then
		if faceAction and self._spine:hasAnimation(mouthAction) then
			if mouthAction ~= self._curMouth then
				self._curMouth = mouthAction
				self._curMouthEnd = nil

				self._spine:setMouthAnimation(self._curMouth, true, 0)
			end
		elseif self._spine:hasAnimation(StoryAnimName.T_ZhengChang) and self._curMouth ~= StoryAnimName.T_ZhengChang then
			self._curMouth = StoryAnimName.T_ZhengChang

			self._spine:setMouthAnimation(self._curMouth, true, 0)
		end
	else
		self:_setBiZui()
	end
end

function Live2dVoiceMouthOfflineAuto:_getFaceActionList()
	if not self._faceActionSpList then
		self._faceActionSpList = {}

		local langFace = self:getFace(self._voiceConfig)
		local faceList = string.split(langFace, "|")

		for _, action in ipairs(faceList) do
			local actionParam = string.split(action, "#")

			if #actionParam >= 3 then
				local faceActionName = actionParam[1]
				local startTime = tonumber(actionParam[2])
				local endTime = tonumber(actionParam[3])

				table.insert(self._faceActionSpList, {
					faceActionName,
					startTime,
					endTime
				})
			end
		end
	end

	return self._faceActionSpList
end

function Live2dVoiceMouthOfflineAuto:_mouthRepeat()
	return
end

function Live2dVoiceMouthOfflineAuto:_setBiZui()
	if not string.nilorempty(self._lastFaceAction) and not self._isVoiceStop then
		local bizuiAction = string.format("t_%s_%s", self._lastFaceAction, "bizui")

		if self._spine:hasAnimation(bizuiAction) then
			if self._curMouth ~= bizuiAction then
				self._curMouth = bizuiAction

				self._spine:setMouthAnimation(self._curMouth, true, 0)
			end

			return
		end
	end

	if self._curMouth ~= StoryAnimName.T_BiZui then
		if self._spine:hasAnimation(StoryAnimName.T_BiZui) then
			self._curMouth = StoryAnimName.T_BiZui

			self._spine:setMouthAnimation(self._curMouth, true, 0)
		else
			self._curMouth = StoryAnimName.T_BiZui

			logError("no animation:t_bizui, heroId = " .. ((self._voiceConfig or nil) and (self._voiceConfig.heroId or "nil")))
		end
	end
end

function Live2dVoiceMouthOfflineAuto:onVoiceStop()
	self._isVoiceStop = true

	self:stopMouth()

	self._isVoiceStop = false

	self:removeTaskActions()

	self._autoMouthRunning = false
	self._manualMouthRunning = false
	self._faceActionSpList = nil
end

function Live2dVoiceMouthOfflineAuto:removeTaskActions()
	Live2dVoiceMouthOfflineAuto.super.removeTaskActions(self)
	self:stopLipSync()
end

function Live2dVoiceMouthOfflineAuto:suspend()
	self:removeTaskActions()
end

return Live2dVoiceMouthOfflineAuto
