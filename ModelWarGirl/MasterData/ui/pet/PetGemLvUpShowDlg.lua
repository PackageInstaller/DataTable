-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetGemLvUpShowDlg.lua

local PetGemInfoPart = require("UI/Pet/PetGemInfoPart")
local ResPetGem = require("ClientData/ResPetGem")
local strClassName = "PetGemLvUpShowDlg"
local PetGemLvUpShowDlg = Class(strClassName, UIControls.Window)

function PetGemLvUpShowDlg:ctor()
	self:initUI()
end

function PetGemLvUpShowDlg:initUI()
	self.petGemName = UIControls.Label(self, "BgPanel/PetGemName")
	self.gemInfoPart = PetGemInfoPart(self, "BgPanel/AttrPanel")
end

function PetGemLvUpShowDlg:setData(gem)
	self.gem = gem

	self.petGemName:setText(self.gem.name)

	if self.gemGrid == nil then
		self.gemGrid = UIControls.GridPetGemChild(self, "BgPanel/PetGemItem", "System/Pet/GridPetGem", 0, 0, true)
	end

	self.gemGrid:setObj(self.gem)
	self.gemGrid:setGridClickEnable(false)

	if self:isShowSubNew() then
		self.gemInfoPart:setData(self.gem, {
			showNewSub = true
		})
	else
		self.gemInfoPart:setData(self.gem)
	end
end

function PetGemLvUpShowDlg:isShowSubNew()
	local curSubNum = 0
	local lastSubNum = 0

	for i, v in pairs(ResPetGem) do
		if v.level == self.gem.level then
			curSubNum = v.vice_attr_num
		end

		if v.level == self.gem.level - 1 then
			lastSubNum = v.vice_attr_num
		end
	end

	return lastSubNum < curSubNum
end

return PetGemLvUpShowDlg
