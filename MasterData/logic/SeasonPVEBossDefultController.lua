-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/controller/SeasonPVEBossDefultController.lua

module("logic.extensions.season.controller.SeasonPVEBossDefultController", package.seeall)

local SeasonPVEBossDefultController = class("SeasonPVEBossDefultController", BaseController)

function SeasonPVEBossDefultController:onInit()
	self:onReset()
end

function SeasonPVEBossDefultController:onReset()
	self._cacheSendDoppelgangerResetTeamId = nil
	self._fmtSeq = {}
	self._isCacheNotify = false
	self._battleIndex = 0
end

function SeasonPVEBossDefultController:saveBossBattleResults(array)
	self._battleIndex = 0
	self._bossBattleResults = array
end

function SeasonPVEBossDefultController:startBossBattle()
	if self._bossBattleResults then
		self._battleIndex = self._battleIndex + 1

		local btlResult = self._bossBattleResults[self._battleIndex]

		BattleFacade.instance:startSeasonPVEBossBattle()
		BattleController.instance:viewUserFightMonsterBtlResult(btlResult, false)
	end
end

function SeasonPVEBossDefultController:tryNextBattle()
	if self._bossBattleResults then
		self._battleIndex = self._battleIndex + 1

		local btlResult = self._bossBattleResults[self._battleIndex]

		print("SeasonPVEBossDefultController:tryNextBattle idx = " .. self._battleIndex .. "len = " .. #self._bossBattleResults)

		if btlResult ~= nil then
			BattleFacade.instance:startSeasonPVEBossBattle()
			BattleController.instance:onBattleContinue(btlResult)

			return true
		end
	end

	return false
end

function SeasonPVEBossDefultController:getBossTeamSortList()
	local teams = SeasonTeamsModel.instance:getTeams()
	local oldTeamIdMap = {}
	local newTeamIdMap = {}

	for _, v in ipairs(self._fmtSeq) do
		oldTeamIdMap[v] = true
	end

	for _, teamMo in ipairs(teams) do
		newTeamIdMap[teamMo.teamId] = true
	end

	for i = #self._fmtSeq, 0, -1 do
		if not newTeamIdMap[self._fmtSeq[i]] then
			table.remove(self._fmtSeq, i)
		end
	end

	for i, v in pairs(newTeamIdMap) do
		if not oldTeamIdMap[i] then
			table.insert(self._fmtSeq, i)
		end
	end

	return self._fmtSeq
end

function SeasonPVEBossDefultController:saveBossTeamSortList(list)
	self._fmtSeq = list
end

function SeasonPVEBossDefultController:initConfig()
	local seasonId = SeasonModel.instance:getSeasonId()

	self._configs = SeasonConfig.instance:getBossPhaseConfigs(seasonId) or {}
	self._bossMo = SeasonModel.instance.bossMo

	local pevCfg = SeasonConfig.instance:getSeasonPVEConfig(SeasonModel.instance:getSeasonId())

	self._doppelgangerPhaseId = checknumber(pevCfg.bossDoppelgangerPhaseId)
	self._bossPhaseId = checknumber(pevCfg.bossPhaseId)
	self._checkPositionCache = {}
end

function SeasonPVEBossDefultController:getBossPhaseId()
	return self._bossPhaseId
end

function SeasonPVEBossDefultController:getDoppelgangerPhaseId()
	return self._doppelgangerPhaseId
end

function SeasonPVEBossDefultController:getBlockStates()
	local doppelgangerTargetPointIds = self:getDoppelgangerReadOnlyPointIds() or {}
	local map = {}
	local isNeedBlock = self._bossMo.phaseId < self._doppelgangerPhaseId

	for i, v in ipairs(doppelgangerTargetPointIds) do
		map[v] = isNeedBlock
	end

	local bossTargetPointId = self:getBossReadOnlyPointId() or -1

	map[bossTargetPointId] = self._bossMo.phaseId < self._bossPhaseId

	return map
end

function SeasonPVEBossDefultController:getDoppelgangerReadOnlyPointIds()
	local config = self._configs[self._doppelgangerPhaseId]

	return (config or nil) and (config.targetPointIds or {})
end

function SeasonPVEBossDefultController:getBossReadOnlyPointId()
	local config = self._configs[self._bossPhaseId]

	return (config and config.targetPointIds and config.targetPointIds[1] or nil) and config.targetPointIds[1]
end

function SeasonPVEBossDefultController:checkNextPhase()
	if not self._bossMo then
		return
	end

	if not self._configs[self._bossMo.phaseId] then
		local config = {}

		if not checkbool(config.purePlot) then
			if not string.nilorempty(config.positions) then
				if self._doppelgangerPhaseId == self._bossMo.phaseId then
					self:_checkDoppelgangerPosition(config)
				end
			elseif config.targetPointIds then
				-- block empty
			else
				self._bossMo:updateCurPhaseProgress(self._bossMo.phaseId, 1, 1)
			end
		else
			self._bossMo:updateCurPhaseProgress(self._bossMo.phaseId, 1, 1)
		end
	end
end

function SeasonPVEBossDefultController:checkDoppelgangerPopup(teamId, id)
	if self._doppelgangerPhaseId == self._bossMo.phaseId then
		local pointIds = self:getDoppelgangerReadOnlyPointIds()

		for i = 1, #pointIds do
			if pointIds[i] == id then
				local key = "season_pve_boss" .. pointIds[i]
				local isHasMove = GameUtil.getUserData(key)

				if not isHasMove then
					GameUtil.saveUserData(key, true)

					local seasonId = SeasonModel.instance:getSeasonId()
					local evtConfig = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, id) or {}

					UIStateManager.instance:push(ViewName.SeasonBossDetailView, {
						strSure = lang("挑战"),
						evtConfig = evtConfig,
						evtDetailConfig = (evtConfig.eventId or nil) and (SeasonConfig.instance:getMapEvtDetail(seasonId, evtConfig.eventType, evtConfig.eventId) or {})
					})
				end

				break
			end
		end
	end
end

function SeasonPVEBossDefultController:_checkDoppelgangerPosition(config)
	local maxProgress = #config.targetPointIds
	local progress = self._bossMo:getDoppelgangerLockCount()

	self._bossMo:updateCurPhaseProgress(self._bossMo.phaseId, progress, maxProgress)
end

function SeasonPVEBossDefultController:_parseGroup(str)
	local isAny = false
	local members = {}

	if str == "*" then
		isAny = true
	else
		members = string.splitToNumber(str, ",")
	end

	return isAny, members
end

function SeasonPVEBossDefultController:handleSMPVEPushBossPhaseRes(status, msg)
	if status == 0 then
		SeasonModel.instance:updateBossInfo(msg.curBossInfo)
	end
end

function SeasonPVEBossDefultController:_doBeforeLogicAnim(config, callback)
	if config and config.storyIds ~= nil then
		SeasonPVEBossStoryHandler.instance:play(config.storyIds, callback)
	else
		GameUtil.callBack(callback)
	end
end

function SeasonPVEBossDefultController:_doLogicAnim(config, callback)
	local function doNext()
		GameUtil.callBack(callback)
	end

	local scene = SceneMgr.instance:getCurScene()

	if self._doppelgangerPhaseId == self._bossMo.phaseId then
		if scene and scene.eventsAnimation then
			scene.eventsAnimation:playBoss2Doppelganger(doNext)
		else
			doNext()
		end
	elseif self._bossPhaseId == self._bossMo.phaseId then
		if scene and scene.eventsAnimation then
			scene.eventsAnimation:playDoppelganger2Boss(function()
				doNext()
			end)
		else
			doNext()
		end
	else
		doNext()
	end
end

function SeasonPVEBossDefultController:_doAfterLogicAnim(config, callback)
	if config and config.storyIdsAfterLogic ~= nil then
		SeasonPVEBossStoryHandler.instance:play(config.storyIdsAfterLogic, callback)
	else
		GameUtil.callBack(callback)
	end
end

function SeasonPVEBossDefultController:doCheckLogic()
	if SeasonModel.instance:isLoadAllMapServerInfo() then
		if self._isCacheNotify and self._bossMo then
			self._isCacheNotify = false

			self:_doLogic()

			if checknumber(self._isCacheSingleId) > 0 then
				local story = checknumber(self._isCacheSingleId)

				self:_playSingleStory(story)
			end

			return
		end

		if checknumber(self._isCacheSingleId) > 0 then
			local story = checknumber(self._isCacheSingleId)

			self:_playSingleStory(story)

			return
		end

		if self._isStoryInLocalBattle == true then
			self._isStoryInLocalBattle = false

			GlobalDispatcher:dispatch(GlobalNotify.SeasonBattleStoryEnd)

			return
		end

		if SeasonAutoFightController.instance:isAutoFight() then
			SeasonAutoFightController.instance:onStartTimer()

			return
		end
	end
end

function SeasonPVEBossDefultController:_doLogic()
	local config = self._configs[self._bossMo.phaseId]

	if config then
		self:_doBeforeLogicAnim(config, function()
			self:_doLogicAnim(config, function()
				self:_doAfterLogicAnim(config, function()
					self:_doAfterLogic(config)
				end)
			end)
		end)
	end
end

function SeasonPVEBossDefultController:_doAfterLogic(config)
	if not string.nilorempty(config.openView) then
		local strs = string.split(config.openView, "#")

		if strs and #strs >= 2 then
			UIStateManager.instance:push(strs[1], strs[2])
		else
			UIStateManager.instance:push(config.openView)
		end
	end

	self:doCheckLogic()
end

function SeasonPVEBossDefultController:handleNotifySMPVEBossPhaseNextStepRes(status, msg)
	if status == 0 then
		SeasonModel.instance:updateBossInfo(msg.curBossInfo)

		local seasonController = SeasonController.instance
		local teamJumps = checktable(msg.teamJumps)

		for i = 1, #teamJumps do
			local teamId = teamJumps[i].teamId
			local curPosition = teamJumps[i].curPosition

			seasonController:onServerLeaderPosChanged(teamId, curPosition)
		end

		if self._bossPhaseId + 1 == self._bossMo.phaseId or self._doppelgangerPhaseId + 1 == self._bossMo.phaseId then
			self._isCacheNotify = true
		else
			self:_doLogic()
		end
	end
end

function SeasonPVEBossDefultController:sendDoppelgangerResetTeam(teamId)
	self._cacheSendDoppelgangerResetTeamId = teamId

	SeasonModePveAgent.instance:sendPM_SMPVEBossDoppelgangerResetTeamReq(teamId)
end

function SeasonPVEBossDefultController:handleSMPVEBossDoppelgangerResetTeamRes(status, msg)
	if status == 0 then
		SeasonModel.instance:updateResetBossLockTeam(self._cacheSendDoppelgangerResetTeamId)

		self._cacheSendDoppelgangerResetTeamId = nil
	end
end

function SeasonPVEBossDefultController:handleSMPVENotifyTeamLockRes(status, msg)
	if status == 0 then
		SeasonModel.instance:updateBossLockTeam(msg)

		self._cacheSendDoppelgangerResetTeamId = nil
	end
end

function SeasonPVEBossDefultController:isCanFight(model, controller, gridX, gridY)
	local teams = model:getTeams()
	local isAllNearBy = true

	for i, v in ipairs(teams) do
		local teamGridX, teamGridY = v:getServerCurGridXY()

		if not controller:isGridNearBy(gridX, gridY, teamGridX, teamGridY) then
			isAllNearBy = false

			break
		end
	end

	if isAllNearBy then
		return true
	else
		FloatWordMgr.instance:show(lang("所有队伍必须在Boss附近"))
	end

	return false
end

function SeasonPVEBossDefultController:isCanDoEvent(evtConfig)
	if evtConfig.eventType == SeasonGridEvtTypes.EVT_BOSS_DOPPELGANGER then
		if SeasonPVEBossController.instance:getDoppelgangerPhaseId() == self._bossMo.phaseId and not self._bossMo:isDoppelgangerLockByGridId(evtConfig.id) then
			return true
		else
			return false
		end
	elseif evtConfig.eventType == SeasonGridEvtTypes.EVT_BOSS then
		if SeasonPVEBossController.instance:getBossPhaseId() == self._bossMo.phaseId then
			return true
		else
			return false
		end
	else
		return true
	end
end

function SeasonPVEBossDefultController:handleOpViewChallenge(seasonId, evtConfig, evtDetailConfig)
	if evtDetailConfig.isElite == true then
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

function SeasonPVEBossDefultController:_handleOpViewBossEvent(seasonId, evtConfig, evtDetailConfig)
	local config = SeasonConfig.instance:getMapEvtDetail(seasonId, evtConfig.eventType, evtConfig.eventId) or {}
	local creepsMasterId = config.creepsMasterId
	local creepsTeam = SeasonConfig.instance:getCreepTeam(creepsMasterId)
	local var_37_0 = {
		bHideSure = true
	}

	var_37_0.recommendZdl = creepsTeam.recommendZdl or 0

	UIStateManager.instance:push(ViewName.SeasonBossChallengeView, var_37_0)
end

function SeasonPVEBossDefultController:_playSingleStory(id)
	SeasonPVEBossStoryHandler.instance:play({
		id
	})

	self._isCacheSingleId = 0
end

function SeasonPVEBossDefultController:setLocalBattle()
	self._isStoryInLocalBattle = true
end

function SeasonPVEBossDefultController:getCurBattleResultIdx()
	return self._battleIndex - 1
end

SeasonPVEBossDefultController.instance = SeasonPVEBossDefultController.New()

return SeasonPVEBossDefultController
