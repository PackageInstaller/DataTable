-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/evt/impl/SeasonEvtBoss.lua

module("logic.extensions.season.model.evt.impl.SeasonEvtBoss", package.seeall)

local SeasonEvtBoss = class("SeasonEvtBoss", SeasonEvtBase)

function SeasonEvtBoss:_doClient(teamId, evtType, params, evtConfig, evtDetailConfig)
	local seasonId = SeasonModel.instance:getSeasonId()
	local config = SeasonConfig.instance:getMapEvtDetail(seasonId, self._evtConfig.eventType, self._evtConfig.eventId) or {}
	local creepsMasterId = config.creepsMasterId
	local creepsTeam = SeasonConfig.instance:getCreepTeam(creepsMasterId)
	local var_1_0 = {}

	var_1_0.recommendZdl = creepsTeam.recommendZdl or 0
	var_1_0.strSure = lang("挑战")

	function var_1_0.sureCallback()
		self:_doEnterFightPrepare()
	end

	UIStateManager.instance:push(ViewName.SeasonBossChallengeView, var_1_0)
	self:rollBackPosition()
end

function SeasonEvtBoss:_doEnterFightPrepare()
	printInfo(".......................SeasonEvtBoss:_doEnterFightPrepare")
	SeasonFmtController.instance:showFightView(self._teamId, self._evtConfig.eventType, self._evtConfig.eventId, self._evtConfig.id)
end

function SeasonEvtBoss:_doServer(evtType, params, evtConfig, evtDetailConfig, msg)
	if msg.bossBtlResult ~= nil then
		SeasonPVEBossController.instance:saveBossBattleResults(msg.bossBtlResult)
		SeasonPVEBossController.instance:startBossBattle()
	end

	if not string.nilorempty(msg.resultParam) then
		local resultJson = GameUtil.jsonToTable(msg.resultParam)

		if resultJson and resultJson.isWin ~= nil then
			BattleSettlementModel.instance:setRewardChangeSetId(msg.changeSetId)
			self:applyDestroy()
		end
	end
end

function SeasonEvtBoss:applySendHandlerEvent(params)
	params = params or {}
	params.teams = SeasonFmtController.instance.seasonFmtMo:getBossTeamSortList()

	SeasonPVEBossController.instance:saveBossTeamSortList(params.teams)
	SeasonEvtBoss.super.applySendHandlerEvent(self, params)
end

return SeasonEvtBoss
