-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongzhu/controller/OriginLongzhuController.lua

module("logic.extensions.originlongzhu.controller.OriginLongzhuController", package.seeall)

local OriginLongzhuController = class("OriginLongzhuController", BaseController)

function OriginLongzhuController:onInit()
	self:onReset()
end

function OriginLongzhuController:onReset()
	self._fmtMoMap = {}
	self._lastSelectIdx = -1
end

function OriginLongzhuController:setLastIdx(idx)
	self._lastSelectIdx = idx
end

function OriginLongzhuController:getLastIdx()
	return self._lastSelectIdx
end

function OriginLongzhuController:sendGetInfo(activityId)
	OriginDragonAryaClgAgent.instance:sendPM_OriginDragonAryaClgGetInfoReq(activityId)
end

function OriginLongzhuController:onGetInfo(msg)
	OriginLongzhuModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ORIGIN_LONGZHU_INFO_UPDATE)
end

function OriginLongzhuController:sendResetFight(activityId, stageId)
	OriginDragonAryaClgAgent.instance:sendPM_OriginDragonAryaClgResetReq(activityId, stageId)
end

function OriginLongzhuController:onResetFight(msg)
	OriginLongzhuModel.instance:onResetFight(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ORIGIN_LONGZHU_INFO_UPDATE)
end

function OriginLongzhuController:showCI()
	MaterialController.instance:showChangeSetInTemp(self._temChangeSetId)

	self._temChangeSetId = nil
end

function OriginLongzhuController:openFmtView(activityId, stageId, extView, resultView)
	self._fmtMoMap[activityId] = self._fmtMoMap[activityId] or OriginLongzhuFmtMo.New()

	local fmtMo = self._fmtMoMap[activityId]

	fmtMo:initParams(activityId, stageId, extView, resultView)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function OriginLongzhuController:sendStartFight(activityId, stageId, scoreTypes_i32_Ary, form_pb, resultViewName)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onNorBattleEnd, self, activityId, stageId, resultViewName))
	OriginDragonAryaClgAgent.instance:sendPM_OriginDragonAryaClgChallengeReq(activityId, stageId, form_pb, scoreTypes_i32_Ary)
end

function OriginLongzhuController:handleFightRes(msg)
	OriginLongzhuModel.instance:handleFightRes(msg)
end

function OriginLongzhuController:_onNorBattleEnd(activityId, stageId, resultViewName)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local pb = OriginLongzhuModel.instance:getFightPb(activityId) or {}
	local isWin = checkbool(pb.win)

	if isWin then
		local fmtMo = self._fmtMoMap[activityId]

		UIStateManager.instance:push(resultViewName, activityId, stageId, fmtMo)

		return true
	end

	return false
end

OriginLongzhuController.instance = OriginLongzhuController.New()

return OriginLongzhuController
