-- chunkname: @modules/live2d/Live2dVoiceMouthAuto.lua

module("modules.live2d.Live2dVoiceMouthAuto", package.seeall)

local Live2dVoiceMouthAuto = class("Live2dVoiceMouthAuto", SpineVoiceMouth)

Live2dVoiceMouthAuto.AutoActionName = "_auto"
Live2dVoiceMouthAuto.AutoMouthThreshold = 0.1

function Live2dVoiceMouthAuto:_playMouthActionList(mouth)
	self._lastMouthId = nil
	self._lastFaceAction = nil
	self._faceActionSpList = nil
	self._voiceStartTime = Time.time
	self._autoMouthRunning = false
	self._manualMouthRunning = false
	self._forceFace = nil
	self._isBiZui = true

	if self._forceNoMouth then
		self:_onMouthEnd()

		return
	end

	if self._voiceConfig.heroId == 3038 and not self._hasAudio then
		self:_onMouthEnd()
	end

	self._mouthAudioId = self._voiceConfig.audio or self._voiceConfig.storyAudioId

	local heroId = self._voiceConfig.heroId

	self._voiceShortcut = GameConfig:GetCurVoiceShortcut()

	if heroId then
		local charVoiceLangId, langStr, usingDefaultLang = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(heroId)
		local charVoiceLang = LangSettings.shortcutTab[charVoiceLangId]
		local curLang = GameConfig:GetCurVoiceShortcut()

		if not string.nilorempty(charVoiceLang) and not usingDefaultLang then
			self._voiceShortcut = charVoiceLang
		end
	end

	self._autoMouthData = AudioConfig.instance:getAutoMouthData(self._mouthAudioId, self._voiceShortcut)

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

			if self:_hasAuto(mouthAction) and mouthAction ~= Live2dVoiceMouthAuto.AutoActionName then
				self._forceFace = string.gsub(mouthAction, Live2dVoiceMouthAuto.AutoActionName, "")
				mouthAction = Live2dVoiceMouthAuto.AutoActionName
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

function Live2dVoiceMouthAuto:_hasAuto(action)
	return string.find(action, Live2dVoiceMouthAuto.AutoActionName)
end

function Live2dVoiceMouthAuto:_configValidity(list, spine)
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

function Live2dVoiceMouthAuto:_addMouth(lastOne, mouthAction, mouthStart, mouthEnd)
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

function Live2dVoiceMouthAuto:_dealOfflineCfg()
	if self._autoMouthData then
		local len = #self._autoMouthData

		for i = 1, len, 2 do
			local mouthStart = self._autoMouthData[i]
			local mouthEnd = self._autoMouthData[i + 1]

			self:_addOfflineMouth(mouthStart, mouthEnd)
		end
	end
end

function Live2dVoiceMouthAuto:_addOfflineMouth(mouthStart, mouthEnd)
	local function startCallback()
		if self._spine then
			self:_setOpenMouth()
		end
	end

	local function stopCallback()
		if self._spine then
			self:_setBiZui()
		end
	end

	table.insert(self._mouthDelayCallbackList, startCallback)
	table.insert(self._mouthDelayCallbackList, stopCallback)

	if mouthStart > 0 then
		TaskDispatcher.runDelay(startCallback, nil, mouthStart)
	else
		startCallback()
	end

	if mouthEnd then
		TaskDispatcher.runDelay(stopCallback, nil, mouthEnd)
	end
end

function Live2dVoiceMouthAuto:startLipSync()
	if self._autoMouthData then
		self:_dealOfflineCfg()
	elseif self._mouthAudioId ~= 0 then
		logError("no offlineCfg", self._mouthAudioId)
	end

	TaskDispatcher.runRepeat(self._checkBiZuiUpdate, self, 0.01, 2000)
end

function Live2dVoiceMouthAuto:stopLipSync()
	if self._autoMouthData then
		-- block empty
	end

	TaskDispatcher.cancelTask(self._checkBiZuiUpdate, self)
end

function Live2dVoiceMouthAuto:_lipSyncUpdate()
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

	if evaluateValue > Live2dVoiceMouthAuto.AutoMouthThreshold then
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

function Live2dVoiceMouthAuto:_getFaceActionList()
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

function Live2dVoiceMouthAuto:_mouthRepeat()
	return
end

function Live2dVoiceMouthAuto:_setOpenMouth()
	self._isBiZui = false

	local faceActionList = self:_getFaceActionList()
	local faceAction
	local t = Time.time - self._voiceStartTime

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
end

function Live2dVoiceMouthAuto:_checkBiZuiUpdate()
	if self._manualMouthRunning then
		return
	end

	if self._isBiZui then
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

		self._lastFaceAction = faceAction or self._lastFaceAction

		self:_setBiZui()
	end
end

function Live2dVoiceMouthAuto:_setBiZui()
	self._isBiZui = true

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

function Live2dVoiceMouthAuto:onVoiceStop()
	self._isVoiceStop = true

	self:stopMouth()

	self._isVoiceStop = false

	self:removeTaskActions()

	self._autoMouthRunning = false
	self._manualMouthRunning = false
	self._faceActionSpList = nil
end

function Live2dVoiceMouthAuto:removeTaskActions()
	Live2dVoiceMouthAuto.super.removeTaskActions(self)
	self:stopLipSync()
end

function Live2dVoiceMouthAuto:suspend()
	self:removeTaskActions()
end

return Live2dVoiceMouthAuto
