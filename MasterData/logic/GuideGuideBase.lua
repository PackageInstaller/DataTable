-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/guide/GuideGuideBase.lua

module("logic.extensions.guide.model.branch.GuideGuideBase", package.seeall)

local GuideGuideBase = class("GuideGuideBase")

function GuideGuideBase:ctor(branchId, guideId)
	self.guide = GuideConfig.instance:getGuide(branchId, guideId)
	self.branchId = branchId
	self.___gid_bak = guideId
	self.isGuiding = nil
	self.isFinish = nil
	self._uiName = nil
	self._guideParam = nil
	self.isForceFinish = false
end

function GuideGuideBase:shouldTrigger()
	if NewhandwelfareController.instance:isNeedPopNewHandSelectPassView() then
		return false
	end

	if self:_isChallengeLimit() then
		return false
	end

	if self:_isChallengeSpecifiedLimit() then
		return false
	end

	if self:_isGuideFinishByTaskFinish() then
		return false
	end

	if self:_isTaskLimit() then
		return false
	end

	return true
end

function GuideGuideBase:isTriggeredInScene(sceneId, sceneType)
	return self.guide.sceneId == sceneId
end

function GuideGuideBase:isTriggeredByScene()
	return self.guide.sceneId and self.guide.sceneId > 0
end

function GuideGuideBase:isTriggeredInView(view, childName)
	if self.guide == nil then
		printError(">>>>>>>>>>>>>>>>>>>>> 新手配置错误 是不是跳错步骤了【" .. self.branchId .. ":" .. self.___gid_bak .. "】")
	end

	if self.guide and self.guide.presentor == "" then
		return true
	end

	local obj = self:getJsonParams()

	if string.nilorempty(obj.parentViewName) then
		return self.guide.presentor == view
	elseif obj.parentViewName == view then
		local list = obj.moreViewNameList

		if list and #list then
			for i, v in ipairs(list) do
				if not ViewMgr.instance:isOpen(v) then
					return false
				end
			end

			return ViewMgr.instance:isOpen(self.guide.presentor)
		else
			return self.guide.presentor == childName
		end
	end
end

function GuideGuideBase:isTriggeredByTask(taskId)
	if self.guide.taskLimit then
		return self.guide.taskLimit[1] == taskId
	else
		return false
	end
end

function GuideGuideBase:reportBehavior()
	local bid = checknumber(self.guide.reportBehavior)

	if bid > 0 then
		SurveyController.instance:reportBehavior(bid)
	end
end

function GuideGuideBase:startGuide()
	print(">>>>>>> 开始引导 步骤", self.guide.branch, self.guide.guideId)

	if not self.isGuiding then
		self.isGuiding = true

		self:_showGuideUI()
		print(">>>>>>> 开始引导 步骤 ss", self.guide.branch, self.guide.guideId)
	end
end

function GuideGuideBase:checkFinish()
	print(">>>>>>> 开始检测 前置条件是不是达到，不达到就强制跳过 步骤 ss", self.guide.branch, self.guide.guideId)

	local obj = self:getJsonParams()

	if obj.checkpet then
		for k, raceId in pairs(obj.checkpet) do
			if BagModel.instance:isExistRaceId(raceId) == false then
				self.isForceFinish = true

				break
			end
		end
	end

	if obj.checkpetlvl then
		local pets = BagModel.instance:getPets()

		if pets then
			local found = false
			local arr = string.split(obj.checkpetlvl, "#")
			local raceId = checknumber(arr[1])
			local lvl = checknumber(arr[2])

			for k, petMo in pairs(pets) do
				if petMo.raceId == raceId and lvl > petMo.level and petMo:isExist() then
					found = true

					break
				end
			end

			if not found then
				self.isForceFinish = true
			end
		end
	end

	if obj.checkItem then
		for k, v in pairs(obj.checkItem) do
			local arr = string.split(v, ":")
			local matType = checknumber(arr[1])
			local id = checknumber(arr[2])
			local len = math.max(3, #arr)
			local num = checknumber(arr[len])

			if num > MaterialModel.instance:getMaterialsNumber(matType, id) then
				self.isForceFinish = true

				break
			end
		end
	end

	if obj.checkPerfect then
		local cid = obj.checkPerfect[1]
		local count = obj.checkPerfect[2]
		local pc, total = PlotCopyModel.instance:getPerfectFinishCount(cid)

		if pc < count then
			self.isForceFinish = true
		end
	end

	if obj.check_FB_open then
		local chapterId = obj.check_FB_open[1]
		local stageId = obj.check_FB_open[2]
		local isUnlock = PlotCopyModel.instance:isChapterUnlock(chapterId)
		local state = PlotCopyModel.instance:getUnlockState(chapterId, stageId)

		if isUnlock and state == 0 then
			-- block empty
		else
			self.isForceFinish = true
		end
	end

	if obj.check_challenge_pass then
		local challengeId = obj.check_challenge_pass

		self.isForceFinish = LegendModel.instance:isChallengePass(challengeId)
	end

	if obj.check_ZY_open then
		local chapterId = obj.check_ZY_open[1]
		local stageId = obj.check_ZY_open[2]
		local hasLeft = MaterialChallengeModel.instance:leftCostCount(chapterId)
		local isStageUnlock = MaterialChallengeModel.instance:isStageUnlock(chapterId, stageId)

		if hasLeft > 0 and isStageUnlock then
			-- block empty
		else
			self.isForceFinish = true
		end
	end

	if obj.check_handbook_get then
		local teamId = obj.check_handbook_get[1]
		local pid = obj.check_handbook_get[2]
		local hasget = HandbookModel.instance:getPrizeReceived(teamId, pid)

		if hasget then
			self.isForceFinish = true
		end
	end

	if obj.check_end_var then
		self.isForceFinish = self:checkViewVar(obj.check_end_var, obj.check_end_varOp)
	end

	if obj.check_nine_place then
		self.isForceFinish = NinePlaceModel.instance:isStageCreepsPass(obj.check_nine_place[1], obj.check_nine_place[2])
	end

	if checknumber(obj.check_has_family) > 0 then
		self.isForceFinish = FamilyController.instance:getFamilyLv() > 0
	end

	if obj.check_openTime then
		local str = obj.check_openTime
		local times = string.split(str, "#")

		self.isForceFinish = GameUtil.checkIsInTimePeriod(times[1], times[2])
	end

	return self.isForceFinish
end

function GuideGuideBase:checkViewVar(key, op)
	local val = GuideController.instance:getOrCheckVarAndDoOnce(key)

	return self:checkValIsMatch(key, val, op)
end

function GuideGuideBase:checkValIsMatch(key, val, op)
	op = op or ""

	local boo = false

	if val ~= nil then
		print(">>>>>>>>>> GuideBranchFunOpen:checkValIsMatch(key , val ,op)", key, val, op)

		boo = string.find(op, ">=") and checknumber(val) >= checknumber(string.split(op, ">=")[2]) or string.find(op, "<=") and checknumber(val) <= checknumber(string.split(op, "<=")[2]) or string.find(op, "==") and checknumber(val) == checknumber(string.split(op, "==")[2]) or string.find(op, "!=") and checknumber(val) ~= checknumber(string.split(op, "!=")[2]) or string.find(op, "~=") and checknumber(val) ~= checknumber(string.split(op, "~=")[2]) or string.find(op, ">") and checknumber(val) > checknumber(string.split(op, ">")[2]) or string.find(op, "<") and checknumber(val) < checknumber(string.split(op, "<")[2]) or string.find(op, "=") and checknumber(val) == checknumber(string.split(op, "=")[2]) or string.find(op, "is$") and val == string.split(op, "is$")[2] or true
	end

	return boo
end

function GuideGuideBase:finishGuide()
	print(">>>>>>> 结束引导 步骤", self.guide.branch, self.guide.guideId)

	if self.isGuiding then
		self.isGuiding = nil

		self:_closeGuideUI()

		self.isFinish = true

		print(">>>>>>> 结束引导 步骤 ss", self.guide.branch, self.guide.guideId)
	end
end

function GuideGuideBase:isFinish()
	return self.isFinish
end

function GuideGuideBase:getGuideId()
	return self.guide.guideId
end

function GuideGuideBase:nextGuideId()
	local nextId = self.guide.nextId

	if not nextId or nextId == 0 then
		return GuideConst.INVALID_GUIDE_ID
	end

	return nextId
end

function GuideGuideBase:getGuideView()
	return self.guide.presentor
end

function GuideGuideBase:getParentGuideView()
	local obj = self:getJsonParams()

	if string.nilorempty(obj.parentViewName) then
		return self.guide.presentor
	else
		return obj.parentViewName
	end
end

function GuideGuideBase:getGuideSceneId()
	return self.guide.sceneId
end

function GuideGuideBase:getGuideUIType()
	return self.guide.uiType
end

function GuideGuideBase:getGuideUIParams()
	return self:getJsonParams().uiParams
end

function GuideGuideBase:getJsonParams()
	if self.guide then
		return self.guide.jsonParams or {}
	else
		return {}
	end
end

function GuideGuideBase:getForceType()
	return self.guide.forceType or self.isForceFinish
end

function GuideGuideBase:autoFinishTime()
	return checknumber(self.guide.autoFinishTime)
end

function GuideGuideBase:getUINode()
	return self.guide.view
end

function GuideGuideBase:getUIWidget()
	return self.guide.widget
end

function GuideGuideBase:getDialogue()
	local obj = self:getJsonParams()

	if obj ~= nil then
		if RoleModel.instance:getPlayerType() == 1 then
			if obj.dialogue_old then
				return lang(obj.dialogue_old)
			end
		elseif RoleModel.instance:getPlayerType() == 2 and obj.dialogue_new then
			return lang(obj.dialogue_new)
		end
	end

	return self.guide.dialogue
end

function GuideGuideBase:getWidgetOffset()
	return self.guide.offset
end

function GuideGuideBase:getRotation()
	return self.guide.rotation
end

function GuideGuideBase:getStartpos()
	if self.guide.startpos then
		return Vector3.New(self.guide.startpos[1], self.guide.startpos[2], 0)
	else
		return Vector3.zero
	end
end

function GuideGuideBase:getEndpos()
	if self.guide.endpos then
		return Vector3.New(self.guide.endpos[1], self.guide.endpos[2], 0)
	else
		return Vector3.zero
	end
end

function GuideGuideBase:getIsMask()
	return self.guide.isMask
end

function GuideGuideBase:getIsShow()
	return self.guide.isShow
end

function GuideGuideBase:getIsIcon()
	return self.guide.isIcon
end

function GuideGuideBase:getContentFix()
	local obj = self:getJsonParams()

	if obj ~= nil then
		return obj.contentFix
	end
end

function GuideGuideBase:getRaycast()
	return self.guide.isRaycast
end

function GuideGuideBase:_isChallengeLimit()
	if self.guide.challengeLimit then
		local cnt = #self.guide.challengeLimit

		if cnt > 0 then
			if not ChallengeFacade.instance:isBranchPassed(self.guide.challengeLimit[1], self.guide.challengeLimit[2], self.guide.challengeLimit[3], self.guide.challengeLimit[4] or 0) then
				return true
			end
		end
	end
end

function GuideGuideBase:setGuideParam(param)
	self._guideParam = param
end

function GuideGuideBase:finishOnEnterSceneId()
	return SceneConfig.BattleSceneId
end

function GuideGuideBase:_isChallengeSpecifiedLimit()
	if self.guide.challenge then
		local cnt = #self.guide.challenge

		if cnt > 0 then
			if ChallengeFacade.instance:isBranchPassed(self.guide.challenge[1], self.guide.challenge[2], self.guide.challenge[3], self.guide.challenge[4] or 0) then
				return
			end

			if not ChallengeFacade.instance:isChallengingBranchLevel(self.guide.challenge[1], self.guide.challenge[2], self.guide.challenge[3], self.guide.challenge[4] or 0) then
				return true
			end
		end
	end
end

function GuideGuideBase:_isGuideFinishByTaskFinish()
	local taskLimit = self.guide.taskLimitFinish

	if taskLimit then
		local cnt = #taskLimit

		if cnt > 0 and taskLimit[2] and TaskFacade.instance:isTaskStepFinished(taskLimit[1], taskLimit[2]) then
			return true
		end
	end

	return false
end

function GuideGuideBase:_isTaskLimit()
	local taskLimit = self.guide.taskLimit

	if taskLimit then
		local cnt = #taskLimit

		if cnt > 0 then
			if self.guide.presentor == ViewName.MainUI then
				if TaskController.instance:hasTaskesAutoCompelete() then
					return true
				end

				local itemSet = ItemGetController.instance:getItemSets()

				if itemSet and not itemSet:IsEmpty() then
					return true
				end
			end

			if not taskLimit[2] or not TaskFacade.instance:isTaskStepFinished(taskLimit[1], taskLimit[2]) then
				return true
			end
		end
	end

	return false
end

function GuideGuideBase:_showGuideUI()
	local guideType = self:getGuideUIType()

	print(">>>>>>>>>>show ui ", guideType)

	local obj = self:getJsonParams()
	local uiName

	if guideType == GuideConst.GUIDE_UI_TIPS then
		uiName = ViewName.GuideTipsView
	elseif guideType == GuideConst.GUIDE_UI_DRAGTO then
		uiName = ViewName.GuideDragto
	elseif guideType == GuideConst.GUIDE_UI_FRAME then
		uiName = ViewName.GuideFrameView
	elseif guideType == GuideConst.GUIDE_UI_HIGHTLIGHT then
		uiName = ViewName.GuideHighLight
	elseif guideType == GuideConst.GUIDE_AUTO_FINISH_MASK_VIEW then
		uiName = ViewName.GuideMaskView
	elseif guideType == GuideConst.GUIDE_UI_HEADVIEW then
		uiName = ViewName.GuideHeadView
	elseif guideType == GuideConst.GUIDE_CAPTURE_VIEW then
		uiName = ViewName.GuideCaptureView
	elseif guideType == GuideConst.GUIDE_UI_BATTLE_GAS then
		uiName = ViewName.GuideBattleGas
	elseif guideType == GuideConst.GUIDE_UI_EFFECT then
		uiName = ViewName.guideEffect
	elseif guideType == GuideConst.GUIDE_UI_QILIN then
		-- block empty
	elseif guideType == GuideConst.GUIDE_FORCEDRAG then
		uiName = ViewName.foreDrag
	elseif guideType == GuideConst.GUIDE_FORCEDRAG_CUSTOM then
		uiName = ViewName.ForeDragCustom
	elseif guideType == GuideConst.GUIDE_FORCEDRAG_CHANGE_POS then
		uiName = ViewName.ForceDragChange
	elseif guideType == GuideConst.GUIDE_UI_TblHIGHT then
		uiName = ViewName.tblHightLight
	elseif guideType == GuideConst.GUIDE_UI_TBLHIGHT_PRIORITY then
		uiName = ViewName.tblHightLightPriority
	elseif guideType == GuideConst.GUIDE_COLLEGE_VIEW then
		uiName = ViewName.GuideMediumshipView
	elseif guideType == GuideConst.GUIDE_COLLEGE_TIPS_VIEW then
		uiName = ViewName.PetcollegetipInBattleView
	elseif guideType == GuideConst.GUIDE_SEASON_VIEW then
		uiName = ViewName.SeasonhexguideView
	elseif guideType == GuideConst.GUIDE_TREASURE_RAIDER_VIEW then
		uiName = ViewName.TreasureraiderhexguideView
	elseif guideType == GuideConst.GUIDE_DISPATCH_EVENT then
		print(">>>>>>>>>>>>> guide 派发1....")

		if obj and obj.event then
			print(">>>>>>>>>>>>> 派发2", obj.event)
			GlobalDispatcher:dispatch(obj.event, self)
		end
	end

	if obj and obj.pre_event and not string.nilorempty(obj.pre_event) then
		GlobalDispatcher:dispatch(obj.pre_event, obj.pre_param)
	end

	self._uiName = uiName

	if self._uiName then
		GuideController.instance:addGuideView(self._uiName)

		local param
		local presentor = ViewMgr.instance:open(self._uiName, self._guideParam and self._guideParam or self)
	end
end

function GuideGuideBase:_closeGuideUI()
	if self.guide.noClose and self._uiName then
		GuideModel.instance:addWillRemoveUI(self._uiName)

		return
	end

	if self.guide.clearPre then
		GuideController.instance:removeGuideUI()
	end

	if self._uiName then
		ViewMgr.instance:close(self._uiName)

		self._uiName = nil
	end
end

return GuideGuideBase
