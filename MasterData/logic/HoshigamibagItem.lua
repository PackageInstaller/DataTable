-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamibagItem.lua

module("logic.extensions.hoshigami.view.HoshigamibagItem", package.seeall)

local HoshigamibagItem = class("HoshigamibagItem", BaseLuaOnce)

function HoshigamibagItem:ctor(go)
	HoshigamibagItem.super.ctor(self, go)
end

function HoshigamibagItem:buildUI()
	HoshigamibagItem.super.buildUI(self)

	self._itemCon = self:getGo("itemCon")
	self._icon = self:getGo("mask/icon")
end

function HoshigamibagItem:bindEvents()
	HoshigamibagItem.super.bindEvents(self)
end

function HoshigamibagItem:unbindEvents()
	HoshigamibagItem.super.unbindEvents(self)
end

function HoshigamibagItem:onEnter(data, equipTipType)
	HoshigamibagItem.super.onEnter(self)
	GlobalDispatcher:addListener(HoshigamiController.PM_UnloadHoshigamiRes, self._showInuseIcon, self)
	GlobalDispatcher:addListener(HoshigamiController.PM_EquipHoshigamiRes, self._showInuseIcon, self)

	self._mo = data.mo
	self._equipTipType = equipTipType or GameEnum.HoshigamiEquipTipType.Bag

	self:_showInuseIcon()

	local proxy = MaterialMgr.setCellByMo(data.mo, self._itemCon)

	proxy.binder:setCallBack(function(item)
		self:_onClick()
	end)
end

function HoshigamibagItem:onExit()
	HoshigamibagItem.super.onExit(self)
	MaterialMgr.resetAll(self._itemCon)
	uGuiUtil.clearImage(self._icon)
	GlobalDispatcher:removeListener(HoshigamiController.PM_UnloadHoshigamiRes, self._showInuseIcon, self)
	GlobalDispatcher:removeListener(HoshigamiController.PM_EquipHoshigamiRes, self._showInuseIcon, self)
end

function HoshigamibagItem:_onClick()
	if self._equipTipType == GameEnum.HoshigamiEquipTipType.Bag then
		UIStateManager.instance:push(ViewName.HoshigamiequiptipsView, self._mo:getId())
	else
		UIStateManager.instance:push(ViewName.HoshigamieprefabquiptipsView, self._mo:getId())
	end
end

function HoshigamibagItem:_showInuseIcon()
	goutil.setActive(self._icon, false)

	local petId = self._mo:getUsePetId()

	if petId > 0 then
		local petMo = BagPetsController.instance:getPet(petId)
		local mco = CharacterConfig.instance:getModelCo(petMo.raceId)

		uGuiUtil.setSpriteToImage(self._icon, nil, GameUrl.getCharacterIconUrl(mco.headName))
		goutil.setActive(self._icon, true)
	elseif self._equipTipType == GameEnum.HoshigamiEquipTipType.EditPrefab then
		local suitId = HoshigamiModel.instance:getSuitIdByHoshigamiId(self._mo:getId())

		if suitId > 0 then
			uGuiUtil.clearImage(self._icon)
			goutil.setActive(self._icon, true)
		end
	end
end

return HoshigamibagItem
