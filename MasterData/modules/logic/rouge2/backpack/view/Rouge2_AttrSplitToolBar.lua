-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_AttrSplitToolBar.lua

module("modules.logic.rouge2.backpack.view.Rouge2_AttrSplitToolBar", package.seeall)

local Rouge2_AttrSplitToolBar = class("Rouge2_AttrSplitToolBar", LuaCompBase)

function Rouge2_AttrSplitToolBar.Load(go, eventFlag)
	if not eventFlag then
		logError("Rouge2_AttrSplitToolBar.Load error eventFlag is nil")
	end

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_AttrSplitToolBar, eventFlag)
end

function Rouge2_AttrSplitToolBar:ctor(eventFlag)
	self._eventFlag = eventFlag
end

function Rouge2_AttrSplitToolBar:init(go)
	self.go = go
	self._goTab = gohelper.findChild(self.go, "Root/#go_Tab")
	self._goTabItem = gohelper.findChild(self.go, "Root/#go_Tab/#go_TabItem")
end

function Rouge2_AttrSplitToolBar:addEventListeners()
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnSwitchAttrTabItem, self._onSwitchAttrTabItem, self)
end

function Rouge2_AttrSplitToolBar:initSwitchCallback(switchCallback, switchCallbackObj)
	self._switchCallback = switchCallback
	self._switchCallbackObj = switchCallbackObj
end

function Rouge2_AttrSplitToolBar:initRefreshNumFlagFunc(refreshFunc, refreshFuncObj)
	self._numFlagRefreshFunc = refreshFunc
	self._numFlagRfreshFuncObj = refreshFuncObj
end

function Rouge2_AttrSplitToolBar:onUpdateMO(tabIdList, selectTabId)
	self._tabIdList = tabIdList or {}
	self._curTabId = selectTabId or tabIdList[1]

	self:refreshAttrTabItemList()
end

function Rouge2_AttrSplitToolBar:refreshAttrTabItemList()
	gohelper.CreateObjList(self, self._refreshAttrItem, self._tabIdList, self._goTab, self._goTabItem, Rouge2_BackpackAttrTabItem)
end

function Rouge2_AttrSplitToolBar:_refreshAttrItem(attrTabItem, attrId, index)
	attrTabItem:initEventFlag(self._eventFlag)
	attrTabItem:initRefreshNumFlagFunc(self._numFlagRefreshFunc, self._numFlagRfreshFuncObj)
	attrTabItem:onUpdateMO(attrId)
	attrTabItem:onSelect(self._curTabId == attrId)
end

function Rouge2_AttrSplitToolBar:_onSwitchAttrTabItem(eventFlag, tabId)
	if eventFlag ~= self._eventFlag then
		return
	end

	if not self._tabIdList or not tabletool.indexOf(self._tabIdList, tabId) or self._curTabId == tabId then
		return
	end

	if self._switchCallback then
		self._switchCallback(self._switchCallbackObj, tabId)
	end

	self._curTabId = tabId

	self:refreshAttrTabItemList()
end

function Rouge2_AttrSplitToolBar:onDestroy()
	self._switchCallback = nil
	self._switchCallbackObj = nil
end

return Rouge2_AttrSplitToolBar
