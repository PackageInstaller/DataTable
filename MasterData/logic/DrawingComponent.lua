-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawandguess/view/DrawingComponent.lua

module("logic.extensions.drawandguess.view.DrawingComponent", package.seeall)

local DrawingComponent = class("DrawingComponent")

DrawingComponent.BrushType = {
	Draw = 1,
	Clear = 2
}

local floor = math.floor

function DrawingComponent:ctor()
	self.isStartEraser = false
	self.isEndEraser = false
	self.rawImage = nil
	self.drawTex = nil
	self.mWidth = 0
	self.mHeight = 0
	self.brushSize = 10
	self.brushSizeSQ = self.brushSize * self.brushSize
	self.totalColorA = 0
	self.curColorA = 0
	self.startDraw = false
	self.twoPoints = false
	self.lastPos = nil
	self.startPos = nil
	self.radius = 12
	self.distance = 1
	self._canvasColor = Color.New(1, 1, 1, 1)
	self._brustColor = Color.New(0, 0, 0, 1)
	self._modifyBrustColor = Color.New(0, 0, 0, 1)
	self._isClear = false
	self._preDrawMaxCount = 200
	self._colorIdx = 1
	self._colorList = {}
end

function DrawingComponent:drawTexOnImg(rawImage, width, height, col)
	self.rawImage = rawImage

	if self.drawTex then
		if self.drawTex.width ~= width or self.drawTex.height ~= height then
			goutil.destroy(self.drawTex)

			self.drawTex = UnityEngine.Texture2D.New(width, height)
		end
	else
		self.drawTex = UnityEngine.Texture2D.New(width, height)
	end

	self.mWidth = self.drawTex.width
	self.mHeight = self.drawTex.height

	for i = 0, width - 1 do
		for j = 0, height - 1 do
			self.drawTex:SetPixel(i, j, col)
		end
	end

	self.drawTex:Apply()

	self.midWidth = self.mWidth * 0.5
	self.midHeight = self.mHeight * 0.5
	self.rawImage.texture = self.drawTex
	self.totalColorA = self.drawTex:GetPixels().Length
	self.curColorA = 0
	self.isEndEraser = false
	self.isStartEraser = false

	local triggerGo = self.rawImage.gameObject

	self._dragHandler = DragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
		self:OnDrag(eventData)
	end)
	self._pointerDownHandler = PointerDownHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
		self:OnPointerDown(eventData)
	end)
	self._pointerUpHandler = PointerUpHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
		self:OnPointerUp(eventData)
	end)
	self._isPush = self._isPush and table.clear(self._isPush) or {}
end

function DrawingComponent:setBrushSize(brushSize)
	self.brushSize = brushSize or 10
	self.brushSizeSQ = self.brushSize * self.brushSize
end

function DrawingComponent:getBrushSize()
	return self.brushSize
end

function DrawingComponent:setBrushType(bType)
	self._brushType = bType

	if bType == DrawingComponent.BrushType.Clear then
		self._colorIdx = 0
	end
end

function DrawingComponent:getBrushType()
	return self._brushType
end

function DrawingComponent:setBrushColor(idx)
	self._colorIdx = idx

	local d = self._colorList[self._colorIdx]

	if not d then
		self._colorIdx = 0
	else
		self._brustColor.r = d.r
		self._brustColor.g = d.g
		self._brustColor.b = d.b
		self._brustColor.a = 1
	end
end

function DrawingComponent:setBrushColorStrList(list)
	self._colorList = {}

	for i, v in ipairs(list) do
		local col = Framework.ColorUtil.ParseColor(v)

		table.insert(self._colorList, {
			r = col.r,
			g = col.g,
			b = col.b
		})
	end
end

function DrawingComponent:setCanvasColor(col)
	self._canvasColor = col
end

function DrawingComponent:regDragHandler(pointDownCallBack, dragCallBack, pointUpCallBack)
	self._pointDownCallBack = pointDownCallBack
	self._dragCallBack = dragCallBack
	self._pointUpCallBack = pointUpCallBack
end

function DrawingComponent:onExit()
	if self.drawTex then
		goutil.destroy(self.drawTex)

		self.drawTex = nil
	end
end

function DrawingComponent:dispose()
	if self.rawImage then
		local triggerGo = self.rawImage.gameObject

		DragHandler.Get(triggerGo):RemoveLuaHandler(self._dragHandler)
		PointerDownHandler.Get(triggerGo):RemoveLuaHandler(self._pointerDownHandler)
		PointerUpHandler.Get(triggerGo):RemoveLuaHandler(self._pointerUpHandler)
	end

	self._startDragCallBack = nil
	self._dragCallBack = nil
	self._endDragCallBack = nil

	if self.drawTex then
		goutil.destroy(self.drawTex)

		self.drawTex = nil
	end
end

function DrawingComponent:OnPointerDown(eventData)
	if self.isEndEraser then
		return
	end

	local col = self:_getColor()

	self._recordCount = 0
	self._recordDrawData = {
		brushType = self:getBrushType(),
		brushSize = self.brushSize,
		brushColorIdx = self._colorIdx,
		list = {}
	}
	self.startDraw = true
	self.startPos = eventData.position

	self:CheckPoint(eventData.position, true)

	if self._pointDownCallBack then
		GameUtil.callBack(self._pointDownCallBack, self._recordDrawData)
	end
end

function DrawingComponent:OnDrag(eventData)
	if self.isEndEraser then
		return
	end

	if self._recordCount < self._preDrawMaxCount then
		local pos = eventData.position

		if self.twoPoints and Vector2.Distance(self.lastPos, pos) > self.distance then
			self:CheckPoint(eventData.position, true, self.lastPos)

			self.lastPos = pos
		else
			self.twoPoints = true
			self.lastPos = eventData.position
		end
	end

	if self._dragCallBack then
		GameUtil.callBack(self._dragCallBack)
	end
end

function DrawingComponent:OnPointerUp(eventData)
	if self.isEndEraser then
		return
	end

	self.startDraw = false
	self.twoPoints = false
	self.lastPos = nil

	if self._pointUpCallBack then
		GameUtil.callBack(self._pointUpCallBack, self._recordDrawData)
	end
end

function DrawingComponent:_getColor()
	if self._brushType == DrawingComponent.BrushType.Clear then
		return self._canvasColor
	else
		if not self._colorList[self._colorIdx] then
			printError("没有设置颜色，调用一下")
		end

		return self._brustColor
	end
end

function DrawingComponent:getColorIdx()
	return self._colorIdx
end

function DrawingComponent:CheckPoint(pScreenPos, isRecordPos, lastPScreenPos)
	local mainCamera = GlobalModel.instance.uiCamera
	local worldPos = mainCamera:ScreenToWorldPoint(pScreenPos)
	local localPos = self.rawImage.gameObject.transform:InverseTransformPoint(worldPos)

	if self:_isPointLegal(localPos.x, localPos.y) then
		if isRecordPos then
			local x = floor(localPos.x + self.midWidth)
			local y = floor(localPos.y + self.midHeight)

			table.insert(self._recordDrawData.list, {
				x = x,
				y = y
			})

			self._recordCount = self._recordCount + 1
		end

		local realDrawDataMap = {}
		local realDrawDataList = {}

		self:_drawPoint(localPos.x, localPos.y, self.brushSize, self._colorIdx, realDrawDataMap, realDrawDataList)

		if lastPScreenPos then
			local lastWorldPos = mainCamera:ScreenToWorldPoint(lastPScreenPos)
			local lastLocalPos = self.rawImage.gameObject.transform:InverseTransformPoint(lastWorldPos)

			self:_drawLine(lastLocalPos.x, lastLocalPos.y, localPos.x, localPos.y, self.brushSize, self._colorIdx, realDrawDataMap, realDrawDataList)
		end

		self:_realDrawPoints(realDrawDataList)
	end
end

function DrawingComponent:_isPointLegal(localPosx, localPosy)
	return localPosx > -self.midWidth and localPosx < self.midWidth and localPosy > -self.midHeight and localPosy < self.midHeight
end

function DrawingComponent:_drawLine(x0, y0, x1, y1, brushSize, brushColorIdx, realDrawDataMap, realDrawDataList)
	if x0 > -self.midWidth and x0 < self.midWidth and y0 > -self.midHeight and y0 < self.midHeight and x1 > -self.midWidth and x1 < self.midWidth and y1 > -self.midHeight and y1 < self.midHeight then
		local dx = x1 - x0
		local dy = y1 - y0
		local steps = math.max(math.abs(dx), math.abs(dy))

		if steps == 0 then
			self:_drawPoint(x0, y0, brushSize, brushColorIdx, realDrawDataMap, realDrawDataList)
		else
			local stepX = dx / steps
			local stepY = dy / steps

			for s = 0, steps do
				local x = math.floor(x0 + stepX * s + 0.5)
				local y = math.floor(y0 + stepY * s + 0.5)

				self:_drawPoint(x, y, brushSize, brushColorIdx, realDrawDataMap, realDrawDataList)
			end
		end
	end
end

function DrawingComponent:_drawPoint(localPosx, localPosy, brushSize, brushColorIdx, realDrawDataMap, realDrawDataList)
	if self:_isPointLegal(localPosx, localPosy) then
		local brushSizeSQ = brushSize * brushSize
		local key = 0
		local drawData

		for i = localPosx - brushSize, localPosx + brushSize do
			for j = localPosy - brushSize, localPosy + brushSize do
				if brushSizeSQ >= (i - localPosx) * (i - localPosx) + (j - localPosy) * (j - localPosy) then
					local x = floor(i + self.midWidth)
					local y = floor(j + self.midHeight)

					if x >= 0 and x <= self.mWidth and y >= 0 and y <= self.mHeight then
						key = self:_getUniqueValueByXY(x, y)
						drawData = realDrawDataMap[key]

						if not realDrawDataMap[key] then
							drawData = {
								x = x,
								y = y,
								brushColorIdx = brushColorIdx,
								listIdx = #realDrawDataList + 1
							}

							table.insert(realDrawDataList, drawData)

							realDrawDataMap[key] = drawData
						else
							drawData.x = x
							drawData.y = y
							drawData.brushColorIdx = brushColorIdx
						end
					end
				end
			end
		end
	end
end

function DrawingComponent:_realDrawPoints(realDrawDataList)
	local col = Color.New(0, 0, 0, 1)

	for k, v in ipairs(realDrawDataList) do
		self:_realDrawPoint(v, col)
	end

	self.drawTex:Apply()
end

function DrawingComponent:_realDrawPoint(drawData, col)
	if not drawData.brushColorIdx or drawData.brushColorIdx <= 0 then
		col = self._canvasColor
	else
		local d = self._colorList[drawData.brushColorIdx]

		col.r = d.r
		col.g = d.g
		col.b = d.b
		col.a = 1
	end

	self.drawTex:SetPixel(drawData.x, drawData.y, col)
end

function DrawingComponent:realDrawPointsByStartEnd(realDrawDataList, startIdx, endIdx)
	local col = Color.New(0, 0, 0, 1)

	for i = startIdx, endIdx do
		local v = realDrawDataList[i]

		if not v then
			break
		end

		self:_realDrawPoint(v, col)
	end

	self.drawTex:Apply()
end

function DrawingComponent:_getUniqueValueByXY(localPosx, localPosy)
	self._cacheUniqueValue = self._cacheUniqueValue or {}

	local key = string.format("%s:%s", localPosx, localPosy)
	local value = self._cacheUniqueValue[key]

	if not value then
		value = localPosx * 100000 + localPosy * 10
		self._cacheUniqueValue[key] = localPosx * 100000 + localPosy * 10
	end

	return value
end

function DrawingComponent:modifyPixels(clearPixelList, drawPixelList, brushSize, brushColorIdx)
	local realDrawDataMap = {}
	local realDrawDataList = {}
	local key = 0
	local drawData

	for i, v in ipairs(clearPixelList) do
		key = self:_getUniqueValueByXY(v.x, v.y)
		drawData = realDrawDataMap[key]

		if not realDrawDataMap[key] then
			drawData = {
				brushColorIdx = 0,
				x = v.x,
				y = v.y,
				listIdx = #realDrawDataList + 1
			}

			table.insert(realDrawDataList, drawData)

			realDrawDataMap[key] = drawData
		else
			drawData.x = x
			drawData.y = y
		end
	end

	for i = 1, #drawPixelList - 1 do
		local localPosx1 = drawPixelList[i].x - self.midWidth
		local localPosy1 = drawPixelList[i].y - self.midHeight
		local localPosx2 = drawPixelList[i + 1].x - self.midWidth
		local localPosy2 = drawPixelList[i + 1].y - self.midHeight

		self:_drawLine(localPosx1, localPosy1, localPosx2, localPosy2, brushSize, brushColorIdx, realDrawDataMap, realDrawDataList)
	end

	self:_realDrawPoints(realDrawDataList)
end

function DrawingComponent:calFinalDrawList(drawData)
	local posList = drawData.list
	local posCnt = #posList
	local realDrawDataMap = {}
	local realDrawDataList = {}

	if posCnt <= 0 then
		return
	end

	if posCnt == 1 then
		local localPosx1 = posList[1].x - self.midWidth
		local localPosy1 = posList[1].y - self.midHeight

		self:_drawPoint(localPosx1, localPosy1, drawData.brushSize, drawData.brushColorIdx, realDrawDataMap, realDrawDataList)

		return realDrawDataList
	end

	for i = 1, #posList - 1 do
		local localPosx1 = posList[i].x - self.midWidth
		local localPosy1 = posList[i].y - self.midHeight
		local localPosx2 = posList[i + 1].x - self.midWidth
		local localPosy2 = posList[i + 1].y - self.midHeight

		self:_drawLine(localPosx1, localPosy1, localPosx2, localPosy2, drawData.brushSize, drawData.brushColorIdx, realDrawDataMap, realDrawDataList)
	end

	return realDrawDataList
end

return DrawingComponent
