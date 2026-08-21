-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetGemListDlg.lua

local EventConst = require("EventConst")
local strClassName = "PetGemListDlg"
local PetGemListDlg = Class(strClassName, UIControls.Window)

function PetGemListDlg:ctor()
	self:initUI()
end

function PetGemListDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnSwitch = UIControls.Button(self, "MainPanel/BtnSwitch")

	self.btnSwitch:addEventClick(self.onClickBtnSwitch)

	self.btnWash = UIControls.Button(self, "MainPanel/BtnWash")

	self.btnWash:addEventClick(self.onClickBtnWash)

	self.noContent = UIControls.Image(self, "MainPanel/ImgNone")
	self.itemListScroll = UIControls.ScrollViewLoopV(self, "MainPanel/ItemListScroll")

	self.itemListScroll:addEventCellChanged(self.onCellChanged)

	self.itemCells = {}
	self.btnLvUp = UIControls.Button(self, "MainPanel/BtnLvUp")

	self.btnLvUp:addEventClick(self.onBtnLvUpClick)

	self.bagNum = UIControls.Label(self, "MainPanel/BagNum/Text")
	self.slotOnPetGemChange = Slot(self.onPetGemChange, self)

	EventCenter.addEventListener(EventConst.PET_GEM_CHANGE, self.slotOnPetGemChange)
end

function PetGemListDlg:destroy()
	EventCenter.removeEventListener(EventConst.PET_GEM_CHANGE, self.slotOnPetGemChange)
	PetGemListDlg.super.destroy(self)
end

function PetGemListDlg:setData()
	self.gemList = CurAvatar:getAllPetGemList()

	table.sort(self.gemList, function(a, b)
		if a.level ~= b.level then
			return a.level > b.level
		else
			return a.id > b.id
		end
	end)
	self.noContent:setVisible(#self.gemList == 0)
	self.itemListScroll:setTotalCount(#self.gemList)
	self.bagNum:setText(string.format("%d/%d", #self.gemList, CurAvatar.bagSize[Const.BAG_TYPE_PET_GEM]))
	self:refreshBtnSwitchAndBtnWash()
end

function PetGemListDlg:onCellChanged(sender, targetCell, newIdx)
	targetCell = targetCell or UIControls.GridPetGemLoop(sender, "System/Pet/GridPetGem", newIdx)

	if not self.gemList or #self.gemList == 0 then
		return
	end

	if self.gemList[newIdx] ~= nil then
		targetCell:setObj(self.gemList[newIdx])

		targetCell.mEventClick = Slot(self.selectItemClick, self)

		if targetCell.iconStarUpRed then
			targetCell.iconStarUpRed:setVisible(self.gemList[newIdx]:checkGemCanLevelUp())
		end
	end

	self.itemCells[newIdx] = targetCell
end

function PetGemListDlg:selectItemClick(sender)
	local mTipsConfig = CurAvatar.commonGemTipsFuncItem

	UIManager.getUI("petGemTips"):show(sender, mTipsConfig, nil, nil, {
		checkShowPetGemChange = true
	})
end

function PetGemListDlg:onBtnLvUpClick()
	UIManager.getUI("petGemLvUpDlg", true):setData()
end

function PetGemListDlg:refreshUI()
	self:setData()
end

function PetGemListDlg:onBtnCloseClick()
	self:setVisible(false)
end

function PetGemListDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_PET_GEM)
end

function PetGemListDlg:refreshBtnSwitchAndBtnWash()
	local checkSwitchEnterOpen = CurAvatar:checkPetGemSwitchEnterOpen()
	local checkWashEnterOpen = CurAvatar:checkPetGemWashEnterOpen()

	self.btnSwitch:setVisible(checkSwitchEnterOpen)
	self.btnWash:setVisible(checkWashEnterOpen)
end

function PetGemListDlg:onPetGemChange()
	if self.gemList then
		self.itemListScroll:setTotalCount(#self.gemList)
	end
end

function PetGemListDlg:onClickBtnSwitch()
	UIManager.getUI("petGemSwitchDlg", true)
end

function PetGemListDlg:onClickBtnWash()
	UIManager.getUI("petGemWashDlg", true)
end

return PetGemListDlg
