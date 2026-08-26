-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/base/model/PuzzleMazeDrawBaseModel.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.base.model.PuzzleMazeDrawBaseModel", package.seeall)

local PuzzleMazeDrawBaseModel = class("PuzzleMazeDrawBaseModel", BaseModel)

function PuzzleMazeDrawBaseModel:reInit()
	self:release()
end

function PuzzleMazeDrawBaseModel:release()
	self._statusMap = nil
	self._blockMap = nil
	self._objMap = nil
	self._objList = nil
	self._startX = nil
	self._startY = nil
	self._endX = nil
	self._endY = nil
	self._lineMap = nil
	self._interactCtrlMap = nil
	self._elementCo = nil

	self:clear()
end

function PuzzleMazeDrawBaseModel:startGame(elementCo)
	self:release()
	self:decode(elementCo.param)

	self._elementCo = elementCo
end

function PuzzleMazeDrawBaseModel:decode(mapInfoJson)
	self._objMap = {}
	self._blockMap = {}
	self._lineMap = {}
	self._interactCtrlMap = {}

	local mapCo = cjson.decode(mapInfoJson)

	self._width = mapCo.width
	self._height = mapCo.height
	self._pawnIconUrl = mapCo.pawnIconUrl

	self:decodeObj(self._blockMap, mapCo.blockMap)
	self:decodeObj(self._objMap, mapCo.objMap)
	self:initMapLineState(mapCo)
	self:findStartAndEndPos()
	self:initConst()
end

function PuzzleMazeDrawBaseModel:findStartAndEndPos()
	for _, v in pairs(self._objMap) do
		if v.objType == PuzzleEnum.MazeObjType.Start then
			self._startPosX = v.x
			self._startPosY = v.y
		elseif v.objType == PuzzleEnum.MazeObjType.End then
			self._endPosX = v.x
			self._endPosY = v.y
		end
	end
end

function PuzzleMazeDrawBaseModel:decodeObj(map, configMap)
	if not configMap then
		return
	end

	for _, co in pairs(configMap) do
		local keySplit = string.splitToNumber(co.key, "_")
		local mo
		local keyLen = #keySplit

		if keyLen <= 2 then
			mo = self:createMOByPos(keySplit[1], keySplit[2], co)
		elseif keyLen >= 4 then
			mo = self:createMOByLine(keySplit[1], keySplit[2], keySplit[3], keySplit[4], co)
		end

		map[co.key] = mo
	end
end

function PuzzleMazeDrawBaseModel:createMOByPos(x, y, co)
	local mo = PuzzleMazeDrawMO.New()

	mo:initByPos(x, y, co.type, co.subType, co.group, co.priority, co.iconUrl, co.effects, co.interactLines)
	self:addAtLast(mo)

	return mo
end

function PuzzleMazeDrawBaseModel:createMOByLine(x1, y1, x2, y2, co)
	local mo = PuzzleMazeDrawMO.New()

	mo:initByLine(x1, y1, x2, y2, co.type, co.subType, co.group, co.priority, co.iconUrl)
	self:addAtLast(mo)

	return mo
end

function PuzzleMazeDrawBaseModel:initMapLineState(mapCo)
	local blockMap = mapCo and mapCo.blockMap

	for _, blockCo in pairs(blockMap or {}) do
		local pos = blockCo.key

		self._lineMap[pos] = PuzzleEnum.LineState.Disconnect
	end

	local objMap = mapCo and mapCo.objMap

	for _, objMo in pairs(objMap or {}) do
		if objMo.interactLines then
			for _, interactLine in pairs(objMo.interactLines) do
				local key = PuzzleMazeHelper.getLineKey(interactLine.x1, interactLine.y1, interactLine.x2, interactLine.y2)

				self._lineMap[key] = PuzzleEnum.LineState.Switch_Off
				self._interactCtrlMap[key] = objMo
			end
		end
	end
end

function PuzzleMazeDrawBaseModel:initConst()
	local w, h = self:getGameSize()

	self._startX = -w * 0.5 - 0.5
	self._startY = -h * 0.5 - 0.5
end

function PuzzleMazeDrawBaseModel:getStartPoint()
	return self._startPosX, self._startPosY
end

function PuzzleMazeDrawBaseModel:getEndPoint()
	return self._endPosX, self._endPosY
end

function PuzzleMazeDrawBaseModel:getElementCo()
	return self._elementCo
end

function PuzzleMazeDrawBaseModel:setGameStatus(isSucc)
	if self._elementCo then
		self._statusMap = self._statusMap or {}
		self._statusMap[self._elementCo.id] = isSucc
	end
end

function PuzzleMazeDrawBaseModel:getClearStatus(elementId)
	if self._statusMap and self._statusMap[elementId] then
		return true
	end

	return false
end

function PuzzleMazeDrawBaseModel:getObjAtPos(x, y)
	local key = PuzzleMazeHelper.getPosKey(x, y)

	return self._objMap[key]
end

function PuzzleMazeDrawBaseModel:getObjAtLine(x1, y1, x2, y2)
	local key = PuzzleMazeHelper.getLineKey(x1, y1, x2, y2)

	return self._blockMap[key]
end

function PuzzleMazeDrawBaseModel:getObjByLineKey(key)
	return self._blockMap[key]
end

function PuzzleMazeDrawBaseModel:getGameSize()
	return self._width or 0, self._height or 0
end

function PuzzleMazeDrawBaseModel:getUIGridSize()
	return PuzzleEnum.mazeUIGridWidth, PuzzleEnum.mazeUIGridHeight
end

function PuzzleMazeDrawBaseModel:getObjectAnchor(x, y)
	return self:getGridCenterPos(x - 0.5, y - 0.5)
end

function PuzzleMazeDrawBaseModel:getLineObjectAnchor(x1, y1, x2, y2)
	local x, y = x1, y1

	x = x + (x2 - x1) * 0.5 - 0.5
	y = y + (y1 - y1) * 0.5

	if y1 == y2 then
		y = y - 0.5
	end

	return self:getGridCenterPos(x, y)
end

function PuzzleMazeDrawBaseModel:getLineAnchor(x1, y1, x2, y2)
	local x, y = x1, y1

	x = x + (x2 - x1) * 0.5 - 0.5
	y = y + (y1 - y1) * 0.5

	if y1 == y2 then
		y = y - 0.5
	end

	return self:getGridCenterPos(x, y)
end

function PuzzleMazeDrawBaseModel:getGridCenterPos(x, y)
	local w, h = self:getUIGridSize()

	return (self._startX + x) * w, (self._startY + y) * h
end

function PuzzleMazeDrawBaseModel:getIntegerPosByTouchPos(touchX, touchY)
	local w, h = self:getUIGridSize()
	local x = math.floor((touchX - (self._startX + 0.5) * w) / w)
	local y = math.floor((touchY - (self._startY + 0.5) * h) / h)
	local totalW, totalH = self:getGameSize()
	local posX, posY = -1, -1
	local lineWidth = PuzzleEnum.mazeUILineWidth * 0.5

	if x >= 0 and x < totalW and y >= 0 and y < totalH then
		posY = y + 1
		posX = x + 1
	elseif x >= 0 and x < totalW then
		if not (x + 1) then
			local fixX = -1

			if y >= 0 and y < totalH then
				if not (y + 1) then
					local fixY = -1
					local deltaX = touchX - (self._startX + 0.5) * w
					local deltaY = touchY - (self._startY + 0.5) * h

					if x < 0 and deltaX > -lineWidth then
						fixX = 1
					elseif totalW <= x and deltaX < totalW * w + self._startX + lineWidth then
						fixX = totalW
					end

					if y < 0 and deltaY > -lineWidth then
						fixY = 1
					elseif totalH <= y and deltaY < totalH * h + self._startY + lineWidth then
						fixY = totalH
					end

					if fixX ~= -1 and fixY ~= -1 then
						posY = fixY
						posX = fixX
					end
				end
			end
		end
	end

	return posX, posY
end

function PuzzleMazeDrawBaseModel:getClosePosByTouchPos(x, y)
	local w, h = self:getUIGridSize()
	local x1, y1 = self:getIntegerPosByTouchPos(x, y)

	if x1 ~= -1 then
		local lineWidthHalf = PuzzleEnum.mazeUILineWidth * 0.5
		local deltaX = x - (self._startX + 0.5) * w
		local startX = (x1 - 1) * w
		local outsideX = false

		if deltaX >= startX + lineWidthHalf then
			if deltaX >= startX + (w - lineWidthHalf) then
				x1 = x1 + 1
			else
				outsideX = true
			end
		end

		local deltaY = y - (self._startY + 0.5) * h
		local startY = (y1 - 1) * h
		local outsideY = false

		if deltaY >= startY + lineWidthHalf then
			if deltaY >= startY + (h - lineWidthHalf) then
				y1 = y1 + 1
			else
				outsideY = true
			end
		end

		if outsideX or outsideY then
			return -1, -1
		end
	end

	return x1, y1
end

function PuzzleMazeDrawBaseModel:getLineFieldByTouchPos(x, y)
	local w, h = self:getUIGridSize()
	local x1, y1 = self:getIntegerPosByTouchPos(x, y)
	local x2, y2 = x1, y1
	local progressX, progressY

	if x1 ~= -1 then
		local lineWidth = PuzzleEnum.mazeUILineWidth * 0.5
		local startX = (x1 - 1) * w
		local deltaX = x - (self._startX + 0.5) * w
		local outsideX = false

		if deltaX >= startX + lineWidth then
			x2 = x2 + 1

			if deltaX < startX + (w - lineWidth) then
				outsideX = true
				progressX = (deltaX - startX) / w
			else
				x1 = x1 + 1
			end
		end

		local startY = (y1 - 1) * h
		local deltaY = y - (self._startY + 0.5) * h
		local outsideY = false

		if deltaY >= startY + lineWidth then
			y2 = y2 + 1

			if deltaY < startY + (h - lineWidth) then
				outsideY = true
				progressY = (deltaY - startY) / h
			else
				y1 = y1 + 1
			end
		end

		if not outsideX or not outsideY then
			return true, x1, y1, x2, y2, progressX, progressY
		end
	end

	return false
end

function PuzzleMazeDrawBaseModel:getMapLineState(startPosX, startPosY, endStartPosX, endStartPosY)
	local key = PuzzleMazeHelper.getLineKey(startPosX, startPosY, endStartPosX, endStartPosY)

	return self._lineMap and self._lineMap[key]
end

function PuzzleMazeDrawBaseModel:getAllMapLines()
	return self._lineMap
end

function PuzzleMazeDrawBaseModel:getInteractLineCtrl(x1, y1, x2, y2)
	local key = PuzzleMazeHelper.getLineKey(x1, y1, x2, y2)

	return self._interactCtrlMap and self._interactCtrlMap[key]
end

function PuzzleMazeDrawBaseModel:pawnIconUrl()
	return self._pawnIconUrl
end

function PuzzleMazeDrawBaseModel:setMapLineState(startPosX, startPosY, endStartPosX, endStartPosY, lineState)
	local key = PuzzleMazeHelper.getLineKey(startPosX, startPosY, endStartPosX, endStartPosY)

	self._lineMap[key] = lineState
end

PuzzleMazeDrawBaseModel.instance = PuzzleMazeDrawBaseModel.New()

return PuzzleMazeDrawBaseModel
