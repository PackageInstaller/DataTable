-- chunkname: @modules/logic/playercard/view/NewPlayerCardView_210021.lua

module("modules.logic.playercard.view.NewPlayerCardView_210021", package.seeall)

local NewPlayerCardView_210021 = class("NewPlayerCardView_210021", NewPlayerCardView)
local BUBBLE_SPEED = 80
local BUBBLE_SPEED_VAR = 60
local BUBBLE_ROT_DAMPING = 2.5
local BUBBLE_ROT_IMPULSE = 0.25
local BUBBLE_COUNT = 8

function NewPlayerCardView_210021:addEvents()
	NewPlayerCardView_210021.super.addEvents(self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
end

function NewPlayerCardView_210021:removeEvents()
	NewPlayerCardView_210021.super.removeEvents(self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
end

function NewPlayerCardView_210021:_onScreenSizeChange()
	self:_refreshRootRange()
	self:_refreshBubbleData()
end

function NewPlayerCardView_210021:_refreshRootRange()
	local uiRoot = ViewMgr.instance:getUIRoot()

	if uiRoot then
		local width = recthelper.getWidth(uiRoot.transform)
		local height = recthelper.getHeight(uiRoot.transform)

		self._boxScale = transformhelper.getLocalScale(self._goBox.transform)

		local y = recthelper.getAnchorY(self._goBox.transform)

		recthelper.setAnchorY(self._gobubble.transform, -y * (1 / self._boxScale))
		recthelper.setSize(self._gobubble.transform, width * (1 / self._boxScale), height * (1 / self._boxScale))
	end
end

function NewPlayerCardView_210021:_refreshRoot()
	self:_refreshRootRange()

	local containerTf = self._gobubble.transform

	self._bubbleHalfW = recthelper.getWidth(containerTf) / 2
	self._bubbleHalfH = recthelper.getHeight(containerTf) / 2
end

function NewPlayerCardView_210021:_editableInitView()
	NewPlayerCardView_210021.super._editableInitView(self)

	self._goBox = gohelper.findChild(self.viewGO, "root/box")
	self._gobubble = gohelper.findChild(self.viewGO, "root/box/box_dec01/UIEff_BgGraphicsAni/#go_bubble")

	self:_refreshRootRange()

	self._gobubbleItem = gohelper.findChild(self._gobubble, "item")

	local width = recthelper.getWidth(self._gobubbleItem.transform)
	local height = recthelper.getHeight(self._gobubbleItem.transform)

	self._bubbleRadio = math.min(width, height) / 2

	gohelper.setActive(self._gobubbleItem, false)

	self._bubbles = self:getUserDataTb_()

	for i = 1, BUBBLE_COUNT do
		local item = self:_getBubbleItem(i)

		gohelper.setActive(item.go, true)
	end
end

function NewPlayerCardView_210021:_getBubbleItem(index)
	local item = self._bubbles[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._gobubbleItem, "bubble_" .. index)
		self._bubbles[index] = item
		item.simage = gohelper.findChildSingleImage(item.go, "icon")

		local random = math.random(1, 2)
		local path = ResUrl.getPlayerCardIcon("210021/playercard_duckbubble_" .. random)

		item.simage:LoadImage(path)

		local rorate = random == 1 and -40 or 30

		transformhelper.setLocalRotation(item.simage.transform, 0, 0, rorate)
	end

	return item
end

function NewPlayerCardView_210021:onOpen(tempSkinId)
	NewPlayerCardView_210021.super.onOpen(self, tempSkinId)
	gohelper.setActive(self._gobubble, false)
	TaskDispatcher.cancelTask(self._startBubbleUpdate, self)
	TaskDispatcher.runDelay(self._startBubbleUpdate, self, 3)
end

function NewPlayerCardView_210021:_refreshBubbleData()
	local containerTf = self._gobubble.transform

	self._bubbleHalfW = recthelper.getWidth(containerTf) / 2
	self._bubbleHalfH = recthelper.getHeight(containerTf) / 2
	self._bubbleDatas = self:getUserDataTb_()

	local halfW = self._bubbleHalfW
	local halfH = self._bubbleHalfH

	for i, item in ipairs(self._bubbles) do
		local tf = item.go.transform
		local startX = (math.random() * 2 - 1) * (halfW - self._bubbleRadio)
		local startY = (math.random() * 2 - 1) * (halfH - self._bubbleRadio)

		recthelper.setAnchor(tf, startX, startY)

		local startRot = math.random() * 360

		transformhelper.setLocalRotation(tf, 0, 0, startRot)

		local angle = math.random() * math.pi * 2
		local speed = BUBBLE_SPEED + (math.random() * 2 - 1) * BUBBLE_SPEED_VAR

		self._bubbleDatas[i] = {
			vrot = 0,
			go = item.go,
			tf = tf,
			vx = math.cos(angle) * speed,
			vy = math.sin(angle) * speed,
			radius = self._bubbleRadio,
			rot = startRot
		}
	end
end

function NewPlayerCardView_210021:_startBubbleUpdate()
	gohelper.setActive(self._gobubble, true)
	self:_refreshBubbleData()

	self._frameHandle = UpdateBeat:CreateListener(self._onBubbleFrame, self)

	UpdateBeat:AddListener(self._frameHandle)
end

function NewPlayerCardView_210021:_onBubbleFrame()
	if not self._bubbleDatas then
		return
	end

	local boxScale = transformhelper.getLocalScale(self._goBox.transform)

	if self._boxScale ~= boxScale then
		self:_refreshRoot()
	end

	local dt = Time.deltaTime
	local datas = self._bubbleDatas
	local count = #datas
	local halfW = self._bubbleHalfW
	local halfH = self._bubbleHalfH

	for i = 1, count do
		local d = datas[i]
		local x, y = recthelper.getAnchor(d.tf)

		x = x + d.vx * dt
		y = y + d.vy * dt

		local r = d.radius

		if x - r < -halfW then
			x = -halfW + r
			d.vx = math.abs(d.vx)
		elseif halfW < x + r then
			x = halfW - r
			d.vx = -math.abs(d.vx)
		end

		if y - r < -halfH then
			y = -halfH + r
			d.vy = math.abs(d.vy)
		elseif halfH < y + r then
			y = halfH - r
			d.vy = -math.abs(d.vy)
		end

		recthelper.setAnchor(d.tf, x, y)
	end

	for i = 1, count do
		local d = datas[i]

		d.rot = (d.rot + d.vrot * dt) % 360
		d.vrot = d.vrot * math.max(0, 1 - BUBBLE_ROT_DAMPING * dt)

		if math.abs(d.vrot) < 1 then
			d.vrot = 0
		end

		transformhelper.setLocalRotation(d.tf, 0, 0, d.rot)
	end

	for i = 1, count - 1 do
		local a = datas[i]
		local ax, ay = recthelper.getAnchor(a.tf)

		for j = i + 1, count do
			local b = datas[j]
			local bx, by = recthelper.getAnchor(b.tf)
			local dx = bx - ax
			local dy = by - ay
			local distSq = dx * dx + dy * dy
			local minDist = a.radius + b.radius

			if distSq < minDist * minDist and distSq > 0.0001 then
				local dist = math.sqrt(distSq)
				local nx = dx / dist
				local ny = dy / dist
				local overlap = (minDist - dist) * 0.5

				ax = ax - nx * overlap
				ay = ay - ny * overlap
				bx = bx + nx * overlap
				by = by + ny * overlap

				local va_n = a.vx * nx + a.vy * ny
				local vb_n = b.vx * nx + b.vy * ny
				local diff = vb_n - va_n

				a.vx = a.vx + diff * nx
				a.vy = a.vy + diff * ny
				b.vx = b.vx - diff * nx
				b.vy = b.vy - diff * ny

				local tx, ty = -ny, nx
				local vrel_t = (b.vx - a.vx) * tx + (b.vy - a.vy) * ty
				local rotImpulse = vrel_t * BUBBLE_ROT_IMPULSE

				a.vrot = a.vrot - rotImpulse
				b.vrot = b.vrot + rotImpulse

				recthelper.setAnchor(a.tf, ax, ay)
				recthelper.setAnchor(b.tf, bx, by)
			end
		end
	end
end

function NewPlayerCardView_210021:_stopBubbleUpdate()
	if self._frameHandle then
		UpdateBeat:RemoveListener(self._frameHandle)

		self._frameHandle = nil
	end

	self._bubbleDatas = nil
end

function NewPlayerCardView_210021:onClose()
	NewPlayerCardView_210021.super.onClose(self)
	self:_stopBubbleUpdate()

	for i, item in ipairs(self._bubbles) do
		item.simage:UnLoadImage()
	end

	TaskDispatcher.cancelTask(self._startBubbleUpdate, self)
end

return NewPlayerCardView_210021
