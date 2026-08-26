-- chunkname: @modules/logic/versionactivity2_1/activity165/model/Activity165StoryMo.lua

module("modules.logic.versionactivity2_1.activity165.model.Activity165StoryMo", package.seeall)

local Activity165StoryMo = class("Activity165StoryMo")

function Activity165StoryMo:ctor()
	self._actId = nil
	self.storyId = nil
	self.storyCo = nil
	self.isUnlock = nil
	self._isNewUnlock = nil
	self.allKeywordMos = nil
	self.stepMoDic = nil
	self.unlockSteps = nil
	self.firstStepMo = nil
	self.finalStepMo = nil
	self.curStepIndex = nil
	self.stepUseKeywords = nil
	self.unlockEndings = nil
	self.claimRewardCount = nil
	self.endingAllBranch = nil
	self.canEndingBranch = nil
	self.curUnlockEndingId = nil
	self._isShowDialog = nil
	self.curStage = nil
	self.reviewEnding = nil
	self._elements = nil
end

function Activity165StoryMo:onInit(actId, storyId)
	self._actId = actId
	self.storyId = storyId
	self.storyCo = Activity165Config.instance:getStoryCo(actId, storyId)
	self.unlockSteps = {}
	self.stepMoDic = {}
	self.unlockEndings = {}
	self.endingAllBranch = {}
	self.canEndingBranch = {}

	self:_initKeywordMo()
	self:_initStepMo(actId, storyId)
	self:_initElements()
end

function Activity165StoryMo:setMo(storyInfo)
	self.reviewEnding = nil

	local _isUnlock = storyInfo and storyInfo.storyState == 1

	if not self.isUnlock and _isUnlock and self._isInit then
		GameFacade.showToast(ToastEnum.Act165StoryUnlock, self:getStoryName())
	end

	self.isUnlock = _isUnlock
	self._isInit = true
	self.unlockEndings = {}
	self.claimRewardCount = storyInfo.gainedEndingCount or 0
	self.stepUseKeywords = self:_getStepUseKeywords()

	self:setCurState(storyInfo.inferState or 0)

	for i = 1, #storyInfo.unlockEndingInfos do
		local endingInfos = storyInfo.unlockEndingInfos[i]
		local steps = {}

		for j = 1, #endingInfos.inferredSteps do
			local step = endingInfos.inferredSteps[j]
			local info = {
				stepId = step.stepId,
				stepKeywords = self:getStepKws(step.stepKeywords)
			}

			table.insert(steps, info)
		end

		self.unlockEndings[endingInfos.endingId] = steps
	end

	self.unlockSteps = {}

	local stepCount = #storyInfo.inferredSteps
	local finalId

	for i = 1, stepCount do
		local stepId = storyInfo.inferredSteps[i].stepId

		table.insert(self.unlockSteps, stepId)

		finalId = stepId

		local stepKeywords = storyInfo.inferredSteps[i].stepKeywords
		local kws = {}

		if #stepKeywords > 0 then
			for j = 1, #stepKeywords do
				table.insert(kws, stepKeywords[j])
			end
		else
			kws = self.stepUseKeywords[stepCount]
		end

		self.stepUseKeywords[i] = kws
	end

	if not self.stepUseKeywords[stepCount] then
		self.stepUseKeywords[stepCount] = self.stepUseKeywords[stepCount]
		self.finalStepMo = self.firstStepMo

		if LuaUtil.tableNotEmpty(self.unlockSteps) then
			if finalId ~= 0 then
				self.finalStepMo = self.stepMoDic[finalId]
			end

			self:checkIsFinishStroy()
		end

		self:setCanUnlockRound()
		self:_checkNewUnlockStory()
	end
end

function Activity165StoryMo:getStepKws(stepKws)
	local kws = {}

	for i = 1, #stepKws do
		table.insert(kws, stepKws[i])
	end

	return kws
end

function Activity165StoryMo:getStoryName(size)
	if size then
		local format = GameUtil.getSubPlaceholderLuaLangTwoParam("act126_story_name_change_size_▩1%s_▩2%s", self._actId, self.storyId)

		return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang(format), size)
	elseif self.storyCo then
		return self.storyCo.name
	end
end

function Activity165StoryMo:getStoryFirstStepMo()
	return self.firstStepMo
end

function Activity165StoryMo:setReviewEnding(reviewEnding)
	self.reviewEnding = reviewEnding

	if reviewEnding then
		local _, kws = self:getEndingStepInfo(self.reviewEnding)

		self.reviewStepUseKeywords = kws
	end
end

function Activity165StoryMo:onRestart()
	self.finalStepList = {}
	self.unlockSteps = {}
	self.stepUseKeywords = {}

	for _, mo in pairs(self.stepMoDic) do
		mo:onReset()
	end

	for _, mo in pairs(self.allKeywordMos) do
		mo:onReset()
	end

	self.canEndingBranch = self.endingAllBranch
	self.finalStepMo = self.firstStepMo

	self:setCurState(Activity165Enum.StoryStage.Filling)

	self.reviewEnding = nil

	self:saveStepUseKeywords()
end

function Activity165StoryMo:checkIsFinishStroy()
	local isSuccess = self.finalStepMo.isEndingStep

	if isSuccess then
		self:setSelectStepIndex()

		if self.curStage == Activity165Enum.StoryStage.Filling then
			self:finishStroy()
		elseif self.curStage == Activity165Enum.StoryStage.Ending then
			local co = self:getEndingCo()

			self.curUnlockEndingId = co.endingId
		end
	end

	return isSuccess
end

function Activity165StoryMo:finishStroy()
	self:setCurState(Activity165Enum.StoryStage.isEndFill)
	Activity165Controller.instance:dispatchEvent(Activity165Event.canfinishStory)
end

function Activity165StoryMo:setCurState(state)
	self.curStage = state
end

function Activity165StoryMo:_initStepMo(actId, storyId)
	local coList = Activity165Config.instance:getStoryStepCoList(actId, storyId)

	if not self.storyCo then
		return
	end

	local firstId = self.storyCo.firstStepId
	local endingStep = {}

	if coList then
		for _, co in pairs(coList) do
			local mo = Activity165StepMo.New()

			mo:onInit(self._actId, co.stepId, self)

			self.stepMoDic[co.stepId] = mo

			if mo.isEndingStep then
				table.insert(endingStep, co.stepId)
			end
		end

		for _, mo in pairs(self.stepMoDic) do
			local rounds = mo:getCanEndingRound(endingStep)

			if LuaUtil.tableNotEmpty(rounds) then
				local _rounds = tabletool.copy(rounds)

				tabletool.addValues(self.endingAllBranch, _rounds)
			end
		end

		self.firstStepMo = self.stepMoDic[firstId]
		self.firstStepMo.isFirstStep = true
	end

	self.canEndingBranch = self.endingAllBranch
end

function Activity165StoryMo:getStepMo(stepId)
	return self.stepMoDic[stepId]
end

function Activity165StoryMo:checkIsFinishStep()
	local ids = self:getKwIdsByStepIndex(self.curStepIndex)

	self:onModifyKeyword(ids)

	if not LuaUtil.tableNotEmpty(ids) then
		return false
	end

	if not LuaUtil.tableNotEmpty(self.canEndingBranch) then
		self:failUnlockStep()

		return false
	end

	local nextStep

	if LuaUtil.tableNotEmpty(self.finalStepMo) then
		nextStep = self.finalStepMo:getNextStep(ids)
	end

	if nextStep and self:checkNextStep(nextStep) then
		local finishStep = {}

		self:successUnlockStep(nextStep, finishStep)

		return true
	else
		self:failUnlockStep()

		return false
	end
end

function Activity165StoryMo:checkNextStep(stepId)
	local index = self:unlockStepCount() + 1

	for _, round in pairs(self.canEndingBranch) do
		if stepId == round[index] then
			return true
		end
	end
end

function Activity165StoryMo:setCanUnlockRound()
	local canEndingBranch = {}

	if not LuaUtil.tableNotEmpty(self.unlockSteps) then
		return self.endingAllBranch
	end

	for _, round in pairs(self.canEndingBranch) do
		if self:isSameRound(round, self.unlockSteps) then
			table.insert(canEndingBranch, round)
		end
	end

	self.canEndingBranch = canEndingBranch
end

function Activity165StoryMo:isSameRound(round1, round2)
	for i = 1, #round2 do
		if round1[i] ~= round2[i] then
			return false
		end
	end

	return true
end

function Activity165StoryMo:successUnlockStep(stepId, finishSteps)
	if not stepId then
		return
	end

	self:setSelectStepIndex()

	self.finalStepMo = self:getStepMo(stepId)

	if not self.finalStepMo then
		return
	end

	self.finalStepMo:setUnlock(true)

	if not LuaUtil.tableContains(self.unlockSteps, stepId) then
		table.insert(self.unlockSteps, stepId)
	end

	self:setCanUnlockRound()

	if Activity165Model.instance:isPrintLog() then
		self:logCanRound()
	end

	table.insert(finishSteps, stepId)

	if self:checkNextIsFixNext(finishSteps) then
		-- block empty
	else
		Activity165Controller.instance:dispatchEvent(Activity165Event.OnFinishStep, finishSteps)
	end
end

function Activity165StoryMo:logCanRound()
	local str = "当前步骤：" .. self.finalStepMo.stepId .. "\n"

	for _, round in pairs(self.canEndingBranch) do
		for _, id in pairs(round) do
			str = str .. "#" .. id
		end

		str = str .. "\n"
	end

	SLFramework.SLLogger.Log(str)
end

function Activity165StoryMo:checkNextIsFixNext(finishSteps)
	for _, v in pairs(self.canEndingBranch) do
		local index = self:unlockStepCount()
		local nextStep_1 = v[index]
		local nextStep_2 = v[index + 1]
		local mo = self:getStepMo(nextStep_1)
		local nextMo = self:getStepMo(nextStep_2)
		local nextStepList = nextStep_2 and mo.nextSteps[nextStep_2]

		if nextMo and nextMo.isEndingStep then
			self:successUnlockStep(nextStep_2, finishSteps)

			return true
		end

		if nextStepList then
			local needKws = nextStepList.needKws

			if LuaUtil.tableNotEmpty(needKws) then
				for _, kws in pairs(needKws) do
					if not LuaUtil.tableNotEmpty(kws) then
						self:successUnlockStep(nextStep_2, finishSteps)

						return true
					end
				end
			end
		end
	end
end

function Activity165StoryMo:failUnlockStep()
	GameFacade.showToast(ToastEnum.Act165StepFillFail)
	AudioMgr.instance:trigger(AudioEnum.Activity156.play_ui_wangshi_fill_fail)
end

function Activity165StoryMo:getUnlockStepIdList()
	return self.unlockSteps
end

function Activity165StoryMo:getUnlockStepIdRemoveEnding()
	local steps = {}

	if self.reviewEnding then
		local endingSteps = self:getEndingStepInfo(self.reviewEnding)

		for i = 1, #endingSteps do
			local mo = self:getStepMo(endingSteps[i])

			if not mo.isEndingStep and not mo.isFirstStep then
				table.insert(steps, mo.stepId)
			end
		end
	else
		for _, step in pairs(self.unlockSteps) do
			local mo = self:getStepMo(step)

			if not mo.isEndingStep and not mo.isFirstStep then
				table.insert(steps, mo.stepId)
			end
		end
	end

	return steps
end

function Activity165StoryMo:getEndingStepInfo(endingId)
	local endingInfo = self.unlockEndings[endingId]
	local steps = {}
	local kws = {}
	local finalStep = self:getFirstStepId()

	if endingInfo then
		for i, info in pairs(endingInfo) do
			steps[i] = info.stepId
			kws[i] = info.stepKeywords
			finalStep = info.stepId
		end
	end

	return steps, kws, finalStep
end

function Activity165StoryMo:getUnlockStepIdRemoveEndingCount()
	return (tabletool.len(self:getUnlockStepIdRemoveEnding()))
end

function Activity165StoryMo:unlockStepCount()
	return tabletool.len(self.unlockSteps)
end

function Activity165StoryMo:removeUnlockStep(index)
	table.remove(self.unlockSteps, index)
end

function Activity165StoryMo:setSelectStepIndex(stepIndex)
	self.curStepIndex = stepIndex

	self:onResfreshKeywordState(stepIndex)
end

function Activity165StoryMo:getSelectStepIndex()
	return self.curStepIndex
end

function Activity165StoryMo:getSelectStepMo()
	return self:getUnlockStepMoByIndex(self.curStepIndex)
end

function Activity165StoryMo:getUnlockStepMoByIndex(index)
	local stepId = self.unlockSteps[index]

	if stepId then
		return self:getStepMo(stepId)
	end
end

function Activity165StoryMo:isFillingStep()
	return self.curStepIndex == self:unlockStepCount()
end

function Activity165StoryMo:resetStep()
	local list = {}
	local finalId = self:getFirstStepId()
	local resetStep
	local kwIds = {}

	if self.curStepIndex then
		for i = 1, self.curStepIndex do
			finalId = self.unlockSteps[i]
			kwIds[i] = self.stepUseKeywords[i]

			table.insert(list, finalId)
		end

		resetStep = self.unlockSteps[self.curStepIndex]
	else
		list = self.unlockSteps
	end

	self.stepUseKeywords = kwIds

	self:setCurState(Activity165Enum.StoryStage.Filling)

	self.unlockSteps = list
	self.finalStepMo = self:getStepMo(finalId)
	self.canEndingBranch = self.endingAllBranch

	self:setCanUnlockRound()
	self:saveStepUseKeywords()

	if resetStep then
		Activity165Rpc.instance:sendAct165RestartRequest(self._actId, self.storyId, resetStep)
	end
end

function Activity165StoryMo:getFirstStepId()
	return self.firstStepMo.stepId
end

function Activity165StoryMo:_initKeywordMo()
	local coList = Activity165Config.instance:getStoryKeywordCoList(self._actId, self.storyId)

	self.allKeywordMos = {}

	if coList then
		for _, co in pairs(coList) do
			local mo = Activity165KeywordMo.New()

			mo:onInit(co)

			self.allKeywordMos[co.keywordId] = mo
		end
	end
end

function Activity165StoryMo:getKeywordList()
	local stepMo = self:getSelectStepMo()

	return (stepMo or nil) and stepMo:getCanUseKeywords()
end

function Activity165StoryMo:getKeywordMo(keywordId)
	return self.allKeywordMos[keywordId]
end

function Activity165StoryMo:onResfreshKeywordState(index)
	local ids = self:getKwIdsByStepIndex(index)

	for _, mo in pairs(self.allKeywordMos) do
		local isUse = LuaUtil.tableContains(ids, mo.keywordId)

		mo:setUsed(isUse)
	end
end

function Activity165StoryMo:fillKeyword(keywordId)
	local ids = self:getKwIdsByStepIndex(self.curStepIndex)

	if not LuaUtil.tableContains(ids, keywordId) then
		table.insert(ids, keywordId)

		self.stepUseKeywords[self.curStepIndex] = ids
	end

	self.allKeywordMos[keywordId]:setUsed(true)
end

function Activity165StoryMo:removeUseKeywords(keywordId)
	local ids = self:getKwIdsByStepIndex(self.curStepIndex)

	if LuaUtil.tableContains(ids, keywordId) then
		tabletool.removeValue(ids, keywordId)

		self.stepUseKeywords[self.curStepIndex] = ids
	end

	self.allKeywordMos[keywordId]:setUsed(false)
end

function Activity165StoryMo:onModifyKeyword(ids)
	Activity165Rpc.instance:sendAct165ModifyKeywordRequest(self._actId, self.storyId, ids or {})
end

function Activity165StoryMo:onModifyKeywordCallback(storyInfo)
	return
end

function Activity165StoryMo:getKwIdsByStepIndex(stepIndex)
	local ids = {}

	if not stepIndex then
		return ids
	end

	ids = self.reviewEnding and (self.reviewStepUseKeywords and self.reviewStepUseKeywords[stepIndex] or {}) or self.stepUseKeywords and self.stepUseKeywords[stepIndex] or {}

	return ids
end

function Activity165StoryMo:generateStroy()
	local co = self:getEndingCo()

	self.curUnlockEndingId = co.endingId

	self:setCurState(Activity165Enum.StoryStage.Ending)
	self:UnlockEnding(co.endingId)
end

function Activity165StoryMo:getEndingCo()
	local finishStepId = self.finalStepMo.stepId

	if self.reviewEnding then
		local _, _, _finishStepId = self:getEndingStepInfo(self.reviewEnding)

		finishStepId = _finishStepId
	end

	return (Activity165Config.instance:getEndingCoByFinalStep(self._actId, self.storyId, finishStepId))
end

function Activity165StoryMo:getEndingText()
	if self.reviewEnding then
		local _, _, finishStepId = self:getEndingStepInfo(self.reviewEnding)
		local mo = self:getStepMo(finishStepId)

		return mo.stepCo.text
	else
		if not self.finalStepMo then
			return
		end

		if self.finalStepMo.isEndingStep then
			return self.finalStepMo.stepCo.text
		end

		logError("不是结局步骤  " .. self.finalStepMo.stepId)
	end
end

function Activity165StoryMo:getState()
	return (self.reviewEnding or nil) and (Activity165Enum.StoryStage.Ending or self.curStage)
end

function Activity165StoryMo:UnlockEnding(endingId)
	local steps = {}

	for i = 1, #self.unlockSteps do
		local info = {
			stepId = self.unlockSteps[i],
			stepKeywords = self.stepUseKeywords[i]
		}

		table.insert(steps, info)
	end

	self._isShowDialog = self.unlockEndings[endingId] == nil
	self.unlockEndings[endingId] = steps

	Activity165Rpc.instance:sendAct165GenerateEndingRequest(self._actId, self.storyId)

	self.curUnlockEndingId = endingId
end

function Activity165StoryMo:getUnlockEndingCount()
	if LuaUtil.tableNotEmpty(self.unlockEndings) then
		return tabletool.len(self.unlockEndings)
	end

	return 0
end

function Activity165StoryMo:isShowDialog()
	return self._isShowDialog
end

function Activity165StoryMo:getAllEndingRewardCo()
	return Activity165Config.instance:getStoryRewardCoList(self._actId, self.storyId)
end

function Activity165StoryMo:gmCreateEndingStep()
	local endingSteps = tabletool.copy(self.endingAllBranch[1])

	table.remove(endingSteps, 1)

	self.unlockSteps = endingSteps

	local finalId = endingSteps[#endingSteps]

	self.finalStepMo = self:getStepMo(finalId)

	self:checkIsFinishStroy()

	local co = Activity165Config.instance:getEndingCoByFinalStep(self._actId, self.storyId, finalId)

	self.curUnlockEndingId = co.endingId

	self:setCurState(Activity165Enum.StoryStage.isEndFill)
	Activity165Controller.instance:dispatchEvent(Activity165Event.refrshEditView)
end

function Activity165StoryMo:getclaimRewardCount()
	return self.claimRewardCount
end

function Activity165StoryMo:setclaimRewardCount(count)
	self.claimRewardCount = count
end

function Activity165StoryMo:isFinish()
	local count = self:getUnlockEndingCount()

	return count > 0
end

function Activity165StoryMo:_initElements()
	self._elements = {}

	if self.storyCo then
		local ids1 = self.storyCo.unlockElementIds1

		if not string.nilorempty(ids1) then
			local list = string.splitToNumber(ids1, "#")

			tabletool.addValues(self._elements, list)
		end

		local ids2 = self.storyCo.unlockElementIds2

		if not string.nilorempty(ids2) then
			local list = string.splitToNumber(ids2, "#")

			tabletool.addValues(self._elements, list)
		end
	end
end

function Activity165StoryMo:getElements()
	return self._elements
end

function Activity165StoryMo:isShowReddot()
	if self:isAllClaimed() then
		return false
	end

	return self._isNewUnlock or self:_isShowRewardReddot()
end

function Activity165StoryMo:_isShowRewardReddot()
	return RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Act165HasReward, self.storyId)
end

function Activity165StoryMo:isNewUnlock()
	return self._isNewUnlock
end

function Activity165StoryMo:cancelNewUnlockStory()
	if self._isNewUnlock then
		self._isNewUnlock = false

		GameUtil.playerPrefsSetNumberByUserId(self:_getNewUnlockStoryKey(), 1)
	end
end

function Activity165StoryMo:_checkNewUnlockStory()
	if self.isUnlock and GameUtil.playerPrefsGetNumberByUserId(self:_getNewUnlockStoryKey(), 0) == 0 then
		self._isNewUnlock = true

		return
	end

	self._isNewUnlock = false
end

function Activity165StoryMo:saveStepUseKeywords()
	local str = ""

	for i, v in pairs(self.stepUseKeywords) do
		if i > 1 then
			str = str .. "|"
		end

		for j, kw in pairs(v) do
			str = j > 1 and str .. "#" .. kw or str .. kw
		end
	end

	GameUtil.playerPrefsSetStringByUserId(self:_getStepUseKeywordsKey(), str)
end

function Activity165StoryMo:_getStepUseKeywords()
	local str = GameUtil.playerPrefsGetStringByUserId(self:_getStepUseKeywordsKey(), "")

	return (not string.nilorempty(str) or nil) and GameUtil.splitString2(str, true)
end

function Activity165StoryMo:_getStepUseKeywordsKey()
	return Activity165Model.instance:_getStoryPrefsKey("StepUseKeywords2", self.storyId)
end

function Activity165StoryMo:_getNewUnlockStoryKey()
	return Activity165Model.instance:_getStoryPrefsKey("NewUnlockStory", self.storyId)
end

function Activity165StoryMo:isAllClaimed()
	local claimCount = self:getclaimRewardCount() or 0
	local storyRewardCoList = self:getAllEndingRewardCo()
	local allRewardCount = storyRewardCoList and tabletool.len(storyRewardCoList) or 0

	return allRewardCount <= claimCount
end

return Activity165StoryMo
