-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/view/father/CommonTabRankFatherView.lua

module("logic.extensions.commontabrank.view.father.CommonTabRankFatherView", package.seeall)

local CommonTabRankFatherView = class("CommonTabRankFatherView", ViewComponent)

function CommonTabRankFatherView:buildUI()
	CommonTabRankFatherView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._contentCol = goutil.findChild(self.mainGO, "contentCol")

	local tabScrView = goutil.findChild(self.mainGO, "tabCol/scrView")
	local tabScrCell = goutil.findChild(self.mainGO, "tabCol/scrCell")

	self._tabScrollList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function CommonTabRankFatherView:bindEvents()
	CommonTabRankFatherView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function CommonTabRankFatherView:unbindEvents()
	CommonTabRankFatherView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function CommonTabRankFatherView:onEnter()
	CommonTabRankFatherView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._commonParams = params[1]

	local onEnterCallBack = self._commonParams:getOnEnterCallBackInFather()

	GameUtil.callBack(onEnterCallBack)

	self._tabKeyList = self._commonParams:getTabKeyList()

	local defalutKey = self._commonParams:getDafaultOpenTab()
	local var_4_0

	if not defalutKey then
		::label_4_0::

		var_4_0 = self._curTabKey or self._tabKeyList[1]
	end

	self._curTabKey = var_4_0

	if table.indexof(self._tabKeyList, self._curTabKey) == false then
		self._curTabKey = self._tabKeyList[1]
	end

	self:_onUpdate()
end

function CommonTabRankFatherView:onExit()
	CommonTabRankFatherView.super.onExit(self)

	local onExitCallBack = self._commonParams:getOnExitCallBackInFather()

	GameUtil.callBack(onExitCallBack)
	self._tabScrollList:dispose()
	self:_onClearTabAt()
end

function CommonTabRankFatherView:_onUpdate()
	self._tabScrollList:reloadData(self._tabKeyList)
	self:_showTabAt()
end

function CommonTabRankFatherView:_updateTabCell(view, cell, tabKey, tag)
	local data = self._commonParams:getTabData(tabKey)
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	txtName.text = data.tabName

	GameUtil.setUIGroupIdx(mainGo, self._curTabKey == tabKey and 1 or 0)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, tabKey))
end

function CommonTabRankFatherView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function CommonTabRankFatherView:_onClickTab(tabKey)
	self._curTabKey = tabKey

	self:_onUpdate()
end

function CommonTabRankFatherView:_showTabAt()
	local data = self._commonParams:getTabData(self._curTabKey)

	if data == nil then
		return
	end

	if self._oldTabKey and self._oldTabKey == self._curTabKey then
		return
	end

	self:_onClearTabAt()

	self._oldTabKey = self._curTabKey

	if data.viewParams then
		self:showTabAt(self._contentCol, data.viewName, unpack(data.viewParams))
	else
		self:showTabAt(self._contentCol, data.viewName)
	end
end

function CommonTabRankFatherView:_onClearTabAt()
	self:showTabAt(self._contentCol, "")

	self._oldTabKey = nil
end

return CommonTabRankFatherView
