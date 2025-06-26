-- chunkname: @IQIGame\\UI\\MazeGetPanelUI.lua

local MazeGetPanelUI = {
	isShowAllItem = false,
	ShowIndex = 1,
	DelayTime = 0.2,
	isDelay = true,
	ItemList = {}
}

MazeGetPanelUI = Base:Extend("MazeGetPanelUI", "IQIGame.Onigao.UI.MazeGetPanelUI", MazeGetPanelUI)

local GetPanelItemCell = require("IQIGame.UI.GetPanel.GetPanelItemCell")

function MazeGetPanelUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfrimBtn()
	end

	self:InitDelegate()

	self.ContentGridLayout = self.ItemContentParent:GetComponent("GridLayoutGroup")
	self.ContentSizeFitter = self.ItemContentParent:GetComponent("ContentSizeFitter")
	self.ConfirmBtnCom = self.ConfirmBtn:GetComponent("ButtonEx")

	self.ConfirmBtnCom:SetDelayClickStartEvent(self.DelegateOnRealClickStartEvent)
end

function MazeGetPanelUI:InitDelegate()
	function self.refreshEvent(userData)
		self:RefreshShow(userData)
	end

	function self.DelegateOnRealClickStartEvent()
		if not self.isShowAllItem then
			return
		end

		self.isShowAllItem = false

		for k, v in pairs(self.ItemList) do
			v:PlayOutAnim()
			v:DisableEffect()
		end
	end
end

function MazeGetPanelUI:GetPreloadAssetPaths()
	return nil
end

function MazeGetPanelUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeGetPanelUI:IsManualShowOnOpen(userData)
	return false
end

function MazeGetPanelUI:GetBGM(userData)
	return nil
end

function MazeGetPanelUI:OnOpen(userData)
	LuaUtility.PlaySoundWithID(11100005)

	self.isDelay = true
	self.ConfirmBtnCom.interactable = false

	self:HideItem()
	self:RefreshShow(userData)
end

function MazeGetPanelUI:OnClose(userData)
	return
end

function MazeGetPanelUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
end

function MazeGetPanelUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
end

function MazeGetPanelUI:OnPause()
	return
end

function MazeGetPanelUI:OnResume()
	return
end

function MazeGetPanelUI:OnCover()
	return
end

function MazeGetPanelUI:OnReveal()
	return
end

function MazeGetPanelUI:OnRefocus(userData)
	return
end

function MazeGetPanelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeGetPanelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeGetPanelUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeGetPanelUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeGetPanelUI:OnDestroy()
	for _, v in pairs(self.ItemList) do
		v:Dispose()
	end

	self.ItemList = {}

	AssetUtil.UnloadAsset(self)
end

function MazeGetPanelUI:OnClickConfrimBtn()
	UIModule.CloseSelf(self)

	if self.callback then
		self.callback()

		self.callback = nil
	end
end

function MazeGetPanelUI:RefreshShow(userData)
	if userData == nil then
		return
	end

	self.callback = userData.callback
	self.args = userData.args
	self.isShowAllItem = false
	self.ShowIndex = 1

	self:AwardShow(userData)
	self:SetTitleState()
end

function MazeGetPanelUI:SetTitleState()
	local state = false

	if self.args == nil or self.args[1] == nil then
		state = false
	end

	state = self.args[1]

	LuaUtility.SetGameObjectShow(self.TitleText, state)
end

function MazeGetPanelUI:AwardShow(userData)
	self.UserData = userData
	self.RawItemDatas = {}

	for i = 1, #self.UserData.items do
		local cfgItem = CfgItemTable[self.UserData.items[i].cid]

		if cfgItem and cfgItem.IsHide ~= 1 then
			local rawItemData = self.UserData.items[i]

			table.insert(self.RawItemDatas, rawItemData)
		end
	end

	self:UpdateView(self.RawItemDatas, self.UserData.args)
end

function MazeGetPanelUI:HideItem()
	for i = 1, #self.ItemList do
		self.ItemList[i]:Hide()
	end
end

function MazeGetPanelUI:UpdateView(items, args)
	self:CreateSlotItem()
end

function MazeGetPanelUI:CreateSlotItem()
	self.ContentSizeFitter.enabled = true
	self.ContentGridLayout.enabled = true

	for i = 1, #self.ItemList do
		self.ItemList[i]:Hide()
	end

	local tag = 0
	local itemData

	for i = 1, #self.RawItemDatas do
		local itemObj = self:InstantiateItemObj(i)
		local rawItemData = self.RawItemDatas[i]

		if rawItemData ~= nil then
			itemData = ItemData.CreateItemShowDataByItemShowPOD(rawItemData)
			tag = rawItemData.tag
		end

		self.ItemList[i]:Show()
		itemObj:SetItem(itemData, tag)
	end

	CoroutineUtility.StartCoroutine(function()
		CoroutineUtility.Yield(CustomWaitForSeconds(0.02))

		for i = 1, #self.ItemList do
			self.ItemList[i]:Hide()
		end

		self.ContentSizeFitter.enabled = false
		self.ContentGridLayout.enabled = false

		CoroutineUtility.Yield(CustomWaitForSeconds(0.35))

		for i = 1, #self.RawItemDatas do
			if self.isDelay then
				CoroutineUtility.Yield(CustomWaitForSeconds(self.DelayTime))
			end

			self.ItemList[i]:Show()
			self.ItemList[i]:PlayInAnim()
			self.ItemList[i]:EnableEffect()
		end

		CoroutineUtility.Yield(CustomWaitForSeconds(0.5))

		self.isShowAllItem = true
		self.ConfirmBtnCom.interactable = true
	end)
end

function MazeGetPanelUI:InstantiateItemObj(index)
	local itemObj = self.ItemList[index]

	if itemObj == nil then
		local obj = UnityEngine.Object.Instantiate(self.Grid_Mould)

		itemObj = GetPanelItemCell.New(obj)

		obj.transform:SetParent(self.ItemContentParent.transform, false)

		self.ItemList[index] = itemObj
	end

	return itemObj
end

return MazeGetPanelUI
