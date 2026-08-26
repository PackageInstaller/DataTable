-- chunkname: @modules/logic/clickuiswitch/controller/ClickUISwitchController.lua

module("modules.logic.clickuiswitch.controller.ClickUISwitchController", package.seeall)

local ClickUISwitchController = class("ClickUISwitchController", BaseController)

function ClickUISwitchController:onInit()
	self:reInit()
end

function ClickUISwitchController:onInitFinish()
	return
end

function ClickUISwitchController:addConstEvents()
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, self._onGetInfoFinish, self)
end

function ClickUISwitchController:reInit()
	return
end

function ClickUISwitchController:_onGetInfoFinish()
	ClickUISwitchModel.instance:initClickUI()
end

function ClickUISwitchController:openClickUISwitchInfoView(skinId, noInfoEffect, isPreview)
	ViewMgr.instance:openView(ViewName.ClickUISwitchInfoView, {
		SkinId = skinId,
		noInfoEffect = noInfoEffect,
		isPreview = isPreview
	})
end

function ClickUISwitchController:setCurClickUIStyle(id, callback, callbackObj)
	local co = lua_scene_click.configDict[id]

	if not co then
		return
	end

	ClickUISwitchModel.instance:setCurUseUI(id)
	GameGlobalMgr.instance:refreshTouchEffectSkin()

	local simpleProperty = PlayerEnum.SimpleProperty.ClickUISkin

	PlayerModel.instance:forceSetSimpleProperty(simpleProperty, tostring(id))
	PlayerRpc.instance:sendSetSimplePropertyRequest(simpleProperty, tostring(id))
	ClickUISwitchController.instance:dispatchEvent(ClickUISwitchEvent.UseClickUI, id)

	if callback then
		callback(callbackObj)
	end
end

function ClickUISwitchController.hasReddot(id)
	return false
end

function ClickUISwitchController.closeReddot(id)
	return
end

function ClickUISwitchController:getClickUIPrefab(prefabName)
	self._clickUIPrefab = self._clickUIPrefab or {}

	if not self._clickUIPrefab[prefabName] then
		self:_loadClickUIPrefab(prefabName)

		return
	end

	return self._clickUIPrefab[prefabName]
end

function ClickUISwitchController:_loadClickUIPrefab(prefabName)
	self._loadClickUIName = prefabName

	if self._loader then
		self._loader:dispose()
	end

	self._loader = MultiAbLoader.New()

	local path = string.format(ClickUISwitchEnum.ClickUIPath, prefabName)

	self._loader:addPath(path)
	self._loader:startLoad(self._loadCallback, self)
end

function ClickUISwitchController:_loadCallback()
	local path = string.format(ClickUISwitchEnum.ClickUIPath, self._loadClickUIName)
	local assetItem = self._loader:getAssetItem(path)

	self._clickUIPrefab[self._loadClickUIName] = assetItem:GetResource(path)

	ClickUISwitchController.instance:dispatchEvent(ClickUISwitchEvent.LoadUIPrefabs)
end

ClickUISwitchController.instance = ClickUISwitchController.New()

return ClickUISwitchController
