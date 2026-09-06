-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fiveyearrecap/controller/FiveYearRecapController.lua

module("logic.extensions.fiveyearrecap.controller.FiveYearRecapController", package.seeall)

local FiveYearRecapController = class("FiveYearRecapController", BaseController)

FiveYearRecapController.OpenFrameView = "openframeview"

function FiveYearRecapController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self._onStartEnterGame, self)
end

function FiveYearRecapController:onReset()
	return
end

function FiveYearRecapController:_onStartEnterGame()
	local activityId = self:getActivityId()

	self:_updatePlayerFirstOpenRedPoint(activityId)
end

function FiveYearRecapController:sendPM_FiveYearRecapGetInfoReq(activityId)
	FiveYearRecapAgent.instance:sendPM_FiveYearRecapGetInfoReq(activityId)
end

function FiveYearRecapController:handlePM_FiveYearRecapGetInfoRes(status, msg)
	if status == 0 then
		local mo = self:getSubMo(msg.activityId)

		mo:handlePM_FiveYearRecapGetInfoRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FiveYearRecapGetInfoRes, status, msg)
end

function FiveYearRecapController:sendPM_FiveYearRecapGainLoginPrizeReq(activityId)
	FiveYearRecapAgent.instance:sendPM_FiveYearRecapGainLoginPrizeReq(activityId)
end

function FiveYearRecapController:handlePM_FiveYearRecapGainLoginPrizeRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_FiveYearRecapGainLoginPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FiveYearRecapGainLoginPrizeRes)
end

function FiveYearRecapController:sendPM_FiveYearRecapUnlockReq(activityId, pieceId)
	FiveYearRecapAgent.instance:sendPM_FiveYearRecapUnlockReq(activityId, pieceId)
end

function FiveYearRecapController:handlePM_FiveYearRecapUnlockRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_FiveYearRecapUnlockRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FiveYearRecapUnlockRes)
end

function FiveYearRecapController:sendPM_FiveYearRecapShareReq(activityId)
	FiveYearRecapAgent.instance:sendPM_FiveYearRecapShareReq(activityId)
end

function FiveYearRecapController:handlePM_FiveYearRecapShareRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_FiveYearRecapShareRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FiveYearRecapShareRes)
end

function FiveYearRecapController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.FiveYearRecap)
end

function FiveYearRecapController:getSubMo(activityId)
	return FiveYearRecapModel.instance:getSubMo(activityId)
end

function FiveYearRecapController:printAllData()
	local activityId = self:getActivityId()

	GlobalDispatcher:addListener(GlobalNotify.HandlePM_FiveYearRecapGetInfoRes, self._printAllData, self)
	FiveYearRecapController.instance:sendPM_FiveYearRecapGetInfoReq(activityId)
end

function FiveYearRecapController:_printAllData(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_FiveYearRecapGetInfoRes, self._printAllData, self)

	if status ~= 0 then
		return
	end

	local result = "\n"
	local activityId = msg.activityId
	local subMo = self:getSubMo(activityId)
	local dataList = FiveYearRecapConfig.instance:getDataIdsDataList() or {}

	for _, data in ipairs(dataList) do
		local dataId = data.id
		local value = subMo:getRecapData(dataId)

		result = result .. string.format("datId:%s : %s\n", dataId, value)
	end

	printError(result)
end

function FiveYearRecapController:isHasReported(activityId)
	local key = string.format("fiveyearrecap_reported_%s", activityId)
	local v = GameUtil.getUserData(key)

	return checknumber(v) ~= 0
end

function FiveYearRecapController:setHasReported(activityId)
	local key = string.format("fiveyearrecap_reported_%s", activityId)

	GameUtil.saveUserData(key, 1)
end

function FiveYearRecapController:_updatePlayerFirstOpenRedPoint(activityId)
	local redId = RedPointModel.ID_FIVEYEARRECAP_PLAYER_FIRST_OPEN
	local isInActivityTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)

	if isInActivityTime then
		local key = string.format("fiveyearrecap_player_first_open_%s", activityId)

		GameUtil.getUserData(key, function(value)
			local v = checknumber(value)
			local isActive = v ~= 0

			RedPointController.instance:setRedPointInfo(redId, isActive)
		end)
	else
		RedPointController.instance:setRedPointInfo(redId, false)
	end
end

function FiveYearRecapController:setPlayerFirstOpenRedPoint(activityId)
	local redId = RedPointModel.ID_FIVEYEARRECAP_PLAYER_FIRST_OPEN
	local key = string.format("fiveyearrecap_player_first_open_%s", activityId)

	GameUtil.saveUserData(key, 1)
	RedPointController.instance:setRedPointInfo(redId, false)
end

FiveYearRecapController.instance = FiveYearRecapController.New()

return FiveYearRecapController
