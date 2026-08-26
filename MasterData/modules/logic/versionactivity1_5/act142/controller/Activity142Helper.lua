-- chunkname: @modules/logic/versionactivity1_5/act142/controller/Activity142Helper.lua

module("modules.logic.versionactivity1_5.act142.controller.Activity142Helper", package.seeall)

local Activity142Helper = {}

function Activity142Helper.showToastByEpisodeId(episodeId)
	local actId = Activity142Model.instance:getActivityId()
	local episodeCfg = Activity142Config.instance:getEpisodeCo(actId, episodeId, true)

	if not episodeCfg then
		return
	end

	local isOpen = Activity142Model.instance:isOpenDay(actId, episodeId)

	if not isOpen then
		GameFacade.showToast(ToastEnum.Activity142EpisodeNotInOpenDay)

		return
	end

	local preEpisodePass = Activity142Model.instance:isPreEpisodeClear(actId, episodeId)

	if not preEpisodePass then
		GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)
	end
end

function Activity142Helper.setAct142UIBlock(isSetBlock, blockKey)
	if isSetBlock then
		UIBlockMgr.instance:startBlock(blockKey or Activity142Enum.UI_BlOCK_KEY)
	else
		UIBlockMgr.instance:endBlock(blockKey or Activity142Enum.UI_BlOCK_KEY)
	end
end

function Activity142Helper.openWinResult()
	local episodeId = Va3ChessModel.instance:getEpisodeId()
	local v1 = "OnChessWinPause" .. episodeId
	local v2 = GuideEvent[v1]
	local v3 = GuideEvent.OnChessWinContinue
	local v4 = Activity142Helper._openSuccessView
	local v5

	GuideController.instance:GuideFlowPauseAndContinue(v1, v2, v3, v4, v5)
end

function Activity142Helper._openSuccessView()
	AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerArrive)
	ViewMgr.instance:openView(ViewName.Activity142ResultView)
end

function Activity142Helper.checkConditionIsFinish(str, actId)
	local result = true
	local params2 = GameUtil.splitString2(str, true, "|", "#")

	if not params2 then
		return result
	end

	for _, params in ipairs(params2) do
		if not Va3ChessMapUtils.isClearConditionFinish(params, actId) then
			result = false

			break
		end
	end

	return result
end

function Activity142Helper.filterInteractType(targetObj, filterDict)
	local result = false

	if filterDict and targetObj and targetObj.config then
		local targetInteractType = targetObj.config.interactType

		result = filterDict[targetInteractType] or false
	end

	return result
end

function Activity142Helper.filterCanBlockFireBall(targetObj)
	return (Activity142Helper.filterInteractType(targetObj, Activity142Enum.CanBlockFireBallInteractType))
end

function Activity142Helper.filterCanMoveKill(targetObj)
	return (Activity142Helper.filterInteractType(targetObj, Activity142Enum.CanMoveKillInteractType))
end

function Activity142Helper.filterCanFireKill(targetObj)
	return (Activity142Helper.filterInteractType(targetObj, Activity142Enum.CanFireKillInteractType))
end

function Activity142Helper.getBaffleDataList(tileData, baffleTypeData)
	local result = {}

	for _, tmpDir in pairs(Va3ChessEnum.Direction) do
		local isHasBaffle = Activity142Helper.isHasBaffleInDir(tileData, tmpDir)

		if isHasBaffle then
			local offset = tmpDir - 1
			local typeMaskBit = bit.lshift(3, offset)
			local typeVerifyResult = bit.band(baffleTypeData, typeMaskBit)
			local baffleType = bit.rshift(typeVerifyResult, offset)

			result[#result + 1] = {
				direction = tmpDir,
				type = baffleType
			}
		end
	end

	return result
end

function Activity142Helper.isHasBaffleInDir(tileData, dir)
	local maskBit = bit.lshift(1, dir)
	local verifyCode = bit.band(tileData, maskBit)

	return verifyCode ~= 0
end

local Dir2Order = {
	[Va3ChessEnum.Direction.Up] = 1,
	[Va3ChessEnum.Direction.Down] = -1,
	[Va3ChessEnum.Direction.Left] = 1,
	[Va3ChessEnum.Direction.Right] = -1
}

function Activity142Helper.calBafflePosInScene(tileX, tileY, direction)
	local order = Dir2Order[direction]
	local x, y, z = Va3ChessGameController.instance:calcTilePosInScene(tileX, tileY, order, true)

	if direction == Va3ChessEnum.Direction.Left then
		x = x - Activity142Enum.BaffleOffset.baffleOffsetX
		y = y + Activity142Enum.BaffleOffset.baffleOffsetY
	elseif direction == Va3ChessEnum.Direction.Up then
		x = x + Activity142Enum.BaffleOffset.baffleOffsetX
		y = y + Activity142Enum.BaffleOffset.baffleOffsetY
	elseif direction == Va3ChessEnum.Direction.Right then
		x = x + Activity142Enum.BaffleOffset.baffleOffsetX
		y = y - Activity142Enum.BaffleOffset.baffleOffsetY
	elseif direction == Va3ChessEnum.Direction.Down then
		x = x - Activity142Enum.BaffleOffset.baffleOffsetX
		y = y - Activity142Enum.BaffleOffset.baffleOffsetY
	else
		logError("un support direction, please check ... " .. direction)
	end

	return x, y, z
end

function Activity142Helper.getBaffleResPath(baffleData)
	if not baffleData then
		return
	end

	local dir = baffleData.direction
	local type = baffleData.type

	if not dir or not type then
		return
	end

	if dir == Va3ChessEnum.Direction.Left or dir == Va3ChessEnum.Direction.Right then
		return Activity142Enum.VerBaffleResPath[type] or Activity142Enum.VerBaffleResPath[1]
	else
		return Activity142Enum.HorBaffleResPath[type] or Activity142Enum.HorBaffleResPath[1]
	end
end

function Activity142Helper.isSurroundPlayer(x, y)
	local isSurroundPlayer = false
	local interactMgr = Va3ChessGameController.instance.interacts
	local mainPlayer = interactMgr and interactMgr:getMainPlayer(true)

	if not mainPlayer then
		return isSurroundPlayer
	end

	local playerX, playerY = mainPlayer.originData.posX, mainPlayer.originData.posY
	local isSameX = playerX == x
	local isSameY = playerY == y
	local absDiffX = math.abs(playerX - x)
	local absDiffY = math.abs(playerY - y)

	isSurroundPlayer = isSameX and absDiffY == 1 or isSameY and absDiffX == 1

	return isSurroundPlayer
end

function Activity142Helper.isCanMoveKill(interactObj)
	local result = false

	if not interactObj then
		return result
	end

	local x, y = interactObj.originData.posX, interactObj.originData.posY
	local isSurroundPlayer = Activity142Helper.isSurroundPlayer(x, y)

	if isSurroundPlayer then
		local interactMgr = Va3ChessGameController.instance.interacts
		local mainPlayer = interactMgr and interactMgr:getMainPlayer(true) or nil

		if mainPlayer then
			local curX, curY = mainPlayer.originData.posX, mainPlayer.originData.posY
			local dir = Va3ChessMapUtils.ToDirection(curX, curY, x, y)
			local isCanWalk = Va3ChessGameController.instance:posCanWalk(x, y, dir, mainPlayer.objType)
			local targetInteractType = interactObj:getObjType()

			if not Activity142Enum.CanMoveKillInteractType[targetInteractType] then
				result = isCanWalk and Activity142Enum.CanMoveKillInteractType[targetInteractType]
			end
		end
	end

	return result
end

function Activity142Helper.isCanFireKill(interactObj)
	local result = false
	local targetInteractId
	local interactMgr = Va3ChessGameController.instance.interacts
	local mainPlayer = interactMgr and interactMgr:getMainPlayer(true)

	if not interactObj or not mainPlayer then
		return result, targetInteractId
	end

	local curX, curY = mainPlayer.originData.posX, mainPlayer.originData.posY
	local x, y = interactObj.originData.posX, interactObj.originData.posY
	local isSameX = curX == x
	local isSameY = curY == y
	local isSamePos = isSameX and isSameY

	if not isSameX and not isSameY or isSamePos then
		return result, targetInteractId
	end

	local isCanMoveKill = Activity142Helper.isCanMoveKill(interactObj)

	if isCanMoveKill then
		return result, targetInteractId
	end

	local fireBallCount = Va3ChessGameModel.instance:getFireBallCount()
	local notHasFireBall = fireBallCount <= 0

	if notHasFireBall then
		return result, targetInteractId
	end

	local isBlockFireBall = Activity142Helper.isBlockFireBall(curX, curY, x, y)

	if isBlockFireBall then
		return result, targetInteractId
	end

	local targetInteractType = interactObj:getObjType()

	result = Activity142Enum.CanFireKillInteractType[targetInteractType]

	return Activity142Enum.CanFireKillInteractType[targetInteractType]
end

function Activity142Helper.isBlockFireBall(curX, curY, x, y)
	local result = false
	local isSameX = curX == x
	local isSameY = curY == y
	local isSamePos = isSameX and isSameY
	local isSurroundPlayer = Activity142Helper.isSurroundPlayer(x, y)

	if not isSameX and not isSameY or isSamePos or isSurroundPlayer then
		return result
	end

	if isSameX then
		local isUp = curY < y

		if isUp then
			if not (curY + 1) then
				local beginY = y + 1
				local endY = isUp and math.max(y - 1, 0) or math.max(curY - 1, 0)

				for tmpY = beginY, endY do
					local blockLen, _ = Va3ChessGameController.instance:searchInteractByPos(curX, tmpY, Activity142Helper.filterCanBlockFireBall)

					if blockLen > 0 then
						result = true

						break
					end
				end
			end
		end
	else
		local isRight = curX < x

		if isRight then
			if not (curX + 1) then
				local beginX = x + 1
				local endX = isRight and math.max(x - 1, 0) or math.max(curX - 1, 0)

				for tmpX = beginX, endX do
					local blockLen, _ = Va3ChessGameController.instance:searchInteractByPos(tmpX, curY, Activity142Helper.filterCanBlockFireBall)

					if blockLen > 0 then
						result = true

						break
					end
				end
			end
		end
	end

	return result
end

function Activity142Helper.getPosHashKey(posX, posY)
	return posX .. "." .. posY
end

return Activity142Helper
