-- chunkname: @IQIGame\\UI\\LotteryRecordsUI.lua

local LotteryRecordsUI = {}

LotteryRecordsUI = Base:Extend("LotteryRecordsUI", "IQIGame.Onigao.UI.LotteryRecordsUI", LotteryRecordsUI)

function LotteryRecordsUI:OnInit()
	self.wrapContent = self.ScrollView:GetComponent("ScrollAreaList")

	function self.wrapContent.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	function self.DelegateRecordResult()
		self:LotteryRecord()
	end

	function self.DelegateTabClick(isOn)
		self:OnClickTab(isOn)
	end

	function self.DelegateLeftBtn()
		self:OnLeftBtnClick()
	end

	function self.DelegateRightBtn()
		self:OnRightBtnClick()
	end

	UGUIUtil.SetText(self.TipText, LotteryRecordsUIApi:GetBottomTips())
	UGUIUtil.SetText(self.TittleText, LotteryRecordsUIApi:GetTopTitles(1))
	UGUIUtil.SetText(self.TypeTitle, LotteryRecordsUIApi:GetTopTitles(2))
	UGUIUtil.SetText(self.NameTitle, LotteryRecordsUIApi:GetTopTitles(3))
	UGUIUtil.SetText(self.TimeTitle, LotteryRecordsUIApi:GetTopTitles(4))
	UGUIUtil.SetText(self.SmallTitle, LotteryRecordsUIApi:GetTopTitles(5))

	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
	self.ToggleList = {}
end

function LotteryRecordsUI:GetPreloadAssetPaths()
	return nil
end

function LotteryRecordsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LotteryRecordsUI:IsManualShowOnOpen(userData)
	return false
end

function LotteryRecordsUI:GetBGM(userData)
	return nil
end

function LotteryRecordsUI:OnOpen(poolType)
	self.poolType = poolType

	LotteryModule.GetDrawRecord(self.poolType)
end

function LotteryRecordsUI:OnClose(userData)
	return
end

function LotteryRecordsUI:OnAddListeners()
	self.LeftBtn:GetComponent("Button").onClick:AddListener(self.DelegateLeftBtn)
	self.RightBtn:GetComponent("Button").onClick:AddListener(self.DelegateRightBtn)
	EventDispatcher.AddEventListener(EventID.LotteryRecordResult, self.DelegateRecordResult)
end

function LotteryRecordsUI:OnRemoveListeners()
	self.LeftBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateLeftBtn)
	self.RightBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateRightBtn)
	EventDispatcher.RemoveEventListener(EventID.LotteryRecordResult, self.DelegateRecordResult)
end

function LotteryRecordsUI:OnPause()
	return
end

function LotteryRecordsUI:OnResume()
	return
end

function LotteryRecordsUI:OnCover()
	return
end

function LotteryRecordsUI:OnReveal()
	return
end

function LotteryRecordsUI:OnRefocus(userData)
	return
end

function LotteryRecordsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LotteryRecordsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LotteryRecordsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LotteryRecordsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LotteryRecordsUI:OnDestroy()
	self.commonReturnBtn:Dispose()
end

function LotteryRecordsUI:OnRenderItem(cell)
	local itemdata = self.recordList[self.tabIndex][cell.index + 1]
	local cfgItemData = CfgUtil.GetItemCfgDataWithID(itemdata.itemId)

	cell.transform:Find("NameText"):GetComponent("Text").text = string.format(ColorCfg.ItemQualityColor[cfgItemData.Quality], CfgItemTable[itemdata.itemId].Name)
	cell.transform:Find("TimeText"):GetComponent("Text").text = string.format(ColorCfg.ItemQualityColor[cfgItemData.Quality], getDateTimeMText(tonumber(itemdata.rollTime) / 1000))
	cell.transform:Find("TypeText"):GetComponent("Text").text = string.format(ColorCfg.ItemQualityColor[cfgItemData.Quality], LotteryRecordsUIApi:GetItemTypeText(CfgItemTable[itemdata.itemId].ItemTypes, CfgItemTable[itemdata.itemId].ItemSubTypes))
end

function LotteryRecordsUI:LotteryRecord()
	self.recordList = {}

	for i = 1, 10 do
		self.recordList[i] = {}
	end

	for i = 1, #LotteryModule.poolRecords do
		local index = math.floor((i - 1) / 10) + 1

		if self.recordList[index] == nil then
			self.recordList[index] = {}
		end

		table.insert(self.recordList[index], LotteryModule.poolRecords[i])
	end

	self.allPageCount = math.ceil(#LotteryModule.poolRecords / 10)

	self:RefreshToggle(self.allPageCount)

	if self.allPageCount <= 0 then
		self.wrapContent:Refresh(0)
	else
		self:ShowTab(1)

		self.ToggleList[1]:GetComponent("Toggle").isOn = true
	end
end

function LotteryRecordsUI:RefreshToggle(len)
	for i = 0, self.ToggleGrid.transform.childCount - 1 do
		local obj = self.ToggleGrid.transform:GetChild(i).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	local ToggleObj

	for i = 1, len do
		ToggleObj = UnityEngine.Object.Instantiate(self.Toggle_01Prefab)

		ToggleObj.transform:SetParent(self.ToggleGrid.transform, false)

		self.ToggleList[i] = ToggleObj
		ToggleObj:GetComponent("ToggleHelperComponent").text = i

		self.ToggleList[i]:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateTabClick)
	end
end

function LotteryRecordsUI:OnClickTab(isOn)
	if isOn then
		local currentTarget = self.UIController:GetCurrentTarget()

		for i = 1, #self.ToggleList do
			if self.ToggleList[i] == currentTarget then
				self:ShowTab(i)

				return
			end
		end
	end
end

function LotteryRecordsUI:ShowTab(index)
	self.tabIndex = index

	self.wrapContent:Refresh(#self.recordList[index])
end

function LotteryRecordsUI:OnLeftBtnClick()
	if self.allPageCount <= 0 then
		return
	end

	self.tabIndex = self.tabIndex - 1

	if self.tabIndex < 1 then
		self.tabIndex = self.tabIndex + 1

		return
	end

	self:ShowTab(self.tabIndex)

	self.ToggleList[self.tabIndex]:GetComponent("Toggle").isOn = true
end

function LotteryRecordsUI:OnRightBtnClick()
	if self.allPageCount <= 0 then
		return
	end

	self.tabIndex = self.tabIndex + 1

	if self.tabIndex > self.allPageCount then
		self.tabIndex = self.tabIndex - 1

		return
	end

	self:ShowTab(self.tabIndex)

	self.ToggleList[self.tabIndex]:GetComponent("Toggle").isOn = true
end

return LotteryRecordsUI
