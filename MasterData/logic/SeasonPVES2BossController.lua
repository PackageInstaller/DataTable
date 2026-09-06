-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/controller/SeasonPVES2BossController.lua

module("logic.extensions.season.controller.SeasonPVES2BossController", package.seeall)

local SeasonPVES2BossController = class("SeasonPVES2BossController", SeasonPVEBossDefultController)

function SeasonPVES2BossController:initConfig()
	SeasonPVES2BossController.super.initConfig(self)

	self._bossShowPhaseId = SeasonConfig.instance:getCommonValue("FINAL_BOSS_SHOW_PHASEID", true)
	self._defendBossShowPhaseId = SeasonConfig.instance:getCommonValue("DEFEND_BOSS_SHOW_PHASEID", true)
end

function SeasonPVES2BossController:checkNextBossStory(id)
	local isBossPoint = false

	for i, v in ipairs(self:getDoppelgangerReadOnlyPointIds()) do
		if v == id then
			isBossPoint = true

			break
		end
	end

	if not isBossPoint then
		return
	end

	if self._bossMo.phaseId <= self._doppelgangerPhaseId then
		local config = self._configs[self._doppelgangerPhaseId]
		local occupiedNum = 0

		for i, v in ipairs(config.targetPointIds) do
			if SeasonModel.instance:isOccupied(v) then
				occupiedNum = occupiedNum + 1
			end
		end

		if config.storyIds[occupiedNum] then
			self._isCacheSingleId = config.storyIds[occupiedNum]
		end
	end
end

function SeasonPVES2BossController:_doLogic()
	if self._bossMo.phaseId == self._doppelgangerPhaseId then
		return
	end

	SeasonPVES2BossController.super._doLogic(self)
end

function SeasonPVES2BossController:_doBeforeLogicAnim(config, callback)
	local function doNext()
		if config and config.storyIds ~= nil then
			SeasonPVEBossStoryHandler.instance:play(config.storyIds, callback)
		else
			GameUtil.callBack(callback)
		end
	end

	if self._defendBossShowPhaseId == self._bossMo.phaseId then
		self._bossUnit = nil
		self._resObject = nil
		self._shadowObject = nil
		self._sceneUnit = nil

		local function onBossModelLoadedFinish()
			self:_onBossModelLoadedFinish()
			doNext()
		end

		local targetGridId = 0
		local config = self._configs[self._defendBossShowPhaseId]
		local seasonId = SeasonModel.instance:getSeasonId()

		for i, v in ipairs(config.storyIds) do
			local storyCfg = SeasonConfig.instance:getBossPhaseStoryConfig(seasonId, v)

			if storyCfg.storyType == 5 then
				targetGridId = checknumber(storyCfg.params)

				break
			end
		end

		if targetGridId > 0 then
			local scene = SceneMgr.instance:getCurScene()
			local destRow, destCol = SeasonPathFindingDataModel.instance:id2Grid(targetGridId)

			self._bossUnit = scene.eventsData:getEventUnit(destRow, destCol)

			local phaseCfg = self._configs[self._bossPhaseId]
			local bossEvtCfg = SeasonConfig.instance:getMapEvtTypeAndId(SeasonModel.instance:getSeasonId(), phaseCfg.targetPointIds[1])
			local bossCfg = SeasonConfig.instance:getMapEvtDetail(bossEvtCfg.seasonId, SeasonGridEvtTypes.EVT_BOSS, bossEvtCfg.eventId)
			local team = SeasonConfig.instance:getCreeps(bossCfg.creepsMasterId)
			local modelCo = CharacterConfig.instance:getModelCo(checknumber(team[1].faceId) > 0 and checknumber(team[1].faceId) or checknumber(team[1].raceId))
			local resPath = GameUrl.getSpineUrl(modelCo.resName)

			self._resObject = self._bossUnit.scene.resCache:newObject(resPath)
			self._resObject.loadedHandler = onBossModelLoadedFinish
			self._resObject.loadedHandlerTarget = self

			self._resObject:setParent(self._bossUnit.go.transform)
			self._resObject:setScale(0.2)
			self._resObject:setLocalPos(0, -0.25, 0)
			self._bossUnit:setVisible(false)
		end
	else
		doNext()
	end
end

function SeasonPVES2BossController:_doLogicAnim(config, callback)
	local function doNext()
		GameUtil.callBack(callback)
	end

	doNext()
end

function SeasonPVES2BossController:_doAfterLogicAnim(config, callback)
	if self._defendBossShowPhaseId == self._bossMo.phaseId then
		self:onDeactiveBossModel()
	end

	if config and config.storyIdsAfterLogic ~= nil then
		SeasonPVEBossStoryHandler.instance:play(config.storyIdsAfterLogic, callback)
	else
		GameUtil.callBack(callback)
	end
end

function SeasonPVES2BossController:isCanDoEvent(evtConfig)
	if evtConfig.eventType == SeasonGridEvtTypes.EVT_BOSS then
		return self:isDefendBossShow()
	else
		return true
	end
end

function SeasonPVES2BossController:isFinalBossShow()
	if self._bossMo.phaseId >= self._bossShowPhaseId then
		return true
	end

	return false
end

function SeasonPVES2BossController:isDefendBossShow()
	if self._bossMo.phaseId >= self._defendBossShowPhaseId then
		return true
	end

	return false
end

function SeasonPVES2BossController:getBlockStates()
	local doppelgangerTargetPointIds = self:getDoppelgangerReadOnlyPointIds() or {}
	local map = {}
	local isNeedBlock = not self:isDefendBossShow()

	for i, v in ipairs(doppelgangerTargetPointIds) do
		map[v] = isNeedBlock
	end

	local bossTargetPointId = self:getBossReadOnlyPointId() or -1

	map[bossTargetPointId] = not self:isFinalBossShow()

	return map
end

function SeasonPVES2BossController:handleNotifySMPVEBossPhaseNextStepRes(status, msg)
	if status == 0 and SeasonController.instance:getSceneSceneId() ~= 0 then
		SeasonModel.instance:updateBossInfo(msg.curBossInfo)

		local seasonController = SeasonController.instance
		local teamJumps = checktable(msg.teamJumps)

		for i = 1, #teamJumps do
			local teamId = teamJumps[i].teamId
			local curPosition = teamJumps[i].curPosition

			seasonController:onServerLeaderPosChanged(teamId, curPosition)
		end

		if self._startbattle == true then
			self._isCacheNotify = true
		else
			self:_doLogic()
		end
	end
end

function SeasonPVES2BossController:handleOpViewChallenge(seasonId, evtConfig, evtDetailConfig)
	local doppelgangers = SeasonPVEBossController.instance:getDoppelgangerReadOnlyPointIds()
	local isDoppelganger = false

	for i, v in ipairs(doppelgangers) do
		if evtConfig.id == checknumber(v) then
			isDoppelganger = true

			break
		end
	end

	if isDoppelganger == true then
		local seasonId = SeasonModel.instance:getSeasonId()
		local config = SeasonConfig.instance:getMapEvtDetail(seasonId, evtConfig.eventType, evtConfig.eventId) or {}
		local creepsMasterId = config.creepsMasterId
		local creepsTeam = SeasonConfig.instance:getCreepTeam(creepsMasterId)
		local var_15_0 = {
			bHideSure = true,
			evtConfig = evtConfig,
			evtDetailConfig = evtDetailConfig
		}

		var_15_0.recommendZdl = creepsTeam.recommendZdl or 0

		UIStateManager.instance:push(ViewName.SeasonS2BossDetatilChallengeView, var_15_0)
	elseif evtDetailConfig.isElite == true then
		UIStateManager.instance:push(ViewName.SeasonEliteChallengeGridShowView, {
			bHideSure = true,
			evtConfig = evtConfig,
			evtDetailConfig = evtDetailConfig
		})
	else
		UIStateManager.instance:push(ViewName.SeasonChallengeGridShowView, {
			bHideSure = true,
			evtConfig = evtConfig,
			evtDetailConfig = evtDetailConfig
		})
	end
end

function SeasonPVES2BossController:_handleOpViewBossEvent(seasonId, evtConfig, evtDetailConfig)
	UIStateManager.instance:push(ViewName.SeasonS2BossChallengeView, {
		bHideSure = true
	})
end

function SeasonPVES2BossController:_onBossModelLoadedFinish()
	if not self._resObject then
		return
	end

	if not self._bossUnit then
		return
	end

	local go = self._resObject.go

	if goutil.isNil(go) then
		return
	end

	local boxCollider = go:GetComponent(ComponentType.BoxCollider)

	if boxCollider then
		boxCollider.enabled = false
	end

	if go.activeInHierarchy then
		GoUtil.PlaySpineAnim(go, "idle", true, true)
	else
		go.transform:SetParent(nil)
		GoUtil.PlaySpineAnim(go, "idle", true, true)
		go.transform:SetParent(self._bossUnit.go.transform)
	end

	GoUtil.SetVisible(go, true)
end

function SeasonPVES2BossController:onDeactiveBossModel()
	if self._resObject then
		local go = self._resObject.go

		if not goutil.isNil(go) then
			local boxCollider = go:GetComponent(ComponentType.BoxCollider)

			if boxCollider then
				boxCollider.enabled = true
			end

			go.transform:SetParent(nil)
		end

		self._bossUnit.scene.resCache:recycleObject(self._resObject)

		self._resObject = nil
	end
end

function SeasonPVES2BossController:startBattle()
	self._startbattle = true
end

function SeasonPVES2BossController:endBattle()
	self._startbattle = false
end

function SeasonPVES2BossController:doCheckLogic()
	self:endBattle()
	SeasonPVES2BossController.super.doCheckLogic(self)
end

function SeasonPVES2BossController:checkDoppelgangerPopup(teamId, id)
	return
end

SeasonPVES2BossController.instance = SeasonPVES2BossController.New()

return SeasonPVES2BossController
