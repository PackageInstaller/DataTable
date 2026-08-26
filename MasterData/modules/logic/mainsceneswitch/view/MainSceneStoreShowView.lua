-- chunkname: @modules/logic/mainsceneswitch/view/MainSceneStoreShowView.lua

module("modules.logic.mainsceneswitch.view.MainSceneStoreShowView", package.seeall)

local MainSceneStoreShowView = class("MainSceneStoreShowView", BaseView)

function MainSceneStoreShowView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_close")
	self._goweatherRoot = gohelper.findChild(self.viewGO, "left/#go_weatherRoot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainSceneStoreShowView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function MainSceneStoreShowView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function MainSceneStoreShowView:_btncloseOnClick()
	self:closeThis()
end

function MainSceneStoreShowView:_editableInitView()
	gohelper.setActive(self._goweatherRoot, false)

	self._rawImage = gohelper.onceAddComponent(gohelper.findChild(self.viewGO, "RawImage"), gohelper.Type_RawImage)

	gohelper.setActive(self._rawImage, false)
end

function MainSceneStoreShowView:onUpdateParam()
	return
end

function MainSceneStoreShowView:onOpen()
	self._sceneId = self.viewParam.sceneId

	MainSceneSwitchCameraController.instance:showScene(self._sceneId, self._showSceneFinished, self)
end

function MainSceneStoreShowView:_showSceneFinished(rt)
	if not self._rawImage then
		return
	end

	gohelper.setActive(self._rawImage, true)
	MainSceneSwitchInfoDisplayView.adjustRt(self._rawImage, rt)

	self._weatherSwitchControlComp = self._weatherSwitchControlComp or MonoHelper.addNoUpdateLuaComOnceToGo(self._goweatherRoot, WeatherSwitchControlComp)

	self._weatherSwitchControlComp:updateScene(self._sceneId, MainSceneSwitchCameraDisplayController.instance)
end

function MainSceneStoreShowView:onClose()
	if self.viewParam.callback then
		self.viewParam.callback(self.viewParam.callbackObj, self.viewParam)

		self.viewParam.callback = nil
	end
end

function MainSceneStoreShowView:onDestroyView()
	return
end

return MainSceneStoreShowView
