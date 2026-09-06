-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/controller/SeasonPVEBossController.lua

module("logic.extensions.season.controller.SeasonPVEBossController", package.seeall)

local SeasonPVEBossController = class("SeasonPVEBossController", BaseController)

function SeasonPVEBossController:onInit()
	self:onReset()
end

function SeasonPVEBossController:onReset()
	self._cacheSendDoppelgangerResetTeamId = nil
	self._fmtSeq = {}
	self._isCacheNotify = false
	self._battleIndex = 0
	self._seasonBossController = SeasonPVEBossDefultController.instance
	self._seasonControllerClassMap = {
		SeasonPVES1BossController,
		SeasonPVES2BossController,
		SeasonPVES3BossController
	}

	self:refreshController()
end

function SeasonPVEBossController:saveBossBattleResults(array)
	self:refreshController()
	self._seasonBossController:saveBossBattleResults(array)
end

function SeasonPVEBossController:startBossBattle()
	self:refreshController()
	self._seasonBossController:startBossBattle()
end

function SeasonPVEBossController:tryNextBattle()
	self:refreshController()

	return self._seasonBossController:tryNextBattle()
end

function SeasonPVEBossController:getBossTeamSortList()
	self:refreshController()

	return self._seasonBossController:getBossTeamSortList()
end

function SeasonPVEBossController:saveBossTeamSortList(list)
	self:refreshController()
	self._seasonBossController:saveBossTeamSortList(list)
end

function SeasonPVEBossController:initConfig()
	self:refreshController()
	self._seasonBossController:initConfig()
end

function SeasonPVEBossController:getBossPhaseId()
	self:refreshController()

	return self._seasonBossController:getBossPhaseId()
end

function SeasonPVEBossController:getDoppelgangerPhaseId()
	self:refreshController()

	return self._seasonBossController:getDoppelgangerPhaseId()
end

function SeasonPVEBossController:getBlockStates()
	self:refreshController()

	return self._seasonBossController:getBlockStates()
end

function SeasonPVEBossController:getDoppelgangerReadOnlyPointIds()
	self:refreshController()

	return self._seasonBossController:getDoppelgangerReadOnlyPointIds()
end

function SeasonPVEBossController:getBossReadOnlyPointId()
	self:refreshController()

	return self._seasonBossController:getBossReadOnlyPointId()
end

function SeasonPVEBossController:checkNextPhase()
	self:refreshController()
	self._seasonBossController:checkNextPhase()
end

function SeasonPVEBossController:checkDoppelgangerPopup(teamId, id)
	self:refreshController()
	self._seasonBossController:checkDoppelgangerPopup(teamId, id)
end

function SeasonPVEBossController:handleSMPVEPushBossPhaseRes(status, msg)
	self:refreshController()
	self._seasonBossController:handleSMPVEPushBossPhaseRes(status, msg)
end

function SeasonPVEBossController:doCheckLogic()
	self:refreshController()

	return self._seasonBossController:doCheckLogic()
end

function SeasonPVEBossController:handleNotifySMPVEBossPhaseNextStepRes(status, msg)
	self:refreshController()
	self._seasonBossController:handleNotifySMPVEBossPhaseNextStepRes(status, msg)
end

function SeasonPVEBossController:sendDoppelgangerResetTeam(teamId)
	self:refreshController()
	self._seasonBossController:sendDoppelgangerResetTeam(teamId)
end

function SeasonPVEBossController:handleSMPVEBossDoppelgangerResetTeamRes(status, msg)
	self:refreshController()
	self._seasonBossController:handleSMPVEBossDoppelgangerResetTeamRes(status, msg)
end

function SeasonPVEBossController:handleSMPVENotifyTeamLockRes(status, msg)
	self:refreshController()
	self._seasonBossController:handleSMPVENotifyTeamLockRes(status, msg)
end

function SeasonPVEBossController:isCanFight(model, controller, gridX, gridY)
	self:refreshController()

	return self._seasonBossController:isCanFight(model, controller, gridX, gridY)
end

function SeasonPVEBossController:isCanDoEvent(evtConfig)
	self:refreshController()

	return self._seasonBossController:isCanDoEvent(evtConfig)
end

function SeasonPVEBossController:handleOpViewChallenge(seasonId, evtConfig, evtDetailConfig)
	self:refreshController()

	return self._seasonBossController:handleOpViewChallenge(seasonId, evtConfig, evtDetailConfig)
end

function SeasonPVEBossController:_handleOpViewBossEvent(seasonId, evtConfig, evtDetailConfig)
	self:refreshController()

	return self._seasonBossController:_handleOpViewBossEvent(seasonId, evtConfig, evtDetailConfig)
end

function SeasonPVEBossController:refreshController()
	if self._seasonControllerClassMap[SeasonModel.instance:getSeasonId()] then
		self._seasonBossController = self._seasonControllerClassMap[SeasonModel.instance:getSeasonId()].instance
	end
end

function SeasonPVEBossController:setLocalBattle()
	self:refreshController()
	self._seasonBossController:setLocalBattle()
end

function SeasonPVEBossController:getCurBattleResultIdx()
	self:refreshController()

	return self._seasonBossController:getCurBattleResultIdx()
end

SeasonPVEBossController.instance = SeasonPVEBossController.New()

return SeasonPVEBossController
