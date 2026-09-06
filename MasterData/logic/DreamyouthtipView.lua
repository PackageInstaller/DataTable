-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamyouth/view/DreamyouthtipView.lua

module("logic.extensions.dreamyouth.view.DreamyouthtipView", package.seeall)

local DreamyouthtipView = class("DreamyouthtipView", ViewComponent)

function DreamyouthtipView:ctor()
	DreamyouthtipView.super.ctor(self)
end

function DreamyouthtipView:unbindEvents()
	GameUtil.rmClickHandler(self._btnPre)
	GameUtil.rmClickHandler(self._btnNext)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnJump)
	GameUtil.rmClickHandler(self._btnLink)
	DreamyouthtipView.super.unbindEvents(self)
end

function DreamyouthtipView:bindEvents()
	DreamyouthtipView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnLink, GameUtil.handler(self._onClickLink, self))
	GameUtil.addClickHandler(self._btnPre, GameUtil.handler(self._onPre, self))
	GameUtil.addClickHandler(self._btnNext, GameUtil.handler(self._onNext, self))
	GameUtil.addClickHandler(self._btnClose, GameUtil.handler(self.close, self))
	GameUtil.addClickHandler(self._btnJump, GameUtil.handler(self._onClickJump, self))
end

function DreamyouthtipView:buildUI()
	DreamyouthtipView.super.buildUI(self)

	self._btnPreGo = self:getGo("btnPre")
	self._btnPre = self:getBtn("btnPre")
	self._btnNextGo = self:getGo("btnNext")
	self._btnNext = self:getBtn("btnNext")
	self._btnClose = self:getBtn("btnClose")
	self._btnPreTxt = self:getTxt("btnPre/Txt")
	self._btnNextTxt = self:getTxt("btnNext/Txt")
	self._btnJump = self:getBtn("conPage/page2/btnJump")
	self._conPage = self:getGo("conPage")
	self._pageNum = self._conPage.transform.childCount
	self._page = {}

	for i = 1, self._pageNum do
		self._page[i] = self:getGo("conPage/page" .. i)
	end

	self._btnLink = self:getGo("conPage/page1/btnLink")
	self._txtLink = self:getTxt("conPage/page1/btnLink/txtLink")
end

function DreamyouthtipView:onExit()
	DreamyouthtipView.super.onExit(self)
end

function DreamyouthtipView:onEnter()
	DreamyouthtipView.super.onEnter(self)

	self._link = "http://aoqi.100bt.com/h5/"
	self._txtLink.text = self._link
	self._curPage = 1

	self:_updateUI()
end

function DreamyouthtipView:_onClickLink()
	UnityEngine.Application.OpenURL(self._link)
end

function DreamyouthtipView:_onClickJump()
	self:close()
	GotoMgr.gotoByString("ui#bonus#exchangecodeview")
end

function DreamyouthtipView:_onPre()
	self._curPage = math.max(1, self._curPage - 1)

	self:_updateUI()
end

function DreamyouthtipView:_onNext()
	self._curPage = math.min(self._pageNum, self._curPage + 1)

	self:_updateUI()
end

function DreamyouthtipView:_updateUI()
	for i = 1, self._pageNum do
		goutil.setActive(self._page[i], false)
	end

	goutil.setActive(self._page[self._curPage], true)
	goutil.setActive(self._btnPreGo, self._curPage > 1)
	goutil.setActive(self._btnNextGo, self._curPage < self._pageNum)

	local matchPlat = ActivityPopupModel.instance:checkIsMatchPlatform(1)

	goutil.setActive(self._btnLink, self._curPage == 1 and matchPlat)
end

return DreamyouthtipView
