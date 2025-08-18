-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\StarUp\\HeroStarUpRevertDlg.lua

local strClassName = "RevertHeroSelectListCell"
local RevertHeroSelectListCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function RevertHeroSelectListCell:ctor()
	self:initUI()
end

function RevertHeroSelectListCell:initUI()
	self.imgCheck = UIControls.Image(self, "Bg")
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)
end

function RevertHeroSelectListCell:setSelectCallback(selectCallback)
	self.selectCallback = selectCallback
end

function RevertHeroSelectListCell:onBtnSelfClick()
	if self.hero and self.selectCallback then
		self.selectCallback(self)
	end
end

function RevertHeroSelectListCell:setSelected(selected)
	self.selected = selected

	self.imgCheck:setVisible(self.selected)
end

function RevertHeroSelectListCell:setHero(hero)
	self.hero = hero

	if not self.gridHero then
		self.gridHero = UIControls.HeroGridChild(self, "GridPanel", "System/StarUp/GridHeroStarUp", 0, 0, true)
	end

	self.gridHero:setObj(self.hero)
end

local HeroStarRevertPanel = require("UI/Hero/StarUp/HeroStarRevertPanel")
local strClassName = "HeroStarUpRevertDlg"
local HeroStarUpRevertDlg = Class(strClassName, UIControls.Window)

function HeroStarUpRevertDlg:ctor()
	self:initUI()
end

function HeroStarUpRevertDlg:initUI()
	self.btnTips = UIControls.Button(self, "BgPanel/BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.panelHeroChoose = UIControls.Panel(self, "BgPanel/HeroChoosePanel")
	self.panelNothing = UIControls.Panel(self, "BgPanel/NothingPanel")
	self.panelBgSelect = UIControls.Panel(self, "BgPanel/HeroChoosePanel/BgSelect")
	self.panelHeroRevert = HeroStarRevertPanel(self, "BgPanel/HeroRevertPanel")
	self.cells = {}
	self.scrollSelectList = UIControls.ScrollViewLoopV(self, "BgPanel/HeroChooseList")

	self.scrollSelectList:addEventCellChanged(self.onSelectListChanged)
end

function HeroStarUpRevertDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_STAR_REVERT)
end

function HeroStarUpRevertDlg:initHeroList()
	self.selectHeroData = CurAvatar:getCanRevertStarHeroList()

	self.panelNothing:setVisible(#self.selectHeroData == 0)
	self.panelBgSelect:setVisible(#self.selectHeroData ~= 0)
	self.scrollSelectList:setTotalCount(#self.selectHeroData)
end

function HeroStarUpRevertDlg:refreshHeroList(heroDataList)
	self.selectedHero = nil

	self.panelHeroRevert:setVisible(false)
	self.panelHeroChoose:setVisible(true)

	self.selectHeroData = heroDataList

	self.panelNothing:setVisible(#self.selectHeroData == 0)
	self.panelBgSelect:setVisible(#self.selectHeroData ~= 0)
	self.scrollSelectList:setTotalCount(#self.selectHeroData)
end

function HeroStarUpRevertDlg:onSelectListChanged(sender, targetCell, newIdx)
	targetCell = targetCell or RevertHeroSelectListCell(sender, "System/StarUp/GridStarUpRevert", newIdx)

	if not self.selectHeroData or #self.selectHeroData == 0 then
		return
	end

	if self.selectHeroData[newIdx] ~= nil then
		targetCell:setSelected(self.selectedHero and self.selectedHero.gid == self.selectHeroData[newIdx].gid)
		targetCell:setHero(self.selectHeroData[newIdx])
		targetCell:setSelectCallback(Slot(self.onSelectHero, self))
	end

	self.cells[newIdx] = targetCell
end

function HeroStarUpRevertDlg:onSelectHero(sender)
	if sender.selected then
		self.selectedHero = nil

		self.panelHeroRevert:setVisible(false)
		self.panelHeroChoose:setVisible(true)
	else
		self.selectedHero = sender.hero

		self.panelHeroRevert:setVisible(true)
		self.panelHeroChoose:setVisible(false)
		self.panelHeroRevert:setHero(self.selectedHero)
	end

	self.panelNothing:setVisible(#self.selectHeroData == 0)
	self.panelBgSelect:setVisible(#self.selectHeroData ~= 0)
	self.scrollSelectList:setTotalCount(#self.selectHeroData)
end

function HeroStarUpRevertDlg:onBtnCloseClick()
	self:setVisible(false)
end

return HeroStarUpRevertDlg
