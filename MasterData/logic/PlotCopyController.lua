-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/controller/PlotCopyController.lua

module("logic.extensions.plotcopy.controller.PlotCopyController", package.seeall)

local PlotCopyController = class("PlotCopyController", BaseController)

function PlotCopyController:ctor()
	self._isFirstReq = true
	self._maxTypeId = GameEnum.Chapter.Plot
end

function PlotCopyController:onInit()
	PlotChallengeAgent.instance:setShowChangeSetFunc(GameUtil.handler(self.showChangeSet, self))
	GlobalDispatcher:addListener(PlotChallengeAgent.NotifyAfterChallengeRes, self._onNotifyAfterChallengeRes, self)
	GlobalDispatcher:addListener(PlotChallengeAgent.GetChapterProgressRes, self._onGetChapterProgressRes, self)
	GlobalDispatcher:addListener(PlotChallengeAgent.GainChapterPrizeRes, self._GainChapterPrizeRes, self)
	GlobalDispatcher:addListener(PlotChallengeAgent.ChallengeRes, self._OnChallengeRes, self)
	GlobalDispatcher:addListener(PlotChallengeAgent.GainPreciousBoxPrizeRes, self._onGainPreciousBoxPrizeRes, self)
	GlobalDispatcher:addListener(PlotChallengeAgent.PCLG_SweepsByTimesRes, self._onSweepByTimesRes, self)
	GlobalDispatcher:addListener(PlotChallengeAgent.PCLG_SweepAutoRes, self._onSweepAutoRes, self)
	self.registerNotify(self, GlobalNotify.OnViewClose, self._onViewClosed, self)
end

function PlotCopyController:onReset()
	self._isFirstReq = true

	self:clearPlotChapterviewCachesExcept()
end

function PlotCopyController:loadCopyInfo()
	self:sendGetChapterProgressReq()
end

function PlotCopyController:enterCopy(id)
	local chapterCo = CopyConfig.instance:getChapter(id)

	if not chapterCo then
		printError("进入副本失败，副本id不存在 chapterId = ", id)

		return
	end

	PlotCopyModel.instance:setChapterType(chapterCo.chapterType)

	local isUnlock = PlotCopyModel.instance:isChapterUnlock(id)

	if not isUnlock then
		PlotCopyModel.instance:showLockTips(chapterCo)

		return
	end

	PlotCopyController.instance:openChapterView(chapterCo.chapterId)
end

function PlotCopyController:enterStateView(chapterId, stageId)
	if stageId == nil then
		stageId = 1
	end

	local chapterCo = CopyConfig.instance:getChapter(chapterId)
	local stageCfg = CopyConfig.instance:getStageById(chapterId, stageId)

	if not chapterCo or not stageCfg then
		printError("进入关卡失败，副本id不存在 chapterId:stageId = ", chapterId, stageId, type(chapterId), type(stageId))

		return
	end

	PlotCopyModel.instance:setChapterType(chapterCo.chapterType)

	local isUnlock = PlotCopyModel.instance:isChapterUnlock(chapterId)

	if not isUnlock then
		PlotCopyModel.instance:showLockTips(chapterCo)

		return
	end

	local unlockState = PlotCopyModel.instance:getUnlockState(chapterId, stageId)
	local isUnlock = unlockState == 0

	if isUnlock then
		self:openStageView(chapterId, stageId)
	else
		local cfg = CopyConfig.instance:getStageById(chapterId, stageId)

		PlotCopyModel.instance:showUnLockTip(unlockState, cfg)
	end
end

function PlotCopyController:_onViewClosed(view)
	if not self._plotChapterviewCaches or table.nums(self._plotChapterviewCaches) == 0 then
		return
	end

	local viewName = view.viewName

	if viewName ~= ViewName.PlotChapterView then
		return
	end

	if UIStateManager.instance:isInStack(ViewName.PlotChapterView) or UIJumper.instance:isInStack(ViewName.PlotChapterView) then
		return
	end

	removetimer(self._autoClearPlotCaches, self)
	settimer(5, self._autoClearPlotCaches, self, false)
end

function PlotCopyController:_autoClearPlotCaches()
	self:clearPlotChapterviewCachesExcept()
end

function PlotCopyController:clearPlotChapterviewCachesExcept(chapterId)
	removetimer(self._autoClearPlotCaches, self)

	if not self._plotChapterviewCaches then
		return
	end

	local needClear
	local temp = table.keys(self._plotChapterviewCaches)

	for k, v in pairs(temp) do
		if v ~= chapterId then
			local caches = self._plotChapterviewCaches[v]

			for k1, v1 in pairs(caches.resourcesList) do
				v1:Release()

				needClear = true
			end

			self._plotChapterviewCaches[v] = nil
		end
	end

	if needClear then
		Framework.DynImageCache.Instance:ReleaseAllUnused()
		rescache:DestroyUnusedResources()
	end
end

function PlotCopyController:cachePlotChapterviewRes(chapterId, resPath)
	self._plotChapterviewCaches = self._plotChapterviewCaches or {}
	self._plotChapterviewCaches[chapterId] = self._plotChapterviewCaches[chapterId] or {}

	local caches = self._plotChapterviewCaches[chapterId]

	caches.resourcesList = caches.resourcesList or {}

	if caches.resourcesList[resPath] then
		return
	end

	local res = rescache:GetResourceNoLoadIfNotExists(resPath)

	if res then
		caches.resourcesList[resPath] = res

		res:Retain()
	end
end

function PlotCopyController:sendGetChapterProgressReq(handler, handlerObj, errHandler)
	PlotChallengeAgent.instance:sendGetChapterProgressReq()
end

function PlotCopyController:sendChallengeReq(chapterId, stageId, handler, handlerObj, errHandler)
	PlotCopyModel.instance:setChapterAndStageInBattle(chapterId, stageId)
	PlotChallengeAgent.instance:sendChallengeReq(chapterId, stageId, handler, handlerObj, errHandler)
end

function PlotCopyController:sendGainChapterPrizeReq(chapterId, index, handler, handlerObj, errHandler)
	PlotChallengeAgent.instance:sendGainChapterPrizeReq(chapterId, index, handler, handlerObj, errHandler)
end

function PlotCopyController:showChangeSet(changeSetId, msgName)
	if msgName == "handleNotifyAfterChallengeRes" then
		local curChapterId, curStageId = PlotCopyModel.instance:getChapterAndStageInBattle()

		if PlotCopyModel.instance:isPurePlot(curChapterId, curStageId) then
			MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
		else
			BattleSettlementModel.instance:setChangeSetId(changeSetId)
		end
	else
		MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
	end
end

function PlotCopyController:_OnChallengeRes(status, msg)
	local chapterId = msg.chapterId
	local stageId = msg.stageId

	local function handler(isWin)
		if isWin then
			self:_playAfterBattle(chapterId, stageId)
		end
	end

	BattleFacade.instance:setBattleEndRoundFromStoryHandler(handler)
end

function PlotCopyController:_playAfterBattle(chapterId, stageId)
	local cfg = CopyConfig.instance:getStageById(chapterId, stageId)

	if cfg and cfg.afterBattleId > 0 then
		if not self:_isPlayStory(chapterId, stageId) then
			return
		end

		local storyData = {
			storyId = cfg.afterBattleId,
			mode = TaskConst.BattleStoryTrigger_End
		}

		BattleModel.instance:setStoryData(storyData)
	end
end

function PlotCopyController:_isPlayStory(chapterId, stageId)
	local name = RoleModel.instance:getUserId() .. CopyConst.playStoryInBattle .. chapterId .. stageId
	local nameValue = UnityEngine.PlayerPrefs.GetInt(name)

	if nameValue == 0 then
		UnityEngine.PlayerPrefs.SetInt(name, 1)

		return true
	else
		return false
	end
end

function PlotCopyController:_onNotifyAfterChallengeRes(status, msg)
	if status == 0 then
		local curStageProgress = msg.curStageProgress
		local isStagePerfectPass = PlotCopyModel.instance:isStagePerfectPass(curStageProgress.chapterId, curStageProgress.curStageId)
		local isPassed = PlotCopyModel.instance:isStagePassed(curStageProgress.chapterId, curStageProgress.curStageId)

		PlotCopyModel.instance:onNotifyAfterChallenge(msg)
		self:_setBattleSettlement(msg, isStagePerfectPass, isPassed)
		self:onPurePlot(curStageProgress.chapterId, curStageProgress.curStageId)
		self:_setNewSympolFinish(curStageProgress.chapterId, curStageProgress.curStageId)

		local multiple = 0
		local isDouble = PlayerReturnModel.instance:getPlgePlotCopyIsDouble()

		if checknumber(msg.rewardMultiplyTimes) > 0 then
			multiple = multiple + 1
		end

		if isDouble then
			multiple = multiple + 1
		end

		if multiple > 0 then
			BattleSettlementModel.instance:setRewardChangeSetId(msg.rewardChangeSetId, true, multiple)
		else
			BattleSettlementModel.instance:setRewardChangeSetId(msg.rewardChangeSetId, false)
		end
	end
end

function PlotCopyController:_setBattleSettlement(msg, isPerfectPassBefore, isPassed)
	local params = {}
	local cfg = CopyConfig.instance:getStageById(msg.curStageProgress.chapterId, msg.curStageProgress.curStageId)

	if cfg then
		params.teamId = cfg.teamIds or 0
	end

	if not PlotCopyModel.instance:isPurePlot(msg.curStageProgress.chapterId, msg.curStageProgress.curStageId) then
		params.videoKey = BattleRecordRankController.instance:getStoryKey(msg.curStageProgress.chapterId, msg.curStageProgress.curStageId)
	end

	if msg.isWin then
		params.isPerfect = msg.isPerfect
	else
		local num = 0

		if cfg and cfg.teamIds then
			local cfgTeam = CopyConfig.instance:getTeamCfg(cfg.teamIds)

			if cfgTeam then
				num = cfgTeam.strengthConsumption
			end
		end

		params.giveBackItem = MatType.Strength .. ":1:" .. num

		if not isPassed then
			params.isHideStrength = true
		end
	end

	params.chapterId = msg.curStageProgress.chapterId
	params.stageId = msg.curStageProgress.curStageId
	params.isPerfectPassBefore = isPerfectPassBefore

	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.PlotCopy, params)
end

function PlotCopyController:_setNewSympolFinish(chapterId, stageId)
	local name = RoleModel.instance:getUserId() .. CopyConst.isNewStage .. chapterId .. stageId
	local nameValue = UnityEngine.PlayerPrefs.GetInt(name)

	if nameValue == 0 then
		UnityEngine.PlayerPrefs.SetInt(name, 1)
	end
end

function PlotCopyController:_onGetChapterProgressRes(status, msg)
	if status == 0 then
		PlotCopyModel.instance:onGetChapterProgress(msg)
		printInfo("data ready 111>>>>>>>>>>", self._isFirstReq, msg.typeId, self._maxTypeId)

		if self._isFirstReq and msg.typeId == self._maxTypeId then
			self._isFirstReq = false

			printInfo("data ready 222>>>>>>>>>>")
			GlobalDispatcher:dispatch(GlobalNotify.CopyDataReady)
		end
	end
end

function PlotCopyController:_GainChapterPrizeRes(status, msg)
	if status == 0 and msg.chapterId and msg.index then
		PlotCopyModel.instance:onGainChapterPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.CopyGainChapterPrizeRes, msg.chapterId)
	end
end

function PlotCopyController:_onGainPreciousBoxPrizeRes(status, msg)
	if status == 0 then
		PlotCopyModel.instance:onGainPreciousBoxPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.CopyGainPreciousBoxPrizeRes)
	end
end

function PlotCopyController:openChapterView(chapterId)
	local chapterCo = CopyConfig.instance:getChapter(chapterId)

	if not chapterCo then
		printError("进入章节失败，副本id不存在 chapterId = ", chapterId)

		return
	end

	removetimer(self._autoClearPlotCaches, self)
	UIStateManager.instance:push(ViewName.PlotChapterView, chapterId)
end

function PlotCopyController:openStageView(chapterId, stageId)
	local chapterCfg = CopyConfig.instance:getChapter(chapterId)
	local stageCfg = CopyConfig.instance:getStageById(chapterId, stageId)

	if not chapterCfg or not stageCfg then
		printError("进入关卡失败，副本id不存在 chapterId:stageId = ", chapterId, stageId, type(chapterId), type(stageId))

		return
	end

	UIStateManager.instance:push(ViewName.PlotStageView, chapterId, stageId)
end

function PlotCopyController:pushOneStackView(chapterId, stageId)
	local chapterType = PlotCopyModel.instance:getChapterType()

	UIJumper.instance:pushOneStack(ViewName.PlotCopyView, true)
	BattleFacade.instance:startCopy(chapterId, stageId)
	UIJumper.instance:pushOneStack(ViewName.PlotChapterView, true, chapterId)
end

function PlotCopyController:onPurePlot(chapterId, stageId)
	BattleFacade.instance:startCopy(chapterId, stageId)

	if PlotCopyModel.instance:isPurePlot(chapterId, stageId) then
		if TaskModel.instance:hasTaskesPureStoryCopy(chapterId, stageId) then
			UIStateManager.instance:clear(true)
		end

		GlobalDispatcher:dispatch(GlobalNotify.UpdateChapterDetail)
	end
end

function PlotCopyController:sendPCLG_SweepsByTimesReq(chapterId, stageId, times, useTicket, handler, handlerObj, errHandler)
	PlotChallengeAgent.instance:sendPCLG_SweepsByTimesReq(chapterId, stageId, times, useTicket, handler, handlerObj, errHandler)
end

function PlotCopyController:sendPCLG_SweepAutoReq(chapterId, stageId, materialType, materialId, num, useTicket, handler, handlerObj, errHandler)
	PlotChallengeAgent.instance:sendPCLG_SweepAutoReq(chapterId, stageId, materialType, materialId, num, useTicket, handler, handlerObj, errHandler)
end

function PlotCopyController:sendPCLG_GetRewardMultiplyTimesReq()
	PlotChallengeAgent.instance:sendPCLG_GetRewardMultiplyTimesReq()
end

function PlotCopyController:_onSweepByTimesRes(status, msg)
	return
end

function PlotCopyController:_onSweepAutoRes(status, msg)
	if status ~= 0 then
		GlobalDispatcher:dispatch(GlobalNotify.CopySweepAutoResError)
	end
end

function PlotCopyController:getMaxQuickPassStageInfo(chapterType)
	local chapterId, stageId = 0, 0
	local chapters = CopyConfig.instance:getChapters(chapterType)
	local isFind = false

	for i, chapterCfg in ipairs(chapters) do
		local stages = CopyConfig.instance:getStages(chapterCfg.chapterId)

		for j, stageCfg in ipairs(stages) do
			local cfg = CopyConfig.instance:getStageById(stageCfg.chapterId, stageCfg.stageId)

			if cfg then
				if not cfg.zdlPercent then
					local factor = 100
					local recZdl = self:_getRecZdl(stageCfg.chapterId, stageCfg.stageId)
					local curZdl = self:_getCurPower()
					local compareZdl = Mathf.Ceil(recZdl * (factor / 100))

					if compareZdl <= curZdl then
						if stageCfg.isMs == true then
							stageId = stageCfg.stageId
							chapterId = stageCfg.chapterId
						end
					else
						isFind = true

						break
					end
				end
			end
		end

		if isFind == true then
			break
		end
	end

	return chapterId, stageId
end

function PlotCopyController:_getRecZdl(chapterId, stageId)
	local cfg = CopyConfig.instance:getStageById(chapterId, stageId)

	if cfg then
		local creepsMasterId = cfg.teamIds
		local cfgTeam = CopyConfig.instance:getTeamCfg(creepsMasterId)

		return (self:_getRecommendZdl(creepsMasterId, checknumber((cfgTeam or nil) and cfgTeam.heroSkillId)))
	end

	return 0
end

function PlotCopyController:_getRecommendZdl(creepsMasterId, heroSkillId)
	local cCfgs = CopyConfig.instance:getTeamPets(creepsMasterId)

	if not cCfgs then
		return 0
	end

	return (FightingPowerFormula.instance:getFightingPowerOfFmt(cCfgs, heroSkillId))
end

function PlotCopyController:_getCurPower()
	local curForm = FormationNewModel.instance:GetCurTeam():GetCurFormation()
	local team = {}
	local heroSkillId = curForm:GetHeroSkillId()
	local fid = 0
	local flv = 0

	for idx, v in ipairs(curForm:GetPositions()) do
		if v > 0 then
			local pet = BagPetsController.instance:getPet(v)

			if pet then
				table.insert(team, pet)
			end
		end
	end

	local info = curForm:GetFormStrengthInfo()

	if info and info.formStrengthId and info.formStrengthId > 0 then
		fid = info.formStrengthId
		flv = info.formStrengthLv
	end

	local eleMap = curForm:getCurElementRelationMap()
	local cutePetRaceId, cutePetQuality = curForm:getCutePetInfo()
	local masterId = curForm:GetSummonMasterPetId()
	local summonId = curForm:GetSummonPetId()

	return (FightingPowerFormula.instance:getTeamFightingPower(team, heroSkillId, fid, flv, eleMap, cutePetRaceId, cutePetQuality, masterId, summonId))
end

PlotCopyController.instance = PlotCopyController.New()

return PlotCopyController
