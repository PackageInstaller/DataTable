-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pinball/view/PinBall.lua

module("logic.extensions.pinball.view.PinBall", package.seeall)

local PinBall = class("PinBall")

function PinBall:ctor(go)
	self._ballGo = go
	self._curDirect = Vector2.New(0, 1)
	self._needRebound = false
	self._rushWallDirect = 0
	self._posX = 0
	self._posY = -219
	self._canMove = false
end

function PinBall:initParam(x, y, radius, speed, direct, screenWidthHalf, screenHeightHalf)
	self._posX = x
	self._posY = y
	self._radius = radius
	self._speed = speed
	self._curDirect = direct
	self._screenWidthHalf = screenWidthHalf
	self._screenHeightHalf = screenHeightHalf
	self._rightWallPosX = self._screenWidthHalf - self._radius
	self._leftWallPosX = -self._screenWidthHalf + self._radius
	self._upWallPosY = self._screenHeightHalf - self._radius
	self._canMove = true

	GameUtil.SetActive(self._ballGo, true)
end

function PinBall:initParamTest(gameObject)
	self._ballGo = gameObject
end

function PinBall:updatePos()
	if self._canMove then
		local rightPos = self._posX + self._radius
		local leftPos = self._posX - self._radius
		local topPos = self._posY + self._radius
		local rushRightWall = rightPos >= self._rightWallPosX
		local rushUpWall = topPos >= self._upWallPosY and self._curDirect.y > 0
		local rushLeftWall = leftPos <= self._leftWallPosX

		if (rushRightWall or rushUpWall or rushLeftWall) and not self._needRebound then
			self._needRebound = true
		end

		if self._needRebound then
			if rushRightWall then
				self:_wallDirect(self._curDirect, PinBallEnum.ReBoundDirect.Right)
			elseif rushUpWall then
				self:_wallDirect(self._curDirect, PinBallEnum.ReBoundDirect.Up)
			elseif rushLeftWall then
				self:_wallDirect(self._curDirect, PinBallEnum.ReBoundDirect.Left)
			end

			self._needRebound = false
		end

		local ballData = {
			radius = self._radius,
			posX = self._posX,
			posY = self._posY
		}
		local direct = PinBallBrickMapMgr.instance:getReflectDirect(ballData, self._curDirect)

		if direct then
			self._curDirect = direct
		end

		local boardDirect, hasReflect = PinBallBoardMgr.instance:getReflectDirect(self._posX, self._posY, self._radius, self._curDirect)

		self._curDirect = boardDirect
		self._posX = self._posX + self._curDirect.x * self._speed
		self._posY = self._posY + self._curDirect.y * self._speed

		GameUtil.setLocalPos(self._ballGo, self._posX, self._posY, 0)
	end
end

function PinBall:_wallDirect(curDirect, wallDirect)
	if wallDirect == PinBallEnum.ReBoundDirect.Right then
		if self._curDirect.x > 0 then
			self._curDirect.x = -self._curDirect.x
		end

		if math.abs(self._curDirect.y) < 0.2 then
			self._curDirect.y = self._curDirect.y * 4
		end
	elseif wallDirect == PinBallEnum.ReBoundDirect.Left then
		if self._curDirect.x < 0 then
			self._curDirect.x = -self._curDirect.x
		end

		if math.abs(self._curDirect.y) < 0.2 then
			self._curDirect.y = self._curDirect.y * 4
		end
	else
		self._curDirect.y = -self._curDirect.y
	end
end

function PinBall:isOutScreen()
	local ballTop = self._posY + self._radius

	return ballTop <= -self._screenHeightHalf
end

function PinBall:reset()
	GameUtil.SetActive(self._ballGo, false)

	self._canMove = false
end

function PinBall:destroy()
	goutil.destroy(self._ballGo)
end

function PinBall:setSpeed(speed)
	self._speed = speed
end

return PinBall
