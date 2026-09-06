-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throwshells/controller/ThrowShellsController.lua

module("logic.extensions.throwshells.controller.ThrowShellsController", package.seeall)

local ThrowShellsController = class("ThrowShellsController", BaseController)

function ThrowShellsController:ctor()
	return
end

function ThrowShellsController:onInit()
	return
end

function ThrowShellsController:onReset()
	return
end

function ThrowShellsController:openHexagramGame(gameId)
	local gameCfg = YirenPozhenConfig.instance:getGameCfg(gameId)
	local params = {}

	params.gameId = gameId
	params.gameCfg = YirenPozhenConfig.instance:getHexagramCfg(gameCfg.planId)

	UIStateManager.instance:push(ViewName.HexagramGameView, params)
end

function ThrowShellsController:getInfo()
	TheOutcastChallengeAgent.instance:sendPM_TheOutcastChallengeInfoReq()
end

function ThrowShellsController:handleInfo(msg, status)
	YirenPozhenModel.instance:setPassStageId(msg.passStageId)

	for k, v in ipairs(msg.gamePrizedIds) do
		YirenPozhenModel.instance:setGamePrizedIds(k, true)
	end

	self:notify(GlobalNotify.HexagramGetInfo, status)
end

function ThrowShellsController:onNotifyAfterChallengeRes(status, msg)
	YirenPozhenModel.instance:setPassStageId(msg.passStageId)

	if checkbool(msg.isWin) then
		-- block empty
	end
end

function ThrowShellsController:sendEndGame(pass, gameId, stepNum)
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

function ThrowShellsController:getTempMaxPet(id)
	local list = YirenPozhenModel.instance:getAllPetList()

	for i, v in ipairs(list) do
		if v.petId == id then
			local mo = BagPetsController.instance:getPet(id)

			if mo then
				v.summonMasterId = mo.summonMasterId
				v.summonedPetId = mo.summonedPetId
				v.carriedMasterId = mo.carriedMasterId
				v.carriedPetId = mo.carriedPetId
				v.oracleMasterId = mo.oracleMasterId
				v.oraclePetId = mo.oraclePetId
				v.oraclePetRaceId = mo.oraclePetRaceId
				v.bookSpiritPetId = mo.bookSpiritPetId
				v.bookSpiritRaceId = mo.bookSpiritRaceId
				v.curFaceId = mo.curFaceId
			end

			return v
		end
	end
end

function ThrowShellsController:getIfNewDay()
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

function ThrowShellsController:gainPrize(day, callback)
	local activityId = OperationSignInModel.instance:getActivityId()

	OperationCheckInAgent.instance:sendPM_OperationCheckInGainPrizeReq(activityId, day, function(msg)
		OperationSignInModel.instance:setDaysList(day)
		GameUtil.callBack(callback, msg)
	end)
end

function ThrowShellsController:updateActivityId()
	local activityId
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.SignIn)

	return ((cfg or nil) and cfg.activityId) ~= nil
end

function ThrowShellsController:onShowChangeSet(changeSetId, msgName)
	if changeSetId ~= nil and changeSetId >= 0 then
		if msgName == "handlePM_NotifyAfterChallengeRes" then
			BattleSettlementModel.instance:setChangeSetId(changeSetId)
		else
			MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
		end
	end
end

ThrowShellsController.instance = ThrowShellsController.New()

return ThrowShellsController
