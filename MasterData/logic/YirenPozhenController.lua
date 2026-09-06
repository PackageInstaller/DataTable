-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yirenpozhen/controller/YirenPozhenController.lua

module("logic.extensions.yirenpozhen.controller.YirenPozhenController", package.seeall)

local YirenPozhenController = class("YirenPozhenController", BaseController)

function YirenPozhenController:ctor()
	return
end

function YirenPozhenController:onInit()
	TheOutcastChallengeAgent.instance:setShowChangeSetFunc(GameUtil.handler(self.onShowChangeSet, self))
end

function YirenPozhenController:onReset()
	return
end

function YirenPozhenController:openHexagramGame(gameId)
	local gameCfg = YirenPozhenConfig.instance:getGameCfg(gameId)
	local params = {}

	params.gameId = gameId
	params.gameCfg = YirenPozhenConfig.instance:getHexagramCfg(gameCfg.planId)

	UIStateManager.instance:push(ViewName.HexagramGameView, params)
end

function YirenPozhenController:getInfo()
	TheOutcastChallengeAgent.instance:sendPM_TheOutcastChallengeInfoReq()
end

function YirenPozhenController:handleInfo(msg, status)
	YirenPozhenModel.instance:setPassStageId(msg.passStageId)

	for k, v in ipairs(msg.gamePrizedIds) do
		YirenPozhenModel.instance:setGamePrizedIds(k, true)
	end

	self:notify(GlobalNotify.HexagramGetInfo, status)
end

function YirenPozhenController:onNotifyAfterChallengeRes(status, msg)
	YirenPozhenModel.instance:setPassStageId(msg.passStageId)

	if checkbool(msg.isWin) then
		-- block empty
	end
end

function YirenPozhenController:sendEndGame(pass, gameId, stepNum)
	local serverKey = YirenPozhenModel.instance:getServerKey()
	local clientKey = YirenPozhenModel.instance:getClientKey()

	serverKey = GenEncryptedKeyUtil.dxor(serverKey, clientKey)

	local encryptedKey = 0

	local function encrypt(num)
		encryptedKey = num % 2 == 0 and encryptedKey + (num + serverKey) * 5381 or encryptedKey + (num + clientKey) * 31
	end

	encrypt(pass)
	encrypt(gameId)
	encrypt(stepNum)

	local encryptedKey = TheOutcastChallengeAgent.instance:sendPM_TheOutcastChallengeEndGameReq(pass, gameId, encryptedKey, stepNum)
end

function YirenPozhenController:getTempMaxPet(id)
	local list = YirenPozhenModel.instance:getAllPetList()

	for i, v in ipairs(list) do
		if v.petId == id then
			local mo = BagPetsController.instance:getPet(id)

			if mo then
				v.summonMasterId = mo.summonMasterId
				v.summonedPetId = mo.summonedPetId
				v.curFaceId = mo.curFaceId
				v.carriedMasterId = mo.carriedMasterId
				v.carriedPetId = mo.carriedPetId
				v.oracleMasterId = mo.oracleMasterId
				v.oraclePetId = mo.oraclePetId
				v.oraclePetRaceId = mo.oraclePetRaceId
				v.bookSpiritPetId = mo.bookSpiritPetId
				v.bookSpiritRaceId = mo.bookSpiritRaceId
			end

			return v
		end
	end
end

function YirenPozhenController:getIfNewDay()
	local lastTimeStamp = OperationSignInModel.instance:getLastTimeStamp()

	if lastTimeStamp then
		local lastTimeObj = GameUtil.time2date(lastTimeStamp)
		local lastWeekDay = lastTimeObj.wday
		local lastHour = lastTimeObj.hour

		if lastHour >= 0 and lastHour < 5 then
			lastWeekDay = lastWeekDay + 6
		end

		lastWeekDay = lastWeekDay % 7

		local curTime = GameUtil.time2date(ServerTime.now())
		local curWeekDay = curTime.wday
		local curHour = curTime.hour

		if curHour >= 0 and curHour < 5 then
			curWeekDay = curWeekDay + 6
		end

		curWeekDay = curWeekDay % 7

		return curWeekDay ~= lastWeekDay
	else
		return false
	end
end

function YirenPozhenController:gainPrize(day, callback)
	local activityId = OperationSignInModel.instance:getActivityId()

	OperationCheckInAgent.instance:sendPM_OperationCheckInGainPrizeReq(activityId, day, function(msg)
		OperationSignInModel.instance:setDaysList(day)
		GameUtil.callBack(callback, msg)
	end)
end

function YirenPozhenController:updateActivityId()
	local activityId
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.SignIn)

	return ((cfg or nil) and cfg.activityId) ~= nil
end

function YirenPozhenController:onShowChangeSet(changeSetId, msgName)
	if changeSetId ~= nil and changeSetId >= 0 then
		if msgName == "handlePM_NotifyAfterChallengeRes" then
			BattleSettlementModel.instance:setChangeSetId(changeSetId)
		else
			MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
		end
	end
end

YirenPozhenController.instance = YirenPozhenController.New()

return YirenPozhenController
