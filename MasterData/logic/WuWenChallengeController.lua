-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wuwenchallenge/controller/WuWenChallengeController.lua

module("logic.extensions.wuwenchallenge.controller.WuWenChallengeController", package.seeall)

local WuWenChallengeController = class("WuWenChallengeController", BaseController)

function WuWenChallengeController:ctor()
	return
end

function WuWenChallengeController:onInit()
	self:onReset()
end

function WuWenChallengeController:onReset()
	self._tempStageId = nil
end

function WuWenChallengeController:handlePM_WuWenClgGetInfoRes(msg)
	WuWenChallengeModel.instance:setInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.WuWenClgRefresh)
end

function WuWenChallengeController:handlePM_WuWenClgNotifyFightResultRes(msg)
	if msg.win then
		WuWenChallengeModel.instance:saveFightInfo(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_WuWenClgNotifyFightResultRes)
end

function WuWenChallengeController:handlePM_WuWenClgFightConfirmRes(msg)
	WuWenChallengeModel.instance:setInfo(msg)
	WuWenChallengeModel.instance:resetFightInfo(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.PM_WuWenClgFightConfirmRes, msg.phasePassed)
end

function WuWenChallengeController:handlePM_WuWenClgResetPhaseRes(msg)
	WuWenChallengeModel.instance:setInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.WuWenClgRefresh)
end

function WuWenChallengeController:openMissionView(activityId, curLevel, curStage, buffList)
	self._tempStageId = curStage

	local selectBuffList = {}

	for i, v in pairs(buffList) do
		table.insert(selectBuffList, i)
	end

	local fmtMo = WuWenChallengeModel.instance:getFmtMo()

	fmtMo:initParams(activityId, curLevel, curStage, selectBuffList)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function WuWenChallengeController:getOnceStageId()
	self._tempStageId = nil

	return self._tempStageId
end

WuWenChallengeController.instance = WuWenChallengeController.New()

return WuWenChallengeController
