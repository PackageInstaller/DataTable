-- chunkname: @modules/logic/mainsceneswitch/view/MainSceneSwitchInfoDisplayView.lua

module("modules.logic.mainsceneswitch.view.MainSceneSwitchInfoDisplayView", package.seeall)

local MainSceneSwitchInfoDisplayView = class("MainSceneSwitchInfoDisplayView", BaseView)

function MainSceneSwitchInfoDisplayView:onInitView()
	self._gobg1 = gohelper.findChild(self.viewGO, "#go_bg1")
	self._gobg2 = gohelper.findChild(self.viewGO, "#go_bg2")
	self._simageFullBG1 = gohelper.findChildSingleImage(self._gobg1, "img")
	self._simageFullBG2 = gohelper.findChildSingleImage(self._gobg2, "img")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainSceneSwitchInfoDisplayView:addEvents()
	return
end

function MainSceneSwitchInfoDisplayView:removeEvents()
	return
end

function MainSceneSwitchInfoDisplayView:_editableInitView()
	self._weatherRoot = gohelper.findChild(self.viewGO, "left/#go_weatherRoot")

	gohelper.setActive(self._weatherRoot, false)

	self._rawImage = gohelper.onceAddComponent(gohelper.findChild(self.viewGO, "RawImage"), gohelper.Type_RawImage)

	gohelper.setActive(self._rawImage, false)
	MainSceneSwitchCameraController.instance:clear()
	self:_clearPage()
	self.addEventCb(self, MainSceneSwitchController.instance, MainSceneSwitchEvent.ShowPreviewSceneInfo, self._onShowSceneInfo, self)
end

function MainSceneSwitchInfoDisplayView:_onShowSceneInfo(id)
	self:_hideMainScene()

	self._sceneId = id

	MainSceneSwitchCameraController.instance:showScene(id, self._showSceneFinished, self)
end

function MainSceneSwitchInfoDisplayView.adjustRt(rawImage, rt)
	rawImage.texture = rt

	rawImage:SetNativeSize()

	local width = rt.width
	local root = ViewMgr.instance:getUIRoot().transform
	local containerWidth = recthelper.getWidth(root)
	local scale = containerWidth / width

	transformhelper.setLocalScale(rawImage.transform, scale, scale, 1)
end

function MainSceneSwitchInfoDisplayView:_showSceneFinished(rt)
	gohelper.setActive(self._rawImage, true)
	MainSceneSwitchInfoDisplayView.adjustRt(self._rawImage, rt)

	self._weatherSwitchControlComp = self._weatherSwitchControlComp or MonoHelper.addNoUpdateLuaComOnceToGo(self._weatherRoot, WeatherSwitchControlComp)

	self._weatherSwitchControlComp:updateScene(self._sceneId, MainSceneSwitchCameraDisplayController.instance)
end

function MainSceneSwitchInfoDisplayView:_clearPage()
	gohelper.setActive(self._simageFullBG1, false)
	gohelper.setActive(self._simageFullBG2, false)
end

function MainSceneSwitchInfoDisplayView:_hideMainScene()
	self._isPreview = self.viewParam and self.viewParam.isPreview

	if self._isPreview then
		MainSceneSwitchDisplayController.instance:hideScene()
	end
end

function MainSceneSwitchInfoDisplayView:onClose()
	MainSceneSwitchCameraController.instance:clear()

	if self._isPreview then
		MainSceneSwitchDisplayController.instance:showCurScene()
	end
end

function MainSceneSwitchInfoDisplayView:onDestroyView()
	self:_clearPage()
end

return MainSceneSwitchInfoDisplayView
