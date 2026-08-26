-- chunkname: @modules/logic/versionactivity3_0/karong/model/KaRongDrawModel.lua

module("modules.logic.versionactivity3_0.karong.model.KaRongDrawModel", package.seeall)

local KaRongDrawModel = class("KaRongDrawModel", BaseModel)

function KaRongDrawModel:reInit()
	self:release()
end

function KaRongDrawModel:release()
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
	self._interactPosX = nil
	self._interactPosY = nil
	self._effectDoneMap = nil
	self._avatarStartPos = nil
	self._avatarEndPos = nil
	self._checkPoints = {}

	self:clear()
end

function KaRongDrawModel:startGame(elementCo)
	self:release()
	self:decode(elementCo.param)

	self._elementCo = elementCo
end

function KaRongDrawModel:decode(mapInfoJson)
	self._objMap = {}
	self._blockMap = {}
	self._lineMap = {}
	self._interactCtrlMap = {}

	local mapCo = cjson.decode(mapInfoJson)

	self._width = mapCo.width
	self._height = mapCo.height

	self:decodeObj(self._blockMap, mapCo.blockMap)
	self:decodeObj(self._objMap, mapCo.objMap)
	self:initMapLineState(mapCo)
	self:findStartAndEndPos()
	self:initConst()
end

function KaRongDrawModel:findStartAndEndPos()
	for _, v in pairs(self._objMap) do
		if v.objType == KaRongDrawEnum.MazeObjType.Start then
			if v.subType == KaRongDrawEnum.MazeObjSubType.Default or v.subType == KaRongDrawEnum.MazeObjSubType.Three then
				self._startPosX = v.x
				self._startPosY = v.y
			end

			if v.subType == KaRongDrawEnum.MazeObjSubType.Two or v.subType == KaRongDrawEnum.MazeObjSubType.Three then
				self._avatarStartPos = Vector2.New(v.x, v.y)
			end
		elseif v.objType == KaRongDrawEnum.MazeObjType.End then
			if v.subType == KaRongDrawEnum.MazeObjSubType.Default or v.subType == KaRongDrawEnum.MazeObjSubType.Three then
				self._endPosX = v.x
				self._endPosY = v.y
			end

			if v.subType == KaRongDrawEnum.MazeObjSubType.Two or v.subType == KaRongDrawEnum.MazeObjSubType.Three then
				self._avatarEndPos = Vector2.New(v.x, v.y)
			end
		end
	end
end

function KaRongDrawModel:decodeObj(map, configMap)
	if not configMap then
		return
	end

	for _, co in pairs(configMap) do
		local keySplit = string.splitToNumber(co.key, "_")
		local mo
		local keyLen = #keySplit

		if keyLen <= 2 then
			mo = self:createMOByPos(keySplit[1], keySplit[2], co)

			if co.type == KaRongDrawEnum.MazeObjType.CheckPoint then
				self._checkPoints[#self._checkPoints + 1] = mo
			end
		elseif keyLen >= 4 then
			mo = self:createMOByLine(keySplit[1], keySplit[2], keySplit[3], keySplit[4], co)
		end

		map[co.key] = mo
	end
end

function KaRongDrawModel:createMOByPos(x, y, co)
	local mo = KaRongDrawMO.New()

	mo:initByPos(x, y, co.type, co.subType, co.group, co.priority, co.iconUrl, co.effects, co.interactLines)
	self:addAtLast(mo)

	return mo
end

function KaRongDrawModel:createMOByLine(x1, y1, x2, y2, co)
	local mo = KaRongDrawMO.New()

	mo:initByLine(x1, y1, x2, y2, co.type, co.subType, co.group, co.priority, co.iconUrl)
	self:addAtLast(mo)

	return mo
end

function KaRongDrawModel:initMapLineState(mapCo)
	local blockMap = mapCo and mapCo.blockMap

	for _, blockCo in pairs(blockMap or {}) do
		local pos = blockCo.key

		self._lineMap[pos] = KaRongDrawEnum.LineState.Disconnect
	end

	if mapCo then
		if not mapCo.objMap then
			local objMap = {}

			for _, objMo in pairs(objMap) do
				if objMo.interactLines then
					for _, interactLine in pairs(objMo.interactLines) do
						local key = KaRongDrawHelper.getLineKey(interactLine.x1, interactLine.y1, interactLine.x2, interactLine.y2)

						self._lineMap[key] = KaRongDrawEnum.LineState.Switch_Off
						self._interactCtrlMap[key] = objMo
					end
				end
			end
		end
	end
end

function KaRongDrawModel:initConst()
	local w, h = self:getGameSize()

	self._startX = -w * 0.5 - 0.5
	self._startY = -h * 0.5 - 0.5
end

function KaRongDrawModel:getStartPoint()
	return self._startPosX, self._startPosY
end

function KaRongDrawModel:getAvatarStartPos()
	return self._avatarStartPos
end

function KaRongDrawModel:getEndPoint()
	return self._endPosX, self._endPosY
end

function KaRongDrawModel:getAvatarEndPos()
	return self._avatarEndPos
end

function KaRongDrawModel:getElementCo()
	return self._elementCo
end

function KaRongDrawModel:setGameStatus(isSucc)
	if self._elementCo then
		self._statusMap = self._statusMap or {}
		self._statusMap[self._elementCo.id] = isSucc
	end
end

function KaRongDrawModel:getObjAtPos(x, y)
	local key = KaRongDrawHelper.getPosKey(x, y)

	return self._objMap[key]
end

function KaRongDrawModel:getObjAtLine(x1, y1, x2, y2)
	local key = KaRongDrawHelper.getLineKey(x1, y1, x2, y2)

	return self._blockMap[key]
end

function KaRongDrawModel:getObjByLineKey(key)
	return self._blockMap[key]
end

function KaRongDrawModel:getGameSize()
	return self._width or 0, self._height or 0
end

function KaRongDrawModel:getUIGridSize()
	return KaRongDrawEnum.mazeUIGridWidth, KaRongDrawEnum.mazeUIGridHeight
end

function KaRongDrawModel:getObjectAnchor(x, y)
	return self:getGridCenterPos(x - 0.5, y - 0.5)
end

function KaRongDrawModel:getLineObjectAnchor(x1, y1, x2, y2)
	if x1 == x2 then
		return self:getGridCenterPos(x1 - 0.5, math.min(y1, y2))
	elseif y1 == y2 then
		return self:getGridCenterPos(math.min(x1, x2), y1 - 0.5)
	else
		logError("错误线段,x和y均不相等")
	end
end

function KaRongDrawModel:getLineAnchor(x1, y1, x2, y2)
	if x1 == x2 then
		return self:getGridCenterPos(x1 - 0.5, math.min(y1, y2))
	elseif y1 == y2 then
		return self:getGridCenterPos(math.min(x1, x2), y1 - 0.5)
	else
		logError("错误线段,x和y均不相等")
	end
end

function KaRongDrawModel:getGridCenterPos(x, y)
	local w, h = self:getUIGridSize()

	return (self._startX + x) * w, (self._startY + y) * h
end

function KaRongDrawModel:getIntegerPosByTouchPos(touchX, touchY)
	local w, h = self:getUIGridSize()
	local x = math.floor((touchX - (self._startX + 0.5) * w) / w)
	local y = math.floor((touchY - (self._startY + 0.5) * h) / h)
	local totalW, totalH = self:getGameSize()
	local posX, posY = -1, -1

	if x >= 0 and x < totalW and y >= 0 and y < totalH then
		posY = y + 1
		posX = x + 1
	else
		local lineWidth = KaRongDrawEnum.mazeUILineWidth * 0.5

		if x >= 0 and x < totalW then
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
	end

	return posX, posY
end

function KaRongDrawModel:getClosePosByTouchPos(x, y)
	local w, h = self:getUIGridSize()
	local x1, y1 = self:getIntegerPosByTouchPos(x, y)

	if x1 ~= -1 then
		local lineWidthHalf = KaRongDrawEnum.mazeUILineWidth * 0.5
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

function KaRongDrawModel:getLineFieldByTouchPos(x, y)
	local w, h = self:getUIGridSize()
	local x1, y1 = self:getIntegerPosByTouchPos(x, y)
	local x2, y2 = x1, y1
	local progressX, progressY

	if x1 ~= -1 then
		local lineWidth = KaRongDrawEnum.mazeUILineWidth * 0.5
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

function KaRongDrawModel:getMapLineState(startPosX, startPosY, endStartPosX, endStartPosY)
	local key = KaRongDrawHelper.getLineKey(startPosX, startPosY, endStartPosX, endStartPosY)

	return self._lineMap and self._lineMap[key]
end

function KaRongDrawModel:getAllMapLines()
	return self._lineMap
end

function KaRongDrawModel:getInteractLineCtrl(x1, y1, x2, y2)
	local key = KaRongDrawHelper.getLineKey(x1, y1, x2, y2)

	return self._interactCtrlMap and self._interactCtrlMap[key]
end

function KaRongDrawModel:getPawnIconUrl(isAvatar)
	if isAvatar then
		return "v3a0_karong_puzzle_head2"
	else
		return "v3a0_karong_puzzle_head"
	end
end

function KaRongDrawModel:setMapLineState(startPosX, startPosY, endStartPosX, endStartPosY, lineState)
	local key = KaRongDrawHelper.getLineKey(startPosX, startPosY, endStartPosX, endStartPosY)

	self._lineMap[key] = lineState
end

function KaRongDrawModel:switchLine(lineState, interactPosX, interactPosY)
	local interactLines = self:getInteractLines(interactPosX, interactPosY)

	if not interactLines then
		return
	end

	for _, interactLine in pairs(interactLines) do
		local startPosX = interactLine.x1
		local startPosY = interactLine.y1
		local endPosX = interactLine.x2
		local endPosY = interactLine.y2
		local key = KaRongDrawHelper.getLineKey(startPosX, startPosY, endPosX, endPosY)

		self._lineMap[key] = lineState

		KaRongDrawController.instance:dispatchEvent(KaRongDrawEvent.SwitchLineState, startPosX, startPosY, endPosX, endPosY)
	end

	if lineState == KaRongDrawEnum.LineState.Connect then
		self._interactPosX = interactPosX
		self._interactPosY = interactPosY
	else
		self._interactPosX = nil
		self._interactPosY = nil
	end
end

function KaRongDrawModel:getInteractLines(interactPosX, interactPosY)
	local interactObj = self:getObjAtPos(interactPosX, interactPosY)

	if interactObj then
		return interactObj.interactLines
	end
end

function KaRongDrawModel:getInteractPos()
	return self._interactPosX, self._interactPosY
end

function KaRongDrawModel:setTriggerEffectDone(posX, posY)
	self._effectDoneMap = self._effectDoneMap or {}

	local key = KaRongDrawHelper.getPosKey(posX, posY)

	self._effectDoneMap[key] = true
end

function KaRongDrawModel:hasTriggerEffect(posX, posY)
	local key = KaRongDrawHelper.getPosKey(posX, posY)

	return self._effectDoneMap and self._effectDoneMap[key]
end

function KaRongDrawModel:canTriggerEffect(posX, posY)
	local hasTrigger = self:hasTriggerEffect(posX, posY)

	if hasTrigger then
		return false
	end

	local mo = self:getObjAtPos(posX, posY)

	if not mo then
		return false
	elseif #mo.effects == 0 then
		return false
	end

	return true
end

function KaRongDrawModel:getTriggerEffectDoneMap()
	return self._effectDoneMap
end

function KaRongDrawModel:setTriggerEffectDoneMap(effectDoneMap)
	self._effectDoneMap = effectDoneMap
end

function KaRongDrawModel:getCheckPointMoList()
	return self._checkPoints
end

KaRongDrawModel.instance = KaRongDrawModel.New()

return KaRongDrawModel
