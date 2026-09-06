-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/evt/impl/season2/SeasonEvtBossS2.lua

module("logic.extensions.season.model.evt.impl.season2.SeasonEvtBossS2S2", package.seeall)

local SeasonEvtBossS2 = class("SeasonEvtBossS2", SeasonEvtBase)

function SeasonEvtBossS2:_doClient(teamId, evtType, params, evtConfig, evtDetailConfig)
	local seasonId = SeasonModel.instance:getSeasonId()
	local config = SeasonConfig.instance:getMapEvtDetail(seasonId, self._evtConfig.eventType, self._evtConfig.eventId) or {}
	local creepsMasterId = config.creepsMasterId
	local creepsTeam = SeasonConfig.instance:getCreepTeam(creepsMasterId)
	local var_1_0 = {}

	var_1_0.recommendZdl = creepsTeam.recommendZdl or 0
	var_1_0.strSure = lang("挑战")
	var_1_0.teamId = teamId

	function var_1_0.sureCallback()
		self:_doEnterFightPrepare()
	end

	UIStateManager.instance:push(ViewName.SeasonS2BossChallengeView, var_1_0)
	self:rollBackPosition()
end

function SeasonEvtBossS2:_doEnterFightPrepare()
	printInfo(".......................SeasonEvtBossS2:_doEnterFightPrepare")
	SeasonFmtController.instance:showFightView(self._teamId, self._evtConfig.eventType, self._evtConfig.eventId, self._evtConfig.id)
end

function SeasonEvtBossS2:_doServer(evtType, params, evtConfig, evtDetailConfig, msg)
	if msg.bossBtlResult ~= nil then
		SeasonPVEBossController.instance:saveBossBattleResults(msg.bossBtlResult)
		SeasonPVEBossController.instance:startBossBattle()
	end

	if not string.nilorempty(msg.resultParam) then
		local resultJson = GameUtil.jsonToTable(msg.resultParam)

		if resultJson and resultJson.isWin ~= nil then
			BattleSettlementModel.instance:setRewardChangeSetId(msg.changeSetId)
			SeasonPVES2BossController.instance:checkNextBossStory(evtConfig.id)
			self:applyDestroy()
		end
	end
end

function SeasonEvtBossS2:applySendHandlerEvent(params)
	SeasonPVES2BossController.instance:startBattle()

	params = params or {}
	params.teams = SeasonFmtController.instance.seasonFmtMo:getBossTeamSortList()

	SeasonPVEBossController.instance:saveBossTeamSortList(params.teams)
	SeasonEvtBossS2.super.applySendHandlerEvent(self, params)
end

return SeasonEvtBossS2
