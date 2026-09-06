-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiunuo/controller/DivineXiuNuoController.lua

module("logic.extensions.divinexiunuo.controller.DivineXiuNuoController", package.seeall)

local DivineXiuNuoController = class("DivineXiuNuoController", BaseController)

DivineXiuNuoController.SPECIAL_PHASE_ID = 3

function DivineXiuNuoController:onInit()
	self:onReset()
end

function DivineXiuNuoController:onReset()
	self._fmtMo = DivineXiuNuoFmtMo.New()
end

function DivineXiuNuoController:getActivityId()
	return 395001
end

function DivineXiuNuoController:sendGetInfo(activityId)
	DivineXiuNuoClgAgent.instance:sendPM_DivineXiuNuoClgGetInfoReq(activityId)
end

function DivineXiuNuoController:onGetInfo(msg)
	DivineXiuNuoModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DIVINE_XIUNUO_INFO_UPDATE)
end

function DivineXiuNuoController:sendResetStage(activityId, phaseId, stageId)
	DivineXiuNuoClgAgent.instance:sendPM_DivineXiuNuoClgResetStageReq(activityId, stageId)
end

function DivineXiuNuoController:onResetStage(msg)
	DivineXiuNuoModel.instance:onResetStage(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DIVINE_XIUNUO_INFO_UPDATE)
end

function DivineXiuNuoController:openFmtView(activityId, phaseId, stageId)
	self._fmtMo:initParams(activityId, phaseId, stageId)
	CustomFmtController.instance:showMissionView(self._fmtMo)
end

function DivineXiuNuoController:sendStartFight(activityId, stageId, form)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onNorBattleEnd, self, activityId))
	DivineXiuNuoClgAgent.instance:sendPM_DivineXiuNuoClgFightReq(activityId, stageId, form)
end

function DivineXiuNuoController:handleFightRes(msg)
	DivineXiuNuoModel.instance:handleFightRes(msg)
end

function DivineXiuNuoController:_onNorBattleEnd(activityId)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local pb = DivineXiuNuoModel.instance:getFightPb(activityId)

	if pb then
		if pb.win then
			local info = DivineXiuNuoModel.instance:getInfo(activityId) or {}
			local curPhaseId = checknumber(info.curPhaseId)
			local curFightStageId = checknumber(info.curFightStageId)
			local list = DivineXiuNuoConfig.instance:getPhaseListById(activityId) or {}

			if curPhaseId > #list then
				UIJumper.instance:removeTopState(ViewName.DivinexiunuolevelView)
			end

			if pb.curFightPhaseId == DivineXiuNuoController.SPECIAL_PHASE_ID then
				UIStateManager.instance:push(ViewName.DivinexiunuoresultlView, pb)

				return true
			else
				local groupCfg = DivineXiuNuoConfig.instance:getStageCfgById(activityId, pb.curFightPhaseId, pb.curFightStageId) or {}
				local supportPetId = checknumber(groupCfg.creepsId)
				local supportCfg = DivineXiuNuoConfig.instance:getSupportCfgById(activityId, supportPetId)
				local name = MaterialMgr.getMaterialsName(MatType.Pet, supportCfg.raceId)

				BattleSettlementController.instance:addDefaultConditions()
				BattleSettlementController.instance:addConditionElement(langPara("助战精灵%s存活", name), pb.win)
			end
		elseif pb.curFightPhaseId ~= DivineXiuNuoController.SPECIAL_PHASE_ID then
			local groupCfg = DivineXiuNuoConfig.instance:getStageCfgById(activityId, pb.curFightPhaseId, pb.curFightStageId) or {}
			local supportPetId = checknumber(groupCfg.creepsId)
			local supportCfg = DivineXiuNuoConfig.instance:getSupportCfgById(activityId, supportPetId)
			local name = MaterialMgr.getMaterialsName(MatType.Pet, supportCfg.raceId)

			BattleSettlementController.instance:addDefaultConditions()
			BattleSettlementController.instance:addConditionElement(langPara("助战精灵%s存活", name), false)
			UIStateManager.instance:open(ViewName.BattleSettlementFail)

			return true
		end
	end

	return false
end

DivineXiuNuoController.instance = DivineXiuNuoController.New()

return DivineXiuNuoController
