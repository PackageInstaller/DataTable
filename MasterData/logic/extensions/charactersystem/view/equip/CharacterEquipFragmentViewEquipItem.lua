-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/CharacterEquipFragmentViewEquipItem.lua

module("logic.extensions.charactersystem.view.equip.CharacterEquipFragmentViewEquipItem", package.seeall)

local M = class("CharacterEquipFragmentViewEquipItem")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._go = compContainer.gameObject
end

function M:Awake()
	self._btnClick = ButtonAdapter.Get(goutil.findChild(self._go, "click"))

	self._btnClick:AddClickListener(self._clickAdd, self)

	self._goItem = goutil.findChild(self._go, "backpack_item")
	self._itemCell = Astral.LuaComponentContainer.Add(self._goItem, ItemCell)
end

function M:addClickHandle(callBackFunc, callBackHandler)
	self._callBackFunc = callBackFunc
	self._callBackHandler = callBackHandler
end

function M:_clickAdd()
	if self._callBackFunc then
		if self._callBackHandler then
			self._callBackFunc(self._callBackHandler, self._part)
		else
			self._callBackFunc(self._part)
		end
	end
end

function M:setItemData(equipData, part)
	self._equipData = equipData
	self._part = part

	goutil.setActive(self._goItem, self._equipData)

	if self._equipData then
		self._itemCell:updateData(self._equipData)
	end
end

function M:OnDestroy()
	self._btnClick:RemoveClickListener()
end

return M
