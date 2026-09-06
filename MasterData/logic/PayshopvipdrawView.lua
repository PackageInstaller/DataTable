-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshopvipdrawView.lua

module("logic.extensions.payshop.view.PayshopvipdrawView", package.seeall)

local PayshopvipdrawView = class("PayshopvipdrawView", ViewComponent)

function PayshopvipdrawView:ctor()
	PayshopvipdrawView.super.ctor(self)
end

function PayshopvipdrawView:buildUI()
	PayshopvipdrawView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnStart = self:getBtn("btnStart")
	self._itemconTr = self:getGo("itemcon").transform
	self._itemGo = self:getGo("itemcon/item")

	goutil.setActive(self._itemGo, false)
	self:_initItems()
end

function PayshopvipdrawView:bindEvents()
	PayshopvipdrawView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnStart:AddClickListener(self._onClickbtnStart, self)
end

function PayshopvipdrawView:unbindEvents()
	PayshopvipdrawView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnStart:RemoveClickListener()
end

function PayshopvipdrawView:destroyUI()
	PayshopvipdrawView.super.destroyUI(self)
end

function PayshopvipdrawView:onEnter()
	PayshopvipdrawView.super.onEnter(self)

	self._isDrawing = false
end

function PayshopvipdrawView:onEnterFinished()
	PayshopvipdrawView.super.onEnterFinished(self)
end

function PayshopvipdrawView:onExit()
	PayshopvipdrawView.super.onExit(self)
	removetimer(self._updateDraw, self)

	for k, v in pairs(self._itemList) do
		goutil.setActive(v.selectGo, false)
	end
end

function PayshopvipdrawView:onExitFinished()
	PayshopvipdrawView.super.onExitFinished(self)
end

function PayshopvipdrawView:_onClickbtnClose()
	self:close()
end

function PayshopvipdrawView:_onClickbtnStart()
	self:_startDraw()
end

function PayshopvipdrawView:_initItems()
	self._itemList = {}
	self._cfgLen = 6

	for i = 1, self._cfgLen do
		local item = self._itemList[i]

		if not item then
			local go = goutil.cloneAndSetParent(self._itemGo, self._itemconTr)

			goutil.setActive(go, true)

			item = {
				con = goutil.findChild(go, "con"),
				selectGo = goutil.findChild(go, "select")
			}

			goutil.setActive(item.selectGo, false)
			GameUtil.setLocalRotation(go, 0, 0, -60 * (i - 1))

			self._itemList[i] = item
		end
	end
end

function PayshopvipdrawView:_startDraw()
	self._isDrawing = true
	self._hitId = 3
	self._drawTime = 3
	self._speedRatio = 10
	self._baseSpeed = 1
	self._totalDrawTime = 0
	self._currIndex = 1

	self:_reStartDraw()
end

function PayshopvipdrawView:_reStartDraw()
	self:_stopDraw()

	self._timeStep = self._baseSpeed / self._speedRatio

	settimer(self._timeStep, self._updateDraw, self, true)
end

function PayshopvipdrawView:_updateDraw()
	self._totalDrawTime = self._totalDrawTime + self._timeStep

	for i, v in ipairs(self._itemList) do
		local showSelect = self._currIndex == i

		goutil.setActive(v.selectGo, showSelect)

		if (self._totalDrawTime >= self._drawTime or nil) and true and showSelect and self._hitId == i then
			self:_stopDraw()

			return
		end
	end

	self._currIndex = self._currIndex + 1

	if self._currIndex > self._cfgLen then
		self._currIndex = 1
	end
end

function PayshopvipdrawView:_stopDraw()
	self._isDrawing = false

	removetimer(self._updateDraw, self)
end

return PayshopvipdrawView
