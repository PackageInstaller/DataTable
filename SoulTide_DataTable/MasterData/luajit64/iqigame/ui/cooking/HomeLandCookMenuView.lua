-- chunkname: @IQIGame\\UI\\Cooking\\HomeLandCookMenuView.lua

local HomeLandCookMenuView = {
	parentIndex = 0,
	isFilter = false
}
local HomeLandCookMenuCell = require("IQIGame.UI.Cooking.HomeLandCookMenuCell")

function HomeLandCookMenuView.__New(ui)
	local o = Clone(HomeLandCookMenuView)

	o:InitView(ui)

	return o
end

function HomeLandCookMenuView:InitView(ui)
	self.goView = ui

	self.goView:SetActive(false)
	LuaCodeInterface.BindOutlet(self.goView, self)

	self.btnClose = self.BtnClose:GetComponent("Button")
	self.btnCooking = self.BtnCooking:GetComponent("Button")
	self.checkToggle = self.ToggleShow:GetComponent("Toggle")
	self.btnRewardBox = self.BtnRewardBox:GetComponent("Button")

	UGUIUtil.SetText(self.TextTitle, HomeLandCookingUIApi:GetString("TextTitleMenu", false))
	UGUIUtil.SetText(self.TextTitleEng, HomeLandCookingUIApi:GetString("TextTitleMenu", true))
	UGUIUtil.SetText(self.TextBtnCooking, HomeLandCookingUIApi:GetString("TextBtnCooking1"))
	UGUIUtil.SetText(self.ToggleText, HomeLandCookingUIApi:GetString("ToggleText"))
	UGUIUtil.SetText(self.TextNull, HomeLandCookingUIApi:GetString("TextNull1"))
	UGUIUtil.SetText(self.TextNull2, HomeLandCookingUIApi:GetString("TextNull2"))

	function self.delegateUnLockCookBookEvent()
		self:OnUnLockCookBook()
	end

	function self.delegateClickBtnCooking()
		self:OnBtnCooking()
	end

	function self.delegateClickBtnReward()
		self:OnBtnGetReward()
	end

	self.menuScrollArea = self.ScrollArea:GetComponent("ExpandableListComponent")

	function self.menuScrollArea.onRenderCell(renderCell)
		self:OnRenderMenu(renderCell)
	end

	function self.menuScrollArea.onSelectCell(renderCell)
		self:OnSelectMenu(renderCell)
	end

	function self.delegateClickBtnClose()
		self:OnBtnClose()
	end

	function self.delegateOnChangeToggle(isOn)
		self:OnChangeToggle(isOn)
	end
end

function HomeLandCookMenuView:AddEventListener()
	self.btnClose.onClick:AddListener(self.delegateClickBtnClose)
	self.checkToggle.onValueChanged:AddListener(self.delegateOnChangeToggle)
	self.btnRewardBox.onClick:AddListener(self.delegateClickBtnReward)
	self.btnCooking.onClick:AddListener(self.delegateClickBtnCooking)
	EventDispatcher.AddEventListener(EventID.UpdateUnlockCookBookEvent, self.delegateUnLockCookBookEvent)
end

function HomeLandCookMenuView:RemoveEventListener()
	self.btnClose.onClick:RemoveListener(self.delegateClickBtnClose)
	self.checkToggle.onValueChanged:RemoveListener(self.delegateOnChangeToggle)
	self.btnCooking.onClick:RemoveListener(self.delegateClickBtnCooking)
	self.btnRewardBox.onClick:RemoveListener(self.delegateClickBtnReward)
	EventDispatcher.RemoveEventListener(EventID.UpdateUnlockCookBookEvent, self.delegateUnLockCookBookEvent)
end

function HomeLandCookMenuView:OnChangeToggle(isOn)
	self.isFilter = isOn
	self.selectMenuData = nil, self:UpdateView(self.queueData, self.otherQueueData)
end

function HomeLandCookMenuView:UpdateView(queueData, otherQueueData)
	self.otherQueueData = otherQueueData

	if queueData == nil then
		return
	end

	self.queueData = queueData

	if #self.queueData.items >= 4 then
		self.queueData = otherQueueData
	end

	self.menus = {}

	for i = 1, #CookingModule.unlockHomeLandCookBook do
		local menuData = CookingModule.unlockHomeLandCookBook[i]

		if menuData.cfgInfo.IsShowMenu then
			if self.isFilter then
				if menuData.unlock and menuData:IsAmple() then
					table.insert(self.menus, menuData)
				end
			else
				table.insert(self.menus, menuData)
			end
		end
	end

	table.sort(self.menus, function(data1, data2)
		local a = data1.cfgInfo.MenuSort
		local b = data2.cfgInfo.MenuSort

		return a < b
	end)
	HomeLandCookMenuCell.DisposeIn(self)

	self.getWayTypes = {
		1,
		2,
		3
	}
	self.getWayTypeData = self:GetWayTypeData()

	self.menuScrollArea:InitForLua(self.getWayTypeData, {
		tostring(self.parentIndex)
	})
	self:ShowSelectMsg()
	UGUIUtil.SetText(self.TextLockNum, HomeLandCookingUIApi:GetString("TextLockNum", self:GetLockMenuNum(), #self.menus))
end

function HomeLandCookMenuView:GetLockMenuNum()
	local num = 0

	for i, v in pairs(self.menus) do
		if v.unlock == true then
			num = num + 1
		end
	end

	return num
end

function HomeLandCookMenuView:GetWayTypeData()
	local tab = {}

	for i = 1, #self.getWayTypes do
		local Quality = self.getWayTypes[i]

		tab[Quality] = {}

		for i = 1, #self.menus do
			local menuData = self.menus[i]

			if menuData.cfgInfo.MenuQuality == Quality then
				table.insert(tab[Quality], menuData)
			end
		end
	end

	return tab
end

function HomeLandCookMenuView:OnSelectMenu(cell)
	self.parentIndex = cell.parentIndex

	local menuData = self.getWayTypeData[cell.parentIndex + 1][cell.index + 1]

	if self.selectMenuData and self.selectMenuData.cid == menuData.cid then
		return
	end

	local menuCell = HomeLandCookMenuCell.PackageOrReuseView(self, cell.gameObject)

	menuCell:SetDate(menuData)

	if self.selectMenuCell then
		self.selectMenuCell:SetSelect(false)
	end

	menuCell:SetSelect(true)

	self.selectMenuCell = menuCell
	self.selectMenuData = menuData

	self:ShowSelectMsg()
end

function HomeLandCookMenuView:OnRenderMenu(cell)
	if cell.isFolder then
		local type = self.getWayTypes[cell.index + 1]
		local openNum, totalNum, isCanGetReward = self:GetTypeOpenNum(cell.index + 1)

		cell.gameObject.transform:Find("BG_01/Text_01"):GetComponent("Text").text = HomeLandCookingUIApi:GetString("WayType", type)
		cell.gameObject.transform:Find("BG_01/Text_02"):GetComponent("Text").text = openNum .. "/" .. totalNum
		cell.gameObject.transform:Find("BG_02/Text_01"):GetComponent("Text").text = HomeLandCookingUIApi:GetString("WayType", type)
		cell.gameObject.transform:Find("BG_02/Text_02"):GetComponent("Text").text = openNum .. "/" .. totalNum

		cell.gameObject.transform:Find("Image_03").gameObject:SetActive(isCanGetReward)
	else
		local menuData = self.getWayTypeData[cell.parentIndex + 1][cell.index + 1]

		if menuData == nil then
			cell.gameObject:SetActive(false)

			return
		end

		local menuCell = HomeLandCookMenuCell.PackageOrReuseView(self, cell.gameObject)

		menuCell:SetDate(menuData)

		if self.selectMenuData == nil then
			self.selectMenuData = menuData
		end

		if self.selectMenuData and self.selectMenuData.cid == menuData.cid then
			menuCell:SetSelect(true)

			self.selectMenuCell = menuCell
		else
			menuCell:SetSelect(false)
		end
	end
end

function HomeLandCookMenuView:GetTypeOpenNum(groupIndex)
	local tab = self.getWayTypeData[groupIndex]
	local num = 0
	local max = #tab
	local isCanGetReward = false

	for i, v in pairs(tab) do
		if v.unlock then
			num = num + 1
		end

		if isCanGetReward == false then
			isCanGetReward = v:IsCanGetReward()
		end
	end

	return num, max, isCanGetReward
end

function HomeLandCookMenuView:ShowSelectMsg()
	if self.selectMenuData ~= nil then
		self.NormalNode2:SetActive(true)
		self.NullNode2:SetActive(false)

		if self.selectMenuData.unlock then
			self.NormalNode:SetActive(true)
			self.NullNode:SetActive(false)
			self:ShowMenuMsg()
		else
			self.NormalNode:SetActive(false)
			self.NullNode:SetActive(true)
		end
	else
		self.NormalNode2:SetActive(false)
		self.NullNode2:SetActive(true)
	end
end

function HomeLandCookMenuView:ShowMenuMsg()
	local msgCell = HomeLandCookMenuCell.PackageOrReuseView(self, self.SelectMould)

	msgCell:SetDate(self.selectMenuData)
	msgCell:SetSelect(true)

	self.ample = true
	self.needFoods = self.selectMenuData:GetFoods()

	local needItem = {}

	for i = 1, #self.needFoods do
		local tab = self.needFoods[i]
		local itemID = tab[1]
		local num = 1

		if needItem[itemID] == nil then
			needItem[itemID] = num
		else
			needItem[itemID] = needItem[itemID] + num
		end
	end

	local str = ""

	for i, v in pairs(needItem) do
		str = str .. CfgItemTable[i].Name .. " x" .. v .. " "

		if self.ample then
			local have = WarehouseModule.GetItemNumByCfgID(i)

			self.ample = v <= have
		end
	end

	UGUIUtil.SetText(self.TextNeed, HomeLandCookingUIApi:GetString("TextNeed", str))
	UGUIUtil.SetText(self.TextEffect, HomeLandCookingUIApi:GetString("TextEffect", self.selectMenuData.cfgInfo.CookDescribe))
	UGUIUtil.SetText(self.TextNeedTime, HomeLandCookingUIApi:GetString("TextNeedTime", GetFormatTime(self.selectMenuData.cfgInfo.CookTimes)))

	local isAmple = self.selectMenuData:IsAmple()

	UGUIUtil.SetText(self.TextCondition, HomeLandCookingUIApi:GetString("TextCondition", isAmple))
	self.RewardBoxCan:SetActive(false)
	self.RewardBoxOpen:SetActive(false)
	self.RewardBoxClose:SetActive(false)

	if self.selectMenuData.unlock then
		if self.selectMenuData.isGetReward == false then
			self.RewardBoxCan:SetActive(true)
		else
			self.RewardBoxOpen:SetActive(true)
		end
	else
		self.RewardBoxClose:SetActive(true)
	end
end

function HomeLandCookMenuView:OnUnLockCookBook()
	if self.selectMenuData then
		self.selectMenuData = CookingModule.GetMenuDataByID(self.selectMenuData.cid)
	end

	self:UpdateView(self.queueData, self.otherQueueData)
end

function HomeLandCookMenuView:OnBtnCooking()
	if self.selectMenuData == nil then
		NoticeModule.ShowNoticeByType(1, HomeLandCookingUIApi:GetString("ErrorMsg3"))

		return
	end

	if self.selectMenuData.unlock == false then
		NoticeModule.ShowNoticeByType(1, HomeLandCookingUIApi:GetString("ErrorMsg3"))

		return
	end

	if self.queueData == nil then
		NoticeModule.ShowNoticeByType(1, HomeLandCookingUIApi:GetString("ErrorMsg2"))

		return
	end

	if self.ample == false then
		NoticeModule.ShowNoticeByType(1, HomeLandCookingUIApi:GetString("ErrorMsg1"))

		return
	end

	self.queueData:CleanItem()

	for i = 1, #self.needFoods do
		local tab = self.needFoods[i]

		self.queueData:AddItem(tab[1])
	end

	EventDispatcher.Dispatch(EventID.UpdatePutInTheFoodEvent)
	self:OnBtnClose()
end

function HomeLandCookMenuView:OnBtnGetReward()
	if self.selectMenuData:IsCanGetReward() then
		HomeLandLuaModule.GetCookBookRewards(self.selectMenuData.cid)
	end
end

function HomeLandCookMenuView:OnOpen()
	self:AddEventListener()

	self.isFilter = false

	self.goView:SetActive(true)

	self.selectMenuData = nil
end

function HomeLandCookMenuView:OnClose()
	self:RemoveEventListener()
	self.goView:SetActive(false)
end

function HomeLandCookMenuView:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.closeSelfCallBack = nil
	self.goView = nil

	HomeLandCookMenuCell.DisposeIn(self)
end

function HomeLandCookMenuView:OnBtnClose()
	if self.closeSelfCallBack then
		self.closeSelfCallBack(self.queueData)
	end

	self:OnClose()
end

return HomeLandCookMenuView
