-- chunkname: @IQIGame\\UI\\ChangeTitleUI.lua

local ChangeTitleUI = {
	titles = {},
	titleCellPool = {}
}

ChangeTitleUI = Base:Extend("ChangeTitleUI", "IQIGame.Onigao.UI.ChangeTitleUI", ChangeTitleUI)

local ChangeTitleCell = require("IQIGame.UI.Setting.ChangeTitle.ChangeTitleCell")

function ChangeTitleUI:OnInit()
	UGUIUtil.SetText(self.PanelTitle, ChangeTitleUIApi:GetString("PanelTitle"))
	UGUIUtil.SetText(self.TextBtnCancel, ChangeTitleUIApi:GetString("TextBtnCancel"))
	UGUIUtil.SetText(self.TextBtnSure, ChangeTitleUIApi:GetString("TextBtnSure"))
	UGUIUtil.SetText(self.TextBtnRemove, ChangeTitleUIApi:GetString("TextBtnRemove"))

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnCancel()
		self:OnBtnCancel()
	end

	function self.delegateBtnSure()
		self:OnBtnSure()
	end

	function self.delegateBtnRemove()
		self:OnBtnRemove()
	end

	self.scrollList = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.scrollList.onSelectedCell(cell)
		self:OnSelectedCell(cell)
	end

	function self.delegateSettingChangeEvent()
		self:OnSettingChangeEvent()
	end

	function self.delegateUpdatePlayerTitle()
		self:OnUpdatePlayerTitle()
	end
end

function ChangeTitleUI:GetPreloadAssetPaths()
	return nil
end

function ChangeTitleUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ChangeTitleUI:IsManualShowOnOpen(userData)
	return false
end

function ChangeTitleUI:GetBGM(userData)
	return nil
end

function ChangeTitleUI:OnOpen(userData)
	self:UpdateView()
end

function ChangeTitleUI:OnClose(userData)
	return
end

function ChangeTitleUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnCancel:GetComponent("Button").onClick:AddListener(self.delegateBtnCancel)
	self.BtnSure:GetComponent("Button").onClick:AddListener(self.delegateBtnSure)
	self.BtnRemove:GetComponent("Button").onClick:AddListener(self.delegateBtnRemove)
	EventDispatcher.AddEventListener(EventID.PlayerSettingChangeEvent, self.delegateSettingChangeEvent)
	EventDispatcher.AddEventListener(EventID.UpdatePlayerTitle, self.delegateUpdatePlayerTitle)
end

function ChangeTitleUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnCancel:GetComponent("Button").onClick:RemoveListener(self.delegateBtnCancel)
	self.BtnSure:GetComponent("Button").onClick:RemoveListener(self.delegateBtnSure)
	self.BtnRemove:GetComponent("Button").onClick:RemoveListener(self.delegateBtnRemove)
	EventDispatcher.RemoveEventListener(EventID.PlayerSettingChangeEvent, self.delegateSettingChangeEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdatePlayerTitle, self.delegateUpdatePlayerTitle)
end

function ChangeTitleUI:OnPause()
	return
end

function ChangeTitleUI:OnResume()
	return
end

function ChangeTitleUI:OnCover()
	return
end

function ChangeTitleUI:OnReveal()
	return
end

function ChangeTitleUI:OnRefocus(userData)
	return
end

function ChangeTitleUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ChangeTitleUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ChangeTitleUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ChangeTitleUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ChangeTitleUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.titleCellPool) do
		v:Dispose()
	end
end

function ChangeTitleUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.ChangeTitleUI)
end

function ChangeTitleUI:OnSettingChangeEvent()
	self:UpdateView()
end

function ChangeTitleUI:OnUpdatePlayerTitle()
	self:UpdateView()
end

function ChangeTitleUI:UpdateView()
	self.posTitleID = PlayerModule.PlayerInfo.baseInfo.title
	self.posTitleID = self.posTitleID == nil and 0 or self.posTitleID
	self.titles = {}

	for i, v in pairs(SettingModule.unlockTitles) do
		if v.isLock then
			table.insert(self.titles, v)
		end
	end

	table.sort(self.titles, function(item1, item2)
		return item1.cfgInfo.Sort < item2.cfgInfo.Sort
	end)
	self.scrollList:Refresh(#self.titles)
	self:ShowSelectMsg()
end

function ChangeTitleUI:OnRenderCell(cell)
	local titleDate = self.titles[cell.index + 1]

	if titleDate == nil then
		cell.gameObject:SetActive(false)
	end

	cell.gameObject:SetActive(true)

	local instanceID = cell.gameObject:GetInstanceID()
	local titleCell = self.titleCellPool[instanceID]

	if titleCell == nil then
		titleCell = ChangeTitleCell.New(cell.gameObject)
		self.titleCellPool[instanceID] = titleCell
	end

	titleCell:SetData(titleDate)

	if self.posTitleID > 0 then
		if titleDate.cfgID == self.posTitleID then
			self.selectTitle = titleDate

			titleCell:SetSelect(true)
		else
			titleCell:SetSelect(false)
		end
	else
		if self.selectTitle == nil then
			self.selectTitle = titleDate
		end

		if titleDate.cfgID == self.selectTitle.cfgID then
			titleCell:SetSelect(true)
		else
			titleCell:SetSelect(false)
		end
	end
end

function ChangeTitleUI:OnSelectedCell(cell)
	self.selectTitle = self.titles[cell.index + 1]

	for i, v in pairs(self.titleCellPool) do
		if v.playerTitleData and v.playerTitleData.cfgID == self.selectTitle.cfgID then
			v:SetSelect(true)
		else
			v:SetSelect(false)
		end
	end

	self:ShowSelectMsg()
end

function ChangeTitleUI:ShowSelectMsg()
	if self.selectTitle then
		local isSelf = self.selectTitle.cfgID == self.posTitleID

		self.BtnSure:SetActive(not isSelf)
		self.BtnRemove:SetActive(isSelf)

		local path = UIGlobalApi.GetPrefabRoot(self.selectTitle.cfgInfo.Prefab)

		AssetUtil.LoadAsset(self, path, self.OnLoadTitleSucceed, nil)
		UGUIUtil.SetText(self.TextTitleName, ChangeTitleUIApi:GetString("TextTitleName", self.selectTitle.cfgInfo.Name))
		UGUIUtil.SetText(self.TextTitleDes, ChangeTitleUIApi:GetString("TextTitleDes", self.selectTitle.cfgInfo.Desc))

		local timeLimitTitle = self.selectTitle:GetTimeLimit()

		if timeLimitTitle > 0 and timeLimitTitle > PlayerModule.GetServerTime() then
			self.TextDate:SetActive(true)
			UGUIUtil.SetText(self.TextDate, ChangeTitleUIApi:GetString("TextDate", getCustomDateTimeText(timeLimitTitle, "MonthToMinuteFormat")))
		else
			self.TextDate:SetActive(false)
		end
	end
end

function ChangeTitleUI:OnLoadTitleSucceed(assetName, asset, duration, userData)
	for i = 0, self.TitlePos.transform.childCount - 1 do
		local obj = self.TitlePos.transform:GetChild(i).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	local goFrame = UnityEngine.Object.Instantiate(asset)

	goFrame.transform:SetParent(self.TitlePos.transform, false)
end

function ChangeTitleUI:OnBtnCancel()
	self:OnBtnClose()
end

function ChangeTitleUI:OnBtnSure()
	if self.selectTitle and self.selectTitle.cfgID ~= PlayerModule.PlayerInfo.baseInfo.title then
		SettingModule.ChangeData(SettingModule.CHANGE_PLAYER_TITLE, self.selectTitle.cfgID)
	end

	self:OnBtnClose()
end

function ChangeTitleUI:OnBtnRemove()
	SettingModule.ChangeData(SettingModule.CHANGE_PLAYER_TITLE, 0)
	self:OnBtnClose()
end

return ChangeTitleUI
