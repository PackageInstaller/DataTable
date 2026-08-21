-- chunkname: @IQIGame\\UI\\SoulCgShowUI.lua

local SoulCgShowUI = Base:Extend("SoulCgShowUI", "IQIGame.Onigao.UI.SoulCgShowUI", {
	pos = 1,
	picUrls = {}
})

function SoulCgShowUI:OnInit()
	self.btnCloseComponent = self.BtnClose:GetComponent("Button")
	self.tweenBgScale = self.PicBG:GetComponent("TweenScale")
	self.sliderComponent = self.Slider:GetComponent("Slider")
	self.sliderComponent.maxValue = 1.5
	self.sliderComponent.minValue = 0.5
	self.TextBtnTitle:GetComponent("Text").text = SoulHandBookUIApi:GetString("TextBtnTitle")

	function self.delegateClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.delegateSliderValue(value)
		self:OnSliderValueChange(value)
	end

	function self.delegateClickBtnLeft()
		self:OnBtnLeft()
	end

	function self.delegateClickBtnRight()
		self:OnBtnRight()
	end
end

function SoulCgShowUI:GetPreloadAssetPaths()
	return nil
end

function SoulCgShowUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SoulCgShowUI:OnOpen(userData)
	self.picUrls = userData[1]
	self.cgPicturePosition = userData[2]
	self.pos = 1

	self:LoadPic()
	self:UpdateShowBtn()
end

function SoulCgShowUI:OnClose(userData)
	return
end

function SoulCgShowUI:OnAddListeners()
	self.btnCloseComponent.onClick:AddListener(self.delegateClickBtnClose)
	self.sliderComponent.onValueChanged:AddListener(self.delegateSliderValue)
	self.BtnLeft:GetComponent("Button").onClick:AddListener(self.delegateClickBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:AddListener(self.delegateClickBtnRight)
end

function SoulCgShowUI:OnRemoveListeners()
	self.btnCloseComponent.onClick:RemoveListener(self.delegateClickBtnClose)
	self.sliderComponent.onValueChanged:RemoveListener(self.delegateSliderValue)
	self.BtnLeft:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnRight)
end

function SoulCgShowUI:OnPause()
	return
end

function SoulCgShowUI:OnResume()
	return
end

function SoulCgShowUI:OnCover()
	return
end

function SoulCgShowUI:OnReveal()
	return
end

function SoulCgShowUI:OnRefocus(userData)
	return
end

function SoulCgShowUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SoulCgShowUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SoulCgShowUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SoulCgShowUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SoulCgShowUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function SoulCgShowUI:OnBtnLeft()
	self.pos = self.pos - 1

	if self.pos < 1 then
		self.pos = 1
	end

	self:LoadPic()
	self:UpdateShowBtn()
end

function SoulCgShowUI:OnBtnRight()
	self.pos = self.pos + 1

	if self.pos > #self.picUrls then
		self.pos = #self.picUrls
	end

	self:LoadPic()
	self:UpdateShowBtn()
end

function SoulCgShowUI:LoadPic()
	self.picUrl = self.picUrls[self.pos]

	if self.picUrl ~= nil then
		self.ImgCG:SetActive(false)
		self.tweenBgScale:ResetToBeginning()

		self.tweenBgScale.enabled = false

		AssetUtil.LoadAsset(self, self.picUrl, self.OnLoadAssetSucceed, nil, self.ImgCG:GetComponent("Image"))
	end
end

function SoulCgShowUI:OnLoadAssetSucceed(assetName, asset, duration, userData)
	local image = userData

	image.sprite = LuaCodeInterface.ToSprite(asset)

	self.ImgCG:SetActive(true)

	self.tweenBgScale.enabled = true
	self.sliderComponent.value = 1

	UGUIUtil.SetText(self.TextSlider, string.format("%.1f", self.sliderComponent.value))
end

function SoulCgShowUI:UpdateShowBtn()
	self.BtnLeft:SetActive(self.pos > 1)
	self.BtnRight:SetActive(self.pos < #self.picUrls)
end

function SoulCgShowUI:OnSliderValueChange(value)
	UGUIUtil.SetText(self.TextSlider, string.format("%.1f", value))

	self.ImgCG.transform.parent.localScale = Vector2.New(value, value)
end

function SoulCgShowUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.SoulCgShowUI)
end

return SoulCgShowUI
