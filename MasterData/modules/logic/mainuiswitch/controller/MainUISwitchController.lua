-- chunkname: @modules/logic/mainuiswitch/controller/MainUISwitchController.lua

module("modules.logic.mainuiswitch.controller.MainUISwitchController", package.seeall)

local MainUISwitchController = class("MainUISwitchController", BaseController)

function MainUISwitchController:onInit()
	self:reInit()
end

function MainUISwitchController:onInitFinish()
	return
end

function MainUISwitchController:addConstEvents()
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, self._onGetInfoFinish, self)
end

function MainUISwitchController:reInit()
	return
end

function MainUISwitchController:_onGetInfoFinish()
	MainUISwitchModel.instance:initMainUI()
end

function MainUISwitchController:openMainUISwitchInfoView(skinId, noInfoEffect, isPreview, isCloseMoHideScene, hideExtraDisPlay)
	ViewMgr.instance:openView(ViewName.MainUISwitchInfoBlurMaskView, {
		SkinId = skinId,
		noInfoEffect = noInfoEffect,
		isPreview = isPreview,
		hideExtraDisPlay = hideExtraDisPlay,
		isCloseMoHideScene = isCloseMoHideScene
	})
end

function MainUISwitchController:openMainUISwitchInfoViewGiftSet(skinId, sceneId, isCloseMoHideScene, hideExtraDisPlay)
	ViewMgr.instance:openView(ViewName.MainUISwitchInfoBlurMaskView, {
		isPreview = true,
		isNotShowLeft = true,
		isNotShowHero = true,
		noInfoEffect = true,
		SkinId = skinId,
		sceneId = sceneId,
		hideExtraDisPlay = hideExtraDisPlay,
		isCloseMoHideScene = isCloseMoHideScene
	})
end

function MainUISwitchController:openSceneUIPackageInfoView(skinId, sceneId, isCloseMoHideScene, hideExtraDisPlay)
	local function openView()
		ViewMgr.instance:openView(ViewName.SceneUIPackageInfoView, {
			isPreview = true,
			isNotShowLeft = true,
			isNotShowHero = true,
			noInfoEffect = true,
			SkinId = skinId,
			sceneId = sceneId,
			hideExtraDisPlay = hideExtraDisPlay,
			isCloseMoHideScene = isCloseMoHideScene
		})
	end

	sceneId = sceneId or MainSceneSwitchModel.instance:getCurSceneId()

	MainSceneSwitchCameraController.instance:showScene(sceneId, openView, self)
end

function MainUISwitchController:setCurMainUIStyle(id, callback, callbackObj)
	local co = lua_scene_ui.configDict[id]

	if not co then
		return
	end

	local itemId = co.defaultUnlock == 1 and 0 or co.itemId

	MainUISwitchModel.instance:setCurUseUI(id)
	PlayerRpc.instance:sendSetUiStyleSkinRequest(itemId, callback, callbackObj)
	MainUISwitchController.instance:dispatchEvent(MainUISwitchEvent.UseMainUI, id)
end

function MainUISwitchController.hasReddot(id)
	return false
end

function MainUISwitchController.closeReddot(id)
	return
end

function MainUISwitchController:isClickEagle()
	return self:isClickObj("#go_eagleclick")
end

function MainUISwitchController:isClickObj(objName)
	if not self._pointerEventData then
		self._pointerEventData = UnityEngine.EventSystems.PointerEventData.New(UnityEngine.EventSystems.EventSystem.current)
		self._raycastResults = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult.New()
	end

	self._pointerEventData.position = UnityEngine.Input.mousePosition

	UnityEngine.EventSystems.EventSystem.current:RaycastAll(self._pointerEventData, self._raycastResults)

	local iter = self._raycastResults:GetEnumerator()

	while iter:MoveNext() do
		local raycastResult = iter.Current

		if raycastResult.gameObject.name == objName then
			return true
		end
	end
end

MainUISwitchController.instance = MainUISwitchController.New()

return MainUISwitchController
