-- chunkname: @modules/logic/versionactivity3_0/karong/controller/KaRongDrawController.lua

module("modules.logic.versionactivity3_0.karong.controller.KaRongDrawController", package.seeall)

local KaRongDrawController = class("KaRongDrawController", BaseController)
local LEFT = KaRongDrawEnum.dir.left
local RIGHT = KaRongDrawEnum.dir.right
local DOWN = KaRongDrawEnum.dir.down
local UP = KaRongDrawEnum.dir.up

function KaRongDrawController:reInit()
	self:release()
end

function KaRongDrawController:openGame(elementCo)
	self:startGame(elementCo)
	ViewMgr.instance:openView(ViewName.KaRongDrawView)
end

function KaRongDrawController:startGame(elementCo)
	self:release()
	KaRongDrawModel.instance:startGame(elementCo)

	self._passedPosX = {}
	self._passedPosY = {}
	self._avatarPassedPos = {}
	self._passedCheckPoint = {}
	self._passedCheckPoint1 = {}
	self._alertMoMap = {}

	self:goStartPoint()

	if self.usingSkill then
		self:setUsingSkill(false)
	end
end

function KaRongDrawController:goStartPoint()
	local startX, startY = KaRongDrawModel.instance:getStartPoint()

	self._curPosX = startX
	self._curPosY = startY

	table.insert(self._passedPosX, startX)
	table.insert(self._passedPosY, startY)

	local startPos = KaRongDrawModel.instance:getAvatarStartPos()

	if startPos then
		self._curAvatarPos = Vector2.New(startPos.x, startPos.y)

		table.insert(self._avatarPassedPos, Vector2.New(startPos.x, startPos.y))
	end
end

function KaRongDrawController:restartGame()
	local elementCo = KaRongDrawModel.instance:getElementCo()

	if elementCo then
		self:startGame(elementCo)
	end
end

function KaRongDrawController:interactSwitchObj(interactPosX, interactPosY)
	KaRongDrawModel.instance:switchLine(KaRongDrawEnum.LineState.Switch_On, interactPosX, interactPosY)
end

function KaRongDrawController:goPassLine(x1, y1, x2, y2, progressX, progressY)
	local xMove = self._curPosX ~= x1 or self._curPosX ~= x2
	local yMove = self._curPosY ~= y1 or self._curPosY ~= y2

	if xMove and yMove then
		self._nextForwardX = nil
		self._nextForwardY = nil

		return
	end

	local fromDir
	local passPosList = {}

	self._nextForwardX = self._curPosX ~= x1 and x1 or x2
	self._nextForwardY = self._curPosY ~= y1 and y1 or y2

	if xMove then
		fromDir = x2 > self._curPosX and LEFT or RIGHT

		if fromDir == LEFT then
			for i = self._curPosX + 1, x1 do
				table.insert(passPosList, {
					RIGHT,
					i,
					y1
				})
			end

			self._nextForwardX = x2
		else
			for i = self._curPosX - 1, x2, -1 do
				table.insert(passPosList, {
					LEFT,
					i,
					y1
				})
			end

			self._nextForwardX = x1
		end

		progressY = nil
	else
		fromDir = y2 > self._curPosY and DOWN or UP

		if fromDir == DOWN then
			for i = self._curPosY + 1, y1 do
				table.insert(passPosList, {
					UP,
					x1,
					i
				})
			end

			self._nextForwardY = y2
		else
			for i = self._curPosY - 1, y2, -1 do
				table.insert(passPosList, {
					DOWN,
					x1,
					i
				})
			end

			self._nextForwardY = y1
		end

		progressX = nil
	end

	self._nextDir = fromDir
	self._nextProgressX = progressX
	self._nextProgressY = progressY

	if #passPosList > 0 then
		self:processPath(passPosList)
	end
end

function KaRongDrawController:goPassPos(x, y)
	if self._curPosX == x and self._curPosY == y or self._curPosX ~= x and self._curPosY ~= y then
		self._nextDir = nil
		self._nextForwardX = nil
		self._nextForwardY = nil

		return
	end

	local fromDir
	local passPosList = {}

	if self._curPosX ~= x then
		fromDir = x > self._curPosX and LEFT or RIGHT

		if fromDir == LEFT then
			for i = self._curPosX + 1, x do
				table.insert(passPosList, {
					RIGHT,
					i,
					y
				})
			end
		else
			for i = self._curPosX - 1, x, -1 do
				table.insert(passPosList, {
					LEFT,
					i,
					y
				})
			end
		end
	elseif self._curPosY ~= y then
		fromDir = y > self._curPosY and DOWN or UP

		if fromDir == DOWN then
			for i = self._curPosY + 1, y do
				table.insert(passPosList, {
					UP,
					x,
					i
				})
			end
		else
			for i = self._curPosY - 1, y, -1 do
				table.insert(passPosList, {
					DOWN,
					x,
					i
				})
			end
		end
	end

	self._nextProgressX = nil
	self._nextProgressY = nil

	if #passPosList > 0 then
		return self:processPath(passPosList)
	end
end

function KaRongDrawController:processPath(passPosList)
	for _, pos in ipairs(passPosList) do
		local isChekPoint = false
		local goDir, nextX, nextY = pos[1], pos[2], pos[3]
		local isBack = self:isBackward(nextX, nextY)

		if not isBack and next(self._alertMoMap) then
			return
		end

		local mo = KaRongDrawModel.instance:getObjAtLine(self._curPosX, self._curPosY, nextX, nextY)

		if mo ~= nil and mo.obstacle then
			self._alertMoMap[mo.key] = KaRongDrawEnum.MazeAlertType.VisitBlock
		end

		local endPoint = false
		local nextKey = KaRongDrawHelper.getPosKey(nextX, nextY)
		local lineKey = KaRongDrawHelper.getLineKey(self._curPosX, self._curPosY, nextX, nextY)

		if isBack then
			self._alertMoMap[lineKey] = nil

			local curKey = KaRongDrawHelper.getPosKey(self._curPosX, self._curPosY)

			self._alertMoMap[curKey] = nil
			mo = KaRongDrawModel.instance:getObjAtPos(self._curPosX, self._curPosY)

			if mo and mo.objType == KaRongDrawEnum.MazeObjType.CheckPoint and not self:alreadyPassed(mo.x, mo.y, true) then
				self._passedCheckPoint[mo.key] = nil
			end
		else
			if not self:canPassLine(nextX, nextY) then
				self._alertMoMap[lineKey] = KaRongDrawEnum.MazeAlertType.DisconnectLine
			elseif self:alreadyPassed(nextX, nextY) then
				self._alertMoMap[nextKey] = KaRongDrawEnum.MazeAlertType.VisitRepeat
			end

			mo = KaRongDrawModel.instance:getObjAtPos(nextX, nextY)

			if mo ~= nil then
				if mo.objType == KaRongDrawEnum.MazeObjType.CheckPoint then
					self._passedCheckPoint[mo.key] = 1
					isChekPoint = true
				elseif mo.objType == KaRongDrawEnum.MazeObjType.End then
					endPoint = true
				end
			end
		end

		if isBack then
			self._passedPosX[#self._passedPosX] = nil
			self._passedPosY[#self._passedPosY] = nil
		else
			table.insert(self._passedPosX, nextX)
			table.insert(self._passedPosY, nextY)
		end

		self._curPosX = nextX
		self._curPosY = nextY
		self._nextDir = goDir
		self._lineDirty = true

		if self._curAvatarPos then
			self:processAvatarPos(goDir, isBack)
		end

		if endPoint and not self:passAllCheckPoint() then
			self._alertMoMap[nextKey] = KaRongDrawEnum.MazeAlertType.VisitRepeat
		end

		if isChekPoint and not next(self._alertMoMap) then
			return true
		end
	end
end

function KaRongDrawController:canPassLine(nextPosX, nextPosY)
	local lineState = KaRongDrawModel.instance:getMapLineState(self._curPosX, self._curPosY, nextPosX, nextPosY)

	return lineState ~= KaRongDrawEnum.LineState.Disconnect and lineState ~= KaRongDrawEnum.LineState.Switch_Off
end

function KaRongDrawController:goBackPos()
	local len = #self._passedPosX

	if len >= 2 then
		self:goPassPos(self._passedPosX[len - 1], self._passedPosY[len - 1])

		for i = len - 1, 2, -1 do
			local posX = self._passedPosX[i]
			local posY = self._passedPosY[i]
			local objMo = KaRongDrawModel.instance:getObjAtPos(posX, posY)

			if objMo then
				break
			end

			self:goPassPos(self._passedPosX[i - 1], self._passedPosY[i - 1])
		end
	end
end

function KaRongDrawController:isBackward(nextX, nextY)
	return #self._passedPosX > 1 and self._passedPosX[#self._passedPosX - 1] == nextX and self._passedPosY[#self._passedPosY - 1] == nextY
end

function KaRongDrawController:alreadyPassed(x, y, withoutTop)
	if self._passedPosX then
		if not #self._passedPosX then
			local pasPointCount = 0

			if withoutTop then
				if not (pasPointCount - 1) then
					local len = pasPointCount

					for i = 1, len do
						local tmpX, tmpY = self._passedPosX[i], self._passedPosY[i]

						if tmpX == x and tmpY == y then
							return true
						end
					end

					return false
				end
			end
		end
	end
end

function KaRongDrawController:alreadyAvatarPassed(x, y, withoutTop)
	local pasPointCount = #self._avatarPassedPos

	if withoutTop then
		if not (pasPointCount - 1) then
			local len = pasPointCount

			for i = 1, len do
				local pos = self._avatarPassedPos[i]

				if pos.x == x and pos.y == y then
					return true
				end
			end

			return false
		end
	end
end

function KaRongDrawController:alreadyCheckPoint(mo)
	if self._passedCheckPoint[mo] or self._passedCheckPoint1[mo] then
		return true
	end

	return false
end

function KaRongDrawController:getLastPos()
	return self._curPosX, self._curPosY
end

function KaRongDrawController:getAvatarPos()
	return self._curAvatarPos
end

function KaRongDrawController:getPassedPoints()
	return self._passedPosX, self._passedPosY
end

function KaRongDrawController:getAvatarPassPoints()
	return self._avatarPassedPos
end

function KaRongDrawController:getProgressLine()
	return self._nextForwardX, self._nextForwardY, self._nextProgressX, self._nextProgressY
end

function KaRongDrawController:getAlertMap()
	return self._alertMoMap
end

function KaRongDrawController:hasAlertObj()
	if next(self._alertMoMap) then
		return true
	end

	if self._passedPosX then
		if not #self._passedPosX then
			local len = 0

			if len >= 2 then
				if self._passedPosX then
					local lastPosX = self._passedPosX[len]

					if self._passedPosY then
						local lastPosY = self._passedPosY[len]
						local objMo = KaRongDrawModel.instance:getObjAtPos(lastPosX, lastPosY)

						if not objMo then
							return true
						end
					end
				end
			end

			return false
		end
	end
end

function KaRongDrawController:isLineDirty()
	return self._lineDirty
end

function KaRongDrawController:resetLineDirty()
	self._lineDirty = false
end

function KaRongDrawController:isGameClear()
	if self:hasAlertObj() then
		return false
	end

	local endX, endY = KaRongDrawModel.instance:getEndPoint()

	if self._curPosX ~= endX or self._curPosY ~= endY then
		return false
	end

	local endPos = KaRongDrawModel.instance:getAvatarEndPos()

	if endPos and (self._curAvatarPos.x ~= endPos.x or self._curAvatarPos.y ~= endPos.y) then
		return false
	end

	if not self:passAllCheckPoint() then
		return false
	end

	return true
end

function KaRongDrawController:release()
	self._curPosX = nil
	self._curPosY = nil
	self._curAvatarPos = nil
	self._passedPosX = nil
	self._passedPosY = nil
	self._passedCheckPoint = nil
	self._passedCheckPoint1 = nil
	self._alertMoMap = nil
	self._nextDir = nil
	self._nextForwardX = nil
	self._nextForwardY = nil
	self._nextProgressX = nil
	self._nextProgressY = nil
	self._lineDirty = nil
	self.skillCnt = 0
end

function KaRongDrawController:processAvatarPos(dir, isBack)
	local curX, curY = self._curAvatarPos.x, self._curAvatarPos.y
	local nextX, nextY

	if dir == UP and curY ~= KaRongDrawEnum.mazeDrawHeight then
		nextX = curX
		nextY = curY + 1
	elseif dir == DOWN and curY ~= 1 then
		nextX = curX
		nextY = curY - 1
	elseif dir == RIGHT and curX ~= 1 then
		nextX = curX - 1
		nextY = curY
	elseif dir == LEFT and curX ~= KaRongDrawEnum.mazeDrawWidth then
		nextX = curX + 1
		nextY = curY
	end

	if isBack then
		local mo = KaRongDrawModel.instance:getObjAtPos(curX, curY)

		if mo and mo.objType == KaRongDrawEnum.MazeObjType.CheckPoint then
			self._passedCheckPoint1[mo.key] = nil
		end

		if nextX then
			local key = KaRongDrawHelper.getLineKey(curX, curY, nextX, nextY)

			self._alertMoMap[key] = nil
			self._avatarPassedPos[#self._avatarPassedPos] = nil
			self._curAvatarPos.x = nextX
			self._curAvatarPos.y = nextY
		end
	elseif nextX then
		local lineKey = KaRongDrawHelper.getLineKey(curX, curY, nextX, nextY)
		local lineState = KaRongDrawModel.instance:getMapLineState(curX, curY, nextX, nextY)
		local canPassLine = lineState ~= KaRongDrawEnum.LineState.Disconnect and lineState ~= KaRongDrawEnum.LineState.Switch_Off

		if not canPassLine then
			self._alertMoMap[lineKey] = KaRongDrawEnum.MazeAlertType.DisconnectLine
		end

		local mo = KaRongDrawModel.instance:getObjAtLine(curX, curY, nextX, nextY)

		if mo and mo.obstacle then
			self._alertMoMap[lineKey] = KaRongDrawEnum.MazeAlertType.VisitBlock
		end

		mo = KaRongDrawModel.instance:getObjAtPos(nextX, nextY)

		if mo ~= nil and mo.objType == KaRongDrawEnum.MazeObjType.CheckPoint then
			self._passedCheckPoint1[mo.key] = 1
		end

		self._avatarPassedPos[#self._avatarPassedPos + 1] = Vector2.New(nextX, nextY)
	end

	if nextX then
		self._curAvatarPos.x = nextX
		self._curAvatarPos.y = nextY

		self:dispatchEvent(KaRongDrawEvent.UpdateAvatarPos)
	end
end

function KaRongDrawController:addSkillCnt()
	AudioMgr.instance:trigger(AudioEnum3_0.ActKaRong.play_ui_lushang_skill_get)

	self.skillCnt = self.skillCnt + 1

	self:dispatchEvent(KaRongDrawEvent.SkillCntChange, true)
end

function KaRongDrawController:setUsingSkill(bool)
	self.usingSkill = bool

	self:dispatchEvent(KaRongDrawEvent.UsingSkill, bool)
end

function KaRongDrawController:useSkill(mo)
	mo.obstacle = false

	KaRongDrawModel.instance:setMapLineState(mo.x1, mo.y1, mo.x2, mo.y2, KaRongDrawEnum.LineState.Switch_On)

	self.skillCnt = self.skillCnt - 1

	self:setUsingSkill(false)
	self:dispatchEvent(KaRongDrawEvent.SkillCntChange)
end

function KaRongDrawController:passAllCheckPoint()
	local needCnt = #KaRongDrawModel.instance:getCheckPointMoList()
	local cnt1 = tabletool.len(self._passedCheckPoint)
	local cnt2 = tabletool.len(self._passedCheckPoint1)

	if needCnt <= cnt1 + cnt2 then
		return true
	end

	return false
end

KaRongDrawController.instance = KaRongDrawController.New()

return KaRongDrawController
