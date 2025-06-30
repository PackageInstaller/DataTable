-- chunkname: @IQIGame\\UI\\GuildIntroduceUI.lua

local GuildIntroduceUI = {
	tabBtn = {},
	childViews = {}
}

GuildIntroduceUI = Base:Extend("GuildIntroduceUI", "IQIGame.Onigao.UI.GuildIntroduceUI", GuildIntroduceUI)

require("IQIGame.UIExternalApi.GuildIntroduceUIApi")

local GuildRecommendView = require("IQIGame.UI.Guild.GuildIntroduce.GuildRecommendView")
local GuildApplyView = require("IQIGame.UI.Guild.GuildIntroduce.GuildApplyView")
local GuildSearchView = require("IQIGame.UI.Guild.GuildIntroduce.GuildSearchView")
local GuildEstablishView = require("IQIGame.UI.Guild.GuildIntroduce.GuildEstablishView")
local GuildTableBtnCell = require("IQIGame.UI.Guild.GuildIntroduce.GuildTableBtnCell")

function GuildIntroduceUI:OnInit()
	UGUIUtil.SetText(self.TitleText, GuildIntroduceUIApi:GetString("TitleText"))

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.tabBtn = {}
	self.childViews = {}

	self.TabBtnPrefab:SetActive(false)

	for i = 1, 4 do
		local tabBtn = UnityEngine.Object.Instantiate(self.TabBtnPrefab)

		tabBtn:SetActive(true)
		tabBtn.transform:SetParent(self.TabGrid.transform, false)

		local btnCell = GuildTableBtnCell.New(tabBtn, i)

		function btnCell.selectCallBack(index)
			self:SelectTab(index)
		end

		btnCell:SetSelect(false)

		self.tabBtn[i] = btnCell
	end

	self.childViews[1] = GuildRecommendView.New(self.Recommend)
	self.childViews[2] = GuildApplyView.New(self.Apply)
	self.childViews[3] = GuildSearchView.New(self.Search)
	self.childViews[4] = GuildEstablishView.New(self.Establish)
end

function GuildIntroduceUI:GetPreloadAssetPaths()
	return nil
end

function GuildIntroduceUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GuildIntroduceUI:IsManualShowOnOpen(userData)
	return false
end

function GuildIntroduceUI:GetBGM(userData)
	return nil
end

function GuildIntroduceUI:OnOpen(userData)
	if self.selectIndex == nil then
		self.selectIndex = 1
	end

	self.tabBtn[self.selectIndex]:SetSelect(true)
	self:ShowSelectView()
	self:UpdateView()
end

function GuildIntroduceUI:OnClose(userData)
	for i, v in pairs(self.childViews) do
		v:Close()
	end
end

function GuildIntroduceUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function GuildIntroduceUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function GuildIntroduceUI:OnPause()
	return
end

function GuildIntroduceUI:OnResume()
	return
end

function GuildIntroduceUI:OnCover()
	return
end

function GuildIntroduceUI:OnReveal()
	return
end

function GuildIntroduceUI:OnRefocus(userData)
	return
end

function GuildIntroduceUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GuildIntroduceUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuildIntroduceUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GuildIntroduceUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GuildIntroduceUI:OnDestroy()
	for i, v in pairs(self.tabBtn) do
		v:Dispose()
	end

	for i, v in pairs(self.childViews) do
		v:Dispose()
	end
end

function GuildIntroduceUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function GuildIntroduceUI:SelectTab(index)
	if self.selectIndex == index then
		return
	end

	self.selectIndex = index

	self:ShowSelectView()
end

function GuildIntroduceUI:ShowSelectView()
	for i, v in pairs(self.childViews) do
		if self.selectIndex == i then
			v:Open()
		else
			v:Close()
		end
	end
end

function GuildIntroduceUI:UpdateView()
	for i, v in pairs(self.tabBtn) do
		v:UpdateView()
	end
end

return GuildIntroduceUI
