-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pinball/view/PinBallMgr.lua

module("logic.extensions.pinball.view.PinBallMgr", package.seeall)

local PinBallMgr = class("PinBallMgr")

function PinBallMgr:ctor()
	self._ballMap = {}
	self._ballPool = nil
end

function PinBallMgr:initParamas(ballGo, parentGo, radius, speed, screenWidthHalf, screenHeightHalf)
	self._radius = radius
	self._speed = speed
	self._screenWidthHalf = screenWidthHalf
	self._screenHeightHalf = screenHeightHalf
	self._ballGo = ballGo
	self._parentGo = parentGo
	self._ballNum = 0
end

function PinBallMgr:createBall(num, x, y)
	if not self._ballPool then
		local function createFunc()
			local go = goutil.cloneAndSetParent(self._ballGo, self._parentGo.transform)

			return (PinBall.New(go))
		end

		local function disposeFunc(ballItem)
			ballItem:destroy()
		end

		local function resetFunc(ballItem)
			ballItem:reset()
		end

		if self._ballPool == nil then
			self._ballPool = ObjectPool.New(50, createFunc, disposeFunc, resetFunc)
		end
	end

	for i = 1, num do
		local ballItem = self._ballPool:fetchObject()
		local randomAngle = math.random(30, 150)
		local directX = math.cos(math.rad(randomAngle))
		local directY = math.sin(math.rad(randomAngle))
		local direct = Vector2.New(directX, directY)

		self._ballMap[ballItem] = ballItem

		ballItem:initParam(x, y, self._radius, self._speed, direct, self._screenWidthHalf, self._screenHeightHalf)
	end

	self._ballNum = self._ballNum + num
end

function PinBallMgr:update()
	for _, ballItem in pairs(self._ballMap) do
		if ballItem then
			ballItem:updatePos()

			if ballItem:isOutScreen() then
				self._ballMap[ballItem] = nil

				self._ballPool:returnObject(ballItem)

				self._ballNum = self._ballNum - 1
			end
		end
	end
end

function PinBallMgr:clear()
	for k, ballItem in pairs(self._ballMap) do
		self._ballPool:returnObject(ballItem)

		self._ballMap[k] = nil
	end

	self._ballPool:clear()
end

function PinBallMgr:getCurBallNum()
	return self._ballNum
end

function PinBallMgr:pauseGame()
	for _, item in pairs(self._ballMap) do
		if item then
			item:setSpeed(0)
		end
	end
end

function PinBallMgr:continueGame()
	for _, item in pairs(self._ballMap) do
		if item then
			item:setSpeed(8)
		end
	end
end

PinBallMgr.instance = PinBallMgr.New()

return PinBallMgr
