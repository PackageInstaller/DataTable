-- chunkname: @IQIGame\\UI\\ItemLetterTipsUI.lua

require("IQIGame.UIExternalApi.ItemLetterTipsUIApi")

local ItemLetterTipsUI = {}

ItemLetterTipsUI = Base:Extend("ItemLetterTipsUI", "IQIGame.Onigao.UI.ItemLetterTipsUI", ItemLetterTipsUI)

function ItemLetterTipsUI:OnInit()
	function self.DelegateOnClickNextBtn()
		self:OnClickNextBtn()
	end

	function self.DelegateOnClickPrevBtn()
		self:OnClickPrevBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	UGUIUtil.SetText(self.TitleText, ItemLetterTipsUIApi:GetString("TitleText"))
end

function ItemLetterTipsUI:GetPreloadAssetPaths()
	return nil
end

function ItemLetterTipsUI:GetOpenPreloadAssetPaths(userData)
	self:CacheLetterImages(userData.itemCid)

	return {
		UIGlobalApi.GetImagePath(self.ImagePaths[1])
	}
end

function ItemLetterTipsUI:IsManualShowOnOpen(userData)
	return false
end

function ItemLetterTipsUI:GetBGM(userData)
	return nil
end

function ItemLetterTipsUI:OnOpen(userData)
	self:UpdateView(userData.itemCid)
end

function ItemLetterTipsUI:OnClose(userData)
	return
end

function ItemLetterTipsUI:OnAddListeners()
	self.NextBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickNextBtn)
	self.PrevBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickPrevBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function ItemLetterTipsUI:OnRemoveListeners()
	self.NextBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickNextBtn)
	self.PrevBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickPrevBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function ItemLetterTipsUI:OnPause()
	return
end

function ItemLetterTipsUI:OnResume()
	return
end

function ItemLetterTipsUI:OnCover()
	return
end

function ItemLetterTipsUI:OnReveal()
	return
end

function ItemLetterTipsUI:OnRefocus(userData)
	return
end

function ItemLetterTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ItemLetterTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ItemLetterTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ItemLetterTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ItemLetterTipsUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function ItemLetterTipsUI:UpdateView(itemCid)
	self.Page = 1

	self:RefreshPage()
end

function ItemLetterTipsUI:CacheLetterImages(itemCid)
	local targetLetterCfgData

	for i, cfgMemorialLetterData in pairsCfg(CfgMemorialLetterTable) do
		if cfgMemorialLetterData.ItemId == itemCid then
			targetLetterCfgData = cfgMemorialLetterData

			break
		end
	end

	self.ImagePaths = {}

	for i = 1, #targetLetterCfgData.Image do
		local path = targetLetterCfgData.Image[i]

		if path ~= "" then
			table.insert(self.ImagePaths, path)
		end
	end
end

function ItemLetterTipsUI:RefreshPage()
	local imagePath = self.ImagePaths[self.Page]

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(imagePath), self.ContentImage:GetComponent("Image"))
	self.PrevBtn:SetActive(self.Page > 1)
	self.PrevBtnGrayView:SetActive(self.Page <= 1)
	self.NextBtn:SetActive(self.Page < #self.ImagePaths)
	self.NextBtnGrayView:SetActive(self.Page >= #self.ImagePaths)
end

function ItemLetterTipsUI:OnClickNextBtn()
	self.Page = self.Page + 1

	local imagePathLength = #self.ImagePaths

	if imagePathLength < self.Page then
		self.Page = imagePathLength
	end

	self:RefreshPage()
end

function ItemLetterTipsUI:OnClickPrevBtn()
	self.Page = self.Page - 1

	if self.Page < 1 then
		self.Page = 1
	end

	self:RefreshPage()
end

function ItemLetterTipsUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return ItemLetterTipsUI
