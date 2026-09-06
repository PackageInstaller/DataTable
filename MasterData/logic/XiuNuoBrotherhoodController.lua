-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhood/controller/XiuNuoBrotherhoodController.lua

module("logic.extensions.xiunuobrotherhood.controller.XiuNuoBrotherhoodController", package.seeall)

local XiuNuoBrotherhoodController = class("XiuNuoBrotherhoodController", BaseController)

function XiuNuoBrotherhoodController:ctor()
	return
end

function XiuNuoBrotherhoodController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(XiuNuoBrotherhoodAgent.PM_XiuNuoBrotherhoodInfoRes, self.handlePM_XiuNuoBrotherhoodInfoRes, self)
	GlobalDispatcher:addListener(XiuNuoBrotherhoodAgent.PM_XiuNuoBrotherhoodStartMoveRes, self.handlePM_XiuNuoBrotherhoodStartMoveRes, self)
	GlobalDispatcher:addListener(XiuNuoBrotherhoodAgent.PM_XiuNuoBrotherhoodEndMoveRes, self.handlePM_XiuNuoBrotherhoodEndMoveRes, self)
	GlobalDispatcher:addListener(XiuNuoBrotherhoodAgent.PM_XiuNuoBrotherhoodResetRes, self.handlePM_XiuNuoBrotherhoodResetRes, self)
	GlobalDispatcher:addListener(XiuNuoBrotherhoodAgent.PM_XiuNuoBrotherhoodFightRes, self.handlePM_XiuNuoBrotherhoodFightRes, self)
	GlobalDispatcher:addListener(XiuNuoBrotherhoodAgent.PM_XiuNuoBrotherhoodBossBattleEndRes, self.handlePM_XiuNuoBrotherhoodBossBattleEndRes, self)
end

function XiuNuoBrotherhoodController:onReset()
	return
end

function XiuNuoBrotherhoodController:sendPM_XiuNuoBrotherhoodInfoReq(activityId, stageId, gameId)
	SxGameModel.instance:getMapInfo(gameId, stageId)
	XiuNuoBrotherhoodAgent.instance:sendPM_XiuNuoBrotherhoodInfoReq(activityId)
end

function XiuNuoBrotherhoodController:handlePM_XiuNuoBrotherhoodInfoRes(status, msg)
	local data = GameUtil.pbToTable(msg)
	local activityCfg = XiuNuoBrotherhoodConfig.instance:getActivityCfg(data.activityId)

	if data.info then
		SxGameModel.instance:initGameMapArrFromMsg(activityCfg.gameId, data.info.stageInfo)
	else
		SxGameModel.instance:initGameMapArrFromMsg(activityCfg.gameId)
	end

	XiuNuoBrotherhoodModel.instance:setData(msg)
	GlobalDispatcher:dispatch(GlobalNotify.XiuNuoBrotherhoodGetInfo)
end

function XiuNuoBrotherhoodController:sendPM_XiuNuoBrotherhoodStartMoveReq(activityId, stageId, clientKey)
	XiuNuoBrotherhoodModel.instance:setCurrActivityAndStage(activityId, stageId)

	if not clientKey or checknumber(clientKey) == 0 then
		XiuNuoBrotherhoodAgent.instance:sendPM_XiuNuoBrotherhoodStartMoveReq(activityId, stageId, XiuNuoBrotherhoodModel.instance:randomClientKey())
	else
		XiuNuoBrotherhoodAgent.instance:sendPM_XiuNuoBrotherhoodStartMoveReq(activityId, stageId, clientKey)
	end
end

function XiuNuoBrotherhoodController:handlePM_XiuNuoBrotherhoodStartMoveRes(status, msg)
	XiuNuoBrotherhoodModel.instance:setServerKey(msg.serverKey)
	GlobalDispatcher:dispatch(GlobalNotify.XiuNuoBrotherhoodStartMove)
end

function XiuNuoBrotherhoodController:sendPM_XiuNuoBrotherhoodEndMoveReq(activityId, stageId, blocks, blockResult, score)
	local tb = {}

	table.insert(tb, score)

	local encryptedKey = 0
	local clientKey = XiuNuoBrotherhoodModel.instance:getClientKey()
	local serverKey = GenEncryptedKeyUtil.dxor(XiuNuoBrotherhoodModel.instance:getServerKey(), clientKey)

	for i, num in ipairs(tb) do
		encryptedKey = num % 2 == 0 and encryptedKey + (num + serverKey) * 5381 or encryptedKey + (num + clientKey) * 31
	end

	XiuNuoBrotherhoodAgent.instance:sendPM_XiuNuoBrotherhoodEndMoveReq(activityId, stageId, blocks, blockResult, score, encryptedKey)
end

function XiuNuoBrotherhoodController:handlePM_XiuNuoBrotherhoodEndMoveRes(status, msg)
	XiuNuoBrotherhoodModel.instance:setMoveEndData(msg)
	GlobalDispatcher:dispatch(GlobalNotify.XiuNuoBrotherhoodEndMove)
end

function XiuNuoBrotherhoodController:handlePM_XiuNuoBrotherhoodResetRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.XiuNuoBrotherhoodReset)
end

function XiuNuoBrotherhoodController:handlePM_XiuNuoBrotherhoodFightRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.XiuNuoBrotherhoodFight)
end

function XiuNuoBrotherhoodController:handlePM_XiuNuoBrotherhoodBossBattleEndRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.XiuNuoBrotherhoodBossBattleEnd)

	if msg.changeSetId ~= nil then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
	end
end

XiuNuoBrotherhoodController.instance = XiuNuoBrotherhoodController.New()

return XiuNuoBrotherhoodController
