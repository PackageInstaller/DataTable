-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetPossessAllGiftDlg.lua

local ResPetGifted = require("ClientData/ResPetGifted")
local ResPet = require("ClientData/ResPet")
local PetPossessAllGiftDlg = Class("PetPossessAllGiftDlg", UIControls.Window)

function PetPossessAllGiftDlg:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.txtPetName = UIControls.Label(self, "BgPanel/TextPetName")
	self.petCell = UIControls.ItemGridChild(self, "BgPanel/GridPanel", "System/Common/Grid/GridMaterialItem")

	self.petCell:setVisible(true)
	self.petCell:setClickEnable(false)

	self.loopSkill = UIControls.ScrollViewLoopV(self, "BgPanel/SkillList")

	self.loopSkill:addEventCellChanged(self.onLoopSkillChange)
end

function PetPossessAllGiftDlg:setData(pet)
	self.pet = pet

	self.txtPetName:setText(self.pet.name)
	self.petCell:setObj(pet)

	self.giftIdList = {}

	if self.pet.resData.purple_pool then
		for _, giftId in pairs(self.pet.resData.purple_pool) do
			table.insert(self.giftIdList, giftId)
		end
	end

	if self.pet.resData.orange_pool then
		for _, giftId in pairs(self.pet.resData.orange_pool) do
			table.insert(self.giftIdList, giftId)
		end
	end

	if self.pet.resData.red_pool then
		for _, giftId in pairs(self.pet.resData.red_pool) do
			table.insert(self.giftIdList, giftId)
		end
	end

	self.loopSkill:setTotalCount(#self.giftIdList)
end

function PetPossessAllGiftDlg:onLoopSkillChange(sender, targetCell, index)
	if not targetCell then
		targetCell = UIControls.GridPetGiftDetailLoop(sender, "System/Pet/GridEnchantTipsSkill", index)
	else
		targetCell.mIndex = index
	end

	local giftId = self.giftIdList[index]

	targetCell:setData(true, giftId)
	targetCell:setHave(self.pet:checkHaveGift(giftId))
end

function PetPossessAllGiftDlg:onClickBtnClose()
	self:setVisible(false)
end

return PetPossessAllGiftDlg
