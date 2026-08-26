-- chunkname: @modules/logic/versionactivity2_5/challenge/controller/Act183Helper.lua

module("modules.logic.versionactivity2_5.challenge.controller.Act183Helper", package.seeall)

local Act183Helper = _M

function Act183Helper.isDailyGroupEpisodeUnlock(groupId)
	local unlockRemainTime = Act183Helper.getDailyGroupEpisodeUnlockRemainTime(groupId)

	if unlockRemainTime <= 0 then
		return true
	end
end

function Act183Helper.getDailyGroupEpisodeUnlockRemainTime(groupId)
	local groupCo = lua_challenge_daily_unlock.configDict[groupId]

	if not groupCo then
		logError(string.format("获取日常关卡组解锁剩余时间失败! 失败原因:找不到关卡组解锁配置 groupId = %s", groupId))

		return 0
	end

	local activityId = Act183Model.instance:getActivityId()
	local actStartTime = ActivityModel.instance:getActStartTime(activityId) / 1000
	local episodeUnlockTime = actStartTime + groupCo.unlock

	return episodeUnlockTime - ServerTime.now()
end

function Act183Helper.getEpisodeType(episodeId)
	local episodeCo = Act183Config.instance:getEpisodeCo(episodeId)
	local order = episodeCo and episodeCo.order

	if order and order > 100 then
		return Act183Enum.EpisodeType.Boss
	end

	return Act183Enum.EpisodeType.Sub
end

function Act183Helper.getGroupType(episodeId)
	local episodeCo = Act183Config.instance:getEpisodeCo(episodeId)

	return episodeCo and episodeCo.type
end

function Act183Helper.isEpisodeHasRule(episodeId)
	local episodeCo = Act183Config.instance:getEpisodeCo(episodeId)
	local ruleIcon = episodeCo and episodeCo.ruleIcon

	return not string.nilorempty(ruleIcon)
end

function Act183Helper.setRuleIcon(episodeId, ruleIndex, imageComp)
	if not imageComp then
		logError("图片组件为空")

		return
	end

	local episodeCo = Act183Config.instance:getEpisodeCo(episodeId)
	local ruleIcon = episodeCo and episodeCo.ruleIcon

	if string.nilorempty(ruleIcon) then
		logError(string.format("关卡机制图标配置不存在: episodeId = %s", episodeId))

		return
	end

	UISpriteSetMgr.instance:setChallengeSprite(imageComp, ruleIcon)
end

function Act183Helper.setEpisodeIcon(episodeId, status, simageComp)
	if not simageComp then
		logError("图片组件为空")

		return
	end

	local episodeCo = Act183Config.instance:getEpisodeCo(episodeId)
	local icon = episodeCo and episodeCo.icon

	if string.nilorempty(icon) then
		logError(string.format("关卡图标配置不存在: episodeId = %s", episodeId))

		return
	end

	local iconUrl = icon

	if episodeCo.type == Act183Enum.GroupType.Daily then
		iconUrl = "daily/" .. iconUrl

		ZProj.UGUIHelper.SetGrayscale(simageComp.gameObject, status ~= Act183Enum.EpisodeStatus.Finished)
	else
		local episodeType = Act183Helper.getEpisodeType(episodeId)

		iconUrl = episodeType ~= Act183Enum.EpisodeType.Boss and (status ~= Act183Enum.EpisodeStatus.Finished and iconUrl .. "_0" or iconUrl .. "_1") or status == Act183Enum.EpisodeStatus.Locked and iconUrl .. "_0" or iconUrl .. "_1"
	end

	simageComp:LoadImage(ResUrl.getChallengeIcon(iconUrl), function(textureWidth, textureHeight)
		recthelper.setSize(simageComp.transform, textureWidth, textureHeight)
	end)
end

function Act183Helper.setEpisodeReportIcon(episodeId, imageComp)
	if not imageComp then
		logError("图片组件为空")

		return
	end

	local episodeCo = Act183Config.instance:getEpisodeCo(episodeId)
	local icon = episodeCo and episodeCo.reportIcon

	if string.nilorempty(icon) then
		logError(string.format("通关记录界面图标配置不存在: episodeId = %s", episodeId))

		return
	end

	UISpriteSetMgr.instance:setChallengeSprite(imageComp, icon)
end

function Act183Helper.setSubEpisodeResultIcon(episodeId, imageComp)
	if not imageComp then
		logError("图片组件为空")

		return
	end

	local icon = Act183Helper.getEpisodeResultIcon(episodeId)

	if not icon then
		return
	end

	UISpriteSetMgr.instance:setChallengeSprite(imageComp, icon)
end

function Act183Helper.setBossEpisodeResultIcon(episodeId, simageComp)
	if not simageComp then
		logError("图片组件为空")

		return
	end

	local icon = Act183Helper.getEpisodeResultIcon(episodeId)

	if not icon then
		return
	end

	local resUrl = ResUrl.getChallengeIcon("result/" .. icon)

	simageComp:LoadImage(resUrl, function(textureWidth, textureHeight)
		recthelper.setSize(simageComp.transform, textureWidth, textureHeight)
	end)
end

function Act183Helper.getEpisodeResultIcon(episodeId)
	local episodeCo = Act183Config.instance:getEpisodeCo(episodeId)
	local icon = episodeCo and episodeCo.resultIcon

	if string.nilorempty(icon) then
		logError(string.format("结算界面图标配置不存在: episodeId = %s", episodeId))

		return
	end

	return icon
end

function Act183Helper.getRoundStage(round)
	local stageCo = lua_challenge_const.configDict[Act183Enum.Const.RoundStage]
	local stageStr = stageCo and stageCo.value2

	if string.nilorempty(stageStr) then
		logError("缺少回合数挡位配置")

		return 1
	end

	local stageNumList = string.splitToNumber(stageStr, "#")

	for index, stageNum in ipairs(stageNumList) do
		if round <= stageNum then
			return index
		end
	end

	return #stageNumList + 1
end

function Act183Helper.getGroupEpisodeTaskProgress(actId, groupId)
	local groupTasks = Act183Config.instance:getAllOnlineGroupTasks(actId, groupId)

	if groupTasks then
		if not #groupTasks then
			local groupTaskCount = 0
			local groupFinishTaskCount = 0

			if groupTasks then
				for _, taskCo in ipairs(groupTasks) do
					local isTaskFinished = Act183Helper.isTaskFinished(taskCo.id)

					if isTaskFinished then
						groupFinishTaskCount = groupFinishTaskCount + 1
					end
				end
			end

			return groupTaskCount, groupFinishTaskCount
		end
	end
end

function Act183Helper.getUnlockSupportHeroIds(activityId, badgeNum)
	local supportHeroIds = {}
	local badgeCos = Act183Config.instance:getActivityBadgeCos(activityId)

	if badgeCos then
		for _, badgeCo in ipairs(badgeCos) do
			if badgeNum >= badgeCo.num and badgeCo.unlockSupport ~= 0 then
				table.insert(supportHeroIds, badgeCo.unlockSupport)
			end
		end
	end

	return supportHeroIds
end

function Act183Helper.isEpisodeCanUseBadge(episodeId)
	local episodeCo = Act183Config.instance:getEpisodeCo(episodeId)

	if episodeCo then
		return episodeCo.type == Act183Enum.GroupType.NormalMain
	end
end

function Act183Helper.isEpisodeCanUseSupportHero(episodeId)
	local episodeCo = Act183Config.instance:getEpisodeCo(episodeId)

	if episodeCo then
		return episodeCo.type == Act183Enum.GroupType.NormalMain or episodeCo.type == Act183Enum.GroupType.Daily
	end
end

function Act183Helper.generateDungeonViewParams(groupType, selectGroupId)
	local groupTypes = {}

	if groupType == Act183Enum.GroupType.Daily then
		table.insert(groupTypes, Act183Enum.GroupType.Daily)
	elseif groupType == Act183Enum.GroupType.NormalMain or groupType == Act183Enum.GroupType.HardMain then
		table.insert(groupTypes, Act183Enum.GroupType.NormalMain)
		table.insert(groupTypes, Act183Enum.GroupType.HardMain)
	end

	return {
		selectGroupId = selectGroupId,
		groupTypes = groupTypes
	}
end

function Act183Helper.generateDungeonViewParams2(episodeId, isSelect)
	local episodeCo = Act183Config.instance:getEpisodeCo(episodeId)
	local groupType = episodeCo and episodeCo.type
	local groupId = episodeCo and episodeCo.groupId
	local viewParams = Act183Helper.generateDungeonViewParams(groupType, groupId)

	viewParams.selectEpisodeId = isSelect and episodeCo.episodeId

	return viewParams
end

function Act183Helper.generateDungeonViewParams3(actId, groupId)
	local episodeCoList = Act183Config.instance:getEpisodeCosByGroupId(actId, groupId)
	local episodeCo = episodeCoList and episodeCoList[1]
	local groupType = episodeCo and episodeCo.type
	local groupId = episodeCo and episodeCo.groupId

	return (Act183Helper.generateDungeonViewParams(groupType, groupId))
end

function Act183Helper.rpcInfosToList(infos, cls, extraInitInfo)
	local list = {}

	for i, v in ipairs(infos) do
		local mo = cls.New()

		mo:init(v, extraInitInfo)
		table.insert(list, mo)
	end

	return list
end

function Act183Helper.listToMap(list)
	local map = {}

	if list then
		for _, info in ipairs(list) do
			map[info] = info
		end
	end

	return map
end

function Act183Helper.generateStartDungeonParams(episodeId)
	local paramsMap = {}
	local canUseBadgeNum = Act183Helper.isEpisodeCanUseBadge(episodeId)

	if canUseBadgeNum then
		paramsMap.useBadgeNum = tostring(Act183Model.instance:getEpisodeReadyUseBadgeNum())
	end

	if Act183Helper.getEpisodeType(episodeId) == Act183Enum.EpisodeType.Boss then
		local selectConditionIds = Act183Model.instance:getRecordEpisodeSelectConditions()

		if selectConditionIds and #selectConditionIds > 0 then
			paramsMap.chooseConditions = selectConditionIds
		end
	end

	return (cjson.encode(paramsMap))
end

function Act183Helper.getSelectConditionIdsInLocal(activityId, episodeId)
	local key = Act183Helper._generateSaveSelectCollectionIdsKey(activityId, episodeId)
	local selectConditionIdStr = PlayerPrefsHelper.getString(key, "")

	return (string.splitToNumber(selectConditionIdStr, "#"))
end

function Act183Helper.saveSelectConditionIdsInLocal(activityId, episodeId, selectConditionIds)
	if selectConditionIds then
		local conditionResultStr = table.concat(selectConditionIds, "#")
		local key = Act183Helper._generateSaveSelectCollectionIdsKey(activityId, episodeId)

		PlayerPrefsHelper.setString(key, conditionResultStr)
	end
end

function Act183Helper._generateSaveSelectCollectionIdsKey(activityId, episodeId)
	return string.format("%s#%s#%s#%s", PlayerPrefsKey.Act183BossEpisodeSelectConditions, PlayerModel.instance:getMyUserId(), activityId, episodeId)
end

function Act183Helper.isHeroGroupPositionOpen(episodeId, index)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeCo then
		if not episodeCo.battleId then
			local battleId = 0
			local battleCo = lua_battle.configDict[battleId]

			if battleCo then
				if not battleCo.roleNum then
					local roleNum = 0

					if roleNum <= 0 then
						logError(string.format("编队解锁位置数量错误 episodeId = %s, battleId = %s, roleNum = %s", episodeId, battleId, roleNum))
					end

					return index > 0 and index <= roleNum
				end
			end
		end
	end
end

function Act183Helper.setTranPositionAndRotation(episodeId, order, posAndRotationMap, tran)
	local posAndRotInfo = posAndRotationMap[order]

	if not posAndRotInfo or #posAndRotInfo < 5 then
		logError(string.format("缺少坐标及旋转配置 episodeId = %s, order = %s", episodeId, order))

		return
	end

	local posX = posAndRotInfo[1]
	local posY = posAndRotInfo[2]
	local rotationX = posAndRotInfo[3]
	local rotationY = posAndRotInfo[4]
	local rotationZ = posAndRotInfo[5]

	transformhelper.setLocalRotation(tran, rotationX, rotationY, rotationZ)
	recthelper.setAnchor(tran, posX, posY)
end

function Act183Helper.isTaskFinished(taskId)
	return Act183Helper.isTaskHasGetReward(taskId) or Act183Helper.isTaskCanGetReward(taskId)
end

function Act183Helper.isTaskCanGetReward(taskId)
	local taskMo = TaskModel.instance:getTaskById(taskId)

	if taskMo then
		return taskMo.finishCount == 0 and taskMo.progress >= taskMo.config.maxProgress
	end
end

function Act183Helper.isTaskHasGetReward(taskId)
	return TaskModel.instance:isTaskFinish(TaskEnum.TaskType.Activity183, taskId)
end

function Act183Helper.getLastEnterMainGroupTypeInLocal(activityId, defalutGroupType)
	local key = Act183Helper._generateSaveLastEnterMainGroupTypeKey(activityId)

	return (tonumber(PlayerPrefsHelper.getNumber(key, tonumber(defalutGroupType))))
end

function Act183Helper.saveLastEnterMainGroupTypeInLocal(activityId, groupType)
	if groupType then
		local key = Act183Helper._generateSaveLastEnterMainGroupTypeKey(activityId)

		PlayerPrefsHelper.setNumber(key, groupType)
	end
end

function Act183Helper._generateSaveLastEnterMainGroupTypeKey(activityId)
	return string.format("%s#%s#%s", PlayerPrefsKey.Act183LastEnterMainGroupType, PlayerModel.instance:getMyUserId(), activityId)
end

function Act183Helper.getLastTotalBadgeNumInLocal(activityId)
	local key = Act183Helper._generateSaveLastTotalBadgeNumInLocal(activityId)

	return (tonumber(PlayerPrefsHelper.getNumber(key, 0)))
end

function Act183Helper.saveLastTotalBadgeNumInLocal(activityId, badgeNum)
	if activityId and badgeNum then
		local key = Act183Helper._generateSaveLastTotalBadgeNumInLocal(activityId)

		PlayerPrefsHelper.setNumber(key, badgeNum)
	end
end

function Act183Helper._generateSaveLastTotalBadgeNumInLocal(activityId)
	return string.format("%s#%s#%s", PlayerPrefsKey.Act183LastTotalBadgeNum, PlayerModel.instance:getMyUserId(), activityId)
end

function Act183Helper.isGroupHasPlayUnlockAnim(activityId, groupId)
	local key = Act183Helper._generateHasPlayUnlockAnimGroupIdKey(activityId, groupId)
	local val = tonumber(PlayerPrefsHelper.getNumber(key, 0))

	return val ~= 0
end

function Act183Helper.savePlayUnlockAnimGroupIdInLocal(activityId, groupId)
	if activityId and groupId then
		local key = Act183Helper._generateHasPlayUnlockAnimGroupIdKey(activityId, groupId)

		PlayerPrefsHelper.setNumber(key, 1)
	end
end

function Act183Helper._generateHasPlayUnlockAnimGroupIdKey(activityId, groupId)
	return string.format("%s#%s#%s#%s", PlayerPrefsKey.Act183HasPlayUnlockAnimGroupIds, PlayerModel.instance:getMyUserId(), activityId, groupId)
end

function Act183Helper.isLastPassEpisodeInType(episodeMo)
	local status = episodeMo and episodeMo:getStatus()

	if status ~= Act183Enum.EpisodeStatus.Finished then
		return
	end

	local groupType = episodeMo:getGroupType()
	local passOrder = episodeMo:getPassOrder()

	return groupType == Act183Enum.GroupType.Daily and passOrder >= Act183Enum.MaxDailySubEpisodesNum or passOrder >= Act183Enum.MaxMainSubEpisodesNum
end

function Act183Helper.isLastPassEpisodeInGroup(episodeMo)
	local status = episodeMo and episodeMo:getStatus()

	if status ~= Act183Enum.EpisodeStatus.Finished then
		return
	end

	local groupType = episodeMo:getGroupType()
	local passOrder = episodeMo:getPassOrder()

	return groupType == Act183Enum.GroupType.Daily and passOrder >= Act183Enum.MaxDailySubEpisodesNum or passOrder >= Act183Enum.MaxMainSubEpisodesNum + Act183Enum.MainGroupBossEpisodeNum
end

function Act183Helper.getHasReadUnlockSupportHeroIdsInLocal(activityId)
	local key = Act183Helper._generateSaveHasReadUnlockSupportHeroIdsKey(activityId)
	local readUnlockHeroIdStr = PlayerPrefsHelper.getString(key, "")

	return (string.splitToNumber(readUnlockHeroIdStr, "#"))
end

function Act183Helper.saveHasReadUnlockSupportHeroIdsInLocal(activityId, unlockHeroIds)
	if unlockHeroIds then
		local key = Act183Helper._generateSaveHasReadUnlockSupportHeroIdsKey(activityId)
		local unlockHeroIdStr = table.concat(unlockHeroIds, "#")

		PlayerPrefsHelper.setString(key, unlockHeroIdStr)
	end
end

function Act183Helper._generateSaveHasReadUnlockSupportHeroIdsKey(activityId)
	return string.format("%s#%s#%s", PlayerPrefsKey.Act183HasReadUnlockSupportHeroIds, PlayerModel.instance:getMyUserId(), activityId)
end

function Act183Helper.getHasPlayRefreshAnimRuleIdsInLocal(episodeId)
	local key = Act183Helper._generateHasPlayRefreshAnimRuleIdsKey(episodeId)
	local refreshAnimRuleIdStr = PlayerPrefsHelper.getString(key, "")

	return (string.split(refreshAnimRuleIdStr, "#"))
end

function Act183Helper.saveHasPlayRefreshAnimRuleIdsInLocal(episodeId, escapeRuleIds)
	if escapeRuleIds then
		local key = Act183Helper._generateHasPlayRefreshAnimRuleIdsKey(episodeId)
		local refreshAnimRuleIdStr = table.concat(escapeRuleIds, "#")

		PlayerPrefsHelper.setString(key, refreshAnimRuleIdStr)
	end
end

function Act183Helper._generateHasPlayRefreshAnimRuleIdsKey(episodeId)
	return string.format("%s#%s#%s", PlayerPrefsKey.Act183HasPlayRefreshAnimRuleIds, PlayerModel.instance:getMyUserId(), episodeId)
end

function Act183Helper.getBadgeItemConfig()
	local constCo = lua_challenge_const.configDict[Act183Enum.Const.BadgeItemId]
	local badgeItemId = constCo and tonumber(constCo.value)
	local badgeItemCo = CurrencyConfig.instance:getCurrencyCo(badgeItemId)

	if badgeItemCo then
		return MaterialEnum.MaterialType.Currency, badgeItemId
	end
end

function Act183Helper.getMaxBadgeNum()
	return tonumber(lua_challenge_const.configDict[Act183Enum.Const.MaxBadgeNum].value)
end

function Act183Helper.isGetBadgeNumMax()
	local curBadgeNum = Act183Model.instance:getBadgeNum()
	local maxBadgeNum = Act183Helper.getMaxBadgeNum()

	if curBadgeNum and maxBadgeNum then
		return maxBadgeNum <= curBadgeNum
	end
end

function Act183Helper.getTaskCanGetBadgeNums(taskIdList)
	local canGetNum = 0

	if taskIdList then
		for _, taskId in ipairs(taskIdList) do
			local taskMo = TaskModel.instance:getTaskById(taskId)
			local taskCo = taskMo and taskMo.config

			if taskCo then
				if not taskCo.badgeNum then
					local badgeNum = 0

					canGetNum = canGetNum + badgeNum
				end
			end
		end
	end

	local curBadgeNum = Act183Model.instance:getBadgeNum()
	local maxBadgeNum = Act183Helper.getMaxBadgeNum()
	local remainBadgeNum = maxBadgeNum - curBadgeNum
	local resultCanGetNum = remainBadgeNum <= canGetNum and remainBadgeNum or canGetNum

	return canGetNum, resultCanGetNum
end

function Act183Helper.showToastWhileGetTaskRewards(taskIdList)
	local canGetNum, resultCanGetNum = Act183Helper.getTaskCanGetBadgeNums(taskIdList)
	local isBadgeNumMax = Act183Helper.isGetBadgeNumMax()

	if resultCanGetNum > 0 then
		GameFacade.showToast(ToastEnum.Act183GetBadgeNum, resultCanGetNum)
	end

	if canGetNum > 0 and isBadgeNumMax then
		GameFacade.showToast(ToastEnum.Act183GetBadgeMax)
	end
end

function Act183Helper.isOnlyCanUseLimitPlayerCloth(episodeId)
	local groupType = Act183Helper.getGroupType(episodeId)
	local playerClothId = Act183Helper.getLimitUsePlayerCloth()

	return groupType ~= Act183Enum.GroupType.Daily and playerClothId and playerClothId ~= 0
end

function Act183Helper.getLimitUsePlayerCloth()
	local constCo = lua_challenge_const.configDict[Act183Enum.Const.PlayerClothIds]
	local constStr = constCo and constCo.value

	if constStr then
		return tonumber(constStr)
	end
end

function Act183Helper.getEpisodeClsKey(groupType, episodeType)
	if not groupType or not episodeType then
		logError(string.format("配置错误 groupType = %s, episodeType = %s", groupType, episodeType))
	end

	return string.format("%s_%s", groupType, episodeType)
end

function Act183Helper.isTeamLeader(episodeId, posIndex)
	local hasTeamLeader = Act183Helper.isEpisodeHasTeamLeader(episodeId)
	local leaderPosition = Act183Config.instance:getEpisodeLeaderPosition(episodeId)

	return hasTeamLeader and leaderPosition ~= 0 and posIndex == leaderPosition
end

function Act183Helper.getEpisodeBattleNum(episodeId)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeCo then
		logError(string.format("关卡配置不存在 episodeId = %s", episodeId))

		return ModuleEnum.MaxHeroCountInGroup
	end

	local battleCo = lua_battle.configDict[episodeCo.battleId]

	if battleCo then
		if not battleCo.roleNum then
			return ModuleEnum.MaxHeroCountInGroup
		end
	end
end

function Act183Helper.isEpisodeHasTeamLeader(episodeId)
	local episodeCo = Act183Config.instance:getEpisodeCo(episodeId)

	if not episodeCo then
		return
	end

	return episodeCo and not string.nilorempty(episodeCo.skillDesc)
end

function Act183Helper.setEpisodeConditionStar(imageComp, isPass, isSelect, setNativeSize)
	if not imageComp then
		logError("图片组件为空")

		return
	end

	if isPass then
		if not Act183Enum.ConditionStatus.Pass then
			local status = Act183Enum.ConditionStatus.Unpass

			if isPass and isSelect ~= nil then
				status = isSelect and Act183Enum.ConditionStatus.Pass_Select or Act183Enum.ConditionStatus.Pass_Unselect
			end

			local starImgName = Act183Enum.ConditionStarImgName[status]

			if string.nilorempty(starImgName) then
				logError(string.format("星星图片不存在 isPass = %s, isSelect = %s, status = %s,", isPass, isSelect, status))

				return
			end

			UISpriteSetMgr.instance:setChallengeSprite(imageComp, starImgName, setNativeSize)
		end
	end
end

function Act183Helper.getEpisodeSnapShotType(episodeId)
	local maxBattleNum = Act183Helper.getEpisodeBattleNum(episodeId)
	local snapshotType = Act183Enum.BattleNumToSnapShotType[maxBattleNum]

	if not snapshotType then
		logError(string.format("编队快照类型(Act183Enum.BattleNumToSnapShotType)不存在 episodeId = %s, maxBattleNum = %s", episodeId, maxBattleNum))

		return Act183Enum.BattleNumToSnapShotType.Default
	end

	return snapshotType
end

function Act183Helper.isOpenCurrencyReplaceTipsViewInLocal()
	local key = Act183Helper._generateOpenCurrencyReplaceTipsViewKey()

	return not string.nilorempty(PlayerPrefsHelper.getString(key, ""))
end

function Act183Helper.saveOpenCurrencyReplaceTipsViewInLocal()
	local key = Act183Helper._generateOpenCurrencyReplaceTipsViewKey()

	PlayerPrefsHelper.setString(key, "true")
end

function Act183Helper._generateOpenCurrencyReplaceTipsViewKey()
	return string.format("%s#%s", PlayerPrefsKey.Act183OpenCurrencyReplaceTipsView, PlayerModel.instance:getMyUserId())
end

function Act183Helper.generateBossRush_ChallengeCurrencyReplaceViewParams()
	local params = {}

	params.oldCurrencyId = CurrencyEnum.CurrencyType.BossRushStore
	params.newCurrencyId = CurrencyEnum.CurrencyType.BossRushStore
	params.oldCurrencyIconUrl = ResUrl.getCurrencyItemIcon(100606)
	params.oldCurrencyNum = tonumber(PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.V2a7_BossRushCurrencyNum))
	params.replaceRate = 1
	params.desc = luaLang("v2a5_challenge_currencyreplacetipsview_desc1")

	return params
end

function Act183Helper.calcEpisodeTotalConditionCount(episodeId)
	local advancedCondition = DungeonConfig.instance:getEpisodeAdvancedCondition(episodeId)
	local advanceConditionCount = 0

	if not string.nilorempty(advancedCondition) then
		local advanceConditionList = string.splitToNumber(advancedCondition, "|")

		advanceConditionCount = advanceConditionList and #advanceConditionList or 0
	end

	local winCondition = DungeonConfig.instance:getEpisodeCondition(episodeId)
	local winConditionCount = 0

	if not string.nilorempty(winCondition) then
		local winList = GameUtil.splitString2(winCondition, false, "|", "#")

		winConditionCount = winList and #winList or 0
	end

	local totalConditionCount = advanceConditionCount + winConditionCount

	return totalConditionCount, winConditionCount, advanceConditionCount
end

function Act183Helper.getEpisodeConditionDescList(episodeId)
	local conditionDescList = {}

	table.insert(conditionDescList, DungeonConfig.instance:getFirstEpisodeWinConditionText(episodeId))

	local advancedCondition = DungeonConfig.instance:getEpisodeAdvancedCondition(episodeId)

	if LuaUtil.isEmptyStr(advancedCondition) == false then
		local conditionList = string.splitToNumber(advancedCondition, "|")

		for _, conditionId in ipairs(conditionList) do
			local condition = lua_condition.configDict[conditionId]

			table.insert(conditionDescList, condition.desc)
		end
	end

	return conditionDescList
end

return Act183Helper
