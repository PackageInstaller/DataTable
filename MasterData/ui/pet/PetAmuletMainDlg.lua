-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetAmuletMainDlg.lua

local strClassName = "PetAmuletMainDlg"
local PetAmuletMainDlg = Class(strClassName, UIControls.Window)

function PetAmuletMainDlg:ctor()
	self:initUI()
end

function PetAmuletMainDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.noContent = UIControls.Image(self, "PetSkillPanel/ImgNone")
	self.itemListScroll = UIControls.ScrollViewLoopV(self, "PetSkillPanel/ItemListScroll")

	self.itemListScroll:addEventCellChanged(self.onCellChanged)

	self.itemCells = {}
end

function PetAmuletMainDlg:setData()
	self.amuletList = {}

	for i, v in pairs(CurAvatar.petAmuletDic or {}) do
		table.insert(self.amuletList, v)
	end

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
	self.itemListScroll:setTotalCount(#self.amuletList)
end

function PetAmuletMainDlg:onCellChanged(sender, targetCell, newIdx)
	targetCell = targetCell or UIControls.GridPetSkillLoop(sender, "System/Pet/GridPetSkill", newIdx)

	if not self.amuletList or #self.amuletList == 0 then
		return
	end

	if self.amuletList[newIdx] ~= nil then
		targetCell:setObj(self.amuletList[newIdx])

		targetCell.mEventClick = Slot(self.selectItemClick, self)

		if targetCell.iconStarUpRed then
			targetCell.iconStarUpRed:setVisible(self.amuletList[newIdx]:checkCanStarUp())
		end
	end

	self.itemCells[newIdx] = targetCell
end

function PetAmuletMainDlg:selectItemClick(sender)
	local mTipsConfig = CurAvatar.commonAmuletTipsFuncItem

	UIManager.getUI("petAmuletTips"):show(sender, mTipsConfig)
end

function PetAmuletMainDlg:refreshData()
	self:setData()
end

function PetAmuletMainDlg:onBtnCloseClick()
	self:setVisible(false)
end

function PetAmuletMainDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_PET_AMULET_MAIN)
end

return PetAmuletMainDlg
