-- chunkname: @modules/logic/fightuiswitch/controller/FightUISwitchController.lua

module("modules.logic.fightuiswitch.controller.FightUISwitchController", package.seeall)

local FightUISwitchController = class("FightUISwitchController", BaseController)

function FightUISwitchController:onInit()
	return
end

function FightUISwitchController:onInitFinish()
	return
end

function FightUISwitchController:addConstEvents()
	return
end

function FightUISwitchController:reInit()
	return
end

function FightUISwitchController:openSceneView(itemId)
	local mo = FightUISwitchModel.instance:getStyleMoByItemId(itemId)

	ViewMgr.instance:openView(ViewName.FightUISwitchSceneView, {
		mo = mo
	})
end

function FightUISwitchController:openEquipView(mo)
	ViewMgr.instance:openView(ViewName.FightUISwitchEquipView, {
		mo = mo
	})
end

function FightUISwitchController:_onLoadStyleRes(showres)
	if string.nilorempty(showres) then
		return
	end

	self._showResPath = self._showResPath or {}

	table.insert(self._showResPath, showres)

	local showRes = self:_getResPath(showres)

	self._loader = self._loader or MultiAbLoader.New()

	self._loader:addPath(showRes)
	self._loader:startLoad(self._onLoadedCallBack, self)
end

function FightUISwitchController:_getResPath(res)
	return (string.format(FightUISwitchEnum.SceneRes, res))
end

function FightUISwitchController:_onLoadedCallBack(loader)
	if self._showResPath then
		for _, res in pairs(self._showResPath) do
			local showRes = self:_getResPath(res)
			local assetItem = loader:getAssetItem(showRes)

			if assetItem then
				self._showResPrefab[res] = assetItem:GetResource()
			end
		end
	end

	self:_finishLoadRes()
end

function FightUISwitchController:_finishLoadRes()
	FightUISwitchController.instance:dispatchEvent(FightUISwitchEvent.LoadFinish, self._viewName)
end

function FightUISwitchController:loadRes(styleId, viewName)
	local co = FightUISwitchConfig.instance:getFightUIStyleCoById(styleId)

	self._viewName = viewName
	self._showResPrefab = self._showResPrefab or {}

	local showres = FightUISwitchModel.instance:getSceneRes(co, viewName)

	if self._showResPrefab[showres] then
		self:_finishLoadRes()

		return
	end

	self:_onLoadStyleRes(showres)
end

function FightUISwitchController:getRes(showres)
	return self._showResPrefab[showres]
end

function FightUISwitchController:dispose()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	self._showResPrefab = nil
end

FightUISwitchController.instance = FightUISwitchController.New()

return FightUISwitchController
