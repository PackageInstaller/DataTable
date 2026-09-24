-- chunkname: @modules/logic/abyss/controller/AbyssController.lua

module("modules.logic.abyss.controller.AbyssController", package.seeall)

local AbyssController = class("AbyssController", BaseController)

function AbyssController:onInit()
	logNormal("AbyssController init")
	self:reInit()
end

function AbyssController:onInitFinish()
	return
end

function AbyssController:addConstEvents()
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, self._refreshTaskData, self)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self._refreshTaskData, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self, LuaEventSystem.Low)
end

function AbyssController:reInit()
	self.tempStageId = nil
end

function AbyssController:_refreshTaskData()
	self:dispatchEvent(AbyssEvent.OnAbyssTaskUpdate)
end

function AbyssController:_onDailyRefresh()
	if not AbyssModel.instance:isFunctionUnlock() then
		return
	end

	if AbyssModel.instance:isCurActOpen(false) then
		self:getTaskInfo()
	end
end

function AbyssController:getTaskInfo(callback, callbackObj)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Abyss
	}, callback, callbackObj)
end

function AbyssController:openTaskView()
	self.getTaskInfo(self, self._openTaskView, self)
end

function AbyssController:_openTaskView()
	ViewMgr.instance:openView(ViewName.AbyssTaskView)
end

function AbyssController:getActivityInfo(actId, callback, callbackObj)
	if actId then
		AbyssRpc.instance:sendGetAct229InfoRequest(actId, callback, callbackObj)
	end
end

function AbyssController:openMainView(actId, refreshInfo)
	if actId then
		AbyssModel.instance:setCurActId(actId)
	else
		actId = AbyssModel.instance:getCurActId()
	end

	if refreshInfo then
		self.getActivityInfo(self, actId, self._openMainView, self)
	else
		self:_openMainView()
	end
end

function AbyssController:_openMainView()
	ViewMgr.instance:openView(ViewName.AbyssMainView)
end

function AbyssController:startFight()
	local stageMo = AbyssModel.instance:getCurStageMo()

	if stageMo == nil then
		return
	end

	local actInfo = AbyssModel.instance:getCurInfoMo()
	local haveChallengedAssist = false

	for _, stageInfo in ipairs(actInfo.stageInfoList) do
		if stageInfo:haveAssist() and stageInfo:isChallenged() then
			haveChallengedAssist = true

			break
		end
	end

	if not haveChallengedAssist and not stageMo:haveAssist() then
		AbyssModel.instance:cleanAssistMO()
	end

	local snapshotId = ModuleEnum.HeroGroupSnapshotType.Abyss

	HeroGroupRpc.instance:sendGetHeroGroupSnapshotListRequest(snapshotId, self._startFight, self)
end

function AbyssController:_startFight()
	local stageId = AbyssModel.instance:getCurStageId()
	local actId = AbyssModel.instance:getCurActId()
	local curStage = AbyssModel.instance:getCurStageMo()
	local stageConfig = AbyssConfig.instance:getEpisodeConfig(actId, stageId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(stageConfig.episodeId)
	local groupInfo = HeroGroupSnapshotModel.instance:getById(ModuleEnum.HeroGroupSnapshotType.Abyss)

	groupInfo:setSelectIndex(curStage.heroGroupSubId or 1)
	DungeonFightController.instance:enterFight(episodeConfig.chapterId, stageConfig.episodeId, nil)
end

function AbyssController:enterFight(param, callback, callbackObj)
	AbyssRpc.instance:sendStartAct229BattleRequest(param, callback, callbackObj)
end

function AbyssController:tryResetStage(stageId)
	local actId = AbyssModel.instance:getCurActId()
	local stageInfoMo = AbyssModel.instance:getStageInfoMo(actId, stageId)

	if not stageInfoMo then
		return
	end

	self.tempStageId = stageId

	local isLock = stageInfoMo and stageInfoMo:isChallenged()

	if isLock then
		GameFacade.showMessageBox(MessageBoxIdDefine.AbyssRestTeamTip, MsgBoxEnum.BoxType.Yes_No, self.realResetCurStage, nil, nil, self)
	end
end

function AbyssController:tryResetCurStage()
	local stageInfoMo = AbyssModel.instance:getCurStageMo()

	self:tryResetStage(stageInfoMo.stageId)
end

function AbyssController:realResetCurStage()
	local actId = AbyssModel.instance:getCurActId()
	local stageId = self.tempStageId

	self:resetStage(actId, stageId)

	self.tempStageId = nil
end

function AbyssController:resetStage(actId, stageId)
	AbyssRpc.instance:sendAct229ResetStageRequest(actId, stageId)
end

function AbyssController:openFightSuccView()
	ViewMgr.instance:openView(ViewName.AbyssFightSuccView)
end

function AbyssController:onReconnectFight(param)
	local episodeId = param.episodeId
	local actId = AbyssConfig.instance:getActIdByEpisodeId(episodeId)
	local stageId = param.stageId

	AbyssModel.instance:setCurActId(actId)
	AbyssModel.instance:setCurStageId(stageId)
end

function AbyssController:statCheckInformation(entrance, episodeId)
	local var_22_0 = {
		[StatEnum.EventProperties.AbyssEntrance] = entrance or StatEnum.AbyssEntranceEnum.Conditions
	}

	var_22_0[StatEnum.EventProperties.AbyssEpisodeId] = tostring(episodeId) or "0"

	StatController.instance:track(StatEnum.EventName.CheckLevelInformation, var_22_0)
end

function AbyssController:openBuffSelectView(stageId, selectSkillId)
	local param = {}

	param.actId = AbyssModel.instance:getCurActId()
	param.stageId = stageId
	param.selectSkillId = selectSkillId

	ViewMgr.instance:openView(ViewName.AbyssBuffSelectView, param)
end

function AbyssController:selectStageSkill(stageId, skillId)
	local actId = AbyssModel.instance:getCurActId()
	local stageInfo = AbyssModel.instance:getStageInfoMo(actId, stageId)

	if not stageInfo or stageInfo:isChallenged() or stageInfo.skillId == skillId then
		return
	end

	stageInfo.skillId = skillId
end

function AbyssController:requestAbyssSnapshot(callback, callbackObj)
	local snapshotId = ModuleEnum.HeroGroupSnapshotType.Abyss

	HeroGroupRpc.instance:sendGetHeroGroupSnapshotListRequest(snapshotId, callback or function()
		return
	end, callbackObj or self)
end

function AbyssController:openTeamPresetView(stageId, heroGroupName, onlyQuickEdit, moIndex)
	stageId = stageId or AbyssModel.instance:getCurStageId()
	moIndex = moIndex or 1

	local actId = AbyssModel.instance:getCurActId()
	local stageConfig = AbyssConfig.instance:getEpisodeConfig(actId, stageId)

	if not stageConfig then
		logError("AbyssController:openTeamPresetView stageConfig is nil, stageId:" .. tostring(stageId))

		return
	end

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(stageConfig.episodeId)

	if not episodeConfig then
		logError("AbyssController:openTeamPresetView episodeConfig is nil, episodeId:" .. tostring(stageConfig.episodeId))

		return
	end

	AbyssModel.instance:setCurStageId(stageId)

	local stageMo = AbyssModel.instance:getStageInfoMo(actId, stageId)
	local groupInfo = HeroGroupSnapshotModel.instance:getById(ModuleEnum.HeroGroupSnapshotType.Abyss)

	groupInfo:setSelectIndex(stageMo.heroGroupSubId or 1)

	if stageMo then
		if not stageMo.heroGroupSubId then
			local selectIndex = 1

			HeroGroupModel.instance:setCurGroupId(selectIndex)
			HeroGroupModel.instance:setParam(episodeConfig.battleId, stageConfig.episodeId, false, nil, episodeConfig.type)
			FightController.instance:setFightParamByEpisodeId(stageConfig.episodeId)

			local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()
			local equips = heroGroupMO:getPosEquips(moIndex - 1).equipUid
			local removeTempList = {}
			local heroList = heroGroupMO.heroList
			local actInfo = AbyssModel.instance:getCurInfoMo()
			local haveChallenge = stageMo:isChallenged()

			for i, uid in ipairs(heroList) do
				local heroMo = HeroModel.instance:getById(uid)
				local isUsed = heroMo and not haveChallenge and actInfo:isHeroUsed(heroMo.heroId, stageMo.lastUpdateTime)

				if heroMo and AbyssModel.instance:isCurHeroLocked(heroMo.heroId) or isUsed then
					table.insert(removeTempList, uid)
				end
			end

			for i, id in ipairs(removeTempList) do
				HeroSingleGroupModel.instance:remove(id)
			end

			local param = {}

			param.singleGroupMOId = moIndex
			param.originalHeroUid = HeroSingleGroupModel.instance:getHeroUid(moIndex)
			param.adventure = HeroGroupModel.instance:isAdventureOrWeekWalk()
			param.equips = equips

			FightAudioMgr.instance:init()
			ViewMgr.instance:openView(ViewName.HeroGroupEditView, param)
		end
	end
end

function AbyssController:setStageBuff(stageId, skillId)
	local actId = AbyssModel.instance:getCurActId()
	local stageMo = AbyssModel.instance:getStageInfoMo(actId, stageId)

	if not stageMo then
		return
	end

	stageMo.skillId = skillId

	local skillIds = {
		stageMo.skillId
	}

	AbyssRpc.instance:sendAct229ModifySkillRequest(actId, stageId, skillIds, function()
		self:dispatchEvent(AbyssEvent.OnUpdateStageInfo)
	end, self)
end

function AbyssController:setStageGroupSubId(stageId, heroGroupId, callback, callbackObj)
	local actId = AbyssModel.instance:getCurActId()
	local infoMo = AbyssModel.instance:getCurInfoMo()

	if not infoMo then
		return
	end

	local curStageMo = infoMo:getStageInfo(stageId)

	if not curStageMo then
		return
	end

	local oldSubId = curStageMo.heroGroupSubId

	if oldSubId == heroGroupId then
		return
	end

	if curStageMo:isChallenged() then
		GameFacade.showToast(ToastEnum.AbyssHeroGroupCannotEdit)

		return
	end

	local swapStageMo

	for _, stageMo in ipairs(infoMo.stageInfoList) do
		if stageMo.stageId ~= stageId and stageMo.heroGroupSubId == heroGroupId then
			swapStageMo = stageMo

			break
		end
	end

	local stageSubIds = {}

	if swapStageMo then
		curStageMo.heroGroupSubId = heroGroupId
		swapStageMo.heroGroupSubId = oldSubId

		table.insert(stageSubIds, {
			stageId = stageId,
			heroGroupSubId = heroGroupId
		})

		for _, stageMo in ipairs(infoMo.stageInfoList) do
			if stageMo.stageId ~= stageId then
				table.insert(stageSubIds, {
					stageId = stageMo.stageId,
					heroGroupSubId = stageMo.heroGroupSubId
				})
			end
		end
	else
		curStageMo.heroGroupSubId = heroGroupId

		table.insert(stageSubIds, {
			stageId = stageId,
			heroGroupSubId = heroGroupId
		})
	end

	AbyssRpc.instance:sendAct229ModifyStageSubIdRequest(actId, stageSubIds, function()
		self:dispatchEvent(AbyssEvent.OnUpdateStageInfo)

		if callback then
			callback(callbackObj)
		end
	end, self)
end

function AbyssController:getCurSkillIdList()
	local result = {}
	local infoMo = AbyssModel.instance:getCurInfoMo()

	if not infoMo then
		return result
	end

	local stageMo = infoMo:getStageInfo(AbyssModel.instance:getCurStageId())

	if not stageMo or not stageMo.skillId then
		return result
	end

	return {
		stageMo.skillId
	}
end

function AbyssController:getFightCustomParam()
	local result = self:getCurSkillIdList()
	local obj = {
		chooseSkillIds = result
	}

	return cjson.encode(obj)
end

function AbyssController:checkAssistHero(req)
	local assistInfo = AbyssModel.instance:getAssistMO()

	if assistInfo then
		for i, uid in ipairs(req.fightGroup.heroList) do
			if assistInfo.heroUid == uid then
				req.fightGroup.heroList[i] = "0"

				local equip = req.fightGroup.equips[i]

				if equip then
					equip.heroUid = "0"
				end

				local act104Equips = req.fightGroup.activity104Equips[i]

				if act104Equips then
					act104Equips.heroUid = "0"
				end
			end
		end
	end
end

function AbyssController:onUseAssist()
	local curStageInfo = AbyssModel.instance:getCurStageMo()
	local saveGroupMo = HeroGroupSnapshotModel.instance:getHeroGroupInfo(ModuleEnum.HeroGroupSnapshotType.Abyss, curStageInfo.heroGroupSubId)

	for pos, uid in ipairs(saveGroupMo.heroList) do
		if curStageInfo:isPosAssist(pos) then
			saveGroupMo.heroList[pos] = "0"
		end
	end

	self:saveSnapShot(saveGroupMo, curStageInfo.heroGroupSubId)
end

function AbyssController:saveSnapShot(saveGroupMo, subId, callback, callbackObj, isReplace)
	local snapshotId = ModuleEnum.HeroGroupSnapshotType.Abyss
	local result = {}
	local infoMo = AbyssModel.instance:getCurInfoMo()

	if infoMo then
		local curStageInfo = AbyssModel.instance:getCurStageMo()
		local snapshotSubId = subId or curStageInfo.heroGroupSubId
		local haveHeroDic = {}

		for pos, uid in ipairs(saveGroupMo.heroList) do
			local heroMo = HeroModel.instance:getById(uid)

			if heroMo then
				haveHeroDic[heroMo.heroId] = true
			elseif curStageInfo:isPosAssist(pos) then
				haveHeroDic[curStageInfo:getPosAssistHeroId(pos)] = true
			end
		end

		if isReplace and curStageInfo:haveAssist() then
			curStageInfo:clearAssistHero()
		end

		if not next(haveHeroDic) then
			self:_saveSnapShot(saveGroupMo, snapshotId, snapshotSubId, callback, callbackObj)
			HeroGroupPresetController.instance:initCopyHeroGroupList()

			return
		end

		for _, stageMo in ipairs(infoMo.stageInfoList) do
			if stageMo.heroGroupSubId ~= snapshotSubId and not stageMo:isChallenged() then
				local groupMo = HeroGroupSnapshotModel.instance:getHeroGroupInfo(snapshotId, stageMo.heroGroupSubId, true)

				for i = 1, #groupMo.heroList do
					local uid = groupMo.heroList[i]
					local heroMo = HeroModel.instance:getById(uid)
					local isAssist = stageMo:isPosAssist(i)

					if heroMo then
						if not heroMo.heroId then
							local heroId = 0
							local assistId = stageMo:getPosAssistHeroId(i)
							local isRemove = true
							local removeId, skinId

							if heroMo ~= nil and haveHeroDic[heroId] then
								result[stageMo.heroGroupSubId] = groupMo
								groupMo.heroList[i] = "0"
								removeId = heroId
								skinId = heroMo.skin
							elseif isAssist and haveHeroDic[assistId] then
								local assistMo = AbyssModel.instance:getAssistMO()

								skinId = assistMo and assistMo.assistMo.skin or stageMo.skinDic[assistId]

								stageMo:clearAssistHero()

								removeId = assistId
							else
								isRemove = false
							end

							if isRemove then
								AbyssController.instance:dispatchEvent(AbyssEvent.OnAbyssRecommendHeroRemove, {
									heroId = removeId,
									skinId = skinId,
									pos = i,
									stageId = stageMo.stageId
								})
							end
						end
					end
				end
			end
		end

		if next(result) then
			result[snapshotSubId] = saveGroupMo

			self:_saveSnapShotList(result, snapshotId, callback, callbackObj)
		else
			self:_saveSnapShot(saveGroupMo, snapshotId, snapshotSubId, callback, callbackObj)
		end

		HeroGroupPresetController.instance:initCopyHeroGroupList()
	end
end

function AbyssController:_saveSnapShotList(result, snapshotId, callback, callbackObj)
	if next(result) then
		HeroGroupRpc.instance:sendSetHeroGroupSnapshotBatchRequest(snapshotId, result, callback, callbackObj)
	end
end

function AbyssController:_saveSnapShot(heroGroupMO, snapshotId, snapshotSubId, callback, callbackObj)
	local req = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

	FightParam.initFightGroup(req.fightGroup, heroGroupMO.clothId, heroGroupMO:getMainList(), heroGroupMO:getSubList(), heroGroupMO:getAllHeroEquips(), heroGroupMO:getAllHeroActivity104Equips(), heroGroupMO:getAssistBossId())
	HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(snapshotId, snapshotSubId, req, callback, callbackObj)
end

function AbyssController:enterFightByEpisodeIdGM(episodeId)
	episodeId = tonumber(episodeId)

	local actId = AbyssConfig.instance:getActIdByEpisodeId(episodeId)

	if not actId then
		logError("enterFightByEpisodeIdGM: episodeId无效 " .. tostring(episodeId))

		return
	end

	local stageId = AbyssConfig.instance:getStageIdByEpisodeId(actId, episodeId)

	if not stageId then
		logError("enterFightByEpisodeIdGM: stageId is nil, episodeId:" .. tostring(episodeId))

		return
	end

	local stageConfig = AbyssConfig.instance:getEpisodeConfig(actId, stageId)

	if not stageConfig then
		logError("enterFightByEpisodeIdGM: stageConfig is nil, stageId:" .. tostring(stageId))

		return
	end

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeConfig then
		logError("enterFightByEpisodeIdGM: episodeConfig is nil, episodeId:" .. tostring(episodeId))

		return
	end

	AbyssModel.instance:setCurActId(actId)
	AbyssModel.instance:setCurStageId(stageId)
	AbyssModel.instance:cleanAssistMO()

	local infoMo = AbyssModel.instance:getInfoMo(actId)

	if not infoMo then
		infoMo = AbyssInfoMo.New(actId)
		AbyssModel.instance._infoMoDic[actId] = infoMo
	end

	if not infoMo:getStageInfo(stageId) then
		local stageMo = AbyssStageMo.New()

		stageMo.stageId = stageId
		stageMo.heroGroupSubId = 1
		stageMo.skillId = AbyssHelper.getValidSkill(actId, stageId, 0)
		stageMo.lastUpdateTime = stageId
		infoMo.stageInfoDic[stageId] = stageMo

		table.insert(infoMo.stageInfoList, stageMo)
	end

	local stageMo = infoMo:getStageInfo(stageId)

	if stageMo and not stageMo.totalStar then
		stageMo.totalStar = AbyssConfig.instance:getStageMaxStar(actId, stageId) or 0
	end

	local stageMo = AbyssModel.instance:getCurStageMo()

	if stageMo then
		if not stageMo.heroGroupSubId then
			local selectIndex = 1

			HeroGroupModel.instance:setCurGroupId(selectIndex)
			HeroGroupModel.instance:setParam(episodeConfig.battleId, episodeId, false, nil, episodeConfig.type)

			local groupInfo = HeroGroupSnapshotModel.instance:getById(ModuleEnum.HeroGroupSnapshotType.Abyss)

			if groupInfo then
				groupInfo:setSelectIndex(selectIndex)
			end

			FightController.instance:setFightParamByEpisodeId(episodeId)
			DungeonFightController.instance:enterFight(episodeConfig.chapterId, episodeId, nil)
		end
	end
end

AbyssController.instance = AbyssController.New()

return AbyssController
