-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Equip\\EquipUpGradePanel.lua

local SingleEquipTipsChild = require("UI/Common/Tips/SingleEquipTipsChild")
local EquipUpGradeMaterialPanel = require("UI/Equip/EquipUpGradeMaterialPanel")
local strClassName = "EquipUpGradePanel"
local EquipUpGradePanel = Class(strClassName, SingleEquipTipsChild)

function EquipUpGradePanel:ctor()
	self:initUI()
end

function EquipUpGradePanel:initUI()
	self.upgradeMaterialPanel = EquipUpGradeMaterialPanel(self, "EquipUpGrade")
	self.textLevel = UIControls.Label(self, "BgUpgrade/Text")
	self.txtMainPropChange = UIControls.Label(self, "InfoList/Content/AttrPanel/AttrMainPanel/AttrMain01/TextNum2")

	for _, cell in ipairs(self.assistCells) do
		cell.imgNew = UIControls.Image(cell, cell.mPath .. "/ImgNew")
	end
end

function EquipUpGradePanel:setItem(equip)
	EquipUpGradePanel.super.setItem(self, equip)
	self.upgradeMaterialPanel:setEquip(equip)
	self.textLevel:setVisible(equip.enhanceLevel ~= 0)
	self.textLevel:setText("+" .. equip.enhanceLevel)
end

function EquipUpGradePanel:updateMaterial(materialItem, isAdd)
	self.upgradeMaterialPanel:updateMaterial(materialItem, isAdd)
end

function EquipUpGradePanel:getAddMaterialCount()
	return self.upgradeMaterialPanel:getAddMaterialCount()
end

function EquipUpGradePanel:clearMaterial(props, total_xp)
	local newPropIdxList = {}

	if props then
		for index, cell in ipairs(self.assistCells) do
			if not cell:getVisible() then
				table.insert(newPropIdxList, index)
			end
		end
	end

	local newEquip = CurAvatar.bagEquips[self.gridEquip.object.gid]

	self:setItem(newEquip)

	if #newPropIdxList > 0 then
		for i, newPropIdx in ipairs(newPropIdxList) do
			local newPropCell = self.assistCells[newPropIdx]

			newPropCell.imgNew:setVisible(true)
		end
	end

	self.upgradeMaterialPanel:clearMaterial()
end

function EquipUpGradePanel:showPropChange()
	return
end

return EquipUpGradePanel
