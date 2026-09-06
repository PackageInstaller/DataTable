-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/evt/SeasonEvtHandler.lua

module("logic.extensions.season.model.evt.SeasonEvtHandler", package.seeall)

local SeasonEvtHandler = class("SeasonEvtHandler")

function SeasonEvtHandler:ctor()
	return
end

function SeasonEvtHandler:reset()
	self._evtHandleImplClassMap = {
		[SeasonGridEvtTypes.EVT_CHALLENGE] = SeasonEvtChallenge,
		[SeasonGridEvtTypes.EVT_MATERIAL] = SeasonEvtMaterial,
		[SeasonGridEvtTypes.EVT_PLOT] = SeasonEvtPlayPlot,
		[SeasonGridEvtTypes.EVT_MEDAL] = SeasonEvtMedal,
		[SeasonGridEvtTypes.EVT_CONVEY] = SeasonEvtConvey,
		[SeasonGridEvtTypes.EVT_MAP_LOCK] = SeasonEvtUnLock,
		[SeasonGridEvtTypes.EVT_WOODEN_STAKE] = SeasonEvtWooden,
		[SeasonGridEvtTypes.EVT_GAME] = SeasonEvtPlayGame,
		[SeasonGridEvtTypes.EVT_RAINBOW] = SeasonEvtRainbow,
		[SeasonGridEvtTypes.EVT_BOSS_DOPPELGANGER] = SeasonEvtBossDoppelganger,
		[SeasonGridEvtTypes.EVT_BOSS] = SeasonEvtBoss,
		[SeasonGridEvtTypes.EVT_HIRE_PET] = SeasonEvtHirePet,
		[SeasonGridEvtTypes.EVT_FIND_KEY] = SeasonEvtFindKey,
		[SeasonGridEvtTypes.EVT_DANCE_LION] = SeasonEvtDanceLion
	}
	self._evtHandleImplMap = {}

	local evtHandleImplChangeMap = {
		[2] = {
			[SeasonGridEvtTypes.EVT_BOSS] = SeasonEvtBossS2,
			[SeasonGridEvtTypes.EVT_CHALLENGE] = SeasonEvtChallengeS2
		}
	}

	if evtHandleImplChangeMap[SeasonModel.instance:getSeasonId()] then
		for i, v in pairs(evtHandleImplChangeMap[SeasonModel.instance:getSeasonId()]) do
			self._evtHandleImplClassMap[i] = v
		end
	end
end

function SeasonEvtHandler:_getHandlerImpl(id, evtType)
	if not self._evtHandleImplMap[id] then
		local cls = self._evtHandleImplClassMap[evtType]

		if cls then
			self._evtHandleImplMap[id] = cls.New()
		end
	end

	return self._evtHandleImplMap[id]
end

function SeasonEvtHandler:removeImpl(id)
	self._evtHandleImplMap[id] = nil
end

function SeasonEvtHandler:_handleClient(teamId, evtType, params, evtConfig, evtDetailConfig)
	local isCanSend = true

	if evtType ~= SeasonGridEvtTypes.EVT_CHALLENGE and SeasonAutoFightController.instance:isAutoFight() then
		SeasonAutoFightController.instance:stopAutoFight()

		isCanSend = false
	end

	if not SeasonOpHandler.instance:checkCanMoveAndShowTips(params.id) then
		SeasonAutoFightController.instance:stopAutoFight()

		isCanSend = false
	end

	local impl = self:_getHandlerImpl(params.id, evtType)

	if impl then
		if isCanSend then
			impl:reset()
			impl:doClient(teamId, evtType, params, evtConfig, evtDetailConfig)
		else
			self:rollBackPosition(teamId)
		end
	end
end

function SeasonEvtHandler:_handleServer(evtType, params, evtConfig, evtDetailConfig, msg)
	local impl = self._evtHandleImplMap[params.id]

	if impl then
		impl:doServer(evtType, params, evtConfig, evtDetailConfig, msg)
	end
end

function SeasonEvtHandler:_buildParams(toGridX, toGridY, id)
	local teamModel = SeasonTeamsModel.instance
	local teamId = teamModel:getCurrTeamId()
	local teamMo = teamModel:getTeam(teamId)
	local clientCurGridX, clientCurGridY = teamMo:getClientCurGridXY()

	return {
		teamId = teamId,
		fromGridX = clientCurGridX,
		fromGridY = clientCurGridY,
		toGridX = toGridX,
		toGridY = toGridY,
		id = id
	}
end

function SeasonEvtHandler:handleEvtByClient(teamId, toGridX, toGridY)
	local seasonModel = SeasonModel.instance
	local id = SeasonPathFindingDataModel.instance:grid2Id(toGridX, toGridY)
	local seasonId = seasonModel:getSeasonId()
	local evtConfig = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, id) or {}

	if not evtConfig.eventType then
		local evtType = SeasonGridEvtTypes.EVT_EMPTY
		local params = self:_buildParams(toGridX, toGridY, id)

		self:_handleClient(teamId, evtType, params, evtConfig, (evtConfig.eventId or nil) and (SeasonConfig.instance:getMapEvtDetail(seasonId, evtType, evtConfig.eventId) or {}))
	end
end

function SeasonEvtHandler:handleEvtByServer(msg)
	local seasonModel = SeasonModel.instance
	local toGridX, toGridY = SeasonPathFindingDataModel.instance:id2Grid(msg.targetPointId)
	local seasonId = seasonModel:getSeasonId()
	local evtConfig = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, msg.targetPointId) or {}

	if not evtConfig.eventType then
		local evtType = SeasonGridEvtTypes.EVT_EMPTY
		local params = self:_buildParams(toGridX, toGridY, msg.targetPointId)

		self:_handleServer(evtType, params, evtConfig, (evtConfig.eventId or nil) and (SeasonConfig.instance:getMapEvtDetail(seasonId, evtType, evtConfig.eventId) or {}), msg)
	end
end

function SeasonEvtHandler:handleEvtByServerFail(gridId)
	local impl = self._evtHandleImplMap[gridId]

	if impl then
		impl:onServerFail()
		impl:applyDestroy()
	end
end

function SeasonEvtHandler:applyTriggerEvt(id, params)
	local impl = self._evtHandleImplMap[id]

	if impl then
		impl:applySendHandlerEvent(params)
	end
end

function SeasonEvtHandler:rollBackPosition(teamId)
	if teamId then
		local teamMo = SeasonTeamsModel.instance:getTeam(teamId)

		if teamMo then
			teamMo:backSetPosition()
		end

		local scene = SceneMgr.instance:getCurScene()

		if scene and scene.leaders then
			scene.leaders:tryDepartTeamsPos()
		end
	end
end

SeasonEvtHandler.instance = SeasonEvtHandler.New()

return SeasonEvtHandler
