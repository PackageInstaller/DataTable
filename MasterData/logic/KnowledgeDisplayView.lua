-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/knowledgeanswer/view/KnowledgeDisplayView.lua

module("logic.extensions.knowledgeanswer.view.KnowledgeDisplayView", package.seeall)

local KnowledgeDisplayView = class("KnowledgeDisplayView", ViewComponent)

function KnowledgeDisplayView:ctor()
	KnowledgeDisplayView.super.ctor(self)
end

function KnowledgeDisplayView:unbindEvents()
	KnowledgeDisplayView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnRight)
end

function KnowledgeDisplayView:bindEvents()
	KnowledgeDisplayView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnLeft, GameUtil.handler(self._onClickTurn, self, true))
	GameUtil.addClickHandler(self._btnRight, GameUtil.handler(self._onClickTurn, self, false))
end

function KnowledgeDisplayView:buildUI()
	KnowledgeDisplayView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnRight = self:getGo("btnRight")
	self._btnLeft = self:getGo("btnLeft")
	self._totalTabNums = 3
	self._showTabGo = {}

	for i = 1, self._totalTabNums do
		self._showTabGo[i] = self:getGo("tabs/contentCol" .. i)
	end
end

function KnowledgeDisplayView:onExit()
	KnowledgeDisplayView.super.onExit(self)
end

function KnowledgeDisplayView:onEnter()
	KnowledgeDisplayView.super.onEnter(self)

	self._curTabId = 1

	self:_updateShwoTabs()
end

function KnowledgeDisplayView:_updateShwoTabs()
	for i = 1, self._totalTabNums do
		goutil.setActive(self._showTabGo[i], i == self._curTabId)
	end

	goutil.setActive(self._btnLeft, self._curTabId > 1)
	goutil.setActive(self._btnRight, self._curTabId < self._totalTabNums)
end

function KnowledgeDisplayView:_onClickTurn(isLeft)
	self._curTabId = isLeft and self._curTabId - 1 or self._curTabId + 1

	self:_updateShwoTabs()
end

return KnowledgeDisplayView
