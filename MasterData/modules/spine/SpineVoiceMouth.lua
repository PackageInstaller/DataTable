-- chunkname: @modules/spine/SpineVoiceMouth.lua

module("modules.spine.SpineVoiceMouth", package.seeall)

local SpineVoiceMouth = class("SpineVoiceMouth")
local pauseFlag = "pause"
local autoBizuiFlag = "auto_bizui|"

function SpineVoiceMouth:ctor()
	local audioMgr = AudioMgr.instance

	self._audioGroup = audioMgr:getIdFromString("PlotVoice")
	self._mouthActionList = {
		[audioMgr:getIdFromString("Smallmouth")] = "xiao",
		[audioMgr:getIdFromString("Mediumsizedmouth")] = "zhong",
		[audioMgr:getIdFromString("Largemouth")] = "da"
	}
end

function SpineVoiceMouth:onDestroy()
	self:removeTaskActions()

	self._spineVoice = nil
	self._voiceConfig = nil
	self._spine = nil
end

function SpineVoiceMouth:_onMouthEnd()
	if self._setComponentStop then
		return
	end

	self._setComponentStop = true

	if self._spineVoice then
		self._spineVoice:_onComponentStop(self)
	end
end

function SpineVoiceMouth:forceNoMouth()
	self._forceNoMouth = true
end

function SpineVoiceMouth:init(spineVoice, voiceConfig, spine)
	self._specialConfig = CharacterDataConfig.instance:getMotionSpecial(spine and spine:getResPath() or "")
	self._spineVoice = spineVoice
	self._voiceConfig = voiceConfig
	self._spine = spine
	self._hasAudio = AudioConfig.instance:getAudioCOById(voiceConfig.audio)
	self._setComponentStop = false
	self._playLastOne = nil

	local mouth = self:getMouth(voiceConfig)

	if string.nilorempty(mouth) and self._spineVoice:getInStory() and self._mouthStopDelayCallbackList then
		local firstCallback = self._mouthStopDelayCallbackList[1]

		if firstCallback then
			firstCallback()
		end
	end

	self:removeTaskActions()
	self:_checkPlayMouthActionList(mouth)
end

function SpineVoiceMouth:_checkPlayMouthActionList(mouth)
	self:_playMouthActionList(mouth)
end

function SpineVoiceMouth:getMouth(voiceCo)
	local shortcut = self._spineVoice:getVoiceLang()

	if shortcut == "zh" then
		return voiceCo.mouth
	else
		return voiceCo[shortcut .. "mouth"] or voiceCo.mouth
	end
end

function SpineVoiceMouth:getFace(voiceCo)
	local shortcut = self._spineVoice:getVoiceLang()

	if shortcut == "zh" then
		return voiceCo.face
	else
		return voiceCo[shortcut .. "face"] or voiceCo.face
	end
end

function SpineVoiceMouth:_getFaceEndTime()
	local langFace = self:getFace(self._voiceConfig)
	local faceList = string.split(langFace, "|")
	local action = faceList[#faceList]

	if not action then
		return
	end

	local actionParam = string.split(action, "#")

	if #actionParam >= 3 then
		return (tonumber(actionParam[3]))
	end
end

function SpineVoiceMouth:_stopMouthRepeat()
	TaskDispatcher.cancelTask(self._mouthRepeat, self)
end

function SpineVoiceMouth:_configValidity(list, spine)
	for i = #list, 1, -1 do
		local action = list[i]
		local actionParam = string.split(action, "#")
		local invalid = true

		if #actionParam == 3 then
			local str = "t_" .. actionParam[1]

			if spine:hasAnimation(str) then
				invalid = false
			end
		elseif string.find(action, pauseFlag) then
			invalid = false
		end

		if invalid then
			logError(string.format("id：%s spine:%s,语音 mouth 无效的配置：%s mouth:%s", self._voiceConfig.audio, self._spine and self._spine:getResPath(), action, self._voiceConfig.mouth))
			table.remove(list, i)
		end
	end
end

function SpineVoiceMouth:_playMouthActionList(mouth)
	self._lastMouthId = nil
	self._pauseMouth = nil
	self._voiceStartTime = Time.time
	self._autoBizui = false

	if self._forceNoMouth then
		self:_onMouthEnd()

		return
	end

	if self._voiceConfig.heroId == 3038 and not self._hasAudio then
		self:_onMouthEnd()
	end

	if LuaUtil.isEmptyStr(mouth) then
		if self._hasAudio then
			TaskDispatcher.runRepeat(self._mouthRepeat, self, 0.03)
		else
			self:_onMouthEnd()
		end
	else
		self._mouthDelayCallbackList = {}
		self._mouthStopDelayCallbackList = {}

		if string.find(mouth, autoBizuiFlag) then
			self._faceEndTime = self:_getFaceEndTime()
			self._autoBizui = self._faceEndTime
			mouth = string.gsub(mouth, autoBizuiFlag, "")
		end

		local mouthActionList

		if not string.nilorempty(mouth) then
			mouthActionList = string.split(mouth, "|")

			self:_configValidity(mouthActionList, self._spine)
		else
			mouthActionList = {}
		end

		local count = #mouthActionList
		local lastMouthEnd = 0
		local isEditor = SLFramework.FrameworkSettings.IsEditor

		for i, v in ipairs(mouthActionList) do
			local param = string.split(v, "#")

			if self:_checkMouthParam(param) then
				local mouthAction = param[1]
				local mouthStart = tonumber(param[2])
				local mouthEnd = tonumber(param[3])

				if isEditor then
					if mouthEnd < mouthStart then
						logError(string.format("SpineVoiceMouth audio:%s mouth配置后面的时间比前面的时间还小, mouthStart:%s > mouthEnd:%s", self._voiceConfig.audio, mouthStart, mouthEnd))
					end

					if mouthStart < lastMouthEnd then
						logError(string.format("SpineVoiceMouth audio:%s mouth配置后面的时间比前面的时间还小, mouthStart:%s < lastMouthEnd:%s", self._voiceConfig.audio, mouthStart, lastMouthEnd))
					end
				end

				if self._autoBizui and mouthEnd ~= mouthStart then
					self:_addMouthBizui(false, lastMouthEnd, mouthStart, true)
				end

				self:_addMouth(i == count and not self._autoBizui, mouthAction, mouthStart, mouthEnd)

				lastMouthEnd = mouthEnd
			end
		end

		if self._autoBizui then
			local faceEndTime = self._faceEndTime

			if faceEndTime < lastMouthEnd then
				faceEndTime = lastMouthEnd
			end

			self:_addMouthBizui(false, lastMouthEnd, faceEndTime)
			self:_addMouthBizui(true, faceEndTime, faceEndTime + 1)
		end

		if count <= 0 then
			self:_onMouthEnd()
		end
	end
end

function SpineVoiceMouth:_checkMouthParam(param)
	if param[1] == pauseFlag then
		self._pauseMouth = param[2]

		return false
	end

	return true
end

function SpineVoiceMouth:_addMouth(lastOne, mouthAction, mouthStart, mouthEnd)
	if not mouthStart or not mouthEnd then
		return
	end

	local function startCallback()
		if self._spine then
			self._curMouth = "t_" .. mouthAction
			self._curMouthEnd = nil

			self._spine:setMouthAnimation(self._curMouth, true, 0)
		end
	end

	local stopCallback

	function stopCallback()
		if self._mouthStopDelayCallbackList then
			tabletool.removeValue(self._mouthStopDelayCallbackList, stopCallback)
		end

		if self._spine then
			self._playLastOne = true

			if lastOne then
				self:stopMouthCallback()
			elseif not self._autoBizui then
				self:stopMouthCallback(true)
			end
		end
	end

	table.insert(self._mouthDelayCallbackList, startCallback)
	table.insert(self._mouthStopDelayCallbackList, stopCallback)
	TaskDispatcher.runDelay(startCallback, nil, mouthStart)
	TaskDispatcher.runDelay(stopCallback, nil, mouthEnd)
end

function SpineVoiceMouth:_addMouthBizui(lastOne, mouthStart, mouthEnd, skipStop)
	if mouthStart == mouthEnd or not mouthStart or not mouthEnd then
		return
	end

	local function startCallback()
		if self._spine then
			local curFace = self._spine:getCurFace()
			local faceName = string.gsub(curFace, "e_", "")
			local faceBizui = "t_" .. faceName .. "_bizui"

			if self._spine:hasAnimation(faceBizui) then
				self._curMouth = faceBizui

				self._spine:setMouthAnimation(self._curMouth, true, 0)

				return
			end

			if self._spine:hasAnimation(StoryAnimName.T_BiZui) then
				self._curMouth = StoryAnimName.T_BiZui

				self._spine:setMouthAnimation(self._curMouth, true, 0)
			end
		end
	end

	table.insert(self._mouthDelayCallbackList, startCallback)
	TaskDispatcher.runDelay(startCallback, nil, mouthStart)

	if skipStop then
		return
	end

	local stopCallback

	function stopCallback()
		if self._mouthStopDelayCallbackList then
			tabletool.removeValue(self._mouthStopDelayCallbackList, stopCallback)
		end

		if self._spine then
			self._playLastOne = true

			if lastOne then
				self:stopMouthCallback()
			else
				self:stopMouthCallback(true)
			end
		end
	end

	table.insert(self._mouthStopDelayCallbackList, stopCallback)
	TaskDispatcher.runDelay(stopCallback, nil, mouthEnd)
end

function SpineVoiceMouth:_mouthRepeat()
	local time = Time.time
	local id = AudioMgr.instance:getSwitch(self._audioGroup)

	if self._lastMouthId ~= id then
		self._lastMouthId = id

		if self._mouthActionList[id] then
			self._curMouth = "t_" .. self._mouthActionList[id]
			self._curMouthEnd = nil

			self._spine:setMouthAnimation(self._curMouth, false, 0)
		else
			self:stopMouth()
		end
	end

	local deltaTime = time - self._voiceStartTime

	if id == 0 and deltaTime >= 1 then
		TaskDispatcher.cancelTask(self._mouthRepeat, self)
		self:_onMouthEnd()

		return
	end
end

function SpineVoiceMouth:stopMouthCallback(force)
	self:stopMouth(force)
end

function SpineVoiceMouth:stopMouth(force)
	if force then
		self._curMouthEnd = nil

		if self._specialConfig and self._specialConfig.skipStopMouth == 1 then
			return
		end

		if self._spine then
			self._spine:stopMouthAnimation()
		end
	elseif self._curMouth then
		self:_setBiZui()

		self._curMouthEnd = self._curMouth
		self._curMouth = nil
	end
end

function SpineVoiceMouth:_setBiZui()
	if self._spine:hasAnimation(StoryAnimName.T_BiZui) then
		self._curMouth = StoryAnimName.T_BiZui

		self._spine:setMouthAnimation(self._curMouth, false, 0)
	end
end

function SpineVoiceMouth:checkMouthEnd(actName)
	if actName == self._curMouthEnd then
		self:stopMouth(true)
		self:_onMouthEnd()

		return true
	end
end

function SpineVoiceMouth:_clearAutoMouthCallback()
	if self._mouthDelayCallbackList then
		for i, v in ipairs(self._mouthDelayCallbackList) do
			TaskDispatcher.cancelTask(v, nil)
		end
	end

	if self._mouthStopDelayCallbackList then
		for i, v in ipairs(self._mouthStopDelayCallbackList) do
			TaskDispatcher.cancelTask(v, nil)
		end
	end

	self._mouthDelayCallbackList = nil
	self._mouthStopDelayCallbackList = nil
end

function SpineVoiceMouth:onVoiceStop()
	self:stopMouth(true)
	self:removeTaskActions()
end

function SpineVoiceMouth:removeTaskActions()
	self:_stopMouthRepeat()
	self:_clearAutoMouthCallback()
end

function SpineVoiceMouth:suspend()
	self:removeTaskActions()
end

return SpineVoiceMouth
