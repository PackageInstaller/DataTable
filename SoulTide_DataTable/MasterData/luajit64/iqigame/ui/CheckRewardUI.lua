-- chunkname: @IQIGame\\UI\\CheckRewardUI.lua

local CheckRewardUI = Base:Extend("CheckRewardUI", "IQIGame.Onigao.UI.CheckRewardUI", {})

function CheckRewardUI:OnInit()
	function self.DelegateUpdateItem(cell)
		self:UpdateItem(cell)
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickGetRewardBtn()
		self:OnClickGetRewardBtn()
	end

	self.TitleImage:GetComponent("Text").text = CheckRewardUIApi:GetString("TitleImage")
end

function CheckRewardUI:GetPreloadAssetPaths()
	return nil
end

function CheckRewardUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function CheckRewardUI:OnOpen(userData)
	self.GetCallback = userData.GetCallback
	self.CloseCallback = userData.CloseCallback

	local state = userData.State

	if state == nil then
		state = userData.GetState and 2 or 3
	end

	local showBtn = userData.ShowBtn

	if showBtn == nil then
		showBtn = true
	end

	self:UpdateView(userData.Rewards, state, showBtn)

	if userData.TextMsg ~= nil and userData.TextMsg ~= "" then
		self.TextDes:GetComponent("Text").text = userData.TextMsg

		self.TextPanel:SetActive(true)
		self.Line:SetActive(true)
	else
		self.TextPanel:SetActive(false)
		self.Line:SetActive(false)
	end

	if userData.TextTitle ~= nil and userData.TextTitle ~= "" then
		self.TitleImage:GetComponent("Text").text = userData.TextTitle
	else
		self.TitleImage:GetComponent("Text").text = CheckRewardUIApi:GetString("TitleImage")
	end
end

function CheckRewardUI:OnClose(userData)
	return
end

function CheckRewardUI:OnPause()
	return
end

function CheckRewardUI:OnResume()
	return
end

function CheckRewardUI:OnCover()
	return
end

function CheckRewardUI:OnReveal()
	return
end

function CheckRewardUI:OnRefocus(userData)
	return
end

function CheckRewardUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function CheckRewardUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function CheckRewardUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function CheckRewardUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function CheckRewardUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	ItemCell.DisposeIn(self)
end

function CheckRewardUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.GetRewardBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGetRewardBtn)
end

function CheckRewardUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.GetRewardBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGetRewardBtn)
end

function CheckRewardUI:UpdateView(rewards, getState, showBtn)
	local wrapContent = self.ItemContainer:GetComponent("ScrollAreaList")

	wrapContent.onRenderCell = self.DelegateUpdateItem
	self.Rewards = {}

	for i, v in pairs(rewards) do
		if CfgItemTable[v.id].IsRewardShow then
			table.insert(self.Rewards, v)
		end
	end

	wrapContent:Refresh(#self.Rewards)

	if showBtn then
		self.GetRewardBtn:SetActive(getState == 2)
		self.DisabledBtn:SetActive(getState ~= 2)
	else
		self.GetRewardBtn:SetActive(false)
		self.DisabledBtn:SetActive(false)
	end

	if getState == 2 then
		UGUIUtil.SetTextInChildren(self.GetRewardBtn, CheckRewardUIApi:GetString("BtnTitle", getState))
	else
		UGUIUtil.SetTextInChildren(self.DisabledBtn, CheckRewardUIApi:GetString("BtnTitle", getState))
	end
end

function CheckRewardUI:UpdateItem(cell)
	local itemGo = cell.gameObject
	local reward = self.Rewards[cell.index + 1]

	if reward == nil then
		itemGo:SetActive(false)

		return
	end

	local itemCell = ItemCell.PackageOrReuseView(self, itemGo)

	itemCell:SetItemByCID(reward.id, reward.num)
	itemGo:SetActive(true)
end

function CheckRewardUI:OnClickGetRewardBtn()
	UIModule.Close(Constant.UIControllerName.CheckRewardUI)

	if self.GetCallback ~= nil then
		self.GetCallback()
	end
end

function CheckRewardUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.CheckRewardUI)

	if self.CloseCallback ~= nil then
		self.CloseCallback()
	end
end

return CheckRewardUI
