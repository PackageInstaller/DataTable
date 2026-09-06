-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhuociyuan/control/OriginHuociyuanController.lua

module("logic.extensions.originhuociyuan.control.OriginHuociyuanController", package.seeall)

local OriginHuociyuanController = class("OriginHuociyuanController", BaseController)

function OriginHuociyuanController:onInit()
	self:onReset()
end

function OriginHuociyuanController:onReset()
	self._fmtMoMap = {}
	self._lastSelectIdx = -1
end

function OriginHuociyuanController:setLastIdx(idx)
	self._lastSelectIdx = idx
end

function OriginHuociyuanController:getLastIdx()
	return self._lastSelectIdx
end

function OriginHuociyuanController:sendGetInfo(activityId)
	OriginFireDimensionAgent.instance:sendPM_OriginFireDimensionInfoReq(activityId)
end

function OriginHuociyuanController:onGetInfo(msg)
	OriginHuociyuanModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ORIGIN_HUOCIYUAN_INFO_UPDATE)
end

function OriginHuociyuanController:sendResetFight(activityId, stageId)
	OriginFireDimensionAgent.instance:sendPM_OriginFireDimensionResetReq(activityId, stageId)
end

function OriginHuociyuanController:onResetFight(msg)
	OriginHuociyuanModel.instance:onResetFight(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ORIGIN_HUOCIYUAN_INFO_UPDATE)
end

function OriginHuociyuanController:showCI()
	MaterialController.instance:showChangeSetInTemp(self._temChangeSetId)

	self._temChangeSetId = nil
end

function OriginHuociyuanController:openFmtView(activityId, stageId, extView, resultView)
	self._resultViewName = resultView
	self._fmtMoMap[activityId] = self._fmtMoMap[activityId] or OriginHuociyuanFmtMo.New()

	local fmtMo = self._fmtMoMap[activityId]

	fmtMo:initParams(activityId, stageId, extView)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function OriginHuociyuanController:sendStartFight(activityId, stageId, buffIds, form_pb)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onNorBattleEnd, self, activityId, stageId))
	OriginFireDimensionAgent.instance:sendPM_OriginFireDimensionClgReq(activityId, stageId, buffIds, form_pb)
end

function OriginHuociyuanController:handleFightRes(msg)
	OriginHuociyuanModel.instance:handleFightRes(msg)
end

function OriginHuociyuanController:_onNorBattleEnd(activityId, stageId)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local pb = OriginHuociyuanModel.instance:getFightPb(activityId)

	if pb and pb.win then
		local stageList = OriginHuociyuanConfig.instance:getStageListCfgById(activityId) or {}
		local isPass = true

		for i, v in ipairs(stageList) do
			if tempMap[v.stageId] == nil then
				isPass = false

				break
			end
		end

		if isPass then
			CustomFmtController.instance:showCommonPassViewWithJump(pb.changeSetId)
		end
	end

	local fmtMo = self._fmtMoMap[activityId]

	UIStateManager.instance:push(self._resultViewName, activityId, stageId, fmtMo)

	return true
end

OriginHuociyuanController.instance = OriginHuociyuanController.New()

return OriginHuociyuanController
