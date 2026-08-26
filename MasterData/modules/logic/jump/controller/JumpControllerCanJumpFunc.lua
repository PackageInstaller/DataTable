-- chunkname: @modules/logic/jump/controller/JumpControllerCanJumpFunc.lua

module("modules.logic.jump.controller.JumpControllerCanJumpFunc", package.seeall)

local JumpController = JumpController

JumpController.DefaultToastId = 0
JumpController.DefaultToastParam = nil

function JumpController:checkModuleIsOpen(openEnum)
	if not OpenModel.instance:isFunctionUnlock(openEnum) then
		local toastId, toastParamList = OpenHelper.getToastIdAndParam(openEnum)

		return false, toastId, toastParamList
	end

	return self:defaultCanJump()
end

function JumpController:defaultCanJump(jumpParam)
	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

function JumpController:canJumpToStoreView(jumpParam)
	local isOpen, toastId, toastParamList = self:checkModuleIsOpen(OpenEnum.UnlockFunc.Bank)

	if not isOpen then
		return isOpen, toastId, toastParamList
	end

	local jumpParamArray = string.splitToNumber(jumpParam, "#")
	local tabId = jumpParamArray[2]

	if StoreModel.instance:isTabOpen(tabId) then
		local goodsId = jumpParamArray[3]
		local isChargeGoods = jumpParamArray[4]

		if goodsId then
			local goodsConfig = not string.nilorempty(isChargeGoods) and StoreConfig.instance:getChargeGoodsConfig(goodsId) or StoreConfig.instance:getGoodsConfig(goodsId)
			local onlineTime = goodsConfig.onlineTime
			local offlineTime = goodsConfig.offlineTime
			local serverTime = ServerTime.now()
			local openTime = string.nilorempty(onlineTime) and serverTime or TimeUtil.stringToTimestamp(onlineTime) - ServerTime.clientToServerOffset()
			local endTime = string.nilorempty(offlineTime) and serverTime or TimeUtil.stringToTimestamp(offlineTime) - ServerTime.clientToServerOffset()

			if goodsConfig.isOnline and openTime <= serverTime and serverTime <= endTime then
				return self:defaultCanJump(jumpParam)
			else
				return false, ToastEnum.ActivityWeekWalkDeepShowView, JumpController.DefaultToastParam
			end
		else
			return self:defaultCanJump(jumpParam)
		end
	else
		return false, ToastEnum.NotOpenStore, JumpController.DefaultToastParam
	end
end

function JumpController:canJumpToSummonView(jumpParam)
	return self:checkModuleIsOpen(OpenEnum.UnlockFunc.Summon)
end

function JumpController:canJumpToDungeonViewWithType(jumpParam)
	local jumpParamArray = string.splitToNumber(jumpParam, "#")

	if not jumpParamArray[2] then
		if not DungeonController.instance:canJumpDungeonType(jumpParamArray[2]) then
			return false, ToastEnum.DungeonIsLock, JumpController.DefaultToastParam
		end

		return self:defaultCanJump(jumpParam)
	end
end

function JumpController:canJumpToDungeonViewWithChapter(jumpParam)
	local jumpParamArray = string.splitToNumber(jumpParam, "#")
	local chapterId = jumpParamArray[#jumpParamArray]

	if not DungeonController.instance:canJumpDungeonChapter(chapterId) then
		return false, ToastEnum.DungeonIsLock, JumpController.DefaultToastParam
	end

	return self:defaultCanJump(jumpParam)
end

function JumpController:canJumpToDungeonViewWithEpisode(jumpParam)
	local jumpParamArray = string.splitToNumber(jumpParam, "#")
	local episodeId = jumpParamArray[#jumpParamArray]
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig and episodeConfig.chapterId)

	if chapterConfig and chapterConfig.type == DungeonEnum.ChapterType.Hard then
		local normalEpisodeConfig = DungeonConfig.instance:getEpisodeCO(episodeConfig.preEpisode)

		if not DungeonModel.instance:isOpenHardDungeon(normalEpisodeConfig.chapterId, normalEpisodeConfig.id) then
			return false, ToastEnum.WarmUpGotoOrder, JumpController.DefaultToastParam
		end
	end

	local chapterOpen = DungeonController.instance:canJumpDungeonChapter(episodeConfig and episodeConfig.chapterId)

	if episodeConfig and chapterOpen and DungeonModel.instance:isUnlock(episodeConfig) and DungeonModel.instance:isFinishElementList(episodeConfig) then
		return self:defaultCanJump(jumpParam)
	else
		return false, ToastEnum.WarmUpGotoOrder, JumpController.DefaultToastParam
	end
end

function JumpController:canJumpToCharacterBackpackViewWithCharacter(jumpParam)
	return self:checkModuleIsOpen(OpenEnum.UnlockFunc.Role)
end

function JumpController:canJumpToCharacterBackpackViewWithEquip(jumpParam)
	return self:checkModuleIsOpen(OpenEnum.UnlockFunc.Equip)
end

function JumpController:canJumpToCharacterBackpackView(jumpParam)
	return self:checkModuleIsOpen(OpenEnum.UnlockFunc.Storage)
end

function JumpController:canJumpToCharacterBackpackUseTypeView(jumpParam)
	return self:checkModuleIsOpen(OpenEnum.UnlockFunc.Storage)
end

function JumpController:canJumpToPlayerClothView(jumpParam)
	return self:checkModuleIsOpen(OpenEnum.UnlockFunc.LeadRoleSkill)
end

function JumpController:canJumpToTaskView(jumpParam)
	return self:checkModuleIsOpen(OpenEnum.UnlockFunc.Task)
end

function JumpController:canJumpToRoomView(jumpParam)
	return self:checkModuleIsOpen(OpenEnum.UnlockFunc.Room)
end

function JumpController:canJumpToRoomProductLineView(jumpParam)
	local isOpen, toastId, toastParamList = self:checkModuleIsOpen(OpenEnum.UnlockFunc.Room)

	if not isOpen then
		return isOpen, toastId, toastParamList
	end

	if not RoomProductionHelper.hasUnlockLine(RoomProductLineEnum.ProductItemType.Change) then
		return false, ToastEnum.MaterialItemLockOnClick2
	end

	return true
end

function JumpController:canJumpToEquipView(jumpParam)
	return self:checkModuleIsOpen(OpenEnum.UnlockFunc.Equip)
end

function JumpController:canJumpToHandbookView(jumpParam)
	return self:checkModuleIsOpen(OpenEnum.UnlockFunc.Handbook)
end

function JumpController:canJumpToSocialView(jumpParam)
	return self:checkModuleIsOpen(OpenEnum.UnlockFunc.Friend)
end

function JumpController:canJumpToNoticeView(jumpParam)
	if VersionValidator.instance:isInReviewing() then
		self:defaultCanJump(jumpParam)
	end

	return self:checkModuleIsOpen(OpenEnum.UnlockFunc.Notice)
end

function JumpController:canJumpToActivityView(jumpParam)
	local jumpParamArray = string.splitToNumber(jumpParam, "#")
	local actId = jumpParamArray[2]
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(actId)

	if status == ActivityEnum.ActivityStatus.Normal then
		local canJumpFunc = JumpController.CanJumpActFunc[actId]

		if canJumpFunc then
			return canJumpFunc(self, jumpParamArray)
		end

		local version = ActivityHelper.getActivityVersion(actId)
		local canJumpFuncs = _G[string.format("VersionActivity%sCanJumpFunc", version)]

		if canJumpFuncs and canJumpFuncs["canJumpTo" .. actId] then
			return canJumpFuncs["canJumpTo" .. actId](self, jumpParamArray)
		end

		return self:defaultCanJump(jumpParam)
	end

	if actId == VersionActivity3_6Enum.ActivityId.YaMi then
		return VersionActivity3_6CanJumpFunc:canJumpTo13608(jumpParamArray)
	end

	return false, toastId, toastParamList
end

function JumpController:canJumpToLeiMiTeBeiDungeonView(jumpParam)
	local isRetroAcitivity = ReactivityModel.instance:isReactivity(VersionActivityEnum.ActivityId.Act113)

	if not isRetroAcitivity then
		local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivityEnum.ActivityId.Act105)

		if status ~= ActivityEnum.ActivityStatus.Normal then
			return false, toastId, toastParamList
		end
	else
		local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivityEnum.ActivityId.Act113)

		if status ~= ActivityEnum.ActivityStatus.Normal then
			return false, toastId, toastParamList
		end
	end

	local jumpParamArray = string.splitToNumber(jumpParam, "#")
	local episodeId = jumpParamArray[2]
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeCo then
		logError("not found episode : " .. jumpParam)

		return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
	end

	local activityDungeonConfig = ActivityConfig.instance:getActivityDungeonConfig(VersionActivityEnum.ActivityId.Act113)

	if activityDungeonConfig and activityDungeonConfig.hardChapterId and episodeCo.chapterId == activityDungeonConfig.hardChapterId and not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(VersionActivityEnum.ActivityId.Act113) then
		return false, ToastEnum.ActivityHardDugeonLockedWithOpenTime, JumpController.DefaultToastParam
	end

	local episodeInfo = DungeonModel.instance:getEpisodeInfo(episodeId)

	if not episodeInfo then
		return false, ToastEnum.WarmUpGotoOrder, JumpController.DefaultToastParam
	end

	return self:defaultCanJump(jumpParam)
end

function JumpController:canJumpToPushBox(jumpParam)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivityEnum.ActivityId.Act105)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivityEnum.ActivityId.Act111)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	return self:defaultCanJump(jumpParam)
end

function JumpController:canJump2Activity1_1Dungeon(jumpParamArray)
	local subJumpId = jumpParamArray[3]

	if subJumpId and subJumpId == JumpEnum.LeiMiTeBeiSubJumpId.DungeonHardMode then
		return VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapterAndGetToast(jumpParamArray[2])
	end

	return self:defaultCanJump()
end

function JumpController:canJump2Activity1_2Dungeon(jumpParamArray)
	if jumpParamArray[3] == JumpEnum.Activity1_2DungeonJump.Hard then
		local isOpen, toast, lockType = VersionActivity1_2DungeonMapEpisodeView.hardModelIsOpen()

		if not isOpen then
			return false, (lockType == 1 or nil) and (ToastEnum.Acticity1_2HardLock1 or ToastEnum.Acticity1_2HardLock2)
		end
	elseif jumpParamArray[3] == JumpEnum.Activity1_2DungeonJump.Jump2Dungeon then
		local episodeId = jumpParamArray[4]
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

		if episodeConfig then
			if episodeConfig.chapterId == VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard then
				local isOpen, toast, lockType = VersionActivity1_2DungeonMapEpisodeView.hardModelIsOpen()

				if not isOpen then
					return false, (lockType == 1 or nil) and (ToastEnum.Acticity1_2HardLock1 or ToastEnum.Acticity1_2HardLock2)
				elseif not DungeonModel.instance:isUnlock(episodeConfig) then
					return false, ToastEnum.DungeonIsLockNormal
				end
			elseif not DungeonModel.instance:isUnlock(episodeConfig) then
				return false, ToastEnum.DungeonIsLockNormal
			end
		end
	end

	return self:defaultCanJump()
end

function JumpController:canJump2Activity1_3Dungeon(jumpParamArray)
	local subJumpId = jumpParamArray[3]

	if subJumpId and subJumpId == JumpEnum.Activity1_3DungeonJump.Hard then
		return VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapterAndGetToast(jumpParamArray[2])
	end

	if subJumpId == JumpEnum.Activity1_3DungeonJump.Daily then
		-- block empty
	elseif subJumpId == JumpEnum.Activity1_3DungeonJump.Astrology then
		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_30102) then
			local desc, param = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Act_30102)

			return false, desc
		end
	elseif subJumpId == JumpEnum.Activity1_3DungeonJump.Buff and not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_30101) then
		local desc, param = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Act_30101)

		return false, desc
	end

	return self:defaultCanJump()
end

function JumpController:canJumpToAct1_3DungeonView(jumpParam)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivity1_8Enum.ActivityId.ReactivityStore)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	local jumpParamArray = string.splitToNumber(jumpParam, "#")
	local episodeId = jumpParamArray[2]
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeCo then
		logError("not found episode : " .. jumpParam)

		return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
	end

	local activityDungeonConfig = ActivityConfig.instance:getActivityDungeonConfig(VersionActivity1_3Enum.ActivityId.Dungeon)

	if activityDungeonConfig and activityDungeonConfig.hardChapterId and episodeCo.chapterId == activityDungeonConfig.hardChapterId and not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(VersionActivity1_3Enum.ActivityId.Dungeon) then
		return false, ToastEnum.ActivityHardDugeonLockedWithOpenTime, JumpController.DefaultToastParam
	end

	local episodeInfo = DungeonModel.instance:getEpisodeInfo(episodeId)

	if not episodeInfo then
		return false, ToastEnum.WarmUpGotoOrder, JumpController.DefaultToastParam
	end

	return self:defaultCanJump(jumpParam)
end

function JumpController:canJumpToAct1_3Act306(jumpParam)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivity1_3Enum.ActivityId.Act306)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	return self:defaultCanJump(jumpParam)
end

function JumpController:canJumpToAct1_3Act305(jumpParam)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivity1_3Enum.ActivityId.Act305)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	return self:defaultCanJump(jumpParam)
end

function JumpController:canJumpToTurnback(jumpParam)
	return self:defaultCanJump(jumpParam)
end

function JumpController:canJumpToAchievement(jumpParam)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		local desc, param = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement)

		return false, desc, param
	end

	return self:defaultCanJump(jumpParam)
end

function JumpController.activateCanJumpFuncController()
	return
end

function JumpController:canJumpToBossRush(jumpParam)
	local jumpData = string.splitToNumber(jumpParam, "#")
	local stage = jumpData[2]

	if not jumpData[3] then
		local layer = 1

		if not BossRushModel.instance:isActOnLine() then
			return false, ToastEnum.ActivityNotInOpenTime
		end

		if stage then
			if not BossRushModel.instance:isBossOnline(stage) then
				return false, ToastEnum.V1a4_BossRushBossLockTip
			end

			local isOpen = BossRushModel.instance:isBossLayerOpen(stage, layer)

			if not isOpen then
				return false, ToastEnum.V1a4_BossRushBossLockTip
			end
		end

		return self:defaultCanJump(jumpParam)
	end
end

function JumpController:canJumpToV3a9BossRush(jumpParam)
	local jumpData = string.splitToNumber(jumpParam, "#")

	if not jumpData[2] then
		local tabIndex = 1
		local actId = Bossrush.instance:getActivityId(tabIndex)

		if not ActivityHelper.isOpen(actId) then
			return false, ToastEnum.V1a4_BossRushBossLockTip
		end

		return self:defaultCanJump(jumpParam)
	end
end

function JumpController:canJumpToSeasonMainView(jumpParam)
	local paramsList = string.splitToNumber(jumpParam, "#")
	local jumpId = paramsList and paramsList[2]

	if jumpId == Activity104Enum.JumpId.Trail then
		local trialId = paramsList[3]
		local actId = Activity104Model.instance:getCurSeasonId()
		local co = SeasonConfig.instance:getTrialConfig(actId, trialId)
		local curLayer = Activity104Model.instance:getAct104CurLayer(actId)

		if co and curLayer <= co.unlockLayer then
			return false, ToastEnum.SeasonTrialLockTip, {
				GameUtil.getNum2Chinese(co.unlockLayer)
			}
		end
	end

	return self:defaultCanJump(jumpParam)
end

function JumpController:canJumpToRoomFishing(jumpParam)
	local isUnlock = FishingModel.instance:isUnlockRoomFishing()

	if isUnlock then
		return self:defaultCanJump(jumpParam)
	else
		return false, ToastEnum.JumpSignView, JumpController.DefaultToastParam
	end
end

function JumpController:canJumpToAct1_5DungeonView(jumpParam)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivity2_0Enum.ActivityId.EnterView)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	local jumpParamArray = string.splitToNumber(jumpParam, "#")
	local episodeId = jumpParamArray[2]
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeCo then
		logError("not found episode : " .. jumpParam)

		return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
	end

	local activityDungeonConfig = ActivityConfig.instance:getActivityDungeonConfig(VersionActivity1_5Enum.ActivityId.Dungeon)

	if activityDungeonConfig and activityDungeonConfig.hardChapterId and episodeCo.chapterId == activityDungeonConfig.hardChapterId and not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(VersionActivity1_5Enum.ActivityId.Dungeon) then
		return false, ToastEnum.ActivityHardDugeonLockedWithOpenTime, JumpController.DefaultToastParam
	end

	local episodeInfo = DungeonModel.instance:getEpisodeInfo(episodeId)

	if not episodeInfo then
		return false, ToastEnum.WarmUpGotoOrder, JumpController.DefaultToastParam
	end

	return self:defaultCanJump(jumpParam)
end

function JumpController:canJumpToActivity142(jumpParam)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivity1_5Enum.ActivityId.Activity142)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	return self:defaultCanJump(jumpParam)
end

function JumpController:canJumpToAct1_6DungeonView(jumpParam)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivity2_5Enum.ActivityId.EnterView)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	local jumpParamArray = string.splitToNumber(jumpParam, "#")
	local episodeId = jumpParamArray[2]
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeCo then
		logError("not found episode : " .. jumpParam)

		return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
	end

	local activityDungeonConfig = ActivityConfig.instance:getActivityDungeonConfig(VersionActivity1_6Enum.ActivityId.Dungeon)

	if activityDungeonConfig and activityDungeonConfig.hardChapterId and episodeCo.chapterId == activityDungeonConfig.hardChapterId and not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(VersionActivity1_6Enum.ActivityId.Dungeon) then
		return false, ToastEnum.ActivityHardDugeonLockedWithOpenTime, JumpController.DefaultToastParam
	end

	local episodeInfo = DungeonModel.instance:getEpisodeInfo(episodeId)

	if not episodeInfo then
		return false, ToastEnum.WarmUpGotoOrder, JumpController.DefaultToastParam
	end

	return self:defaultCanJump(jumpParam)
end

function JumpController:canJumpToSeason123(jumpParam)
	local actId = Season123Model.instance:getCurSeasonId()

	if actId then
		local actMO = ActivityModel.instance:getActMO(actId)

		if not actMO or not actMO:isOpen() then
			return false, ToastEnum.ActivityNotOpen, JumpController.DefaultToastParam
		end
	else
		return false, ToastEnum.ActivityNotOpen, JumpController.DefaultToastParam
	end

	return self:defaultCanJump(jumpParam)
end

function JumpController:canJumpToVersionEnterView(jumpParam)
	local jumpParamArray = string.splitToNumber(jumpParam, "#")
	local actId = jumpParamArray[2]

	if actId then
		local actMO = ActivityModel.instance:getActMO(actId)

		if not actMO or not actMO:isOpen() then
			return false, ToastEnum.ActivityNotOpen, JumpController.DefaultToastParam
		end
	else
		local enum = VersionActivityFixedHelper.getVersionActivityEnum()

		if enum and enum.ActivityId.EnterView then
			local actMO = ActivityModel.instance:getActMO(enum.ActivityId.EnterView)

			if actMO and actMO:isOpen() then
				return self:defaultCanJump(jumpParam)
			end
		end

		return false, ToastEnum.ActivityNotOpen, JumpController.DefaultToastParam
	end

	return self:defaultCanJump(jumpParam)
end

function JumpController:canJumpToRougeMainView(jumpParam)
	local isCanJump = true
	local toastId, toastParamList
	local isUnlock = RougeOutsideModel.instance:isUnlock()

	if not isUnlock then
		isCanJump = false

		local openId = RougeOutsideModel.instance:openUnlockId()

		toastId, toastParamList = OpenHelper.getToastIdAndParam(openId)
	end

	return isCanJump, toastId, toastParamList
end

function JumpController:canJumpToSurvivalView()
	local isCanJump = true
	local toastId, toastParamList
	local isShow = SurvivalController.instance:isOpenSurvival()

	if not isShow then
		isCanJump = false
		toastId, toastParamList = OpenHelper.getToastIdAndParam(OpenEnum.UnlockFunc.Survival)
	end

	return isCanJump, toastId, toastParamList
end

function JumpController:canJumpToRougeRewardView(jumpParam)
	local isCanJump = true
	local toastId, toastParamList
	local isUnlock = RougeOutsideModel.instance:isUnlock()

	if not isUnlock then
		isCanJump = false

		local openId = RougeOutsideModel.instance:openUnlockId()

		toastId, toastParamList = OpenHelper.getToastIdAndParam(openId)
	else
		local paramsList = string.splitToNumber(jumpParam, "#")
		local stage = paramsList[3]
		local isStageOpen = RougeRewardModel.instance:isStageOpen(stage)

		if not isStageOpen then
			isCanJump = false
			toastId = ToastEnum.RougeRewardStageLock
		end
	end

	return isCanJump, toastId, toastParamList
end

function JumpController:canJumpToTower(jumpParam)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Tower) then
		local desc, param = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Tower)

		return false, desc, param
	end

	local jumpArray = string.splitToNumber(jumpParam, "#")
	local towerType = jumpArray[2]

	if towerType == TowerEnum.TowerType.Boss then
		local isBossTowerOpenLayer = TowerController.instance:isBossTowerOpen()
		local isBossTowerStateOpen = TowerModel.instance:checkHasOpenStateTower(TowerEnum.TowerType.Boss)

		if not isBossTowerOpenLayer or not isBossTowerStateOpen then
			return false, ToastEnum.TowerNotOpen
		end
	elseif towerType == TowerEnum.TowerType.Limited then
		local curTimeLimitTowerOpenMo = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()
		local isTimeLimitTowerOpenLayer = TowerController.instance:isTimeLimitTowerOpen()

		if not curTimeLimitTowerOpenMo or not isTimeLimitTowerOpenLayer then
			return false, ToastEnum.TowerNotOpen
		end
	end

	return self:defaultCanJump(jumpParam)
end

function JumpController:canJumpToTowerComposeView(jumpParam)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Tower) then
		local desc, param = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Tower)

		return false, desc, param
	end

	local jumpArray = string.splitToNumber(jumpParam, "#")
	local jumpId = jumpArray[2]
	local themeId = jumpArray[3]
	local layerId = jumpArray[4]

	if themeId and themeId > 0 then
		local themeMo = TowerComposeModel.instance:getThemeMo(themeId)

		if not themeMo then
			return false, ToastEnum.TowerComposeNotOpen
		end

		local passLayerId = TowerComposeModel.instance:getThemePassLayer(themeId)

		if layerId and passLayerId and passLayerId < layerId and Mathf.Abs(passLayerId - layerId) > 1 then
			return false, ToastEnum.TowerComposeNotOpen
		end

		if jumpId == TowerComposeEnum.JumpId.TowerComposePlane then
			local isPlaneUnlock = TowerComposeModel.instance:checkHasPlaneLayerUnlock(themeId)

			if not isPlaneUnlock then
				return false, ToastEnum.TowerComposeNotOpen
			end
		end
	end

	return self:defaultCanJump(jumpParam)
end

function JumpController:canJumpToOdyssey(jumpParam)
	local actId = VersionActivity2_9Enum.ActivityId.Dungeon2

	if not VersionActivityEnterHelper.checkCanOpen(actId) then
		return false, ToastEnum.ActivityNotOpen
	end

	local jumpArray = string.splitToNumber(jumpParam, "#")
	local jumpType = jumpArray[2]

	if jumpType == OdysseyEnum.JumpType.JumpToElementAndOpen then
		local elementMo = OdysseyDungeonModel.instance:getElementMo(jumpArray[3])

		if not elementMo then
			return false, ToastEnum.OdysseyElementLock
		end
	elseif jumpType == OdysseyEnum.JumpType.JumpToReligion then
		local religionConstCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.ReligionUnlock)
		local canReligionUnlock = OdysseyDungeonModel.instance:checkConditionCanUnlock(religionConstCo.value)

		if not canReligionUnlock then
			return false, ToastEnum.OdysseyReligionLock
		end
	elseif jumpType == OdysseyEnum.JumpType.JumpToMyth then
		local canMythUnlock = OdysseyDungeonModel.instance:checkHasFightTypeElement(OdysseyEnum.FightType.Myth)

		if not canMythUnlock then
			return false, ToastEnum.OdysseyMythViewLock
		end
	end

	return self:defaultCanJump(jumpParam)
end

function JumpController:canJumpToAssassinLibraryView(jumpParam)
	local jumpArray = string.splitToNumber(jumpParam, "#")
	local jumpActId = jumpArray[2]
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(jumpActId)
	local canJump = status == ActivityEnum.ActivityStatus.Normal or status == ActivityEnum.ActivityStatus.Expired

	if not canJump then
		return false, toastId, toastParam
	end

	return true
end

function JumpController:canJumpToStoreSupplementMonthCardUseView(jumpParam)
	local day = SignInModel.instance:getCanSupplementMonthCardDays()
	local canJump = day > 0

	if not canJump then
		return false, ToastEnum.NorSign
	end

	return true
end

function JumpController:canJump2Abyss(jumpParam)
	local constConfig = AbyssConfig.instance:getConstConfig(AbyssEnum.ConstId.ActId)

	if not constConfig or string.nilorempty(constConfig.value) then
		logError("新深渊 不存在常量活动id配置")

		return false, ToastEnum.ActivityNotOpen
	end

	local jumpActId = tonumber(constConfig.value)
	local activityConfig = ActivityConfig.instance:getActivityCo(jumpActId)

	if activityConfig.openId ~= 0 and not OpenModel.instance:isFunctionUnlock(activityConfig.openId) then
		local toastId, toastParamList = OpenHelper.getToastIdAndParam(activityConfig.openId)

		return false, toastId, toastParamList
	end

	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(jumpActId)
	local canJump = status == ActivityEnum.ActivityStatus.Normal

	if not canJump then
		return false, toastId, toastParam
	end

	return true
end

function JumpController:canJump2Act236(jumpParam)
	local jumpActId = ActivityEnum.Activity.V3a7_Act236
	local activityConfig = ActivityConfig.instance:getActivityCo(jumpActId)

	if activityConfig.openId ~= 0 and not OpenModel.instance:isFunctionUnlock(activityConfig.openId) then
		local toastId, toastParamList = OpenHelper.getToastIdAndParam(activityConfig.openId)

		return false, toastId, toastParamList
	end

	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(jumpActId)
	local canJump = status == ActivityEnum.ActivityStatus.Normal

	if not canJump then
		return false, toastId, toastParam
	end

	return true
end

function JumpController:canJumpToAtomicDungeonView(jumpParam)
	local actId = VersionActivity3_10Enum.ActivityId.Outside

	if not VersionActivityEnterHelper.checkCanOpen(actId) then
		return false, ToastEnum.ActivityNotOpen
	end

	local jumpArray = string.splitToNumber(jumpParam, "#")
	local jumpType = jumpArray[2]
	local jumpMapId = jumpArray[3]

	if jumpType == AtomicDungeonEnum.JumpType.DungeonMap then
		local mapInfoConfig = AtomicDungeonConfig.instance:getMapInfoConfig(jumpMapId)
		local mapInfo = AtomicDungeonModel.instance:getMapInfo((mapInfoConfig.type == AtomicDungeonEnum.MapType.Normal or nil) and AtomicDungeonModel.instance:getMapIdByArenaMapId(jumpMapId))

		if not mapInfo then
			return false, ToastEnum.AtomicDungeonMapLock
		end
	elseif jumpType == AtomicDungeonEnum.JumpType.Talent then
		local canUnlock = AtomicDungeonModel.instance:checkTalentUnlock()

		if not canUnlock then
			return false, ToastEnum.AtomicTalentLockLock
		end
	end

	return self:defaultCanJump(jumpParam)
end

function JumpController:canJumpToActivityCenterView(jumpParam)
	local jumpArray = string.splitToNumber(jumpParam, "#")

	if not jumpArray[1] then
		if ActivityModel.instance:getCenterActivities(jumpArray[1]) then
			return self:defaultCanJump(jumpParam)
		end

		return false, ToastEnum.ActivityNotOpen
	end
end

function JumpController:canJumpToPlayerCardView(jumpParam)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.PlayerCard) then
		return self:defaultCanJump(jumpParam)
	end

	local desc, param = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.PlayerCard)

	return false, desc
end

function JumpController:canJumpToTeachingMainiew(jumpParam)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Teaching) then
		return self:defaultCanJump(jumpParam)
	end

	local desc, param = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Teaching)

	return false, desc
end

function JumpController:canJumpToUdimoView(jumpParam)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Udimo) then
		return self:defaultCanJump(jumpParam)
	end

	local desc, param = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Udimo)

	return false, desc
end

function JumpController:canJumpToMainSwitchView(jumpParam)
	return self:defaultCanJump(jumpParam)
end

JumpController.JumpViewToCanJumpFunc = {
	[JumpEnum.JumpView.StoreView] = JumpController.canJumpToStoreView,
	[JumpEnum.JumpView.SummonView] = JumpController.canJumpToSummonView,
	[JumpEnum.JumpView.DungeonViewWithType] = JumpController.canJumpToDungeonViewWithType,
	[JumpEnum.JumpView.DungeonViewWithChapter] = JumpController.canJumpToDungeonViewWithChapter,
	[JumpEnum.JumpView.DungeonViewWithEpisode] = JumpController.canJumpToDungeonViewWithEpisode,
	[JumpEnum.JumpView.CharacterBackpackViewWithCharacter] = JumpController.canJumpToCharacterBackpackViewWithCharacter,
	[JumpEnum.JumpView.CharacterBackpackViewWithEquip] = JumpController.canJumpToCharacterBackpackViewWithEquip,
	[JumpEnum.JumpView.BackpackView] = JumpController.canJumpToCharacterBackpackView,
	[JumpEnum.JumpView.BackpackUseType] = JumpController.canJumpToCharacterBackpackUseTypeView,
	[JumpEnum.JumpView.PlayerClothView] = JumpController.canJumpToPlayerClothView,
	[JumpEnum.JumpView.TaskView] = JumpController.canJumpToTaskView,
	[JumpEnum.JumpView.RoomView] = JumpController.canJumpToRoomView,
	[JumpEnum.JumpView.RoomProductLineView] = JumpController.canJumpToRoomProductLineView,
	[JumpEnum.JumpView.EquipView] = JumpController.canJumpToEquipView,
	[JumpEnum.JumpView.HandbookView] = JumpController.canJumpToHandbookView,
	[JumpEnum.JumpView.SocialView] = JumpController.canJumpToSocialView,
	[JumpEnum.JumpView.NoticeView] = JumpController.canJumpToNoticeView,
	[JumpEnum.JumpView.ActivityView] = JumpController.canJumpToActivityView,
	[JumpEnum.JumpView.LeiMiTeBeiDungeonView] = JumpController.canJumpToLeiMiTeBeiDungeonView,
	[JumpEnum.JumpView.Act1_3DungeonView] = JumpController.canJumpToAct1_3DungeonView,
	[JumpEnum.JumpView.PushBox] = JumpController.canJumpToPushBox,
	[JumpEnum.JumpView.Turnback] = JumpController.canJumpToTurnback,
	[JumpEnum.JumpView.Achievement] = JumpController.canJumpToAchievement,
	[JumpEnum.JumpView.BossRush] = JumpController.canJumpToBossRush,
	[JumpEnum.JumpView.SeasonMainView] = JumpController.canJumpToSeasonMainView,
	[JumpEnum.JumpView.RoomFishing] = JumpController.canJumpToRoomFishing,
	[JumpEnum.JumpView.Tower] = JumpController.canJumpToTower,
	[JumpEnum.JumpView.TowerCompose] = JumpController.canJumpToTowerComposeView,
	[JumpEnum.JumpView.Odyssey] = JumpController.canJumpToOdyssey,
	[JumpEnum.JumpView.AssassinLibraryView] = JumpController.canJumpToAssassinLibraryView,
	[JumpEnum.JumpView.Challenge] = Act183JumpController.canJumpToAct183,
	[JumpEnum.JumpView.V1a5Dungeon] = JumpController.canJumpToAct1_5DungeonView,
	[JumpEnum.JumpView.V1a6Dungeon] = JumpController.canJumpToAct1_6DungeonView,
	[JumpEnum.JumpView.Season123] = JumpController.canJumpToSeason123,
	[JumpEnum.JumpView.VersionEnterView] = JumpController.canJumpToVersionEnterView,
	[JumpEnum.JumpView.RougeRewardView] = JumpController.canJumpToRougeRewardView,
	[JumpEnum.JumpView.RougeMainView] = JumpController.canJumpToRougeMainView,
	[JumpEnum.JumpView.StoreSupplementMonthCardUseView] = JumpController.canJumpToStoreSupplementMonthCardUseView,
	[JumpEnum.JumpView.SurvivalView] = JumpController.canJumpToSurvivalView,
	[JumpEnum.JumpView.Abyss] = JumpController.canJump2Abyss,
	[JumpEnum.JumpView.Act236] = JumpController.canJump2Act236,
	[JumpEnum.JumpView.AtomicDungeon] = JumpController.canJumpToAtomicDungeonView,
	[JumpEnum.JumpView.ActivityCenter] = JumpController.canJumpToActivityCenterView,
	[JumpEnum.JumpView.PlayerCard] = JumpController.canJumpToPlayerCardView,
	[JumpEnum.JumpView.TeachingMain] = JumpController.canJumpToTeachingMainiew,
	[JumpEnum.JumpView.Udimo] = JumpController.canJumpToUdimoView,
	[JumpEnum.JumpView.MainSwitchView] = JumpController.canJumpToMainSwitchView,
	[JumpEnum.JumpView.V3a9BossRush] = JumpController.canJumpToBossRush
}
JumpController.CanJumpActFunc = {
	[JumpEnum.ActIdEnum.Act113] = JumpController.canJump2Activity1_1Dungeon,
	[JumpEnum.ActIdEnum.Act1_3Dungeon] = JumpController.canJump2Activity1_3Dungeon,
	[JumpEnum.ActIdEnum.Act1_2Dungeon] = JumpController.canJump2Activity1_2Dungeon,
	[JumpEnum.ActIdEnum.Act1_3Act305] = JumpController.canJumpToAct1_3Act305,
	[JumpEnum.ActIdEnum.Act1_3Act306] = JumpController.canJumpToAct1_3Act306,
	[JumpEnum.ActIdEnum.Activity142] = JumpController.canJumpToActivity142
}

return JumpController
