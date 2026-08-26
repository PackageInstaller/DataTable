-- chunkname: @modules/logic/dungeon/model/DungeonPuzzleMazeDrawModel.lua

module("modules.logic.dungeon.model.DungeonPuzzleMazeDrawModel", package.seeall)

local DungeonPuzzleMazeDrawModel = class("DungeonPuzzleMazeDrawModel", BaseModel)

function DungeonPuzzleMazeDrawModel:reInit()
	self:release()

	self._clearMap = nil
end

function DungeonPuzzleMazeDrawModel:release()
	self._blockMap = nil
	self._objMap = nil
	self._objList = nil
	self._startX = nil
	self._startY = nil
	self._endX = nil
	self._endY = nil

	self:clear()
end

function DungeonPuzzleMazeDrawModel:initByElementCo(elementCo)
	self._cfgElement = elementCo

	self:initData(self._cfgElement.param)
end

function DungeonPuzzleMazeDrawModel:initData(content)
	self:release()
	self:initConst()

	self._objMap = {}
	self._blockMap = {}

	self:decode(content)
end

function DungeonPuzzleMazeDrawModel:decode(content)
	if string.nilorempty(content) then
		return
	end

	local strArr = string.split(content, ",")
	local offset = 1

	offset = self:decodeObjMap(self._blockMap, strArr, offset)
	offset = self:decodeObjMap(self._objMap, strArr, offset)

	for k, v in pairs(self._objMap) do
		if v.objType == DungeonPuzzleEnum.MazeObjType.Start then
			local tmpArr = string.splitToNumber(k, "_")

			self._startPosX = tmpArr[1]
			self._startPosY = tmpArr[2]
		elseif v.objType == DungeonPuzzleEnum.MazeObjType.End then
			local tmpArr = string.splitToNumber(k, "_")

			self._endPosX = tmpArr[1]
			self._endPosY = tmpArr[2]
		end
	end
end

function DungeonPuzzleMazeDrawModel:decodeObjMap(map, strArr, index)
	local len = strArr[index] and tonumber(strArr[index]) or 0

	if len > 0 then
		index = index + 1

		for i = 1, len do
			local key = strArr[index]
			local objType = tonumber(strArr[index + 1])
			local objVal = tonumber(strArr[index + 2])
			local keySplit = string.splitToNumber(key, "_")
			local mo
			local keyLen = #keySplit

			if keyLen <= 2 then
				mo = self:createMOByPos(keySplit[1], keySplit[2], objType, objVal)
			elseif keyLen >= 4 then
				mo = self:createMOByLine(keySplit[1], keySplit[2], keySplit[3], keySplit[4], objType, objVal)
			end

			map[strArr[index]] = mo
			index = index + 3
		end
	end

	return index
end

function DungeonPuzzleMazeDrawModel:createMOByPos(x, y, objType, val)
	local mo = DungeonPuzzleMazeDrawMO.New()

	mo:initByPos(x, y, objType, val)
	self:addAtLast(mo)

	return mo
end

function DungeonPuzzleMazeDrawModel:createMOByLine(x1, y1, x2, y2, objType, val)
	local mo = DungeonPuzzleMazeDrawMO.New()

	mo:initByLine(x1, y1, x2, y2, objType, val)
	self:addAtLast(mo)

	return mo
end

function DungeonPuzzleMazeDrawModel:initConst()
	local w, h = self:getGameSize()

	self._startX = -w * 0.5 - 0.5
	self._startY = -h * 0.5 - 0.5
end

function DungeonPuzzleMazeDrawModel:getStartPoint()
	return self._startPosX, self._startPosY
end

function DungeonPuzzleMazeDrawModel:getEndPoint()
	return self._endPosX, self._endPosY
end

function DungeonPuzzleMazeDrawModel:getElementCo()
	return self._cfgElement
end

function DungeonPuzzleMazeDrawModel:setClearStatus(isClear)
	if self._cfgElement then
		self._clearMap = self._clearMap or {}
		self._clearMap[self._cfgElement.id] = isClear
	end
end

function DungeonPuzzleMazeDrawModel:getClearStatus(elementId)
	if self._clearMap and self._clearMap[elementId] then
		return true
	end

	return false
end

function DungeonPuzzleMazeDrawModel:getObjAtPos(x, y)
	local key = self.getPosKey(x, y)

	return self._objMap[key]
end

function DungeonPuzzleMazeDrawModel:getObjAtLine(x1, y1, x2, y2)
	local key = self.getLineKey(x1, y1, x2, y2)

	return self._blockMap[key]
end

function DungeonPuzzleMazeDrawModel:getObjByLineKey(key)
	return self._blockMap[key]
end

function DungeonPuzzleMazeDrawModel:getGameSize()
	return DungeonPuzzleEnum.mazeDrawWidth, DungeonPuzzleEnum.mazeDrawHeight
end

function DungeonPuzzleMazeDrawModel:getUIGridSize()
	return DungeonPuzzleEnum.mazeUIGridWidth, DungeonPuzzleEnum.mazeUIGridHeight
end

function DungeonPuzzleMazeDrawModel:getObjectAnchor(x, y)
	return self:getGridCenterPos(x - 0.5, y - 0.5)
end

function DungeonPuzzleMazeDrawModel:getLineObjectAnchor(x1, y1, x2, y2)
	local x, y = x1, y1

	x = x + (x2 - x1) * 0.5 - 0.5
	y = y + (y1 - y1) * 0.5

	if y1 == y2 then
		y = y - 0.5
	end

	return self:getGridCenterPos(x, y)
end

function DungeonPuzzleMazeDrawModel:getLineAnchor(x1, y1, x2, y2)
	local x, y = x1, y1

	x = x + (x2 - x1) * 0.5 - 0.5
	y = y + (y1 - y1) * 0.5

	if y1 == y2 then
		y = y - 0.5
	end

	return self:getGridCenterPos(x, y)
end

function DungeonPuzzleMazeDrawModel:getGridCenterPos(x, y)
	local w, h = self:getUIGridSize()

	return (self._startX + x) * w, (self._startY + y) * h
end

function DungeonPuzzleMazeDrawModel:getIntegerPosByTouchPos(touchX, touchY)
	local w, h = self:getUIGridSize()
	local x = math.floor((touchX - (self._startX + 0.5) * w) / w)
	local y = math.floor((touchY - (self._startY + 0.5) * h) / h)
	local totalW, totalH = self:getGameSize()
	local posX, posY = -1, -1
	local lineWidth = DungeonPuzzleEnum.mazeUILineWidth * 0.5

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

function DungeonPuzzleMazeDrawModel:getClosePosByTouchPos(x, y)
	local w, h = self:getUIGridSize()
	local x1, y1 = self:getIntegerPosByTouchPos(x, y)

	if x1 ~= -1 then
		local lineWidthHalf = DungeonPuzzleEnum.mazeUILineWidth * 0.5
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

function DungeonPuzzleMazeDrawModel:getLineFieldByTouchPos(x, y)
	local w, h = self:getUIGridSize()
	local x1, y1 = self:getIntegerPosByTouchPos(x, y)
	local x2, y2 = x1, y1
	local originX, originY = x1, y1
	local progressX, progressY

	if x1 ~= -1 then
		local lineWidth = DungeonPuzzleEnum.mazeUILineWidth * 0.5
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

function DungeonPuzzleMazeDrawModel.getPosKey(x, y)
	return string.format("%s_%s", x, y)
end

function DungeonPuzzleMazeDrawModel.getLineKey(x1, y1, x2, y2)
	return string.format("%s_%s_%s_%s", x1, y1, x2, y2)
end

DungeonPuzzleMazeDrawModel.instance = DungeonPuzzleMazeDrawModel.New()

return DungeonPuzzleMazeDrawModel
