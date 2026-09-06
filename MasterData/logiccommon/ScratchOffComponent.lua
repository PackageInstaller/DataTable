-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/components/ScratchOffComponent.lua

module("logiccommon.common.components.ScratchOffComponent", package.seeall)

local ScratchOffComponent = class("ScratchOffComponent")
local floor = math.floor

function ScratchOffComponent:ctor()
	self.isStartEraser = false
	self.isEndEraser = false
	self.rawImage = nil
	self.drawTex = nil
	self.mWidth = 0
	self.mHeight = 0
	self.brushSize = 50
	self.brushSizeSQ = self.brushSize * self.brushSize
	self.totalColorA = 0
	self.curColorA = 0
	self.startDraw = false
	self.twoPoints = false
	self.lastPos = nil
	self.startPos = nil
	self.radius = 12
	self.distance = 1
end

function ScratchOffComponent.getTiledTex(tex, width, height)
	local drawTex = UnityEngine.Texture2D.New(width, height)

	for i = 0, floor(width / tex.width) do
		for j = 0, floor(height / tex.height) do
			local dWidth = tex.width
			local dHeight = tex.height

			if width < i * tex.width + tex.width then
				dWidth = width - i * tex.width
			end

			if height < j * tex.height + tex.height then
				dHeight = height - j * tex.height
			end

			local col = tex:GetPixels(0, 0, dWidth, dHeight)

			drawTex:SetPixels(i * tex.width, j * tex.height, dWidth, dHeight, col)
		end
	end

	drawTex:Apply()

	return drawTex
end

function ScratchOffComponent:drawTexOnImg(rawImage, tex)
	self.brushSize = 50
	self.brushSizeSQ = self.brushSize * self.brushSize
	self.rawImage = rawImage

	if self.drawTex then
		if self.drawTex.width ~= tex.width or self.drawTex.height ~= tex.height then
			goutil.destroy(self.drawTex)

			self.drawTex = UnityEngine.Texture2D.New(tex.width, tex.height)
		end
	else
		self.drawTex = UnityEngine.Texture2D.New(tex.width, tex.height)
	end

	self.mWidth = self.drawTex.width
	self.mHeight = self.drawTex.height

	self.drawTex:SetPixels(tex:GetPixels())
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

function ScratchOffComponent:setBrushSize(brushSize)
	self.brushSize = brushSize or 50
	self.brushSizeSQ = self.brushSize * self.brushSize
end

function ScratchOffComponent:regDragHandler(pointDownCallBack, dragCallBack, pointUpCallBack)
	self._pointDownCallBack = pointDownCallBack
	self._dragCallBack = dragCallBack
	self._pointUpCallBack = pointUpCallBack
end

function ScratchOffComponent:onExit()
	if self.drawTex then
		goutil.destroy(self.drawTex)

		self.drawTex = nil
	end
end

function ScratchOffComponent:dispose()
	local triggerGo = self.rawImage.gameObject

	DragHandler.Get(triggerGo):RemoveLuaHandler(self._dragHandler)
	PointerDownHandler.Get(triggerGo):RemoveLuaHandler(self._pointerDownHandler)
	PointerUpHandler.Get(triggerGo):RemoveLuaHandler(self._pointerUpHandler)

	self._startDragCallBack = nil
	self._dragCallBack = nil
	self._endDragCallBack = nil

	if self.drawTex then
		goutil.destroy(self.drawTex)

		self.drawTex = nil
	end
end

function ScratchOffComponent:Beizier(points, startPos, midPos, endPos, segments)
	local d = 1 / segments

	points = points and table.clear(points) or {}

	table.insert(points, midPos)

	for i = 0, segments - 1 do
		local t = d * (i + 1)
		local pos = (1 - t) * (1 - t) * midPos + 2 * t * (1 - t) * startPos + t * t * endPos

		table.insert(points, pos)
	end

	table.insert(points, endPos)

	return points
end

function ScratchOffComponent:OnPointerDown(eventData)
	if self.isEndEraser then
		return
	end

	self.startDraw = true
	self.startPos = eventData.position

	self:CheckPoint(eventData.position)

	if self._pointDownCallBack then
		GameUtil.callBack(self._pointDownCallBack)
	end
end

function ScratchOffComponent:OnDrag(eventData)
	if self.isEndEraser then
		return
	end

	local pos = eventData.position

	if self.twoPoints and Vector2.Distance(self.lastPos, pos) > self.distance then
		local dis = Vector2.Distance(self.lastPos, pos)

		self:CheckPoint(eventData.position)

		local segments = math.floor(dis / self.radius)

		segments = segments < 1 and 1 or segments
		segments = segments >= 10 and 10 or segments
		self._points = self:Beizier(self._points, self.startPos, self.lastPos, pos, segments)

		for i, v in ipairs(self._points) do
			self:CheckPoint(v)
		end

		local len = #self._points

		if len > 2 then
			self.startPos = self._points[len - 2]
		end

		self.lastPos = pos
	else
		self.twoPoints = true
		self.lastPos = eventData.position
	end

	if self._dragCallBack then
		GameUtil.callBack(self._dragCallBack)
	end
end

function ScratchOffComponent:OnPointerUp(eventData)
	if self.isEndEraser then
		return
	end

	self.startDraw = false
	self.twoPoints = false

	if self._pointUpCallBack then
		GameUtil.callBack(self._pointUpCallBack)
	end
end

function ScratchOffComponent:CheckPoint(pScreenPos)
	local mainCamera = GlobalModel.instance.uiCamera
	local worldPos = mainCamera:ScreenToWorldPoint(pScreenPos)
	local localPos = self.rawImage.gameObject.transform:InverseTransformPoint(worldPos)

	if localPos.x > -self.midWidth and localPos.x < self.midWidth and localPos.y > -self.midHeight and localPos.y < self.midHeight then
		for i = localPos.x - self.brushSize, localPos.x + self.brushSize do
			for j = localPos.y - self.brushSize, localPos.y + self.brushSize do
				if (i - localPos.x) * (i - localPos.x) + (j - localPos.y) * (j - localPos.y) <= self.brushSizeSQ then
					local x = floor(i + self.midWidth)
					local y = floor(j + self.midHeight)

					if x >= 0 and x <= self.mWidth and y >= 0 and y <= self.mHeight then
						self._isPush[x] = self._isPush[x] or {}

						if not self._isPush[x][y] then
							local col = Color.New(0, 0, 0, 0)

							self.drawTex:SetPixel(x, y, col)

							self._isPush[x][y] = true
						end
					end
				end
			end
		end

		self.isStartEraser = self.isStartEraser or true

		self.drawTex:Apply()
	end
end

return ScratchOffComponent
