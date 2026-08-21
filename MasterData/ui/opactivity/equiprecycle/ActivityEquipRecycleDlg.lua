-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\EquipRecycle\\ActivityEquipRecycleDlg.lua

local ActivityEquipRecyclePanel = require("UI/OpActivity/EquipRecycle/ActivityEquipRecyclePanel")
local ActivityEquipRecycleTab = Class("ActivityEquipRecycleTab", UIControls.Child)

function ActivityEquipRecycleTab:ctor(...)
	self:initUI()
end

function ActivityEquipRecycleTab:initUI(...)
	self.equipRecycleTab = UIControls.Button(self, "")
	self.mainPanel = UIControls.Panel(self, "MainPanel")

	self.equipRecycleTab:addEventClick(self.onEquipRecycleTabClick)

	self.imgSelected = UIControls.Image(self, "MainPanel/ImgSelected")
	self.txtName = UIControls.Label(self, "MainPanel/Text")
	self.iconNew = UIControls.RedDot(self, "MainPanel/IconNew")
	self.confirms = {}

	for i = 1, 6 do
		local targetUI = UIControls.Image(self, "MainPanel/ReviewPanel/Dot" .. i .. "/Comfirm")

		table.insert(self.confirms, targetUI)
	end
end

local numToName = {
	Lang.get(99496),
	Lang.get(101569)
}

function ActivityEquipRecycleTab:setData(data)
	local equipNum = 0

	self.data = data

	if self.data then
		if self.data.equipList then
			equipNum = #self.data.equipList
		end

		for i = 1, 6 do
			self.confirms[i]:setVisible(i <= equipNum)
		end

		if self.data.isRent and not self.data.unLock then
			self.mainPanel:playStateAnimator("TabLock")
		else
			self.mainPanel:playStateAnimator("TabNormal")
		end
	end

	if self.index and numToName[self.index] then
		self.txtName:setText(numToName[self.index])
	end
end

function ActivityEquipRecycleTab:setSelect(isSelected)
	self.imgSelected:setVisible(isSelected)

	if isSelected then
		self.txtName:setFontColor(ResColor.EQUIPRECYCLETAB)
	else
		self.txtName:setFontColor(ResColor.EQUIPRECYCLETAB2)
	end

	self.isSelected = isSelected
end

function ActivityEquipRecycleTab:onEquipRecycleTabClick()
	if self.isSelected then
		return
	end

	self.mParent:onChangeSelectTab(self)
end

local ActivityEquipRecycleDlg = Class("ActivityEquipRecycleDlg", UIControls.Window)

function ActivityEquipRecycleDlg:ctor(...)
	self:initUI()
end

function ActivityEquipRecycleDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnExchange = UIControls.Button(self, "MainInfoPanel/BtnExchange")

	self.btnExchange:addEventClick(self.onBtnExchangeClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)
end

function ActivityEquipRecycleDlg:setData(actData)
	self.actData = actData or self.actData

	if self.actData then
		if not self.btnTabs then
			self.btnTabs = {}
		end

		if #self.btnTabs == 0 then
			for i = 1, 2 do
				self.btnTabs[i] = ActivityEquipRecycleTab(self, "MainInfoPanel/TabPanel/TabList/Content", "System/Activity/ActivityEquipRecycle/EquipRecycleTab")
				self.btnTabs[i].index = i

				self.btnTabs[i]:setVisible(true)

				if i == 1 then
					self.btnTabs[i].iconNew:addHint({
						UIConst.RD_HINT_EQUIP_RECYCLE_AWARD_NORMAL
					})
				elseif i == 2 then
					self.btnTabs[i].iconNew:addHint({
						UIConst.RD_HINT_EQUIP_RECYCLE_AWARD_RENT
					})
				end
			end
		end

		local selectTabIndex = self.nowSelectTab or 1

		for i = 1, 2 do
			self.btnTabs[i]:setSelect(selectTabIndex == i)

			if i == 1 then
				self.btnTabs[i]:setData(self.actData.mainWorkShopData)
			end

			if i == 2 then
				self.btnTabs[i]:setData(self.actData.rentWorkShopData)
			end
		end

		if not self.panelEquipRecycle then
			self.panelEquipRecycle = ActivityEquipRecyclePanel(self, "MainInfoPanel/RecyclePanel", "System/Activity/ActivityEquipRecycle/EquipRecyclePanel")

			self.panelEquipRecycle:setVisible(true)
		end

		self.panelEquipRecycle:setListIndex(selectTabIndex)
		self.panelEquipRecycle:setData(self.actData)
	end
end

function ActivityEquipRecycleDlg:onChangeSelectTab(sender)
	for i = 1, 2 do
		self.btnTabs[i]:setSelect(sender.index == i)
	end

	self.nowSelectTab = sender.index

	self.panelEquipRecycle:setListIndex(sender.index)
	self.panelEquipRecycle:onChangeData(self.actData)
end

function ActivityEquipRecycleDlg:onBtnExchangeClick()
	if self.actData then
		if self.actData:checkNeedShowStartTips() then
			local function funY(self)
				local itemId, itemNum = self.actData:getExchangeItemData()

				UIManager.getUI("activityBraceletExchangeDlg", true):setData(itemId)
			end

			UIManager.showConfirmWithId(1134, Slot(funY, self), nil)
		else
			local itemId, itemNum = self.actData:getExchangeItemData()

			UIManager.getUI("activityBraceletExchangeDlg", true):setData(itemId)
		end
	end
end

function ActivityEquipRecycleDlg:onBtnCloseClick()
	if self.actData and self.actData:checkNeedShowStartTips() then
		local function funY(self)
			self:setVisible(false)
		end

		UIManager.showConfirmWithId(1134, Slot(funY, self), nil)
	else
		self:setVisible(false)
	end
end

function ActivityEquipRecycleDlg:onBtnTipsClick(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(529)
end

return ActivityEquipRecycleDlg
