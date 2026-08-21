-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/BackpackEquipItemCellComponet.lua

module("logic.extensions.backpack.cellcomponent.BackpackEquipItemCellComponet", package.seeall)

local M = class("BackpackEquipItemCellComponet", CellBaseComponent)

function M:ctor(cell)
	M.super.ctor(self, cell)
end

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()
	local inEquipmentGo = registry:findUIElement("backpack_item_-1719482002")

	self._inEquipmentGo = inEquipmentGo
	self._inEquipBgGo = goutil.findChild(inEquipmentGo, "Image1")
	self._inEquipTextGo = goutil.findChild(inEquipmentGo, "Text")
	self._headGo = goutil.findChild(inEquipmentGo, "head")
	self._headIcon = registry:findUIElement("backpack_item_537430731")
	self._lockGo = registry:findUIElement("backpack_item_962705275")
	self._discardGo = registry:findUIElement("backpack_item_2012755664")

	self._inEquipmentGo:SetActive(true)
	self._inEquipBgGo:SetActive(false)
	self._inEquipTextGo:SetActive(false)
	self._headGo:SetActive(false)
	self._headIcon:SetActive(false)
end

function M:updateData(equipItemData)
	self._equipItemData = equipItemData

	local visible = equipItemData:getIsEquip()

	self._inEquipBgGo:SetActive(false)
	self._inEquipTextGo:SetActive(false)

	local heroId = equipItemData:getHeroId()
	local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

	self._isEquiped = false

	if visible and heroMO then
		self._isEquiped = true

		local modelCO = ModelConfig.instance:getModelConfig(heroMO:getModelId())

		IconLoader.setSprite(self._headIcon, IconType.RoleHeadIcon, modelCO.headIconName)
	end

	self:updateEquipStatus()
end

function M:updateEquipStatus()
	self._headGo:SetActive(self._isEquiped)
	self._headIcon:SetActive(self._isEquiped)

	local showLocked = not self._isEquiped and self._equipItemData:getIsLock()

	goutil.setActive(self._lockGo, showLocked)
end

return M
