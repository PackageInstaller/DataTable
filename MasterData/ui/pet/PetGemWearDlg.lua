-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetGemWearDlg.lua

local ResPetDegreeLevel = require("ClientData/ResPetDegreeLevel")
local PetGemInfoPanel = require("UI/Pet/PetGemInfoPanel")
local strClassName = "PetGemWearDlg"
local PetGemWearDlg = Class(strClassName, UIControls.Window)

function PetGemWearDlg:ctor()
	self:initUI()
end

function PetGemWearDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.view = UIControls.ScrollViewLoopV(self, "BgItemList/PetGemListWearPanel", 0, self._initItem)
	self.cells = {}
	self.noContent = UIControls.Panel(self, "BgItemList/PetGemListWearPanel/NoContent")
	self.panelNone1 = UIControls.Panel(self, "WearInfoPanel/TextNone")
	self.panelNone2 = UIControls.Panel(self, "WearInfoPanel/TextNone1")
	self.btnFunOff = UIControls.Button(self, "WearInfoPanel/BtnFun1")

	self.btnFunOff:addEventClick(self.onBtnFunOffClick)

	self.btnFunWear = UIControls.Button(self, "WearInfoPanel/BtnFun2")

	self.btnFunWear:addEventClick(self.onBtnFunWearClick)

	self.imgState = UIControls.Image(self, "WearInfoPanel/ImgState")
end

function PetGemWearDlg:setDataInBattle(gem, petId)
	self:setData(gem, petId)

	if self.panelFund then
		self.panelFund:setVisible(false)
	end
end

function PetGemWearDlg:setData(gem, petId)
	self.isFakeData = false
	self.gem = gem
	self.petId = petId or self.gem.inWearing
	self.gemList = CurAvatar:getAllCanWearPetGemList()

	self:refreshData()
end

function PetGemWearDlg:setFakeData(gem, petId, gemList, changeCb)
	self.isFakeData = true
	self.gem = gem
	self.petId = petId
	self.gemList = gemList
	self.changeCb = changeCb

	self:refreshData()
end

function PetGemWearDlg:refreshData()
	self:refreshInfoPanel()
	self:refreshWearPanel()
	table.sort(self.gemList, function(a, b)
		if a.level ~= b.level then
			return a.level > b.level
		else
			return a.id > b.id
		end
	end)
	self.noContent:setVisible(#self.gemList == 0)
	self.view:setTotalCount(#self.gemList)
end

function PetGemWearDlg:_initItem(sender, targetCell, newIdx)
	targetCell = targetCell or UIControls.GridPetGemLoop(sender, "System/Pet/GridPetGem", newIdx)

	if not self.gemList or #self.gemList == 0 then
		return
	end

	if self.gemList[newIdx] ~= nil then
		targetCell:setObj(self.gemList[newIdx])
		targetCell.imgSelect:setVisible(self.selectItem and self.selectItem.gid == self.gemList[newIdx].gid)

		targetCell.mEventClick = Slot(self.selectItemClick, self)

		if self.isFakeData then
			targetCell:hideIconState()
		end
	end

	self.cells[newIdx] = targetCell
end

function PetGemWearDlg:refreshInfoPanel()
	if self.gem then
		self.wearInfoChild1 = PetGemInfoPanel(self, "WearInfoPanel/InfoPanel1", "System/Pet/PetGemInfoWearPanel", 0, 0, true)

		self.wearInfoChild1:setData(self.gem)
		self.panelNone1:setVisible(false)
		self.btnFunOff:setVisible(true)
		self.imgState:setVisible(true)
	else
		self.panelNone1:setVisible(true)
		self.btnFunOff:setVisible(false)
		self.imgState:setVisible(false)
	end
end

function PetGemWearDlg:refreshWearPanel()
	if self.selectItem then
		if not self.wearInfoChild2 then
			self.wearInfoChild2 = PetGemInfoPanel(self, "WearInfoPanel/InfoPanel2", "System/Pet/PetGemInfoWearPanel", 0, 0, true)
		end

		self.wearInfoChild2:setData(self.selectItem)
		self.panelNone2:setVisible(false)
		self.btnFunWear:setVisible(true)
		self.btnFunWear:setEnable(true)
	else
		self.panelNone2:setVisible(true)
		self.btnFunWear:setVisible(false)
	end
end

function PetGemWearDlg:selectItemClick(cell)
	self.selectItem = cell.object

	self:refreshWearPanel()
	self.view:setTotalCount(#self.gemList)
end

function PetGemWearDlg:onBtnFunOffClick()
	if self.gem then
		if self.changeCb then
			self.changeCb(Const.PET_GEM_TYPE_OFF, self.petId, nil, self.gem.gid)
			self:setVisible(false)
		else
			RPC.petGemInset(Const.PET_GEM_TYPE_OFF, self.petId, nil, self.gem.gid)
		end
	end
end

function PetGemWearDlg:onBtnFunWearClick()
	if self.selectItem then
		if self.changeCb then
			self.changeCb(Const.PET_GEM_TYPE_WEAR, self.petId, self.selectItem.gid, self.gem and self.gem.gid)
			self:setVisible(false)
		else
			RPC.petGemInset(Const.PET_GEM_TYPE_WEAR, self.petId, self.selectItem.gid, self.gem and self.gem.gid)
		end

		self.btnFunWear:setEnable(false)
	end
end

function PetGemWearDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_PET_GEM)
end

function PetGemWearDlg:onCloseClick()
	self:setVisible(false)
end

return PetGemWearDlg
