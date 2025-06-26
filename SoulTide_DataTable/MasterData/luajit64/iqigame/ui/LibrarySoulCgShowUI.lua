-- chunkname: @IQIGame\\UI\\LibrarySoulCgShowUI.lua

local LibrarySoulCgShowUI = Base:Extend("LibrarySoulCgShowUI", "IQIGame.Onigao.UI.LibrarySoulCgShowUI", {
	pos = 1,
	picUrls = {}
})

function LibrarySoulCgShowUI:OnInit()
	self.btnCloseComponent = self.BtnClose:GetComponent("Button")
	self.tweenBgScale = self.PicBG:GetComponent("TweenScale")
	self.sliderComponent = self.Slider:GetComponent("Slider")
	self.TextBtnTitle:GetComponent("Text").text = SoulHandBookUIApi:GetString("TextBtnTitle")

	function self.delegateClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.delegateClickBtnLeft()
		self:OnClickBtnLeft()
	end

	function self.delegateClickBtnRight()
		self:OnClickBtnRight()
	end

	function self.delegateSliderValue(value)
		self:OnSliderValueChange(value)
	end

	self.sliderComponent.maxValue = 1.5
	self.sliderComponent.minValue = 0.5
end

function LibrarySoulCgShowUI:GetPreloadAssetPaths()
	return nil
end

function LibrarySoulCgShowUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LibrarySoulCgShowUI:IsManualShowOnOpen(userData)
	return false
end

function LibrarySoulCgShowUI:GetBGM(userData)
	return nil
end

function LibrarySoulCgShowUI:OnOpen(userData)
	self.cfgTownStoryCGRes = userData
	self.pos = 1
	self.picUrls = {}

	for i = 1, #self.cfgTownStoryCGRes.CG do
		local url = self.cfgTownStoryCGRes.CG[i]

		if url ~= nil and url ~= "" then
			table.insert(self.picUrls, url)
		end
	end

	self:UpdateView()
end

function LibrarySoulCgShowUI:OnClose(userData)
	return
end

function LibrarySoulCgShowUI:OnAddListeners()
	self.btnCloseComponent.onClick:AddListener(self.delegateClickBtnClose)
	self.BtnLeft:GetComponent("Button").onClick:AddListener(self.delegateClickBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:AddListener(self.delegateClickBtnRight)
	self.sliderComponent.onValueChanged:AddListener(self.delegateSliderValue)
end

function LibrarySoulCgShowUI:OnRemoveListeners()
	self.btnCloseComponent.onClick:RemoveListener(self.delegateClickBtnClose)
	self.BtnLeft:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnRight)
	self.sliderComponent.onValueChanged:RemoveListener(self.delegateSliderValue)
end

function LibrarySoulCgShowUI:OnPause()
	return
end

function LibrarySoulCgShowUI:OnResume()
	return
end

function LibrarySoulCgShowUI:OnCover()
	return
end

function LibrarySoulCgShowUI:OnReveal()
	return
end

function LibrarySoulCgShowUI:OnRefocus(userData)
	return
end

function LibrarySoulCgShowUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LibrarySoulCgShowUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LibrarySoulCgShowUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LibrarySoulCgShowUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LibrarySoulCgShowUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function LibrarySoulCgShowUI:UpdateView()
	self:LoadPic()
	self:UpdateShowBtn()
end

function LibrarySoulCgShowUI:UpdateShowBtn()
	self.BtnLeft:SetActive(self.pos > 1)
	self.BtnRight:SetActive(self.pos < #self.picUrls)
end

function LibrarySoulCgShowUI:OnClickBtnLeft()
	self.pos = self.pos - 1

	if self.pos < 1 then
		self.pos = 1
	end

	self:LoadPic()
	self:UpdateShowBtn()
end

function LibrarySoulCgShowUI:OnClickBtnRight()
	self.pos = self.pos + 1

	if self.pos > #self.picUrls then
		self.pos = #self.picUrls
	end

	self:LoadPic()
	self:UpdateShowBtn()
end

function LibrarySoulCgShowUI:LoadPic()
	self.picUrl = self.picUrls[self.pos]

	if self.picUrl ~= nil then
		self.ImgCG:SetActive(false)
		self.tweenBgScale:ResetToBeginning()

		self.tweenBgScale.enabled = false

		AssetUtil.LoadAsset(self, UIGlobalApi.GetImagePath(self.picUrl), self.OnLoadAssetSucceed, nil, self.ImgCG:GetComponent("Image"))
	end
end

function LibrarySoulCgShowUI:OnLoadAssetSucceed(assetName, asset, duration, userData)
	local image = userData

	image.sprite = LuaCodeInterface.ToSprite(asset)

	self.ImgCG:SetActive(true)

	self.tweenBgScale.enabled = true
	self.sliderComponent.value = 1

	UGUIUtil.SetText(self.TextSlider, string.format("%.1f", self.sliderComponent.value))
end

function LibrarySoulCgShowUI:OnSliderValueChange(value)
	UGUIUtil.SetText(self.TextSlider, string.format("%.1f", value))

	self.ImgCG.transform.parent.localScale = Vector2.New(value, value)
end

function LibrarySoulCgShowUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.LibrarySoulCgShowUI)
end

return LibrarySoulCgShowUI
