-- chunkname: @IQIGame\\UI\\HomeLandCookingListUI.lua

local HomeLandCookingListUI = Base:Extend("HomeLandCookingListUI", "IQIGame.Onigao.UI.HomeLandCookingListUI", {
	count = 1,
	maxCount = 1
})
local HomeLandCookMenuCell = require("IQIGame.UI.Cooking.HomeLandCookMenuCell")

function HomeLandCookingListUI:OnInit()
	UGUIUtil.SetText(self.TextBtnClose, HomeLandCookingUIApi:GetString("TextTitleMenu", false))
	UGUIUtil.SetText(self.TextTitle2, HomeLandCookingUIApi:GetString("TextTitle2"))
	UGUIUtil.SetText(self.TextBtnCooking, HomeLandCookingUIApi:GetString("TextBtnCooking1"))
	UGUIUtil.SetText(self.TextBtnMin, HomeLandCookingUIApi:GetString("TextBtnMin"))
	UGUIUtil.SetText(self.TextBtnMax, HomeLandCookingUIApi:GetString("TextBtnMax"))
	UGUIUtil.SetText(self.TextNumDes, HomeLandCookingUIApi:GetString("TextNumDes"))

	self.menuScrollArea = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.menuScrollArea.onSelectedCell(cell)
		self:OnSelectMenu(cell)
	end

	function self.menuScrollArea.onRenderCell(cell)
		self:OnRenderMenu(cell)
	end

	function self.delegateClickBtnClose()
		self:OnBtnClose()
	end

	function self.delegateClickBtnCooking()
		self:OnBtnCooking()
	end

	function self.delegateClickBtnMin()
		self:OnBtnMin()
	end

	function self.delegateClickBtnMax()
		self:OnBtnMax()
	end

	function self.delegateClickBtnAdd()
		self:OnBtnAdd()
	end

	function self.delegateClickBtnReduce()
		self:OnBtnReduce()
	end

	function self.DelegateOnUpdateItem()
		self:ShowSelect()
	end

	self.spendItemCells = {}

	for i = 1, 4 do
		local spendItemCell = ItemCell2.New(self["Item" .. i])

		self.spendItemCells[i] = spendItemCell
	end
end

function HomeLandCookingListUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandCookingListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandCookingListUI:IsManualShowOnOpen(userData)
	return false
end

function HomeLandCookingListUI:GetBGM(userData)
	return nil
end

function HomeLandCookingListUI:OnOpen(userData)
	self.queueData = userData

	self:UpdateView()
end

function HomeLandCookingListUI:OnClose(userData)
	return
end

function HomeLandCookingListUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateClickBtnClose)
	self.BtnCooking:GetComponent("Button").onClick:AddListener(self.delegateClickBtnCooking)
	self.BtnMin:GetComponent("Button").onClick:AddListener(self.delegateClickBtnMin)
	self.BtnMax:GetComponent("Button").onClick:AddListener(self.delegateClickBtnMax)
	self.BtnAdd:GetComponent("Button").onClick:AddListener(self.delegateClickBtnAdd)
	self.BtnReduce:GetComponent("Button").onClick:AddListener(self.delegateClickBtnReduce)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function HomeLandCookingListUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnClose)
	self.BtnCooking:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnCooking)
	self.BtnMin:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnMin)
	self.BtnMax:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnMax)
	self.BtnAdd:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnAdd)
	self.BtnReduce:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnReduce)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function HomeLandCookingListUI:OnPause()
	return
end

function HomeLandCookingListUI:OnResume()
	return
end

function HomeLandCookingListUI:OnCover()
	return
end

function HomeLandCookingListUI:OnReveal()
	return
end

function HomeLandCookingListUI:OnRefocus(userData)
	return
end

function HomeLandCookingListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandCookingListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandCookingListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandCookingListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandCookingListUI:OnDestroy()
	for i, v in pairs(self.spendItemCells) do
		v:OnDestroy()
	end

	AssetUtil.UnloadAsset(self)
	HomeLandCookMenuCell.DisposeIn(self)
end

function HomeLandCookingListUI:UpdateView()
	self.cookBookMenus = CookingModule.GetCookBooks()

	self.menuScrollArea:Refresh(#self.cookBookMenus)
	self:ShowSelect()
end

function HomeLandCookingListUI:OnSelectMenu(cell)
	local menuData = self.cookBookMenus[cell.index + 1]

	if menuData.unlock then
		local menuCell = HomeLandCookMenuCell.PackageOrReuseView(self, cell.gameObject)

		menuCell:SetDate(menuData)

		if self.selectMenuCell then
			self.selectMenuCell:SetSelect(false)
		end

		menuCell:SetSelect(true)

		self.selectMenuCell = menuCell
		self.selectMenuData = menuData

		self:ShowSelect()
	end
end

function HomeLandCookingListUI:OnRenderMenu(cell)
	local menuData = self.cookBookMenus[cell.index + 1]

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

function HomeLandCookingListUI:ShowSelect()
	if self.selectMenuData ~= nil and self.selectMenuData.unlock then
		self.maxCount = self.selectMenuData:CookMaxNum()

		if self.maxCount <= 0 then
			self.maxCount = 1
		end

		self.count = self.maxCount

		self:ShowSelectMsg()
	end
end

function HomeLandCookingListUI:ShowSelectMsg()
	if self.selectMenuData ~= nil and self.selectMenuData.unlock then
		local selectItem = CfgItemTable[self.selectMenuData.cfgInfo.ItemId[1]]

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(selectItem.Icon), self.ImgIcon:GetComponent("Image"))
		UGUIUtil.SetText(self.TextTitle, selectItem.Name)
		UGUIUtil.SetText(self.TextValue, selectItem.Describe)
		UGUIUtil.SetText(self.TextNum, self.count)
		UGUIUtil.SetText(self.TextNeedTime, HomeLandCookingUIApi:GetString("TextNeedTime", GetFormatTime(self.selectMenuData.cfgInfo.CookTimes * self.count)))

		for i, v in pairs(self.spendItemCells) do
			v:SetActive(false)
		end

		local spend = {}

		for i = 1, #self.selectMenuData.cfgInfo.NeedItem, 2 do
			local id = self.selectMenuData.cfgInfo.NeedItem[i]
			local needNum = self.selectMenuData.cfgInfo.NeedItem[i + 1] * self.count

			if spend[id] == nil then
				spend[id] = needNum
			else
				spend[id] = spend[id] + needNum
			end
		end

		local index = 1

		for i, v in pairs(spend) do
			local itemCell = self.spendItemCells[index]

			if itemCell then
				itemCell:SetActive(true)
				itemCell:Refresh(i, v)
			end

			index = index + 1
		end
	end
end

function HomeLandCookingListUI:OnBtnCooking()
	if self.selectMenuData == nil then
		NoticeModule.ShowNoticeByType(1, HomeLandCookingUIApi:GetString("ErrorMsg3"))

		return
	end

	if self.selectMenuData.unlock == false then
		NoticeModule.ShowNoticeByType(1, HomeLandCookingUIApi:GetString("ErrorMsg3"))

		return
	end

	if self.queueData:IsFullItem() then
		NoticeModule.ShowNoticeByType(1, HomeLandCookingUIApi:GetString("PutFullErrorMsg"))

		return
	end

	if self.selectMenuData:IsAmple() == false then
		NoticeModule.ShowNoticeByType(1, HomeLandCookingUIApi:GetString("ErrorMsg1"))

		return
	end

	self.queueData:CleanItem()

	for i = 1, #self.selectMenuData.cfgInfo.NeedItem, 2 do
		local id = self.selectMenuData.cfgInfo.NeedItem[i]

		self.queueData:AddItem(id)
	end

	EventDispatcher.Dispatch(EventID.PlayCookPutOnEffect, self.queueData)
	HomeLandLuaModule.Cook(Constant.HomelandBuildType.BuildCooking, self.queueData.id, self.selectMenuData.cid, self.count)
	self:OnBtnClose()
end

function HomeLandCookingListUI:OnBtnMin()
	self.count = 1

	self:ShowSelectMsg()
end

function HomeLandCookingListUI:OnBtnMax()
	self.count = self.maxCount

	self:ShowSelectMsg()
end

function HomeLandCookingListUI:OnBtnAdd()
	if self.count < self.maxCount then
		self.count = self.count + 1

		self:ShowSelectMsg()
	end
end

function HomeLandCookingListUI:OnBtnReduce()
	if self.count > 1 then
		self.count = self.count - 1

		self:ShowSelectMsg()
	end
end

function HomeLandCookingListUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.HomeLandCookingListUI)
end

return HomeLandCookingListUI
