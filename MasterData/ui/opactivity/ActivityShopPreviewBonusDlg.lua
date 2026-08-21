-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityShopPreviewBonusDlg.lua

local ResShopExchg = require("ClientData/ResShopExchg")
local ShopItem = require("UI/MainState/Trade/ShopItem")
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local ResOpActivityAchieveMisc = require("ClientData/ResOpActivityAchieveMisc")
local UIControls = UIControls
local ActivityShopPreviewBonusCell = Class("ActivityShopPreviewBonusCell", UIControls.Child)

function ActivityShopPreviewBonusCell:ctor()
	self:initUI()
end

function ActivityShopPreviewBonusCell:initUI()
	self.grid = UIControls.getGridContainer(self, "GridItem", true)
	self.grid.mDisableWays = true

	self.grid:setVisible(true)

	self.panelLock = UIControls.Panel(self, "LockPanel")
	self.textLock = UIControls.Label(self, "LockPanel/TxtLock")
	self.imgCost = UIControls.Image(self, "ChargePanel/Icon")
	self.textCost = UIControls.Label(self, "ChargePanel/TxtNum")
	self.shopItemName = UIControls.Label(self, "TxtName")
	self.textLimit = UIControls.Label(self, "LimitPanel/TxtNum")
	self.panelSelf = UIControls.Panel(self, "")
end

function ActivityShopPreviewBonusCell:setData(shopItem, nowLevel, shopLevel)
	self.grid:setObj(shopItem.object)
	self.textLimit:setText(shopItem.data.exchgmax or "∞")

	if shopItem:isLocked() then
		self.panelLock:setVisible(true)
		self.textLock:setText(shopItem.lockHint or "")
		self:playStateAnimator("TokenAwardCellDis")
		self.grid.grid:setIconGray(true)
		self.panelSelf:setObjGray(true)
	elseif shopLevel < nowLevel then
		self.panelLock:setVisible(true)
		self.textLock:setText("")
		self:playStateAnimator("TokenAwardCellDis")
		self.grid.grid:setIconGray(true)
		self.panelSelf:setObjGray(true)
	else
		self.panelLock:setVisible(false)
		self:playStateAnimator("TokenAwardCellNml")
		self.grid.grid:setIconGray(false)
		self.panelSelf:setObjGray(false)
	end

	self.shopItemName:setText(shopItem.object.name or "")

	local moneyInfo = shopItem.data.use[1]
	local moneyPath = ClientUtils.getMoneyIcon(moneyInfo.ID)

	if moneyPath then
		self.imgCost:setImage(moneyPath[1], moneyPath[2])
	else
		local itemPath = BaseObject.getItemIconPath(moneyInfo.ID)

		if itemPath then
			self.imgCost:setImage(itemPath[1], itemPath[2])
		end
	end

	self.textCost:setText(moneyInfo.discount)
end

local classNameStr = "ActivityShopPreviewBonusDlg"
local ActivityShopPreviewBonusDlg = Class(classNameStr, UIControls.Window)

function ActivityShopPreviewBonusDlg:ctor()
	self:initUI()
end

local MAX_TAB_NUM = 5

function ActivityShopPreviewBonusDlg:initUI()
	self.btnTabs = {}

	for index = 1, MAX_TAB_NUM do
		local newBtn = UIControls.Button(self, "BgPanel/TabPanel/BtnTab" .. index, "Text")

		newBtn.index = index

		newBtn:addEventClick(self.onTabClick)
		table.insert(self.btnTabs, newBtn)
	end

	self.cellsAward = {}
	self.panelView = UIControls.Panel(self, "BgPanel/AwardInfoPanel/Viewport/Content")
end

function ActivityShopPreviewBonusDlg:onShow(actData)
	self.actData = actData
	self.nowLevel = actData.shopLevel + 1
	self.levelData = {}

	for exchgid, data in pairs(actData.clientData) do
		local level = data.level or 0

		level = level + 1

		if not self.levelData[level] then
			self.levelData[level] = {}
		end

		table.insert(self.levelData[level], actData:_createItemInfo(0, exchgid, 0, true))
	end

	for level, levelData in pairs(self.levelData) do
		table.sort(levelData, utils.getSortingFunc("id", true))
	end

	local btnStr = actData.miscData.preview_bonus_title

	for index, btn in ipairs(self.btnTabs) do
		if self.levelData[index] then
			btn:setVisible(true)

			if btnStr then
				btn:setText(string.format(btnStr, index))
			end
		else
			btn:setVisible(false)
		end
	end

	self:onTabClick(self.btnTabs[1])
end

function ActivityShopPreviewBonusDlg:onTabClick(sender)
	self.panelView:setPosition(0, 0)

	for index, btn in ipairs(self.btnTabs) do
		btn:setEnable(btn ~= sender)
	end

	self.level = sender.index
	self.nowData = self.levelData[self.level] or {}

	for index = #self.cellsAward + 1, #self.nowData do
		local newCell = ActivityShopPreviewBonusCell(self, "BgPanel/AwardInfoPanel/Viewport/Content", "System/Activity/TokenAwardCell")

		table.insert(self.cellsAward, newCell)
	end

	for index, cell in ipairs(self.cellsAward) do
		local lData = self.nowData[index]

		if lData then
			cell:setVisible(true)
			cell:setData(lData, self.level, self.nowLevel)
		else
			cell:setVisible(false)
		end
	end
end

return ActivityShopPreviewBonusDlg
