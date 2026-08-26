-- chunkname: @modules/logic/summonuiswitch/controller/SummonUISwitchController.lua

module("modules.logic.summonuiswitch.controller.SummonUISwitchController", package.seeall)

local SummonUISwitchController = class("SummonUISwitchController", BaseController)

function SummonUISwitchController:onInit()
	self:reInit()
end

function SummonUISwitchController:onInitFinish()
	return
end

function SummonUISwitchController:addConstEvents()
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, self._onGetInfoFinish, self)
	self.addEventCb(self, PlayerController.instance, PlayerEvent.UpdateSimpleProperty, self._updateSimpleProperty, self)
end

function SummonUISwitchController:reInit()
	return
end

function SummonUISwitchController:_onGetInfoFinish()
	SummonUISwitchModel.instance:initSceneUI()
end

function SummonUISwitchController:_updateSimpleProperty(simplePropertyId)
	if simplePropertyId == PlayerEnum.SimpleProperty.SummonUISkin then
		local value = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.SummonUISkin)

		if value then
			local id = tonumber(value)

			SummonUISwitchModel.instance:setCurUseUI(id)
		end
	end
end

function SummonUISwitchController:openClickUISwitchInfoView(skinId, noInfoEffect, isPreview)
	return
end

function SummonUISwitchController:setCurSummonUIStyle(id)
	local co = SummonUISwitchConfig.instance:getSummonSwitchConfig(id)

	if not co then
		return
	end

	local simpleProperty = PlayerEnum.SimpleProperty.SummonUISkin

	PlayerRpc.instance:sendSetSimplePropertyRequest(simpleProperty, tostring(id))
end

function SummonUISwitchController.hasReddot(id)
	return false
end

function SummonUISwitchController.closeReddot(id)
	return
end

function SummonUISwitchController:getClickUIPrefab(prefabName)
	self._clickUIPrefab = self._clickUIPrefab or {}

	if not self._clickUIPrefab[prefabName] then
		self:_loadClickUIPrefab(prefabName)

		return
	end

	return self._clickUIPrefab[prefabName]
end

function SummonUISwitchController:_loadClickUIPrefab(prefabName)
	self._loadClickUIName = prefabName

	if self._loader then
		self._loader:dispose()
	end

	self._loader = MultiAbLoader.New()

	local path = string.format(ClickUISwitchEnum.ClickUIPath, prefabName)

	self._loader:addPath(path)
	self._loader:startLoad(self._loadCallback, self)
end

function SummonUISwitchController:_loadCallback()
	local path = string.format(ClickUISwitchEnum.ClickUIPath, self._loadClickUIName)
	local assetItem = self._loader:getAssetItem(path)

	self._clickUIPrefab[self._loadClickUIName] = assetItem:GetResource(path)

	SummonUISwitchController.instance:dispatchEvent(ClickUISwitchEvent.LoadUIPrefabs)
end

SummonUISwitchController.instance = SummonUISwitchController.New()

return SummonUISwitchController
