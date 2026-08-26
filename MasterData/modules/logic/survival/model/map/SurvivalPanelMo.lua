-- chunkname: @modules/logic/survival/model/map/SurvivalPanelMo.lua

module("modules.logic.survival.model.map.SurvivalPanelMo", package.seeall)

local SurvivalPanelMo = pureTable("SurvivalPanelMo")

function SurvivalPanelMo:init(data)
	self.uid = data.uid
	self.type = data.type
	self.unitId = data.unitId
	self.treeId = data.treeId
	self.dialogueId = data.dialogueId
	self.param = data.param
	self.status = data.status
	self.canSelectNum = data.canSelectNum
	self.items = {}

	for i, v in ipairs(data.items) do
		local itemMo = SurvivalBagItemMo.New()

		itemMo:init(v)

		if self.type == SurvivalEnum.PanelType.Search then
			itemMo.source = SurvivalEnum.ItemSource.Search
			self.items[itemMo.uid] = itemMo
		elseif self.type == SurvivalEnum.PanelType.DropSelect then
			itemMo.source = SurvivalEnum.ItemSource.Drop
			self.items[i] = itemMo
		else
			self.items[i] = itemMo
		end
	end

	self.shop = SurvivalShopMo.New()

	self.shop:init(data.shop)

	self.decreesProp = SurvivalDecreesPanelPropMo.New()

	self.decreesProp:init(data.decreesProp)

	self.isFirstSearch = false
end

function SurvivalPanelMo:getSearchItems()
	return self.items
end

return SurvivalPanelMo
