-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\EquipTipsStrenghPanel.lua

local strClassName = "EquipTipsStrenghPanel"
local EquipTipsStrenghPanel = Class(strClassName, UIControls.Panel)

function EquipTipsStrenghPanel:ctor()
	self:initUI()
end

function EquipTipsStrenghPanel:initUI()
	self.imgIconStar = UIControls.Image(self, self.mPath .. "/IconStar")
	self.txtTitle = UIControls.Label(self, self.mPath .. "/Text")
	self.txtNum = UIControls.Label(self, self.mPath .. "/TextNum")
end

function EquipTipsStrenghPanel:setEquip(equip)
	self.equip = equip

	local sprite = "IconEquipStar01Nml"
	local canEnhanceStr = Lang.get(582)

	if self.equip.canEnhance == 1 then
		self.txtNum:setVisible(true)

		local numStr = "+" .. self.equip:getMaxLevel()

		if self.equip.itemType == Const.ITEM_TYPE_EQUIP or self.equip:getMaxLevel() > 0 then
			numStr = "+" .. self.equip.enhanceLevel .. "/" .. numStr
		end

		self.txtNum:setText(numStr)
	else
		self.txtNum:setVisible(false)

		sprite = "IconEquipStar01Dis"
		canEnhanceStr = Lang.get(30233)
	end

	self.imgIconStar:setImage("Atlas/CommonAtlas/GridAtlas/GridEquipAtlas", sprite)
	self.txtNum:setVisible(self.equip.canEnhance == 1)
	self.txtTitle:setText(canEnhanceStr)
end

return EquipTipsStrenghPanel
