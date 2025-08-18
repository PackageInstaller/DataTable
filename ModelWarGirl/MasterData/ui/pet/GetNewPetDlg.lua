-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\GetNewPetDlg.lua

local ShareAchievePanel = require("UI/Achieve/ShareAchievePanel")
local strClassName = "GetNewPetDlg"
local GetNewPetDlg = Class(strClassName, UIControls.Window)

function GetNewPetDlg:ctor()
	self:initUI()
end

function GetNewPetDlg:initUI()
	self.imgPetRole = UIControls.PetRole(self, "InfoPanel/GridPetPortraitPanel")
	self.imgPetRole2 = UIControls.PetRole(self, "InfoPanel/GridPetPortraitPanel02")
	self.imgPetRole3 = UIControls.PetRole(self, "InfoPanel/GridPetPortraitPanel03")
	self.textName = UIControls.Label(self, "InfoPanel/BgTextName/TextName")
	self.btnBlock = UIControls.Button(self, "Block")

	self.btnBlock:addEventClick(self.onBtnBlockClick)

	self.sharePanel = ShareAchievePanel(self, "SharePanel")
end

function GetNewPetDlg:setData(pet, transItems)
	self.pet = pet
	self.transItems = transItems

	self.imgPetRole:showRole(self.pet.id)
	self.imgPetRole2:showRole(self.pet.id)
	self.imgPetRole2:changeMaterial(UIConst.PET_PORTRAIT_02_GET_NEW_MATERIAL)
	self.imgPetRole3:showRole(self.pet.id)
	self.textName:setText(self.pet.name)
	self.sharePanel:setAchieveInfo(Const.ACHIEVE_TYPE_SHARE_GET_PET, "getNewPetDlg")
	self.sharePanel:setShareVisible(true)
end

function GetNewPetDlg:onBtnBlockClick()
	self:setVisible(false)
end

function GetNewPetDlg:onClose()
	if self.transItems then
		CurAvatar:onGetBonusNotice("petShowAwardDlg", "onShow", {
			self.transItems
		})
	else
		local petLevelUpDlg = UIManager.tryGetUI("petLevelUpDlg")

		if petLevelUpDlg then
			petLevelUpDlg:setVisible(true)
		end
	end

	GetNewPetDlg.super.onClose(self)
end

return GetNewPetDlg
