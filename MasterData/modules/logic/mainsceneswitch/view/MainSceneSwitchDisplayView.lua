-- chunkname: @modules/logic/mainsceneswitch/view/MainSceneSwitchDisplayView.lua

module("modules.logic.mainsceneswitch.view.MainSceneSwitchDisplayView", package.seeall)

local MainSceneSwitchDisplayView = class("MainSceneSwitchDisplayView", BaseView)

function MainSceneSwitchDisplayView:onInitView()
	self._gobg1 = gohelper.findChild(self.viewGO, "#go_bg1")
	self._gobg2 = gohelper.findChild(self.viewGO, "#go_bg2")
	self._simageFullBG1 = gohelper.findChildSingleImage(self._gobg1, "img")
	self._simageFullBG2 = gohelper.findChildSingleImage(self._gobg2, "img")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainSceneSwitchDisplayView:addEvents()
	return
end

function MainSceneSwitchDisplayView:removeEvents()
	return
end

function MainSceneSwitchDisplayView:_editableInitView()
	self._weatherRoot = gohelper.findChild(self.viewGO, "left/#go_weatherRoot")

	gohelper.setActive(self._weatherRoot, false)
	MainSceneSwitchDisplayController.instance:initMaps()
	self:_initSceneRoot()
	self:_clearPage()
end

function MainSceneSwitchDisplayView:onOpen()
	self.addEventCb(self, MainSceneSwitchController.instance, MainSceneSwitchEvent.ShowSceneInfo, self._onShowSceneInfo, self)
	self.addEventCb(self, MainSceneSwitchController.instance, MainSceneSwitchEvent.StartSwitchScene, self._onStartSwitchScene, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenView, self)
end

function MainSceneSwitchDisplayView:_onCloseView(viewName)
	if viewName == ViewName.MainSceneSkinMaterialTipView then
		MainSceneSwitchDisplayController.instance:setSwitchCompContinue(self._curShowSceneId, true)
	end
end

function MainSceneSwitchDisplayView:_onOpenView(viewName)
	if viewName == ViewName.MainSceneSkinMaterialTipView then
		MainSceneSwitchDisplayController.instance:setSwitchCompContinue(self._curShowSceneId, false)
	end
end

function MainSceneSwitchDisplayView:_onShowScene(id)
	MainSceneSwitchDisplayController.instance:showScene(id, function()
		WeatherController.instance:FakeShowScene(false)

		self._weatherSwitchControlComp = self._weatherSwitchControlComp or MonoHelper.addNoUpdateLuaComOnceToGo(self._weatherRoot, WeatherSwitchControlComp)

		self._weatherSwitchControlComp:updateScene(id, MainSceneSwitchDisplayController.instance)
	end)
end

function MainSceneSwitchDisplayView:_initSceneRoot()
	local curScene = GameSceneMgr.instance:getCurScene()
	local curSceneRootGO = curScene and curScene:getSceneContainerGO()
	local rootGo = self:_getSceneRoot(curSceneRootGO)

	MainSceneSwitchDisplayController.instance:setSceneRoot(rootGo)
end

function MainSceneSwitchDisplayView:_getSceneRoot(root)
	local name = "mainSceneSkinRoot"
	local transform = root.transform
	local childCount = transform.childCount

	for i = 1, childCount do
		local child = transform:GetChild(i - 1)

		if child.name == name then
			return child.gameObject
		end
	end

	return (gohelper.create3d(root, name))
end

function MainSceneSwitchDisplayView:_onStartSwitchScene()
	MainSceneSwitchDisplayController.instance:hideScene()
end

function MainSceneSwitchDisplayView:_onShowSceneInfo(id)
	self._curShowSceneId = id
	self._curSceneId = MainSceneSwitchModel.instance:getCurSceneId()

	self:_onShowScene(id)
end

function MainSceneSwitchDisplayView:_clearPage()
	gohelper.setActive(self._simageFullBG1, false)
	gohelper.setActive(self._simageFullBG2, false)
end

function MainSceneSwitchDisplayView:onTabSwitchOpen()
	self._isShowView = true

	self:showTab()
end

function MainSceneSwitchDisplayView:showTab()
	gohelper.setActive(self._weatherRoot, true)
	self:_changeToPrevScene()
end

function MainSceneSwitchDisplayView:_changeToPrevScene()
	WeatherController.instance:onSceneHide(true)

	if self._prevShowSceneId then
		local id = self._prevShowSceneId

		self._prevShowSceneId = nil

		self:_onShowScene(id)
	end
end

function MainSceneSwitchDisplayView:_changeToMainScene()
	self._prevShowSceneId = self._curShowSceneId

	MainSceneSwitchDisplayController.instance:hideScene()
	WeatherController.instance:onSceneShow()
end

function MainSceneSwitchDisplayView:onTabSwitchClose()
	self._isShowView = false

	self:hideTab()
end

function MainSceneSwitchDisplayView:hideTab()
	gohelper.setActive(self._weatherRoot, false)
	self:_changeToMainScene()
end

function MainSceneSwitchDisplayView:isShowView()
	return self._isShowView
end

function MainSceneSwitchDisplayView:onClose()
	self.removeEventCb(self, MainSceneSwitchController.instance, MainSceneSwitchEvent.ShowSceneInfo, self._onShowSceneInfo, self)
	self.removeEventCb(self, MainSceneSwitchController.instance, MainSceneSwitchEvent.StartSwitchScene, self._onStartSwitchScene, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenView, self)
	MainSceneSwitchDisplayController.instance:clear()
end

function MainSceneSwitchDisplayView:onDestroyView()
	self:_clearPage()
end

return MainSceneSwitchDisplayView
