-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/colorfullantern/view/ColorfulLanternMakeView.lua

module("logic.extensions.colorfullantern.view.ColorfulLanternMakeView", package.seeall)

local ColorfulLanternMakeView = class("ColorfulLanternMakeView", ViewComponent)

function ColorfulLanternMakeView:buildUI()
	ColorfulLanternMakeView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._mainPageGo = self:getGo("mainPageGo")
	self._otherPageGo = self:getGo("otherPageGo")
	self._workLeft = self:getGo("otherPageGo/imgLeft")
	self._workRight = self:getGo("otherPageGo/imgRight")
	self._leftBtn = self:getBtn("btnFront")
	self._rightBtn = self:getBtn("btnNext")
	self._shareBtn = self:getBtn("btnShare")
	self._shareReward = self:getGo("bubble/item")
end

function ColorfulLanternMakeView:bindEvents()
	ColorfulLanternMakeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._leftBtn, self._onClickLeft, self)
	GameUtil.addClickHandler(self._rightBtn, self._onClickRight, self)
	GameUtil.addClickHandler(self._shareBtn, self._onClickShare, self)
end

function ColorfulLanternMakeView:unbindEvents()
	ColorfulLanternMakeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._leftBtn)
	GameUtil.rmClickHandler(self._rightBtn)
	GameUtil.rmClickHandler(self._shareBtn)
end

function ColorfulLanternMakeView:onEnter()
	ColorfulLanternMakeView.super.onEnter(self)

	self._maxWork = 2
	self._maxPage = 1 + math.ceil(self._maxWork / 2)
	self._curPage = 1
	self._shareId = 18

	local prize = ShareController.instance.activeByTimes(self._shareId, self:getGo("bubble"))

	MaterialMgr.setCellByCfg(prize, self:getGo("bubble/item"))
	self:_refreshUI()
end

function ColorfulLanternMakeView:onExit()
	ColorfulLanternMakeView.super.onExit(self)
	MaterialMgr.resetAll(self:getGo("bubble/item"))
end

function ColorfulLanternMakeView:_refreshUI()
	if self._curPage > 1 then
		local indexRight = (self._curPage - 1) * 2
		local indexLeft = (self._curPage - 1) * 2 - 1

		if indexRight <= self._maxWork then
			local res = ColorfulLanternConfig.instance:getWorkResName(indexRight)
		end

		if indexLeft <= self._maxWork then
			local res = ColorfulLanternConfig.instance:getWorkResName(indexLeft)
		end
	end

	GameUtil.SetActive(self._mainPageGo, self._curPage == 1)
	GameUtil.SetActive(self._otherPageGo, self._curPage ~= 1)
	GameUtil.SetActive(self._leftBtn, self._curPage > 1)
	GameUtil.SetActive(self._rightBtn, self._curPage < self._maxPage)
end

function ColorfulLanternMakeView:_onClickLeft()
	if self._curPage > 1 then
		self._curPage = self._curPage - 1

		self:_refreshUI()
	end
end

function ColorfulLanternMakeView:_onClickRight()
	if self._curPage < self._maxPage then
		self._curPage = self._curPage + 1

		self:_refreshUI()
	end
end

function ColorfulLanternMakeView:_onClickShare()
	local hideBtns = {
		self:getGo("btnFront"),
		self:getGo("btnNext"),
		self:getGo("btnShare"),
		self:getGo("leftTop"),
		self:getGo("bubble")
	}

	ShareController.instance:share(self._shareId, hideBtns)
end

return ColorfulLanternMakeView
