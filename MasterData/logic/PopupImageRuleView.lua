-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/PopupImageRuleView.lua

module("logic.extensions.tips.view.PopupImageRuleView", package.seeall)

local PopupImageRuleView = class("PopupImageRuleView", ViewComponent)

function PopupImageRuleView:ctor()
	PopupImageRuleView.super.ctor(self)
end

function PopupImageRuleView:buildUI()
	PopupImageRuleView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnLeft = self:getBtn("btnLeft")
	self._btnRight = self:getBtn("btnRight")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtDesc = self:getTxt("txtDesc")
	self._imgRule = self:getGo("imgRule")
end

function PopupImageRuleView:bindEvents()
	PopupImageRuleView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnLeft:AddClickListener(self._onClickLeft, self)
	self._btnRight:AddClickListener(self._onClickRight, self)
end

function PopupImageRuleView:unbindEvents()
	PopupImageRuleView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
end

function PopupImageRuleView:onEnter()
	PopupImageRuleView.super.onEnter(self)

	local params = self:getOpenParam()

	if not params or not params[1] then
		self:_initEmptyPage()

		return
	end

	self._dataList = params[1]

	if params[2] then
		self._titleName = params[2] or "游戏规则"
	end

	self._closeCallBack = params[3]
	self._maxPage = #self._dataList

	if self._maxPage == 0 then
		self:_initEmptyPage()

		return
	else
		self:_initPage()
	end
end

function PopupImageRuleView:onExit()
	PopupImageRuleView.super.onExit(self)

	self._closeCallBack = nil

	uGuiUtil.clearImage(self._imgRule)
	GlobalDispatcher:dispatch(GlobalNotify.PopupImageRuleClose)
end

function PopupImageRuleView:_onClickClose()
	if self._closeCallBack then
		GameUtil.callBack(self._closeCallBack, self)
	end

	self:close()
end

function PopupImageRuleView:_onClickLeft()
	self:_clampPage(self._curPage - 1)
	self:_updateBtns()
	self:_updateInfo(self._dataList[self._curPage])
end

function PopupImageRuleView:_onClickRight()
	self:_clampPage(self._curPage + 1)
	self:_updateBtns()
	self:_updateInfo(self._dataList[self._curPage])
end

function PopupImageRuleView:_initEmptyPage()
	goutil.setActive(self._btnLeft.gameObject, false)
	goutil.setActive(self._btnRight.gameObject, false)

	self._txtDesc.text = "规则为空"
end

function PopupImageRuleView:_initPage()
	self._curPage = 1
	self._txtTitle.text = self._titleName
	self._txtDesc.text = self._maxPage > 1 and "点击左右侧箭头可翻页" or ""

	self:_updateBtns()
	self:_updateInfo(self._dataList[self._curPage])
end

function PopupImageRuleView:_clampPage(pageIndex)
	self._curPage = Mathf.Clamp(pageIndex, 1, self._maxPage)
end

function PopupImageRuleView:_updateInfo(data)
	local info = data
	local imagePath = info.url
	local imageDesc = info.desc

	uGuiUtil.setSpriteToImage(self._imgRule, uGuiUtil.SpriteType.BigBg, imagePath)

	if imageDesc then
		self._txtDesc.text = imageDesc
	end
end

function PopupImageRuleView:_updateBtns()
	goutil.setActive(self._btnLeft.gameObject, true)
	goutil.setActive(self._btnRight.gameObject, true)

	if self._curPage == 1 then
		goutil.setActive(self._btnLeft.gameObject, false)
	end

	if self._curPage == self._maxPage then
		goutil.setActive(self._btnRight.gameObject, false)
	end
end

return PopupImageRuleView
