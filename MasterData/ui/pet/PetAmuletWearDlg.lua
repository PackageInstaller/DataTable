-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetAmuletWearDlg.lua

local ResPetDegreeLevel = require("ClientData/ResPetDegreeLevel")
local PetAmuletSkillInfoPanel = require("UI/Pet/PetAmuletSkillInfoPanel")
local strClassName = "PetAmuletWearDlg"
local PetAmuletWearDlg = Class(strClassName, UIControls.Window)

function PetAmuletWearDlg:ctor()
	self:initUI()
end

function PetAmuletWearDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.view = UIControls.ScrollViewLoopV(self, "BgItemList/PetSkillListWearPanel", 0, self._initItem)
	self.cells = {}
	self.noContent = UIControls.Panel(self, "BgItemList/PetSkillListWearPanel/NoContent")
	self.panelNone1 = UIControls.Panel(self, "WearInfoPanel/TextNone")
	self.panelNone2 = UIControls.Panel(self, "WearInfoPanel/TextNone1")
	self.btnFunOff = UIControls.Button(self, "WearInfoPanel/BtnFun1")

	self.btnFunOff:addEventClick(self.onBtnFunOffClick)

	self.btnFunWear = UIControls.Button(self, "WearInfoPanel/BtnFun2")

	self.btnFunWear:addEventClick(self.onBtnFunWearClick)

	self.imgState = UIControls.Image(self, "WearInfoPanel/ImgState")
end

function PetAmuletWearDlg:setDataInBattle(amulet, pos, petId)
	self:setData(amulet, pos, petId)

	if self.panelFund then
		self.panelFund:setVisible(false)
	end
end

function PetAmuletWearDlg:setData(amulet, pos, petId)
	self.isFakeData = false
	self.amulet = amulet
	self.pos = pos or self.amulet.pos
	self.petId = petId or self.amulet.inWearing
	self.amuletList = CurAvatar:getAllCanWearAmuletList(self.pos)

	self:refreshData()
end

function PetAmuletWearDlg:setFakeData(amulet, pos, petId, amuletList, changeCb)
	self.isFakeData = true
	self.amulet = amulet
	self.pos = pos
	self.petId = petId
	self.amuletList = amuletList
	self.changeCb = changeCb

	self:refreshData()
end

function PetAmuletWearDlg:refreshData()
	self:refreshInfoPanel()
	self:refreshWearPanel()
	table.sort(self.amuletList, function(a, b)
		if a.quality ~= b.quality then
			return a.quality > b.quality
		elseif a.star ~= b.star then
			return a.star > b.star
		else
			return a.id > b.id
		end
	end)
	self.noContent:setVisible(#self.amuletList == 0)
	self.view:setTotalCount(#self.amuletList)
end

function PetAmuletWearDlg:_initItem(sender, targetCell, newIdx)
	targetCell = targetCell or UIControls.GridPetSkillLoop(sender, "System/Pet/GridPetSkill", newIdx)

	if not self.amuletList or #self.amuletList == 0 then
		return
	end

	if self.amuletList[newIdx] ~= nil then
		targetCell:setObj(self.amuletList[newIdx])
		targetCell.imgSelect:setVisible(self.selectItem and self.selectItem.id == self.amuletList[newIdx].id)

		targetCell.mEventClick = Slot(self.selectItemClick, self)

		if self.isFakeData then
			targetCell:hideIconState()
		end
	end

	self.cells[newIdx] = targetCell
end

function PetAmuletWearDlg:refreshInfoPanel()
	if self.amulet then
		self.wearInfoChild1 = self.wearInfoChild1 or PetAmuletSkillInfoPanel(self, "WearInfoPanel/InfoPanel1", "System/Pet/PetSkillInfoWearPanel", 0, 0, true)

		self.wearInfoChild1:setData(self.amulet)
		self.wearInfoChild1:setNoEffectSkillByPos(self.pos)
		self.panelNone1:setVisible(false)
		self.btnFunOff:setVisible(true)
		self.imgState:setVisible(true)
	else
		self.panelNone1:setVisible(true)
		self.btnFunOff:setVisible(false)
		self.imgState:setVisible(false)
	end
end

function PetAmuletWearDlg:refreshWearPanel()
	if self.selectItem then
		self.wearInfoChild2 = self.wearInfoChild2 or PetAmuletSkillInfoPanel(self, "WearInfoPanel/InfoPanel2", "System/Pet/PetSkillInfoWearPanel", 0, 0, true)

		self.wearInfoChild2:setData(self.selectItem)
		self.wearInfoChild2:setNoEffectSkillByPos(self.pos)
		self.panelNone2:setVisible(false)
		self.btnFunWear:setVisible(true)
	else
		self.panelNone2:setVisible(true)
		self.btnFunWear:setVisible(false)
	end
end

function PetAmuletWearDlg:selectItemClick(cell)
	self.selectItem = cell.object

	self:refreshWearPanel()
	self.view:setTotalCount(#self.amuletList)
end

function PetAmuletWearDlg:onBtnFunOffClick()
	if self.amulet then
		if self.changeCb then
			self.changeCb(Const.PET_AMULET_TYPE_OFF, Const.PET_AMULET_POS_TYPE[self.pos], self.petId, self.amulet.id)
			self:setVisible(false)
		else
			RPC.petAmuletSet(Const.PET_AMULET_TYPE_OFF, Const.PET_AMULET_POS_TYPE[self.pos], self.petId, self.amulet.id)
		end
	end
end

function PetAmuletWearDlg:onBtnFunWearClick()
	if self.selectItem then
		if self.changeCb then
			self.changeCb(Const.PET_AMULET_TYPE_WEAR, Const.PET_AMULET_POS_TYPE[self.pos], self.petId, self.selectItem.id)
			self:setVisible(false)
		else
			RPC.petAmuletSet(Const.PET_AMULET_TYPE_WEAR, Const.PET_AMULET_POS_TYPE[self.pos], self.petId, self.selectItem.id)
		end
	end
end

function PetAmuletWearDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_PET_AMULET_MAIN)
end

function PetAmuletWearDlg:onCloseClick()
	self:setVisible(false)
end

return PetAmuletWearDlg
