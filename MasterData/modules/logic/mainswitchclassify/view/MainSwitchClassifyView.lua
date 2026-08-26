-- chunkname: @modules/logic/mainswitchclassify/view/MainSwitchClassifyView.lua

module("modules.logic.mainswitchclassify.view.MainSwitchClassifyView", package.seeall)

local MainSwitchClassifyView = class("MainSwitchClassifyView", BaseView)

function MainSwitchClassifyView:onInitView()
	self._gobg2 = gohelper.findChild(self.viewGO, "#go_bg2")
	self._gobg1 = gohelper.findChild(self.viewGO, "#go_bg1")
	self._goleft = gohelper.findChild(self.viewGO, "left/#go_left")
	self._left = gohelper.findChild(self.viewGO, "left")
	self._root = gohelper.findChild(self.viewGO, "root")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainSwitchClassifyView:addEvents()
	self.viewContainer:registerCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)
	self.addEventCb(self, MainSceneSwitchController.instance, MainSceneSwitchEvent.SceneSwitchUIVisible, self._onSwitchUIVisible, self)
	self.addEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.SwitchUIVisible, self._onSwitchUIVisible, self)
	self.addEventCb(self, ClickUISwitchController.instance, ClickUISwitchEvent.SwitchVisible, self._onSwitchUIVisible, self)
	self.addEventCb(self, SummonUISwitchController.instance, SummonUISwitchEvent.SwitchVisible, self._onSwitchUIVisible, self)
	self.addEventCb(self, MainSceneSwitchController.instance, MainSceneSwitchEvent.ForceShowSceneTab, self._onForceShowSceneTab, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.refreshView, self)
end

function MainSwitchClassifyView:removeEvents()
	self.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)
	self.removeEventCb(self, MainSceneSwitchController.instance, MainSceneSwitchEvent.SceneSwitchUIVisible, self._onSwitchUIVisible, self)
	self.removeEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.SwitchUIVisible, self._onSwitchUIVisible, self)
	self.removeEventCb(self, ClickUISwitchController.instance, ClickUISwitchEvent.SwitchVisible, self._onSwitchUIVisible, self)
	self.removeEventCb(self, SummonUISwitchController.instance, SummonUISwitchEvent.SwitchVisible, self._onSwitchUIVisible, self)
	self.removeEventCb(self, MainSceneSwitchController.instance, MainSceneSwitchEvent.ForceShowSceneTab, self._onForceShowSceneTab, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.refreshView, self)
end

function MainSwitchClassifyView:_onForceShowSceneTab()
	self.viewContainer:switchClassifyTab(MainSwitchClassifyEnum.Classify.Scene)
end

function MainSwitchClassifyView:_toSwitchTab(tabContainerId, tabId)
	if tabContainerId == self._tabContainerId then
		self._tabId = tabId
	end

	self:_refreshRootSibling()
end

function MainSwitchClassifyView:_refreshRootSibling()
	local isScene = self._tabId == MainSwitchClassifyEnum.Classify.Scene

	gohelper.setSibling(self._left, isScene and 1 or 2)
	gohelper.setSibling(self._root, isScene and 2 or 1)
end

function MainSwitchClassifyView:_editableInitView()
	self._rootAnimator = self.viewGO:GetComponent("Animator")
end

function MainSwitchClassifyView:onUpdateParam()
	return
end

function MainSwitchClassifyView:_onSwitchUIVisible(showUI)
	gohelper.setActive(self._goleft, showUI)
	self._rootAnimator:Play(showUI and "open" or "close", 0, 0)
end

function MainSwitchClassifyView:onOpen()
	MainSwitchClassifyListModel.instance:initMoList()

	self._tabContainerId = 3
	self._tabId = self.viewParam.defaultTabIds[1]

	self:_refreshRootSibling()
end

function MainSwitchClassifyView:onClose()
	self:_clearScene()
end

function MainSwitchClassifyView:onDestroyView()
	return
end

function MainSwitchClassifyView:onTabSwitchOpen()
	MainHeroView.resetPostProcessBlur()
	self._rootAnimator:Play("open", 0, 0)
end

function MainSwitchClassifyView:onTabSwitchClose(isClosing)
	self:_clearScene()
end

function MainSwitchClassifyView:_clearScene()
	WeatherController.instance:FakeShowScene(true)
	MainHeroView.setPostProcessBlur()
end

function MainSwitchClassifyView:refreshView()
	MainSwitchClassifyListModel.instance:onModelUpdate()
end

return MainSwitchClassifyView
