-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/BackpackNotGetTypeComponent.lua

module("logic.extensions.backpack.cellcomponent.BackpackNotGetTypeComponent", package.seeall)

local M = class("BackpackNotGetTypeComponent", CellBaseComponent)

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()

	self._notGetTypeGo = registry:findUIElement("backpack_item_1556523902")

	self._notGetTypeGo:SetActive(false)
end

function M:updateData(data)
	local visible = false
	local type = data:getType()

	if type and type == GameEnum.ItemTypeEnum.DrawingItemType then
		visible = data:getCount() == 0
	end

	self._notGetTypeGo:SetActive(visible)
end

return M
