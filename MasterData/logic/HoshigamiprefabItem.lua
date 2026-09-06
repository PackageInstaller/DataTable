-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamiprefabItem.lua

module("logic.extensions.hoshigami.view.HoshigamiprefabItem", package.seeall)

local HoshigamiprefabItem = class("HoshigamiprefabItem", BaseLuaOnce)

function HoshigamiprefabItem:ctor(go)
	HoshigamiprefabItem.super.ctor(self, go)
end

function HoshigamiprefabItem:buildUI()
	HoshigamiprefabItem.super.buildUI(self)

	self._nameText = self:getText("bg/text")

	local bg = self:getGo("bg")

	self._imgSelectGo = self:getGo("bg/imgSelect")
	self._btn = self:getBtn("bg")
	self._imgChange = bg:GetComponent(ComponentType.UIChangeGroup)
end

function HoshigamiprefabItem:bindEvents()
	HoshigamiprefabItem.super.bindEvents(self)
	self._btn:AddClickListener(self._onClick, self)
end

function HoshigamiprefabItem:unbindEvents()
	HoshigamiprefabItem.super.unbindEvents(self)
	self._btn:RemoveClickListener()
end

function HoshigamiprefabItem:onEnter(data, selectSuitId, handle, handleObj)
	HoshigamiprefabItem.super.onEnter(self)

	self._handle = handle
	self._handleObj = handleObj
	self._data = data
	self._isClickAddTab = data.isClickAddTab
	self._isCurrSuitTab = data.isCurrSuitTab

	self._imgChange:SetState(data.suitId == selectSuitId and 1 or 0)
	goutil.setActive(self._imgSelectGo, data.suitId == selectSuitId)

	self._nameText.text = data.suitId == -998 and "新增预设" or data.suitId == -999 and "当前星神套装" or "套装" .. data.suitId
end

function HoshigamiprefabItem:onExit()
	HoshigamiprefabItem.super.onExit(self)
end

function HoshigamiprefabItem:_onClick()
	self._handle(self._handleObj, self._data.suitId)
end

return HoshigamiprefabItem
