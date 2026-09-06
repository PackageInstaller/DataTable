-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/model/PlotCopyModel.lua

module("logic.extensions.plotcopy.model.PlotCopyModel", package.seeall)

local PlotCopyModel = class("PlotCopyModel", BaseModel)

function PlotCopyModel:ctor()
	self._rewardMultiplyTimes = nil
end

function PlotCopyModel:onInit()
	self:onReset()
end

function PlotCopyModel:onReset()
	self._mainBtnState = 0
	self._rewardMultiplyTimes = nil
	self._copyLists = {}
	self._copyLists[GameEnum.Chapter.Plot] = CopyInfo.New()
	self._curData = self._copyLists[GameEnum.Chapter.Plot]
end

function PlotCopyModel:setChapterAndStageInBattle(chapterId, stageId)
	self._curData:setChapterAndStageInBattle(chapterId, stageId)
end

function PlotCopyModel:getChapterAndStageInBattle()
	return self._curData:getChapterAndStageInBattle()
end

function PlotCopyModel:setBtnState(chapterType)
	self._mainBtnState = chapterType
end

function PlotCopyModel:getBtnState()
	return self._mainBtnState
end

function PlotCopyModel:onGetChapterProgress(msg)
	for i, v in ipairs(msg.info) do
		if v.typeId == GameEnum.Chapter.Plot then
			self._copyLists[v.typeId]:onGetChapterProgress(v)
		end
	end
end

function PlotCopyModel:setChapterType(chapterType)
	self._curData = self._copyLists[GameEnum.Chapter.Plot]

	self:setBtnState(chapterType)
end

function PlotCopyModel:isCurDataExist()
	if self._curData then
		return true
	else
		return false
	end
end

function PlotCopyModel:getChapterType()
	return self._curData:getChapterType()
end

function PlotCopyModel:getChapterTypeBychapterId(chapterId)
	local cfg = CopyConfig.instance:getChapter(chapterId)

	if not cfg then
		printError("通过章节id找不到相对应配置 chapterId =", chapterId, type(chapterId))

		return -1
	end

	return cfg.chapterType
end

function PlotCopyModel:_getCopyList(chapterId)
	local chapterType = self:getChapterTypeBychapterId(chapterId)

	return self._copyLists[chapterType]
end

function PlotCopyModel:onNotifyAfterChallenge(msg)
	self._curData:onNotifyAfterChallenge(msg)
end

function PlotCopyModel:onGainChapterPrizeRes(msg)
	local chapterType = self:getChapterTypeBychapterId(msg.chapterId)

	self._copyLists[chapterType]:onGainChapterPrizeRes(msg)
end

function PlotCopyModel:onGainPreciousBoxPrizeRes(msg)
	local typeId = msg.updateProgressInfo.typeId

	if self._copyLists[typeId] then
		local updateProgressList = msg.updateProgressInfo.progressList

		self._copyLists[typeId]:onGainPreciousBoxPrizeRes(updateProgressList)
	end
end

function PlotCopyModel:onCopyZdlSecKillRes(msg)
	self._curData:onCopyZdlSecKillRes(msg)
end

function PlotCopyModel:isPerfectPass(battleSettlementModelEnum)
	if battleSettlementModelEnum == BattleSettlementModel.Enum.PlotCopy then
		return self._copyLists[GameEnum.Chapter.Plot]:isPerfectPass()
	else
		return false
	end
end

function PlotCopyModel:isStagePerfectPass(chapterId, stageId)
	local chapterType = self:getChapterTypeBychapterId(chapterId)

	return self._copyLists[chapterType]:isStagePerfectPass(chapterId, stageId)
end

function PlotCopyModel:isChapterUnlock(chapterId)
	local chapterType = self:getChapterTypeBychapterId(chapterId)
	local copyInfo = self._copyLists[chapterType]

	if copyInfo then
		return self._copyLists[chapterType]:isChapterUnlock(chapterId)
	end

	return false
end

function PlotCopyModel:isStageUnlock(chapterId, stageId)
	local chapterType = self:getChapterTypeBychapterId(chapterId)
	local unlockState = self._copyLists[chapterType]:getUnlockState(chapterId, stageId)
	local openStageNum = self._copyLists[chapterType]:curOpenStageNum(chapterId)
	local isLock = openStageNum < stageId or unlockState ~= 0

	return not isLock
end

function PlotCopyModel:getCostLimitCount(chapterId)
	local chapterType = self:getChapterTypeBychapterId(chapterId)

	return self._copyLists[chapterType]:getCostLimitCount(chapterId)
end

function PlotCopyModel:_updateChapterProgress(msg)
	self._curData:_updateChapterProgress(msg)
end

function PlotCopyModel:_getChapterProgress(chapterId)
	local chapterType = self:getChapterTypeBychapterId(chapterId)

	return self._copyLists[chapterType]:_getChapterProgress(chapterId)
end

function PlotCopyModel:isHaveChapterRewardsGain(chapterType)
	return self._copyLists[chapterType]:isHaveChapterRewardsGain()
end

function PlotCopyModel:isHaveRedPoint()
	return self:isHaveChapterRewardsGain(GameEnum.Chapter.Plot) or ShareTaskModel.instance:GetShareBossRed()
end

function PlotCopyModel:isChapterRewardCanGet(chapterId)
	local chapterType = self:getChapterTypeBychapterId(chapterId)

	return self._copyLists[chapterType]:isChapterRewardCanGet(chapterId)
end

function PlotCopyModel:isChapterRewardGain(chapterId, index)
	local chapterType = self:getChapterTypeBychapterId(chapterId)

	return self._copyLists[chapterType]:isChapterRewardGain(chapterId, index)
end

function PlotCopyModel:isCanGetChapterReward(chapterId, index)
	local chapterType = self:getChapterTypeBychapterId(chapterId)

	return self._copyLists[chapterType]:isCanGetChapterReward(chapterId, index)
end

function PlotCopyModel:getChapterRewardCfgs()
	local rewardList = {}
	local cfgChapters = CopyConfig.instance:getChapters(self:getChapterType())

	for id, v in ipairs(cfgChapters) do
		local isUnlock = self:isChapterUnlock(v.chapterId)

		if isUnlock then
			local cfgs = CopyConfig.instance:getRewardStrategys(v.progressReward)

			if cfgs then
				for i, cfgReward in ipairs(cfgs) do
					if self:isCanGetChapterReward(v.chapterId, i - 1) then
						table.insert(rewardList, cfgReward)
					end
				end
			end
		end
	end

	return rewardList
end

function PlotCopyModel:getCurMaxProgress()
	return self._curData:getCurMaxProgress()
end

function PlotCopyModel:curOpenStageNum(chapterId)
	local chapterType = self:getChapterTypeBychapterId(chapterId)

	return self._copyLists[chapterType]:curOpenStageNum(chapterId)
end

function PlotCopyModel:getStageFinishCount(chapterId)
	local chapterType = self:getChapterTypeBychapterId(chapterId)

	return self._copyLists[chapterType]:getStageFinishCount(chapterId)
end

function PlotCopyModel:getPerfectFinishCount(chapterId)
	local chapterType = self:getChapterTypeBychapterId(chapterId)

	if chapterType == GameEnum.Chapter.Plot then
		return self._copyLists[chapterType]:getPerfectFinishCount(chapterId)
	end

	return 0, 0
end

function PlotCopyModel:getStageFinishCountExceptPurePlot(chapterId)
	local chapterType = self:getChapterTypeBychapterId(chapterId)

	return self._copyLists[chapterType]:getStageFinishCountExceptPurePlot(chapterId)
end

function PlotCopyModel:isChapterPerfectPassed(chapterId)
	local curCount, totalCount = self:getPerfectFinishCount(chapterId)

	return curCount ~= 0 and totalCount <= curCount
end

function PlotCopyModel:isChapterPassed(chapterId)
	local chapterType = self:getChapterTypeBychapterId(chapterId)

	return self._copyLists[chapterType]:isChapterPassed(chapterId)
end

function PlotCopyModel:getChapterPerfectPassedList(chapterId)
	local chapterType = self:getChapterTypeBychapterId(chapterId)

	return self._copyLists[chapterType]:getChapterPerfectPassedList(chapterId)
end

function PlotCopyModel:isStagePassed(chapterId, stageId)
	local chapterType = self:getChapterTypeBychapterId(chapterId)

	return self._copyLists[chapterType]:isStagePassed(chapterId, stageId)
end

function PlotCopyModel:isStagePassedAllCopy(chapterId, stageId)
	for k, v in pairs(self._copyLists) do
		local isPass = v:isStagePassed(chapterId, stageId)

		if isPass then
			return true
		end
	end

	return false
end

function PlotCopyModel:isPowerEnough(chapterId, stageId)
	local cfg = CopyConfig.instance:getTeamCfgById(chapterId, stageId)

	if cfg then
		local curPower = SupplyModel.instance:getHaveTiliCount()

		return curPower >= cfg.strengthConsumption
	else
		return false
	end
end

function PlotCopyModel:isPurePlot(chapterId, stageId)
	local cfg = CopyConfig.instance:getStageById(chapterId, stageId)

	if cfg and cfg.purePlot then
		return true
	end

	return false
end

function PlotCopyModel:getLockedChapterReason(chapterId)
	local chapterType = self:getChapterTypeBychapterId(chapterId)

	return self._copyLists[chapterType]:getLockedChapterReason(chapterId)
end

function PlotCopyModel:getUnlockState(chapterId, stageId)
	local chapterType = self:getChapterTypeBychapterId(chapterId)

	return self._copyLists[chapterType]:getUnlockState(chapterId, stageId)
end

function PlotCopyModel:showLockTips(cfg)
	local lockState = self:getLockedChapterReason(cfg.chapterId)
	local preChapter = cfg.preChapter
	local taskLimit = cfg.taskLimit
	local needPlayerLevel = cfg.needPlayerLevel
	local maxZdlLimit = cfg.maxZdlLimit

	if lockState == 1 then
		local cfg = CopyConfig.instance:getChapter(preChapter)
		local chapters = CopyConfig.instance:getChapters(cfg.chapterType)
		local index = table.indexof(chapters, cfg)

		FloatWordMgr.instance:show(langPara("fuben_chaptertip", GameUtil.getChineseNumber(index), cfg.chapterName))
		FuncOpenController.instance:openFunc(47)
	elseif lockState == 2 then
		if taskLimit and not string.nilorempty(taskLimit) then
			local params = string.split(taskLimit, "-")
			local taskId = checknumber(params[1])
			local stepId = checknumber(params[2])
			local isFinishTask = TaskFacade.instance:isTaskStepFinished(taskId, stepId)

			if not isFinishTask then
				self:_showTaskLimitTips(taskId)

				return
			end
		end
	elseif lockState == 3 then
		if needPlayerLevel and needPlayerLevel > 0 then
			local curLv = MofangModel.instance:getCurLv()

			if curLv < needPlayerLevel then
				FloatWordMgr.instance:show(langPara("fuben_leveltip", needPlayerLevel))

				return
			end
		end
	elseif lockState == 4 then
		if maxZdlLimit and maxZdlLimit > 0 then
			local curPower = RoleModel.instance:getMaxPower()

			if curPower < maxZdlLimit then
				FloatWordMgr.instance:show(langPara("fuben_powertip", maxZdlLimit))

				return
			end
		end
	else
		printInfo(">>>>>>>>>>>章节处于锁定状态，却没有弹提示")
	end
end

function PlotCopyModel:_showTaskLimitTips(taskId)
	local cfgTask = TaskConfig.instance:getTaskCo(taskId)

	if cfgTask.chapterId == 0 then
		FloatWordMgr.instance:show(langPara("fuben_tasktip1", cfgTask.name))
	else
		local desc

		FloatWordMgr.instance:show(cfgTask.chapterId == 1 and langPara("fuben_tasktip2", cfgTask.name) or langPara("fuben_tasktip3", GameUtil.getChineseNumber(cfgTask.chapterId - 1), cfgTask.name))
	end
end

function PlotCopyModel:showUnLockTip(unlockState, cfg)
	if unlockState == 1 then
		if string.nilorempty(cfg.preStage) then
			return
		end

		local params = string.split(cfg.preStage, "-")
		local chapterId = params[1]
		local stageId = params[2]
		local cfgStage = CopyConfig.instance:getStageById(chapterId, stageId)

		if cfgStage then
			FloatWordMgr.instance:show(langPara("fuben_stagetip", cfgStage.stageName))
		end
	elseif unlockState == 2 then
		if string.nilorempty(cfg.taskLimit) then
			return
		end

		local taskIds = string.split(cfg.taskLimit, "-")

		if taskIds and taskIds[1] and taskIds[2] then
			local taskId = checknumber(taskIds[1])
			local stepId = checknumber(taskIds[2])
			local isFinishTask = TaskFacade.instance:isTaskStepFinished(taskId, stepId)

			if not isFinishTask then
				self:_showTaskLimitTips(taskId)
			end
		end
	elseif unlockState == 3 then
		local needPlayerLevel = cfg.needPlayerLevel
		local curLv = MofangModel.instance:getCurLv()

		if curLv < needPlayerLevel then
			FloatWordMgr.instance:show(langPara("fuben_leveltip", needPlayerLevel))
		end
	elseif unlockState == 4 then
		local maxZdlLimit = cfg.maxZdlLimit
		local curPower = RoleModel.instance:getMaxPower()

		if curPower < maxZdlLimit then
			FloatWordMgr.instance:show(langPara("fuben_powertip", maxZdlLimit))
		end
	else
		FloatWordMgr.instance:show("通过上一关卡可挑战本关")
	end
end

function PlotCopyModel:getSweepListByMat(mType, mId)
	local key = mType .. "@" .. mId

	self._sweeplistbymat = self._sweeplistbymat or {}

	if not self._sweeplistbymat[key] then
		local curViewDatas = {}
		local plotCfg = CopyConfig.instance:getAllPlotChallengeState()

		for _, cfg in pairs(plotCfg) do
			local teamIds = cfg.teamIds

			if teamIds then
				local tcfg = CopyConfig.instance:getTeamCfg(teamIds)

				if tcfg then
					local reward = tcfg.reward

					if not string.nilorempty(reward) then
						local matsStr = MaterialMgr.changeItemStr(reward)
						local matArr = string.split(matsStr, "#")

						for _, vv in ipairs(matArr) do
							local finalMat = string.split(vv, ":")
							local matType = checknumber(finalMat[1])
							local cfgId = checknumber(finalMat[2])

							if checknumber(mType) == matType and checknumber(mId) == cfgId then
								local newCf = {
									id = 1,
									name = cfg.stageName,
									jumpTo = "fb#" .. cfg.chapterId .. "#" .. cfg.stageId,
									openCondition = cfg.openCondition,
									openTime = cfg.openTime,
									lockedTips = cfg.lockedTips
								}

								table.insert(curViewDatas, newCf)

								break
							end
						end
					end
				end
			end
		end

		self._sweeplistbymat[key] = curViewDatas
	end

	return self._sweeplistbymat[key]
end

function PlotCopyModel:isOneWaySweepExistAtLeast(mType, mId)
	local plotCfg = CopyConfig.instance:getAllPlotChallengeState()

	for i, cfg in ipairs(plotCfg) do
		if cfg.teamIds then
			local teamCfg = CopyConfig.instance:getTeamCfg(cfg.teamIds)

			if teamCfg and not string.nilorempty(teamCfg.reward) then
				local matsStr = MaterialMgr.changeItemStr(teamCfg.reward)
				local matArr = string.split(matsStr, "#")

				for k, vv in ipairs(matArr) do
					local finalMat = string.split(vv, ":")
					local matType = checknumber(finalMat[1])
					local cfgId = checknumber(finalMat[2])

					if checknumber(mType) == matType and checknumber(mId) == cfgId and self:isStagePassed(cfg.chapterId, cfg.stageId) then
						return true, cfg.chapterId, cfg.stageId
					end
				end
			end
		end
	end

	return false
end

function PlotCopyModel:getChapterAndStageTxt(chapterId, stageId)
	return checknumber(chapterId) % 1000 .. "-" .. stageId
end

function PlotCopyModel:getRecentOpenChapter(chapterType)
	local str = RoleModel.instance:getUserId() .. CopyConst.recentOpenChapter .. chapterType
	local value = UnityEngine.PlayerPrefs.GetInt(str)

	if value <= 0 then
		value = 1
	end

	return value
end

function PlotCopyModel:setRecentOpenChapter(chapterType, chapterIndex)
	local str = RoleModel.instance:getUserId() .. CopyConst.recentOpenChapter .. chapterType

	UnityEngine.PlayerPrefs.SetInt(str, chapterIndex)
end

function PlotCopyModel:markAreaUnlock()
	local unlockAreaIdList = {}
	local cfgs = CopyConfig.instance:getPlotAreaAllCfg()

	for i, v in ipairs(cfgs) do
		local chapterId = v.chapterIds[1]

		if chapterId and chapterId > 0 then
			local isUnlock = self:isChapterUnlock(chapterId)

			if isUnlock then
				table.insert(unlockAreaIdList, v.id)
			end
		end
	end

	local count = #unlockAreaIdList

	if count > 1 then
		for i = 1, count - 1 do
			local areaId = unlockAreaIdList[i]

			GameUtil.saveUserData("PlotCopyMapView_AreaUnlock" .. areaId, true)
			printInfo("test markAreaUnlock", areaId)
		end
	end
end

function PlotCopyModel:getAreaIdBy(chapterId)
	local cfgs = CopyConfig.instance:getPlotAreaAllCfg()

	for i, v in ipairs(cfgs) do
		local chapterIds = v.chapterIds

		for j, id in ipairs(chapterIds) do
			if chapterId == id then
				return v.id
			end
		end
	end

	return 0
end

function PlotCopyModel:setAreaUnlockStateOver(areaId)
	if areaId > 0 then
		GameUtil.saveUserData("PlotCopyMapView_AreaUnlock" .. areaId, true)
	else
		printError("areaId 不存在", areaId)
	end
end

function PlotCopyModel:getAreaUnlockState(areaId)
	if areaId > 0 then
		return (GameUtil.getUserData("PlotCopyMapView_AreaUnlock" .. areaId))
	else
		printError("areaId 不存在", areaId)

		return false
	end
end

function PlotCopyModel:getOriginalCurFormation()
	return FormationNewModel.instance:GetCurTeam():GetCurFormation()
end

function PlotCopyModel:_getCurFormation()
	return PetHireModel.instance:getFormationMoByFormId(PetHireModel.ID_TYPE_NORMAL)
end

function PlotCopyModel:getAllShowPetList()
	local pets = BagPetsController.instance:getFightBagPet() or {}

	pets = PetHireModel.instance:appendListByHirePets(pets)

	return pets
end

function PlotCopyModel:getRewardMultiplyTime()
	return self._rewardMultiplyTimes
end

function PlotCopyModel:setRewardMultiplyTime(msg)
	self._rewardMultiplyTimes = nil

	if msg == nil or msg.infos == nil then
		return
	end

	self._rewardMultiplyTimes = {}

	for _, info in pairs(msg.infos) do
		if info and info.campaignId and checknumber(info.campaignId) > 0 then
			self._rewardMultiplyTimes[info.campaignId] = info.times
		end
	end
end

PlotCopyModel.instance = PlotCopyModel.New()

return PlotCopyModel
