-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetPossessGiftDlg.lua

local ResColor = require("ClientData/ResColor")
local ResPetStar = require("ClientData/ResPetStar")
local ResPetMisc = require("ClientData/ResPetMisc")
local EventConst = require("EventConst")
local PetPossessGiftDlg = Class("PetPossessGiftDlg", UIControls.Window)

function PetPossessGiftDlg:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.btnTips = UIControls.Button(self, "BgPanel/BtnTips")

	self.btnTips:addEventClick(self.onClickBtnTips)

	self.btnAllGift = UIControls.Button(self, "BgPanel/BtnAllSkill")

	self.btnAllGift:addEventClick(self.onClickAllGift)

	self.imgCareer = UIControls.Image(self, "BgPanel/ImgCareer")
	self.petCell = UIControls.ItemGridChild(self, "BgPanel/GridPanel", "System/Common/Grid/GridMaterialItem")

	self.petCell:setVisible(true)
	self.petCell:setClickEnable(false)

	self.newSkillListPanel = UIControls.Panel(self, "BgPanel/SkillNewPanel/SkillList")
	self.newSkillNoContentPanel = UIControls.Panel(self, "BgPanel/SkillNewPanel/NoContent")
	self.getGiftPanel = UIControls.Panel(self, "BgPanel/GetSkillPanel")
	self.btnCostItem1 = UIControls.Button(self, "BgPanel/GetSkillPanel/BtnTips01")

	self.btnCostItem1:addEventClick(self.onClickBtnCostItem1)

	self.imgCostItem1 = UIControls.Image(self, "BgPanel/GetSkillPanel/BtnTips01/Icon")
	self.txtCostItem1 = UIControls.Label(self, "BgPanel/GetSkillPanel/BtnTips01/TextNum")
	self.btnCostItem2 = UIControls.Button(self, "BgPanel/GetSkillPanel/BtnTips02")

	self.btnCostItem2:addEventClick(self.onClickBtnCostItem2)

	self.imgCostItem2 = UIControls.Image(self, "BgPanel/GetSkillPanel/BtnTips02/Icon")
	self.txtCostItem2 = UIControls.Label(self, "BgPanel/GetSkillPanel/BtnTips02/TextNum")
	self.btnCostItem3 = UIControls.Button(self, "BgPanel/GetSkillPanel/BtnTips03")

	self.btnCostItem3:addEventClick(self.onClickBtnCostItem3)

	self.imgCostItem3 = UIControls.Image(self, "BgPanel/GetSkillPanel/BtnTips03/Icon")
	self.txtCostItem3 = UIControls.Label(self, "BgPanel/GetSkillPanel/BtnTips03/TextNum")
	self.btnGetGift1 = UIControls.Button(self, "BgPanel/GetSkillPanel/BtnGetSkill01")

	self.btnGetGift1:addEventClick(self.onClickBtnGetGift1, 0.5)

	self.getGift1NmlPanel = UIControls.Panel(self, "BgPanel/GetSkillPanel/BtnGetSkill01/NmlPanel")
	self.getGift1DisPanel = UIControls.Panel(self, "BgPanel/GetSkillPanel/BtnGetSkill01/DisPanel")
	self.btnGetGift2 = UIControls.Button(self, "BgPanel/GetSkillPanel/BtnGetSkill02")

	self.btnGetGift2:addEventClick(self.onClickBtnGetGift2, 0.5)

	self.getGift2NmlPanel = UIControls.Panel(self, "BgPanel/GetSkillPanel/BtnGetSkill02/NmlPanel")
	self.getGift2DisPanel = UIControls.Panel(self, "BgPanel/GetSkillPanel/BtnGetSkill02/DisPanel")
	self.btnGetGift3 = UIControls.Button(self, "BgPanel/GetSkillPanel/BtnGetSkill03")

	self.btnGetGift3:addEventClick(self.onClickBtnGetGift3, 0.5)

	self.getGift3NmlPanel = UIControls.Panel(self, "BgPanel/GetSkillPanel/BtnGetSkill03/NmlPanel")
	self.getGift3DisPanel = UIControls.Panel(self, "BgPanel/GetSkillPanel/BtnGetSkill03/DisPanel")
	self.savePanel = UIControls.Panel(self, "BgPanel/SavePanel")
	self.btnSaveNew = UIControls.Button(self, "BgPanel/SavePanel/BtnSave")

	self.btnSaveNew:addEventClick(self.onClickBtnSaveNew)

	self.btnSaveOld = UIControls.Button(self, "BgPanel/SavePanel/BtnCancel")

	self.btnSaveOld:addEventClick(self.onClickBtnSaveOld)

	self.efx1 = UIControls.LazyEffectPlayer(self, "BgPanel/SkillNewPanel/Efx1")
	self.efx2 = UIControls.LazyEffectPlayer(self, "BgPanel/SkillNewPanel/Efx2")
	self.efx3 = UIControls.LazyEffectPlayer(self, "BgPanel/SkillNewPanel/Efx3")
	self.selectEfx = UIControls.LazyEffectPlayer(self, "BgPanel/SkillOldPanel/Efx")
	self.slotOnPetGistChange = Slot(self.onPetGiftChange, self)

	EventCenter.addEventListener(EventConst.PET_GIFT_CHANGE, self.slotOnPetGistChange)
end

function PetPossessGiftDlg:onOpen()
	PetPossessGiftDlg.super.onOpen(self)

	local ui = UIManager.getUI("petPossessMainDlg")

	if ui then
		self:bindWindow(ui)
	end

	self:refreshView()
end

function PetPossessGiftDlg:destroy()
	PetPossessGiftDlg.super.destroy(self)
	EventCenter.removeEventListener(EventConst.PET_GIFT_CHANGE, self.slotOnPetGistChange)
end

function PetPossessGiftDlg:setData(pet)
	self.pet = pet

	self.petCell:setObj(self.pet)
	self:refreshView()

	if RedDotManager.getKeyState(UIConst.RD_HINT_PET_POSSESS_GIFT) then
		CurAvatar:onOpenPetPossessGiftDlg(self.pet)
	end
end

function PetPossessGiftDlg:refreshView()
	if not self.pet then
		return
	end

	local possessCareerId = CurAvatar:getPetPossessInfoByPetId(self.pet.id)
	local checkPossess = possessCareerId and possessCareerId > 0

	self.imgCareer:setVisible(checkPossess)

	if checkPossess then
		self.imgCareer:setImage("Atlas/PetAtlas/PetEnchantAtlas9", "IconCareerStroke0" .. possessCareerId)
	end

	local maxGiftNum = ResPetStar[self.pet.star].gifted_limit
	local oldGiftIdList = self.pet.giftList

	self.oldGiftCellList = self.oldGiftCellList or {}

	local oldDataNum = #oldGiftIdList
	local oldCellNum = #self.oldGiftCellList

	for i = 1, maxGiftNum do
		local cell

		if i <= oldCellNum then
			cell = self.oldGiftCellList[i]
		else
			cell = UIControls.GridPetGiftDetailChild(self, "BgPanel/SkillOldPanel/SkillList", "System/Pet/GridEnchantTipsSkill")

			table.insert(self.oldGiftCellList, cell)
		end

		cell:setVisible(true)

		if i <= oldDataNum then
			cell:setData(true, oldGiftIdList[i])
		else
			cell:setData(true, 0)
		end
	end

	if maxGiftNum < oldCellNum then
		for i = maxGiftNum + 1, oldCellNum do
			self.oldGiftCellList[i]:setVisible(false)
		end
	end

	local checkNewData = self.pet.unSaveGiftData ~= nil

	self.newSkillListPanel:setVisible(checkNewData)
	self.newSkillNoContentPanel:setVisible(not checkNewData)
	self.savePanel:setVisible(checkNewData)
	self.getGiftPanel:setVisible(not checkNewData)

	if checkNewData then
		local newGiftIdList = utils.deepcopy(oldGiftIdList)

		newGiftIdList[self.pet.unSaveGiftData.pos] = self.pet.unSaveGiftData.id
		self.newGiftCellList = self.newGiftCellList or {}

		local newDataNum = #newGiftIdList
		local newCellNum = #self.newGiftCellList

		for i = 1, maxGiftNum do
			local cell

			if i <= newCellNum then
				cell = self.newGiftCellList[i]
			else
				cell = UIControls.GridPetGiftDetailChild(self, "BgPanel/SkillNewPanel/SkillList", "System/Pet/GridEnchantTipsSkill")

				table.insert(self.newGiftCellList, cell)
			end

			cell:setVisible(true)

			if i <= newDataNum then
				local giftId = newGiftIdList[i]

				cell:setData(true, giftId)
				cell:setNew(self.pet.unSaveGiftData.id == giftId)
			else
				cell:setData(true, 0)
			end
		end

		if maxGiftNum < newCellNum then
			for i = maxGiftNum + 1, newCellNum do
				self.newGiftCellList[i]:setVisible(false)
			end
		end
	else
		local miscConfig = ResPetMisc[1]
		local costItemId1 = miscConfig.purple_gift_id
		local needCostItemNum1 = 1
		local haveCostItemNum1 = CurAvatar:getItemNumById(costItemId1)

		self.checkCostItem1Enough = needCostItemNum1 <= haveCostItemNum1

		self.getGift1NmlPanel:setVisible(self.checkCostItem1Enough)
		self.getGift1DisPanel:setVisible(not self.checkCostItem1Enough)

		self.costItem1 = BaseObject.GetObject(costItemId1, needCostItemNum1)

		self.txtCostItem1:setFontColor(self.checkCostItem1Enough and ResColor.COLORRANK05 or ResColor.RED)
		self.txtCostItem1:setText(needCostItemNum1 .. "/" .. haveCostItemNum1)

		local iconPath1 = self.costItem1:getIconPath()

		if iconPath1 then
			self.imgCostItem1:setImage(iconPath1[1], iconPath1[2])
		end

		local costItemId2 = miscConfig.orange_gift_id
		local needCostItemNum2 = 1
		local haveCostItemNum2 = CurAvatar:getItemNumById(costItemId2)

		self.checkCostItem2Enough = needCostItemNum2 <= haveCostItemNum2

		self.getGift2NmlPanel:setVisible(self.checkCostItem2Enough)
		self.getGift2DisPanel:setVisible(not self.checkCostItem2Enough)

		self.costItem2 = BaseObject.GetObject(costItemId2, needCostItemNum2)

		self.txtCostItem2:setText(needCostItemNum2 .. "/" .. haveCostItemNum2)
		self.txtCostItem2:setFontColor(self.checkCostItem2Enough and ResColor.COLORRANK05 or ResColor.RED)

		local iconPath2 = self.costItem2:getIconPath()

		if iconPath2 then
			self.imgCostItem2:setImage(iconPath2[1], iconPath2[2])
		end

		local costItemId3 = miscConfig.red_gift_id
		local needCostItemNum3 = 1
		local haveCostItemNum3 = CurAvatar:getItemNumById(costItemId3)

		self.checkCostItem3Enough = needCostItemNum3 <= haveCostItemNum3

		self.getGift3NmlPanel:setVisible(self.checkCostItem3Enough)
		self.getGift3DisPanel:setVisible(not self.checkCostItem3Enough)

		self.costItem3 = BaseObject.GetObject(costItemId3, needCostItemNum3)

		self.txtCostItem3:setText(needCostItemNum3 .. "/" .. haveCostItemNum3)
		self.txtCostItem3:setFontColor(self.checkCostItem3Enough and ResColor.COLORRANK05 or ResColor.RED)

		local iconPath3 = self.costItem3:getIconPath()

		if iconPath3 then
			self.imgCostItem3:setImage(iconPath3[1], iconPath3[2])
		end
	end
end

function PetPossessGiftDlg:onClickBtnGetGift1()
	if not self.checkCostItem1Enough then
		MsgManager.clientNotice(760)

		return
	end

	RPC.petDevelopGift(self.pet.id, self.costItem1.id)
end

function PetPossessGiftDlg:onClickBtnGetGift2()
	if not self.checkCostItem2Enough then
		MsgManager.clientNotice(760)

		return
	end

	RPC.petDevelopGift(self.pet.id, self.costItem2.id)
end

function PetPossessGiftDlg:onClickBtnGetGift3()
	if not self.checkCostItem3Enough then
		MsgManager.clientNotice(760)

		return
	end

	RPC.petDevelopGift(self.pet.id, self.costItem3.id)
end

function PetPossessGiftDlg:onClickBtnSaveNew()
	RPC.petChooseGift(self.pet.id, Const.PET_CHOOSE_INTELLIGENCE_TYPE.New)
end

function PetPossessGiftDlg:onClickBtnSaveOld()
	RPC.petChooseGift(self.pet.id, Const.PET_CHOOSE_INTELLIGENCE_TYPE.Old)
end

function PetPossessGiftDlg:onClickBtnCostItem1()
	UIManager.getUI("itemTips"):showObj(self, self.costItem1)
end

function PetPossessGiftDlg:onClickBtnCostItem2()
	UIManager.getUI("itemTips"):showObj(self, self.costItem2)
end

function PetPossessGiftDlg:onClickBtnCostItem3()
	UIManager.getUI("itemTips"):showObj(self, self.costItem3)
end

function PetPossessGiftDlg:onClickAllGift()
	local ui = UIManager.getUI("petPossessAllGiftDlg", true)

	if ui then
		ui:setData(self.pet)
	end
end

function PetPossessGiftDlg:onClickBtnClose()
	self:setVisible(false)
end

function PetPossessGiftDlg:onClickBtnTips()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_PET_POSSESS_GIFT)
end

function PetPossessGiftDlg:onPetDevelopGiftResp(pet_id, res_id)
	self:refreshView()

	if res_id == self.costItem1.id then
		self.efx1:playEffect()
	elseif res_id == self.costItem2.id then
		self.efx2:playEffect()
	elseif res_id == self.costItem3.id then
		self.efx3:playEffect()
	end
end

function PetPossessGiftDlg:onPetGiftChange(pet_id, op_type)
	self:refreshView()

	if op_type == Const.PET_CHOOSE_INTELLIGENCE_TYPE.New then
		self.selectEfx:playEffect()
	end
end

return PetPossessGiftDlg
