-- chunkname: @modules/logic/story/model/StoryModel.lua

module("modules.logic.story.model.StoryModel", package.seeall)

local StoryModel = class("StoryModel", BaseModel)

function StoryModel:onInit()
	self:reInit()
end

function StoryModel:reInit()
	self._log = {}
	self._herocuts = {}
	self._hideBtns = false
	self.skipFade = false
	self._storyStepLines = {}
	self._storyState = {}
	self._isVersionActivityPV = false
	self._isReplay = false
	self._statStepClickTime = 0

	self:resetStoryState()
end

function StoryModel:resetStoryState()
	self._stepLines = {}
	self._auto = false
	self._isNormalStep = false
	self._hide = false
	self._textShowing = false
	self._enableClick = true
	self._needFadeIn = false
	self._needFadeOut = false
	self._hasBottomEffect = false
	self._specialPlayingVideos = {}
	self._playingVideos = {}
	self._isPlayFinished = false
	self._uiActive = false
	self._inScreenSplit = false
end

function StoryModel:setPlayFnished()
	self._isPlayFinished = true
end

function StoryModel:isPlayFinished()
	return self._isPlayFinished
end

function StoryModel:clearStepLine()
	self._stepLines = {}
end

function StoryModel:isVersionActivityPV()
	return self._isVersionActivityPV
end

function StoryModel:setVersionActivityPV(isPv)
	self._isVersionActivityPV = isPv
end

function StoryModel:isReplay()
	return self._isReplay
end

function StoryModel:setIsReplay(replay)
	self._isReplay = replay
end

function StoryModel:addSkipStepLine(storyId, stepId, skip)
	if not self._stepLines[storyId] then
		self._stepLines[storyId] = {}

		local stepParam = {}

		stepParam.stepId = stepId
		stepParam.skip = skip

		table.insert(self._stepLines[storyId], stepParam)

		return
	end

	if self._stepLines[storyId][#self._stepLines[storyId]].stepId ~= stepId then
		local stepParam = {}

		stepParam.stepId = stepId
		stepParam.skip = skip

		table.insert(self._stepLines[storyId], stepParam)
	end
end

function StoryModel:getStepLine()
	return self._stepLines
end

function StoryModel:setHideBtns(hide)
	self._hideBtns = hide
end

function StoryModel:getHideBtns()
	return self._hideBtns
end

function StoryModel:isStoryAuto()
	return self._auto
end

function StoryModel:setStoryAuto(auto)
	self._auto = auto

	StoryController.instance:dispatchEvent(StoryEvent.AutoChange)
end

function StoryModel:isNormalStep()
	return self._isNormalStep
end

function StoryModel:setStepNormal(normal)
	self._isNormalStep = normal
end

function StoryModel:isViewHide()
	return self._hide
end

function StoryModel:setViewHide(hide)
	self._hide = hide
end

function StoryModel:isTextShowing()
	return self._textShowing
end

function StoryModel:setTextShowing(show)
	self._textShowing = show
end

function StoryModel:isEnableClick()
	return self._enableClick
end

function StoryModel:enableClick(enable)
	self._enableClick = enable
end

function StoryModel:isNeedFadeIn()
	return self._needFadeIn
end

function StoryModel:setNeedFadeIn(need)
	self._needFadeIn = need
end

function StoryModel:isNeedFadeOut()
	return self._needFadeOut
end

function StoryModel:setNeedFadeOut(need)
	self._needFadeOut = need
end

function StoryModel:hasBottomEffect()
	return self._hasBottomEffect
end

function StoryModel:setHasBottomEffect(has)
	self._hasBottomEffect = has
end

function StoryModel:setUIActive(active)
	self._uiActive = active

	PostProcessingMgr.instance:setUIActive(active)
end

function StoryModel:getUIActive()
	return self._uiActive
end

function StoryModel:isHeroIconCuts(str)
	if not next(self._herocuts) then
		self._herocuts = {}

		for _, v in pairs(StoryConfig.instance:getStoryCutConfig()) do
			self._herocuts[v.cutName] = 1
		end
	end

	return self._herocuts[str]
end

function StoryModel:setStoryList(serco)
	if serco then
		local storyMo = StoryMo.New()

		storyMo:init(serco)

		self._storyState = storyMo
	end
end

function StoryModel:isStoryFinished(id)
	return self._storyState and self._storyState.finishList and self._storyState.finishList[id]
end

function StoryModel:_setStoryFinished(id)
	self._storyState.finishList[id] = true
end

function StoryModel:updateStoryList(info)
	if not self._storyState or not self._storyState.finishList or self._storyState.finishList[info.storyId] then
		return
	end

	self._storyState:update(info)
end

function StoryModel:isStoryHasPlayed(storyId)
	if self:isStoryFinished(storyId) then
		return true
	end

	if self._storyState and self._storyState.processList then
		for _, v in pairs(self._storyState.processList) do
			if v.storyId == storyId then
				return true
			end
		end
	end

	return false
end

function StoryModel:setStoryFirstStep(stepId)
	self._firstStep = stepId
end

function StoryModel:getStoryFirstSteps()
	if self._firstStep and self._firstStep ~= 0 then
		return {
			self._firstStep
		}
	end

	local startStep = {}
	local stepList = StoryStepModel.instance:getStepList()

	if #stepList == 0 then
		return startStep
	end

	if #stepList == 1 then
		table.insert(startStep, stepList[1].id)

		return startStep
	end

	local groupConfig = StoryGroupModel.instance:getGroupList()

	for _, config in pairs(groupConfig) do
		for _, v in ipairs(config) do
			if #self:getPreSteps(v.id) == 0 then
				local contain = false

				for _, step in pairs(startStep) do
					if step == v.id then
						contain = true
					end
				end

				if not contain then
					table.insert(startStep, v.id)
				end
			end
		end
	end

	return startStep
end

function StoryModel:getFollowSteps(stepId)
	local steps = {}
	local config = StoryGroupModel.instance:getGroupListById(stepId)

	if not config then
		return {}
	end

	for _, branch in ipairs(config) do
		table.insert(steps, branch.branchId)
	end

	return steps
end

function StoryModel:getPreSteps(stepId)
	local steps = {}
	local groupConfig = StoryGroupModel.instance:getGroupList()

	for _, config in ipairs(groupConfig) do
		for _, value in ipairs(config) do
			if value.branchId == stepId then
				table.insert(steps, value.id)
			end
		end
	end

	return steps
end

function StoryModel:setSpecialVideoPlaying(videoName)
	local videoList = StoryConfig.instance:getStoryDialogFadeConfig()

	for _, sv in pairs(videoList) do
		if videoName == sv.skipvideo then
			table.insert(self._specialPlayingVideos, videoName)
		end
	end

	self._playingVideos[videoName] = 1

	StoryController.instance:dispatchEvent(StoryEvent.VideoChange, true)
end

function StoryModel:setSpecialVideoEnd(videoName)
	for i = #self._specialPlayingVideos, 1, -1 do
		if self._specialPlayingVideos[i] == videoName then
			table.remove(self._specialPlayingVideos, i)
		end
	end

	self._playingVideos[videoName] = nil

	StoryController.instance:dispatchEvent(StoryEvent.VideoChange, false)
end

function StoryModel:isPlayingVideo()
	if self._playingVideos then
		for k, v in pairs(self._playingVideos) do
			return true
		end
	end

	return false
end

function StoryModel:isSpecialVideoPlaying()
	return #self._specialPlayingVideos > 0
end

function StoryModel:getSkipStep(storyId, stepId)
	local id = stepId
	local steps = {
		id
	}
	local skip = true

	repeat
		id = steps[1]

		self:addSkipStepLine(storyId, steps[1], true)

		local stepList = StoryStepModel.instance:getStepListById(id)
		local videoList = stepList and stepList.videoList

		if videoList and #videoList > 0 and id ~= stepId and not self._needWait then
			for _, v in pairs(videoList) do
				if v.orderType == StoryEnum.VideoOrderType.Produce then
					skip = false
				end
			end
		end

		steps = self:getFollowSteps(steps[1])
	until not ((#steps < 1 or nil) and false)

	return id
end

function StoryModel:isBranchHasCondition(id)
	local has = false
	local steps = {
		id
	}

	repeat
		local videoList = StoryStepModel.instance:getStepListById(id).videoList

		if #videoList > 0 then
			for _, v in pairs(videoList) do
				if v.orderType == StoryEnum.VideoOrderType.Produce then
					has = true
				end
			end
		end

		steps = self:getFollowSteps(steps[1])
	until not ((#steps < 1 or nil) and false)

	return has
end

function StoryModel:addLog(log)
	if self._log[#self._log] == log then
		return
	end

	if LuaUtil.isTable(log) and LuaUtil.isTable(self._log[#self._log]) and self._log[#self._log].stepId == log.stepId then
		return
	end

	table.insert(self._log, log)
end

function StoryModel:getLog()
	local log = {}

	if self._log then
		for _, v in ipairs(self._log) do
			local stepCo = StoryStepModel.instance:getStepListById(v)

			if not stepCo then
				table.insert(log, v)
			elseif stepCo.conversation.type ~= StoryEnum.ConversationType.None and stepCo.conversation.type ~= StoryEnum.ConversationType.SlideDialog and not string.match(stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()], "<notShowInLog>") then
				table.insert(log, v)
			end
		end
	end

	return log
end

function StoryModel:addSkipLog(stepId)
	local id = stepId
	local steps = {
		id
	}
	local skip = true

	repeat
		id = steps[1]

		self:addLog(steps[1])

		local stepList = StoryStepModel.instance:getStepListById(id)
		local videoList = stepList and stepList.videoList

		if videoList and #videoList > 0 then
			for _, v in pairs(videoList) do
				if v.orderType == StoryEnum.VideoOrderType.Produce then
					skip = false
				end
			end
		end

		steps = self:getFollowSteps(steps[1])
	until not ((#steps ~= 1 or nil) and false)
end

function StoryModel:clearData()
	self._isPlayFinished = false
	self._log = {}

	StoryLogListModel.instance:clearData()
end

function StoryModel:getStoryTxtByVoiceType(txt, audioId)
	local result = txt
	local txtType = GameLanguageMgr.instance:getLanguageTypeStoryIndex()
	local txtDiffCos = StoryConfig.instance:getStoryTxtDiffConfig()
	local voiceType = GameLanguageMgr.instance:getVoiceTypeStoryIndex()
	local key1 = LanguageEnum.LanguageStoryType2Key[voiceType]
	local key2 = LanguageEnum.LanguageStoryType2Key[txtType]
	local defaultType = LanguageEnum.LanguageStoryType.EN
	local txtDiffCfg = true

	if audioId then
		local txtDiffCfg

		::label_53_0::

		txtDiffCfg = audioId ~= 0 and txtDiffCos[audioId] and (txtDiffCos[audioId][txtType] or txtDiffCos[audioId][defaultType]) or false
	end

	if txtDiffCfg then
		if txtType ~= voiceType then
			result = string.gsub(result, txtDiffCfg[key2], txtDiffCfg[key1])
		end

		return result
	end

	local matchTxts = {}

	for _, v in pairs(txtDiffCos) do
		if not v[txtType] then
			if v[txtType] and math.floor(v[txtType].id / 100000) < 1 then
				table.insert(matchTxts, v[txtType])
			end
		end
	end

	local findString, replaceString

	for k, v in pairs(matchTxts) do
		if not string.nilorempty(v[key2]) then
			result = string.gsub(result, v[key2], v[key1])
		end
	end

	return result
end

function StoryModel:isTypeSkip(type, storyId)
	if (type == StoryEnum.SkipType.InDarkFade or type == StoryEnum.SkipType.OutDarkFade) and StoryController.instance._hideStartAndEndDark then
		return true
	end

	local skipIds = string.splitToNumber(StoryConfig.instance:getStorySkipConfig(type).skipDetail, "#")

	for _, v in pairs(skipIds) do
		if v == storyId then
			return true
		end
	end

	return false
end

function StoryModel:isPrologueSkipAndGetTxt(storyId, stepId)
	local prologueCo = StoryConfig.instance:getStoryPrologueSkipConfig()
	local keySteps = {}

	for _, co in pairs(prologueCo) do
		local prologueIds = string.split(co.prologues, "|")

		for _, prologueId in pairs(prologueIds) do
			local ids = string.splitToNumber(prologueId, "#")

			if storyId == ids[1] then
				local stepParam = {}

				stepParam.stepId = ids[2]
				stepParam.content = co.content

				table.insert(keySteps, stepParam)
			end
		end
	end

	if #keySteps > 0 then
		for i = #self._log, 1, -1 do
			for _, v in pairs(keySteps) do
				if v.stepId == self._log[i] then
					return true, v.content
				end
			end
		end
	end

	return false, ""
end

function StoryModel:isPrologueSkip(storyId)
	local skipIds = {
		{
			100001,
			100002
		},
		{
			100005,
			100006
		},
		{
			100008,
			100015,
			100016,
			100017
		}
	}

	if self._skipStoryId and self._skipStoryId > 0 then
		local targetIndex = 0

		for k, v in ipairs(skipIds) do
			for _, id in pairs(v) do
				if id == self._skipStoryId then
					targetIndex = k
				end
			end
		end

		if targetIndex > 0 and #skipIds[targetIndex] > 0 then
			for _, v in pairs(skipIds[targetIndex]) do
				if v == storyId then
					return true
				end
			end
		end
	end

	return false
end

function StoryModel:setPrologueSkipId(storyId)
	self._skipStoryId = storyId
end

function StoryModel:getShowStoryBranchOpts(stepId)
	local opts = {}
	local optList = StoryStepModel.instance:getStepListById(stepId).optList

	for _, opt in ipairs(optList) do
		local isSpType = StoryModel.instance:isSpOptionType(opt.type)

		if opt.conditionType == StoryEnum.OptionConditionType.None and not isSpType then
			table.insert(opts, opt)
		end
	end

	return opts
end

function StoryModel:hasConfigNotExist()
	local stepCos = StoryStepModel.instance:getStepList()

	if not stepCos or not next(stepCos) then
		logError("剧情step数据异常,请检查数据！")

		return true
	end

	local groupCos = StoryGroupModel.instance:getGroupList()

	if not groupCos or not next(groupCos) then
		logError("剧情group数据异常,请检查数据！")

		return true
	end

	return false
end

function StoryModel:addStepClickTime()
	self._statStepClickTime = self._statStepClickTime + 1
end

function StoryModel:getStepClickTime()
	return self._statStepClickTime
end

function StoryModel:resetStepClickTime()
	self._statStepClickTime = 0
end

function StoryModel:needWaitStoryFinish()
	return self._needWait
end

function StoryModel:setNeedWaitStoryFinish(need)
	self._needWait = need
end

function StoryModel:setReplaceHero(initHero, replaceHero)
	self._replaceHeroList = self._replaceHeroList or {}

	local hero = {}

	hero.initHero = initHero
	hero.replaceHeroPath = replaceHero

	table.insert(self._replaceHeroList, hero)
end

function StoryModel:getReplaceHeroPath(initHero)
	if not self._replaceHeroList then
		return
	end

	for _, v in pairs(self._replaceHeroList) do
		if initHero == v.initHero then
			return v.replaceHeroPath
		end
	end
end

function StoryModel:isDirectSkipStory(storyId)
	if math.floor(storyId / 100) == 8008 then
		return storyId % 100 > 4
	end

	return false
end

function StoryModel:setCurStoryId(storyId)
	self._curStoryId = storyId
end

function StoryModel:getCurStoryId()
	return self._curStoryId or 0
end

function StoryModel:setCurStepId(stepId)
	self._curStepId = stepId or 0
end

function StoryModel:getCurStepId()
	return self._curStepId
end

function StoryModel:isSpVersionStory(storyId)
	local curStoryId = storyId or self:getCurStoryId()
	local storyPrefixs = CommonConfig.instance:getConstStr(ConstEnum.SP_StoryIdPrefix)
	local prefixs = string.splitToNumber(storyPrefixs, "#")

	for _, prefix in pairs(prefixs) do
		if math.floor(curStoryId / 100) == prefix then
			return true
		end
	end

	return false
end

function StoryModel:isStoryPvPause()
	return self._pvPause
end

function StoryModel:setStoryPvPause(pause)
	self._pvPause = pause
end

function StoryModel:setLimitNoInteractLock(lock)
	self._isLimitNoInteractLock = lock
end

function StoryModel:isLimitNoInteractLock(stepCo)
	if not stepCo or stepCo.conversation.type ~= StoryEnum.ConversationType.LimitNoInteract then
		return false
	end

	return self._isLimitNoInteractLock
end

function StoryModel:isMagicType(stepCo)
	if not stepCo then
		return false
	end

	local isSpMagicType = self:isSpMagicType(stepCo)

	if isSpMagicType then
		return true
	end

	if stepCo.conversation.effType == StoryEnum.ConversationEffectType.CommonMagic then
		return true
	end

	if stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic then
		return true
	end

	if stepCo.conversation.effType == StoryEnum.ConversationEffectType.SilverMagic then
		return true
	end

	if stepCo.conversation.effType == StoryEnum.ConversationEffectType.XranMagic then
		return true
	end

	return false
end

function StoryModel:isSpMagicType(stepCo)
	if not stepCo then
		return false
	end

	if stepCo.conversation.effType == StoryEnum.ConversationEffectType.SandMagic then
		return true
	end

	if stepCo.conversation.effType == StoryEnum.ConversationEffectType.GoldlineMagic then
		return true
	end

	return false
end

function StoryModel:isSpOptionType(optionType)
	if optionType == StoryEnum.OptionType.SpClick then
		return true
	end

	if optionType == StoryEnum.OptionType.SpSlide then
		return true
	end

	if optionType == StoryEnum.OptionType.SpLongClick then
		return true
	end

	return false
end

function StoryModel:setInScreenSplitMode(isScreenSplit)
	self._inScreenSplit = isScreenSplit
end

function StoryModel:isInScreenSplitMode()
	return self._inScreenSplit
end

function StoryModel:hasBranchPlayed(stepCo)
	if not stepCo then
		return false
	end

	if #stepCo.optList <= 0 then
		return false
	end

	for _, v in ipairs(stepCo.optList) do
		if v.type == StoryEnum.OptionType.EndAsk then
			local logs = StoryModel.instance:getLog()

			for _, option in pairs(stepCo.optList) do
				if LuaUtil.tableContains(logs, option.followId) then
					return true
				end
			end
		end
	end

	return false
end

function StoryModel:isSetTopView(viewName)
	local setting = ViewMgr.instance:getSetting(viewName)

	if setting.layer == UILayerName.Message then
		return true
	end

	if setting.layer == UILayerName.IDCanvasPopUp then
		return true
	end

	if setting.layer == UILayerName.PopUpTop and setting.bgBlur and setting.bgBlur > 0 then
		return true
	end

	return false
end

StoryModel.instance = StoryModel.New()

return StoryModel
