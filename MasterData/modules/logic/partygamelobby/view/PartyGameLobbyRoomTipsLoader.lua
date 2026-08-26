-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyRoomTipsLoader.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyRoomTipsLoader", package.seeall)

local PartyGameLobbyRoomTipsLoader = class("PartyGameLobbyRoomTipsLoader", UserDataDispose)

function PartyGameLobbyRoomTipsLoader:init(toastItem, toastParams)
	self._toastItem = toastItem
	self._toastParams = toastParams

	if not self._toastLoader then
		self._toastLoader = MultiAbLoader.New()

		self._toastLoader:addPath(self._toastParams.resPath)
		self._toastLoader:startLoad(self._onToastLoadedCallBack, self)
	end
end

function PartyGameLobbyRoomTipsLoader:_onToastLoadedCallBack(loader)
	local assetItem = loader:getAssetItem(self._toastParams.resPath)
	local toastPrefab = assetItem:GetResource(self._toastParams.resPath)

	if not self.viewGO then
		local normalGo = self._toastItem:getToastRootByType(ToastItem.ToastType.Normal)

		gohelper.setActive(normalGo, false)

		local rootGo = self._toastItem:getGo()
		local go = gohelper.clone(toastPrefab, rootGo)
		local comp = MonoHelper.addNoUpdateLuaComOnceToGo(go, self._toastParams.toastItemComp)

		self._itemGo = go

		comp:onUpdateMO(self._toastParams, self._toastItem)
	end
end

function PartyGameLobbyRoomTipsLoader:dispose()
	if self._toastLoader then
		self._toastLoader:dispose()

		self._toastLoader = nil
	end

	if self._itemGo then
		gohelper.destroy(self._itemGo)
	end

	self._toastItem = nil
	self._toastParams = nil
end

return PartyGameLobbyRoomTipsLoader
