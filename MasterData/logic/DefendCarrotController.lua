-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/controller/DefendCarrotController.lua

module("logic.extensions.defendcarrot.controller.DefendCarrotController", package.seeall)

local DefendCarrotController = class("DefendCarrotController", BaseController)

function DefendCarrotController:onInit()
	self:onReset()
end

function DefendCarrotController:onReset()
	self.ciList = nil
	self._curClientKey = nil
	self._curServerKey = nil
	self._isInGame = false
end

function DefendCarrotController:_getRanamdomClientKey()
	self._curClientKey = MmUtil.createClientKey()

	return self._curClientKey
end

function DefendCarrotController:getClientKey()
	return self._curClientKey
end

function DefendCarrotController:getServerKey()
	return self._curServerKey
end

function DefendCarrotController:getEncryptedKey(isPass, secParam)
	local temPass = isPass and 1 or 0

	return (GameUtil.getClientEncryptedKey(self._curClientKey, self._curServerKey, {
		temPass,
		secParam
	}))
end

function DefendCarrotController:showCI()
	MaterialController.instance:showChangeSetInTemp(self.ciList)

	self.ciList = {}
end

function DefendCarrotController:getInfo(activityId)
	DefendCarrotAgent.instance:sendPM_DefendCarrotInfoReq(activityId)
end

function DefendCarrotController:handleGetInfo(msg)
	DefendCarrotModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DefendCarrotGetInfo)
end

function DefendCarrotController:upgradeWeapon(activityId, weaponId)
	DefendCarrotAgent.instance:sendPM_DefendCarrotUpgradeWeaponReq(activityId, weaponId)
end

function DefendCarrotController:handleUpgradeWeapon(msg)
	DefendCarrotModel.instance:onUpgradeWeapon(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DefendCarrotUpgradeWeapon)
	TipsFacade.instance:openCommonTips("升级成功")
end

function DefendCarrotController:startGame(activityId, stageId)
	local clientKey = self:_getRanamdomClientKey()

	DefendCarrotAgent.instance:sendPM_DefendCarrotStartGameReq(activityId, stageId, clientKey)
end

function DefendCarrotController:handleStartGame(msg)
	self._curServerKey = checknumber(msg.serverKey)

	DefendCarrotModel.instance:onStartGame(msg)

	self._isInGame = true

	UIStateManager.instance:push(ViewName.DefendCarrotGameView, msg.activityId, msg.stageId, DefendCarrotEnum.LevelMode_Normal)
	GlobalDispatcher:dispatch(GlobalNotify.DefendCarrotStartGame, msg.activityId, msg.stageId)
end

function DefendCarrotController:endGame(activityId, stageId, isPass, kills_pb_Ary, history_pb_Ary, last_pb_Ary)
	local killNum = 0
	local killInfos = kills_pb_Ary or {}

	for _, killInfo in ipairs(killInfos) do
		killNum = killNum + (killInfo.killNum or 0)
	end

	local encryptedKey = self:getEncryptedKey(isPass, killNum)

	DefendCarrotAgent.instance:sendPM_DefendCarrotEndGameReq(activityId, stageId, isPass, encryptedKey, kills_pb_Ary, history_pb_Ary, last_pb_Ary)
end

function DefendCarrotController:handleEndGame(msg)
	DefendCarrotModel.instance:onEndGame(msg)

	self._curClientKey = nil
	self._curServerKey = nil
	self._isInGame = false
	self.ciList = msg.changeSetId

	MaterialController.instance:saveChangeSetToTemp(self.ciList)
	GlobalDispatcher:dispatch(GlobalNotify.DefendCarrotEndGame)
end

function DefendCarrotController:gainPrize(activityId, prizeId)
	DefendCarrotAgent.instance:sendPM_DefendCarrotGainPrizeReq(activityId, prizeId)
end

function DefendCarrotController:handleGainPrize(msg)
	DefendCarrotModel.instance:onGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DefendCarrotGainPrize)
end

function DefendCarrotController:startMaterialGame(activityId, stageId)
	local clientKey = self:_getRanamdomClientKey()

	DefendCarrotAgent.instance:sendPM_DefendCarrotMaterialClgStartGameReq(activityId, stageId, clientKey)
end

function DefendCarrotController:handleStartMaterialGame(msg)
	DefendCarrotModel.instance:onStartMaterialGame(msg)

	self._curServerKey = checknumber(msg.serverKey)
	self._isInGame = true

	UIStateManager.instance:push(ViewName.DefendCarrotGameView, msg.activityId, msg.stageId, DefendCarrotEnum.LevelMode_Material)
	GlobalDispatcher:dispatch(GlobalNotify.DefendCarrotMaterialClgStartGame, msg.activityId, msg.stageId)
end

function DefendCarrotController:endMaterialGame(activityId, stageId, isPass, finishWaveId)
	local encryptedKey = self:getEncryptedKey(isPass, finishWaveId)

	DefendCarrotAgent.instance:sendPM_DefendCarrotMaterialClgEndGameReq(activityId, stageId, isPass, encryptedKey, finishWaveId)
end

function DefendCarrotController:handleEndMaterialGame(msg)
	DefendCarrotModel.instance:onEndMaterialGame(msg)

	self._curClientKey = nil
	self._curServerKey = nil
	self._isInGame = false
	self.ciList = msg.changeSetId

	MaterialController.instance:saveChangeSetToTemp(self.ciList)
	GlobalDispatcher:dispatch(GlobalNotify.DefendCarrotMaterialClgEndGame)
end

function DefendCarrotController:getRankInfo(activityId)
	DefendCarrotAgent.instance:sendPM_DefendCarrotRankInfoReq(activityId)
end

function DefendCarrotController:handleGetRankInfo(msg)
	DefendCarrotModel.instance:onGetRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DefendCarrotRankInfo)
end

function DefendCarrotController:getIsInGame()
	return self._isInGame
end

DefendCarrotController.instance = DefendCarrotController.New()

return DefendCarrotController
