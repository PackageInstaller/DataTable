-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/colorfullantern/view/ColorfulLanternMasterView.lua

module("logic.extensions.colorfullantern.view.ColorfulLanternMasterView", package.seeall)

local ColorfulLanternMasterView = class("ColorfulLanternMasterView", ViewComponent)

function ColorfulLanternMasterView:buildUI()
	ColorfulLanternMasterView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._tableCell = self:getGo("tableCell")
	self._tableview = self:getGo("tableview")
	self._leftBtn = self:getBtn("btnFront")
	self._rightBtn = self:getBtn("btnNext")
	self._shareBtn = self:getBtn("btnShare")
	self._shareReward = self:getGo("bubble/item")
end

function ColorfulLanternMasterView:bindEvents()
	ColorfulLanternMasterView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._shareBtn, self._onClickShare, self)
end

function ColorfulLanternMasterView:unbindEvents()
	ColorfulLanternMasterView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._shareBtn)
end

function ColorfulLanternMasterView:onEnter()
	ColorfulLanternMasterView.super.onEnter(self)
	GameUtil.SetActive(self._leftBtn, false)
	GameUtil.SetActive(self._rightBtn, false)

	self._shareId = 17

	local prize = ShareController.instance.activeByTimes(self._shareId, self:getGo("bubble"))

	MaterialMgr.setCellByCfg(prize, self:getGo("bubble/item"))
end

function ColorfulLanternMasterView:onExit()
	ColorfulLanternMasterView.super.onExit(self)
	MaterialMgr.resetAll(self:getGo("bubble/item"))
end

function ColorfulLanternMasterView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local title = goutil.findChildTextComponent(go, "txt")
	local img = goutil.findChild(go, "img")

	title.text = data.title
end

function ColorfulLanternMasterView:_clearCell(cell)
	local go = cell.gameObject
	local img = goutil.findChild(go, "img")

	uGuiUtil.clearImage(img)
end

function ColorfulLanternMasterView:_onClickLeft()
	if index > 0 then
		-- block empty
	elseif index == 0 then
		-- block empty
	end
end

function ColorfulLanternMasterView:_onClickRight()
	if index + count - 1 < self._maxIndex - 1 then
		-- block empty
	elseif index + count - 1 == self._maxIndex - 1 then
		-- block empty
	end
end

function ColorfulLanternMasterView:_onClickShare()
	local hideBtns = {
		self:getGo("btnFront"),
		self:getGo("btnNext"),
		self:getGo("btnShare"),
		self:getGo("leftTop"),
		self:getGo("bubble")
	}

	ShareController.instance:share(self._shareId, hideBtns)
end

return ColorfulLanternMasterView
