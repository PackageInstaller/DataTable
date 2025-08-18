-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetGemInfoPanel.lua

local PetGemInfoPart = require("UI/Pet/PetGemInfoPart")
local PetGemInfoPanel = Class("PetGemInfoPanel", UIControls.Child)

function PetGemInfoPanel:ctor()
	self:initUI()
end

function PetGemInfoPanel:initUI()
	self.gemInfoPart = PetGemInfoPart(self, "AttrPanel")
	self.textName = UIControls.Label(self, "TextName")
end

function PetGemInfoPanel:setData(gem)
	self.gem = gem

	self.textName:setText(self.gem.name)

	if self.gemGrid == nil then
		self.gemGrid = UIControls.GridPetGemChild(self, "GridPanel", "System/Pet/GridPetGem", 0, 0, true)
	end

	self.gemGrid:setObj(self.gem)

	if self.gemGrid.iconState then
		self.gemGrid.iconState:setVisible(false)
	end

	self.gemGrid:setGridClickEnable(false)
	self.gemInfoPart:setData(self.gem)
end

return PetGemInfoPanel
