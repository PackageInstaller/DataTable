-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/colorfullantern/view/ColorfulLanternIntroView.lua

module("logic.extensions.colorfullantern.view.ColorfulLanternIntroView", package.seeall)

local ColorfulLanternIntroView = class("ColorfulLanternIntroView", ViewComponent)

function ColorfulLanternIntroView:buildUI()
	ColorfulLanternIntroView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._txtLeftTopDesc = self:getTxt("txtIntro")
	self._txtLeftTopTitle = self:getTxt("txtIntro/txtTitle")
	self._txtLeftBottonDesc = self:getTxt("txtLinkage")
	self._txtLeftBottonTitle = self:getTxt("txtLinkage/txtTitle")
	self._txtImgTitle = self:getTxt("imgCon/txtTitle")
	self._leftBtn = self:getBtn("btnFront")
	self._rightBtn = self:getBtn("btnNext")
	self._shareBtn = self:getBtn("btnShare")
	self._shareReward = self:getGo("bubble/item")
end

function ColorfulLanternIntroView:bindEvents()
	ColorfulLanternIntroView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._leftBtn, self._onClickLeft, self)
	GameUtil.addClickHandler(self._rightBtn, self._onClickRight, self)
	GameUtil.addClickHandler(self._shareBtn, self._onClickShare, self)
end

function ColorfulLanternIntroView:unbindEvents()
	ColorfulLanternIntroView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._leftBtn)
	GameUtil.rmClickHandler(self._rightBtn)
	GameUtil.rmClickHandler(self._shareBtn)
end

function ColorfulLanternIntroView:onEnter()
	ColorfulLanternIntroView.super.onEnter(self)

	self._maxPage = ColorfulLanternConfig.instance:getMaxIntroPage()
	self._curPage = 1
	self._shareId = 16

	local prize = ShareController.instance.activeByTimes(self._shareId, self:getGo("bubble"))

	MaterialMgr.setCellByCfg(prize, self:getGo("bubble/item"))
	self:_refreshUI()
end

function ColorfulLanternIntroView:onExit()
	ColorfulLanternIntroView.super.onExit(self)
	MaterialMgr.resetAll(self:getGo("bubble/item"))
end

function ColorfulLanternIntroView:_refreshUI()
	local pageCfg = ColorfulLanternConfig.instance:getIntroPageCfg(self._curPage)

	self._txtLeftTopDesc.text = pageCfg.leftTopTxt
	self._txtLeftTopTitle.text = pageCfg.leftTopTitle
	self._txtLeftBottonDesc.text = pageCfg.leftBottonTxt
	self._txtLeftBottonTitle.text = pageCfg.leftBottonTitle
	self._txtImgTitle.text = pageCfg.rightTitle

	if pageCfg.rightResName then
		-- block empty
	end

	GameUtil.SetActive(self._leftBtn, self._curPage > 1)
	GameUtil.SetActive(self._rightBtn, self._curPage < self._maxPage)
end

function ColorfulLanternIntroView:_onClickLeft()
	if self._curPage > 1 then
		self._curPage = self._curPage - 1

		self:_refreshUI()
	end
end

function ColorfulLanternIntroView:_onClickRight()
	if self._curPage < self._maxPage then
		self._curPage = self._curPage + 1

		self:_refreshUI()
	end
end

function ColorfulLanternIntroView:_onClickShare()
	local hideBtns = {
		self:getGo("btnFront"),
		self:getGo("btnNext"),
		self:getGo("btnShare"),
		self:getGo("leftTop"),
		self:getGo("bubble")
	}

	ShareController.instance:share(self._shareId, hideBtns)
end

return ColorfulLanternIntroView
