-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/ItemSignComponent.lua

module("logic.extensions.backpack.cellcomponent.ItemSignComponent", package.seeall)

local M = class("ItemSignComponent", CellBaseComponent)

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()

	self._rootGo = registry:findUIElement("backpack_item_549918192")
	self._goSign = {}
	self._goSign[CommEnum.BackPackItemSignTyp.RecommendSign] = registry:findUIElement("backpack_item_2030817851")
	self._goSign[CommEnum.BackPackItemSignTyp.First] = registry:findUIElement("rewards_detail_item_1708769659")
	self._goSign[CommEnum.BackPackItemSignTyp.Main] = registry:findUIElement("rewards_detail_item_1136215506")
	self._goSign[CommEnum.BackPackItemSignTyp.LimitTime] = registry:findUIElement("backpack_item_-1569296312")
	self._goSign[CommEnum.BackPackItemSignTyp.Extra] = registry:findUIElement("backpack_item_970798316")
	self._goSign[CommEnum.BackPackItemSignTyp.Probability] = registry:findUIElement("backpack_item_1540339615")
	self._goSign[CommEnum.BackPackItemSignTyp.Activity] = registry:findUIElement("backpack_item_-270536419")
	self._goSign[CommEnum.BackPackItemSignTyp.Get] = registry:findUIElement("backpack_item_413833979")
	self._goSign[CommEnum.BackPackItemSignTyp.Star] = registry:findUIElement("backpack_item_-2133219617")
	self._goSign[CommEnum.BackPackItemSignTyp.FixDrop] = registry:findUIElement("backpack_item_-2091142923")
	self._goSign[CommEnum.BackPackItemSignTyp.SmallProbabilityDrop] = registry:findUIElement("backpack_item_-53348070")
	self._goSign[CommEnum.BackPackItemSignTyp.MultipleDropDouble] = registry:findUIElement("backpack_item_207282543")
	self._goSign[CommEnum.BackPackItemSignTyp.MultipleDropTrible] = registry:findUIElement("backpack_item_1698105051")

	local rootSign = registry:findUIElement("backpack_item_549918192")

	for i = 0, rootSign.transform.childCount - 1 do
		local go = rootSign.transform:GetChild(i).gameObject

		goutil.setActive(go, false)
	end

	goutil.setActive(rootSign, true)
end

function M:updateData(data)
	self:hideAllSign()

	local sign = data and data.itemSign or nil

	self:setSignShow(sign, true)
end

function M:setVisible(visible)
	self._rootGo:SetActive(visible)
end

function M:hideAllSign()
	for key, value in pairs(self._goSign) do
		goutil.setActive(value, false)
	end
end

function M:setSignShow(signTyp, show)
	local go = self._goSign[signTyp]

	if go then
		goutil.setActive(go, show)
	end
end

function M:showSingle(signTyp)
	for _type, go in pairs(self._goSign or {}) do
		goutil.setActive(go, _type == signTyp)
	end
end

return M
