-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gulas/controller/GulasController.lua

module("logic.extensions.gulas.controller.GulasController", package.seeall)

local GulasController = class("GulasController", BaseController)

function GulasController:onInit()
	self:onReset()
end

function GulasController:onReset()
	self._fmtMo = GulasFmtMo.New()
	self._tempChangeSetId = nil
	self._levelView = nil
end

function GulasController:getActivityId()
	return 437001
end

function GulasController:sendGetInfo(activityId)
	GulasClgAgent.instance:sendPM_GulasClgGetInfoReq(activityId)
end

function GulasController:onGetInfo(msg)
	GulasModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GULAS_CLG_INFO_UPDATE)
end

function GulasController:sendResetStage(activityId, phaseId, stageId)
	GulasClgAgent.instance:sendPM_GulasClgResetStageReq(activityId, phaseId, stageId)
end

function GulasController:onResetStage(msg)
	GulasModel.instance:onResetStage(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GULAS_CLG_INFO_UPDATE)
end

function GulasController:tryShowChangeSet()
	if self._tempChangeSetId then
		MaterialController.instance:showChangeSetInTemp(self._tempChangeSetId)

		self._tempChangeSetId = nil
	end
end

function GulasController:openFmtView(activityId, phaseId, stageId, extView, levelView)
	self._levelView = levelView

	self._fmtMo:initParams(activityId, phaseId, stageId, extView)
	CustomFmtController.instance:showMissionView(self._fmtMo)
end

function GulasController:sendStartFight(activityId, phaseId, stageId, form_pb)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onNorBattleEnd, self, activityId))
	GulasClgAgent.instance:sendPM_GulasClgChallengeReq(activityId, phaseId, stageId, form_pb)
end

function GulasController:handleFightRes(msg)
	GulasModel.instance:handleFightRes(msg)
end

function GulasController:_onNorBattleEnd(activityId)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local pb = GulasModel.instance:getFightPb(activityId)

	if pb and pb.win then
		local info = GulasModel.instance:getInfo(activityId) or {}
		local passPhaseId = checknumber(info.passPhaseId)

		if not pb.lockRaceIds then
			if not pb.lockRaceIds.list then
				local list = {}

				if #list == 0 then
					passPhaseId = passPhaseId + 1
				end

				local cfgList = GulasConfig.instance:getPhaseCfgListById(activityId) or {}

				if passPhaseId >= #cfgList then
					if self._levelView then
						UIJumper.instance:removeTopState(self._levelView)

						self._levelView = nil
					end

					CustomFmtController.instance:showCommonPassViewWithJump(pb.changeSetId)
				end
			end
		end
	end

	return false
end

GulasController.instance = GulasController.New()

return GulasController
