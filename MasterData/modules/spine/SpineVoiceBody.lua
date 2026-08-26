-- chunkname: @modules/spine/SpineVoiceBody.lua

module("modules.spine.SpineVoiceBody", package.seeall)

local SpineVoiceBody = class("SpineVoiceBody")

function SpineVoiceBody:ctor()
	return
end

function SpineVoiceBody:onDestroy()
	self:removeTaskActions()

	self._spineVoice = nil
	self._voiceConfig = nil
	self._spine = nil
end

function SpineVoiceBody:setBodyAnimation(name, loop, mixTime)
	local curAniName = self._spine:getCurBody()
	local playCutTime = self:_getPlayMotionMixTime(name)

	if playCutTime then
		mixTime = playCutTime
	end

	self:_setBodyAnimation(name, loop, mixTime, self._motionCutList[curAniName])
end

function SpineVoiceBody:_getPlayMotionMixTime(name)
	if not self._motionPlayCutList[name] then
		return
	end

	if self._motionPlayCutConfig.whenStopped == 1 and self._isVoiceStopping then
		return 0
	end

	if self._motionPlayCutConfig.whenNotStopped == 1 and not self._isVoiceStopping then
		return 0
	end
end

function SpineVoiceBody:_setBodyAnimation(name, loop, mixTime, isCut)
	if isCut then
		if not self._onlyVoiceStopCut then
			mixTime = 0
		end

		if self._onlyVoiceStopCut and self._isVoiceStopping then
			mixTime = 0
		end
	end

	local curAniName = self._spine:getCurBody()

	if name ~= curAniName then
		self._spine:setBodyAnimation(name, loop, mixTime or 0.2)
	end
end

function SpineVoiceBody:init(spineVoice, voiceConfig, spine)
	self._spineVoice = spineVoice
	self._voiceConfig = voiceConfig
	self._spine = spine
	self._skinId = spine and spine._skinId

	self:_initCutMotion(voiceConfig)
	self:_initPlayCutMotion(voiceConfig)

	self._onlyVoiceStopCut = self._motionCutConfig and self._motionCutConfig.onlyStopCut == 1

	local motion = self:getMotion(voiceConfig)

	self:playBodyActionList(motion)
end

function SpineVoiceBody:getSpineVoice()
	return self._spineVoice
end

function SpineVoiceBody:getMotion(voiceCo)
	local shortcut = self._spineVoice:getVoiceLang()

	if shortcut == "zh" then
		return voiceCo.motion
	else
		return voiceCo[shortcut .. "motion"] or voiceCo.motion
	end
end

function SpineVoiceBody:_getHeroId(voiceConfig)
	if voiceConfig.storyHeroIndex then
		local config = lua_story_hero_to_character.configDict[voiceConfig.storyHeroIndex]

		return config and config.heroId
	end

	return voiceConfig.heroId
end

function SpineVoiceBody:_initCutMotion(voiceConfig)
	self._motionCutList = {}
	self._motionCutConfig = nil

	local motionData = lua_character_motion_cut.configDict[self:_getHeroId(voiceConfig)]

	if not motionData then
		return
	end

	motionData = self._skinId and motionData[self._skinId] or motionData[1]

	if not motionData then
		return
	end

	self._motionCutConfig = motionData

	local motionStr = motionData.motion
	local motionList = string.split(motionStr, "|")

	for i, v in ipairs(motionList) do
		self._motionCutList["b_" .. v] = true
	end
end

function SpineVoiceBody:_initPlayCutMotion(voiceConfig)
	self._motionPlayCutList = {}
	self._motionPlayCutConfig = nil

	local motionData = lua_character_motion_play_cut.configDict[self:_getHeroId(voiceConfig)]

	if not motionData then
		return
	end

	motionData = self._skinId and motionData[self._skinId] or motionData[1]

	if not motionData then
		return
	end

	self._motionPlayCutConfig = motionData

	local motionStr = motionData.motion
	local motionList = string.split(motionStr, "|")

	for i, v in ipairs(motionList) do
		self._motionPlayCutList["b_" .. v] = true
	end
end

function SpineVoiceBody:_configValidity(list, spine)
	for i = #list, 1, -1 do
		local action = list[i]
		local actionParam = string.split(action, "#")
		local invalid = true

		if actionParam[2] then
			local str = "b_" .. actionParam[1]

			if spine:hasAnimation(str) then
				invalid = false
			end
		end

		if invalid then
			if SLFramework.FrameworkSettings.IsEditor then
				logWarn(string.format("编辑器下的调试log，无需在意。 id：%s 语音 body 无效的配置：%s motion:%s", self._voiceConfig.audio, action, self._motion))
			end

			table.remove(list, i)
		end
	end
end

function SpineVoiceBody:playBodyActionList(motion)
	self._bodyStart = 0
	self._motion = motion

	if not string.nilorempty(motion) then
		self._bodyList = string.split(motion, "|")

		self:_configValidity(self._bodyList, self._spine)
	else
		self._bodyList = {}
	end

	self._appointIdleName = nil
	self._appointIdleMixTime = nil

	self:_playBodyAction()
end

function SpineVoiceBody:_checkAppointIdle()
	if self._spineVoice:getInStory() and #self._bodyList > 0 then
		local action = self._bodyList[1]
		local actionParam = string.split(action, "#")

		if actionParam[3] == "-2" then
			self._appointIdleName = "b_" .. actionParam[1]
			self._appointIdleMixTime = tonumber(actionParam[4])

			table.remove(self._bodyList, 1)
		end
	end
end

function SpineVoiceBody:_playBodyAction()
	self._bodyActionName = nil
	self._playBodyName = nil
	self._nextActionStartTime = nil

	local showNormal = true
	local isEnd = true

	self:_checkAppointIdle()
	TaskDispatcher.cancelTask(self._bodyActionDelay, self)

	if #self._bodyList > 0 then
		local action = table.remove(self._bodyList, 1)
		local actionParam = string.split(action, "#")

		if actionParam[2] then
			self._bodyActionName = "b_" .. actionParam[1]
			self._actionLoop = actionParam[3] == "-1"
			self._mixTime = actionParam[4] and tonumber(actionParam[4])

			local time = tonumber(actionParam[2]) or 0
			local delayTime = time - self._bodyStart

			self._bodyStartTime = Time.time

			if delayTime > 0 then
				TaskDispatcher.runDelay(self._bodyActionDelay, self, delayTime)
			else
				showNormal = false

				if self._onlyVoiceStopCut then
					TaskDispatcher.runDelay(self._bodyActionDelay, self, 0)
				else
					self:_bodyActionDelay()
				end
			end

			isEnd = false
		end
	end

	if showNormal then
		self:setNormal()
	end

	self:_startCheckLoopEnd()

	if isEnd then
		self:_onBodyEnd()
	end
end

function SpineVoiceBody:_startCheckLoopEnd()
	self._nextActionStartTime = nil

	TaskDispatcher.cancelTask(self._checkLoopActionEnd, self)

	if not self._actionLoop then
		return
	end

	if #self._bodyList > 0 then
		local action = self._bodyList[1]
		local actionParam = string.split(action, "#")

		if actionParam[2] then
			local time = tonumber(actionParam[2])
			local delayTime = time - self._bodyStart

			self._nextActionStartTime = self._bodyStartTime + delayTime
		end
	end

	if self._nextActionStartTime then
		TaskDispatcher.runRepeat(self._checkLoopActionEnd, self, 0)
	end
end

function SpineVoiceBody:_checkLoopActionEnd()
	if not self._nextActionStartTime then
		TaskDispatcher.cancelTask(self._checkLoopActionEnd, self)

		return
	end

	if self._nextActionStartTime <= Time.time then
		TaskDispatcher.cancelTask(self._checkLoopActionEnd, self)

		self._bodyStart = self._bodyStart + (Time.time - self._bodyStartTime)

		self:_playBodyAction()
	end
end

function SpineVoiceBody:_onBodyEnd()
	self._spineVoice:_onComponentStop(self)
end

function SpineVoiceBody:setNormal()
	if not self._spineVoice then
		return
	end

	if self._appointIdleName then
		self:setBodyAnimation(self._appointIdleName, true, self._appointIdleMixTime)

		self._appointIdleMixTime = nil

		return
	end

	if self._spineVoice:getInStory() then
		if not StoryAnimName.B_IDLE then
			local name = CharacterVoiceController.instance:getIdle(self._voiceConfig.heroId)

			self:setBodyAnimation(name, true)
		end
	end
end

function SpineVoiceBody:_bodyActionDelay()
	if self._lastBodyActionName and self._motionCutList[self._lastBodyActionName] then
		self:_setBodyAnimation(self._bodyActionName, self._actionLoop, self._mixTime, true)
	else
		self:setBodyAnimation(self._bodyActionName, self._actionLoop, self._mixTime)
	end

	self._lastBodyActionName = self._bodyActionName
	self._playBodyName = self._bodyActionName
end

function SpineVoiceBody:checkBodyEnd(actName)
	if actName == self._playBodyName and not self._actionLoop then
		self._bodyStart = self._bodyStart + (Time.time - self._bodyStartTime)

		self:_playBodyAction()

		return true
	end
end

function SpineVoiceBody:removeTaskActions()
	TaskDispatcher.cancelTask(self._bodyActionDelay, self)
	TaskDispatcher.cancelTask(self._checkLoopActionEnd, self)
end

function SpineVoiceBody:onVoiceStop()
	self._isVoiceStopping = true

	self:removeTaskActions()
	self:setNormal()

	self._isVoiceStopping = false
end

return SpineVoiceBody
