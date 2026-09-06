-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pinball/view/PinBallBoardMgr.lua

module("logic.extensions.pinball.view.PinBallBoardMgr", package.seeall)

local PinBallBoardMgr = class("PinBallBoardMgr")

function PinBallBoardMgr:ctor()
	self._curBoard = nil
	self._reflectDirect = Vector2.New(0, 0)
end

function PinBallBoardMgr:init(pinBallBoard)
	self._curBoard = pinBallBoard
end

function PinBallBoardMgr:updateBoardPos(posX, posY)
	self._curBoard:setBoardPos(posX, posY)
end

function PinBallBoardMgr:getBoardData()
	return self._curBoard:getBoardData()
end

function PinBallBoardMgr:addBoardLen(len)
	self._curBoard:addBoardLen(len)
end

function PinBallBoardMgr:getReflectDirect(ballPosX, ballPosY, radius, direct)
	local boardData = self._curBoard:getBoardData()
	local reflectDirect = direct
	local ballBottom = ballPosY - radius
	local rateDistance = (ballPosX - boardData.posX) / (boardData.width / 2)
	local ballLeft = ballPosX - radius
	local ballRight = ballPosX + radius
	local rightUpBoardPos, rightDownBoardPos, leftUpBoardPos, leftDownBoardPos = self._curBoard:getBoardRoundPos()
	local hasReflect = false

	if ballPosX > leftUpBoardPos.x and ballPosX < rightUpBoardPos.x and ballBottom <= rightUpBoardPos.y and ballBottom >= rightDownBoardPos.y then
		local angle = (1 - rateDistance) * 90

		reflectDirect.x = math.cos(math.rad(angle))
		reflectDirect.y = math.sin(math.rad(angle))
	else
		local rushLeftCorner = ballLeft <= boardData.posX and ballPosX > boardData.posX
		local rushRightCorner = ballRight >= boardData.posX and ballPosX < boardData.posX

		if rushLeftCorner then
			if ballBottom <= rightUpBoardPos.y and ballBottom >= rightDownBoardPos.y then
				local rightUpDistanceSq = (ballPosX - rightUpBoardPos.x) * (ballPosX - rightUpBoardPos.x) + (ballPosY - rightUpBoardPos.y) * (ballPosY - rightUpBoardPos.y)
				local sqRadius = radius * radius

				if rightUpDistanceSq <= sqRadius then
					reflectDirect.x = -reflectDirect.x
					reflectDirect.y = -reflectDirect.y
				else
					reflectDirect.x = -reflectDirect.x
				end
			end
		elseif rushRightCorner and ballBottom <= leftUpBoardPos.y and ballBottom >= leftDownBoardPos.y then
			local leftUpDistanceSq = (ballPosX - leftUpBoardPos.x) * (ballPosX - leftUpBoardPos.x) + (ballPosY - leftUpBoardPos.y) * (ballPosY - leftUpBoardPos.y)
			local sqRadius = radius * radius

			if leftUpDistanceSq <= sqRadius then
				reflectDirect.x = -reflectDirect.x
				reflectDirect.y = -reflectDirect.y
			else
				reflectDirect.x = -reflectDirect.x
			end
		end

		hasReflect = true
	end

	self._reflectDirect.x = reflectDirect.x
	self._reflectDirect.y = reflectDirect.y

	return reflectDirect, hasReflect
end

PinBallBoardMgr.instance = PinBallBoardMgr.New()

return PinBallBoardMgr
