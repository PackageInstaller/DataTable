-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/view/father/CommonTabRankFatherListView.lua

module("logic.extensions.commontabrank.view.father.CommonTabRankFatherListView", package.seeall)

local CommonTabRankFatherListView = class("CommonTabRankFatherListView", ViewComponent)

function CommonTabRankFatherListView:buildUI()
	CommonTabRankFatherListView.super.buildUI(self)

	self._contentCol = self:getGo("contentCol")
	self._btnClose = self:getGo("btnClose")
	self._tablist = self:getGo("tablist")
	self._commonTab = TabFrameCommonTab.create(self._tablist, GameUtil.handler(self._onUpdateCell, self), GameUtil.handler(self._onUpdateRight, self))

	self._commonTab:setIsUnlockCallBack(GameUtil.handler(self._isUnlock, self))
	self._commonTab:setPreClickCallBack(GameUtil.handler(self._onPreClickTab, self))
	self._commonTab:setDefaultLeafCallBack(GameUtil.handler(self._onGetDefaultLeaf, self))
end

function CommonTabRankFatherListView:bindEvents()
	CommonTabRankFatherListView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function CommonTabRankFatherListView:unbindEvents()
	CommonTabRankFatherListView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function CommonTabRankFatherListView:onEnter()
	CommonTabRankFatherListView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._commonParams = params[1]

	local onEnterCallBack = self._commonParams:getOnEnterCallBackInFather()

	GameUtil.callBack(onEnterCallBack)
	self:initTabViewWithFrameId(self._commonParams)
end

function CommonTabRankFatherListView:onExit()
	CommonTabRankFatherListView.super.onExit(self)
	self:_onClearTabAt()

	local onExitCallBack = self._commonParams:getOnExitCallBackInFather()

	GameUtil.callBack(onExitCallBack)
end

function CommonTabRankFatherListView:initTabViewWithFrameId(commonParams)
	self._commonParams = commonParams
	self._tabKeyList = self._commonParams:getTabKeyList()

	local defalutKey = self._commonParams:getDafaultOpenTab()
	local var_6_0

	if not defalutKey then
		::label_6_0::

		var_6_0 = self._curTabKey or self._tabKeyList[1]
	end

	self._curTabKey = var_6_0

	if table.indexof(self._tabKeyList, self._curTabKey) == false then
		self._curTabKey = self._tabKeyList[1]
	end

	local tabKeyList = self._commonParams:getTabKeyList()

	self._commonTab:clearAllData()

	for i, key in ipairs(tabKeyList) do
		local data = self._commonParams:getTabData(key)

		if data.secTabId and data.secTabId > 0 then
			if not data.headTabId then
				local hisRoot = 0

				self._commonTab:addTabData(data.tabName, data, hisRoot)
			end
		end
	end

	local tabData = self._commonParams:getTabData(self._curTabKey)

	self._commonTab:jumpTabByData(tabData)
end

function CommonTabRankFatherListView:_onUpdateCell(view, cell, tabData, tag)
	local isUnlock = self._commonTab:_isUnlock(tabData)
	local redpoint = goutil.findChild(cell, "redpoint")
	local lock = goutil.findChild(cell, "lock")

	GameUtil.SetActive(redpoint, false)
	GameUtil.SetActive(lock, not isUnlock)
end

function CommonTabRankFatherListView:_onUpdateRight(tabData)
	if tabData and tabData.data and tabData.data.tabKey then
		self._curTabKey = tabData.data.tabKey
	end

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

function CommonTabRankFatherListView:_onClearTabAt()
	self:showTabAt(self._contentCol, "")

	self._oldTabKey = nil
end

function CommonTabRankFatherListView:_isUnlock(tabData)
	return true
end

function CommonTabRankFatherListView:_onGetDefaultLeaf(tabData)
	return 0
end

function CommonTabRankFatherListView:_onPreClickTab(tabData)
	local isUnlock = self:_isUnlock(tabData)

	if not isUnlock then
		FloatWordMgr.instance:show("未开启")

		return true
	end

	return false
end

function CommonTabRankFatherListView:_onClickClose()
	self:close()
end

return CommonTabRankFatherListView
