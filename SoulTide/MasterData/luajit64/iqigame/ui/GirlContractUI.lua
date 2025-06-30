-- chunkname: @IQIGame\\UI\\GirlContractUI.lua

local GirlContractUI = Base:Extend("GirlContractUI", "IQIGame.Onigao.UI.GirlContractUI", {})

require("IQIGame.UI.AVPro.AVProView")

function GirlContractUI:OnInit()
	UGUIUtil.SetText(self.TextBtnConclusion, GirlContractUIApi:GetString("TextBtnConclusion"))
	UGUIUtil.SetText(self.TextBtnReview, GirlContractUIApi:GetString("TextBtnReview"))
	UGUIUtil.SetText(self.TextTitle, GirlContractUIApi:GetString("TextTitle", 1))
	UGUIUtil.SetText(self.TextTitleEng, GirlContractUIApi:GetString("TextTitle", 2))
	UGUIUtil.SetText(self.PanelText1, GirlContractUIApi:GetString("PanelText1"))
	UGUIUtil.SetText(self.PanelText2, GirlContractUIApi:GetString("PanelText2"))

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnConclusion()
		self:OnBtnConclusion()
	end

	function self.delegateBtnReview()
		self:OnBtnReview()
	end

	function self.delegateSoulOathSuccess(soulCid)
		self:OnSoulOathSuccess(soulCid)
	end

	function self.delegateSpineEnd()
		self:OnSpinetEnd()
	end

	function self.delegateOnPlayMovieComplete()
		self:OnPlayMovieComplete()
	end

	self.avProView = AVProView.New()
	self.avProView.playCurtainEndComplete = self.delegateOnPlayMovieComplete
end

function GirlContractUI:GetPreloadAssetPaths()
	return nil
end

function GirlContractUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GirlContractUI:OnOpen(userData)
	self.soulData = userData

	self.Panel1:SetActive(false)
	self.Panel3:SetActive(false)
	self:UpdateView()
end

function GirlContractUI:OnClose(userData)
	return
end

function GirlContractUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnConclusion:GetComponent("Button").onClick:AddListener(self.delegateBtnConclusion)
	self.BtnReview:GetComponent("Button").onClick:AddListener(self.delegateBtnReview)
	EventDispatcher.AddEventListener(EventID.SoulCompleteOathSuccess, self.delegateSoulOathSuccess)
end

function GirlContractUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnConclusion:GetComponent("Button").onClick:RemoveListener(self.delegateBtnConclusion)
	self.BtnReview:GetComponent("Button").onClick:RemoveListener(self.delegateBtnReview)
	EventDispatcher.RemoveEventListener(EventID.SoulCompleteOathSuccess, self.delegateSoulOathSuccess)
end

function GirlContractUI:OnPause()
	return
end

function GirlContractUI:OnResume()
	return
end

function GirlContractUI:OnCover()
	return
end

function GirlContractUI:OnReveal()
	return
end

function GirlContractUI:OnRefocus(userData)
	return
end

function GirlContractUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GirlContractUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GirlContractUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GirlContractUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GirlContractUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function GirlContractUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.GirlContractUI)
end

function GirlContractUI:OnSoulOathSuccess(soulCid)
	if soulCid == self.soulData.soulCid then
		self.Panel1:SetActive(true)

		local timer = Timer.New(function()
			self.Panel1:SetActive(false)
			self:UpdateView()
		end, 2)

		timer:Start()
	end
end

function GirlContractUI:UpdateView()
	if self.soulData then
		local girlPod = GirlModule.GetSoulGirlData(self.soulData.soulCid)

		self.Review:SetActive(girlPod.activation)
		self.Panel:SetActive(not girlPod.activation)

		local cfgSoulMarry = GirlModule.GetSoulOathData(self.soulData.soulCid)
		local path = UIGlobalApi.GetImagePath(cfgSoulMarry.SoulDress)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))

		self.ImgIcon.transform.localPosition = Vector3.New(cfgSoulMarry.SoulDressPosition[1], cfgSoulMarry.SoulDressPosition[2], cfgSoulMarry.SoulDressPosition[3])
		self.ImgIcon.transform.sizeDelta = Vector2.New(cfgSoulMarry.SoulDressScale[1], cfgSoulMarry.SoulDressScale[2])
		self.TextName:GetComponent("Text").text = self.soulData:GetCfgSoul().Name
		self.TextTime2:GetComponent("Text").text = GirlContractUIApi:GetString("TextTitle1")

		if girlPod.activation then
			self.TextReward:GetComponent("Text").text = cfgSoulMarry.PabilityWord[1]

			UGUIUtil.SetText(self.TextRewardNum, cfgSoulMarry.PabilityWordNum[1])

			self.TextTime1:GetComponent("Text").text = GirlContractUIApi:GetString("TextTime1", getDateText(GirlModule.soulOathPOD.dateData[5] / 1000))
			self.TextDes:GetComponent("Text").text = cfgSoulMarry.Soliloquy[2]
		else
			self.TextReward:GetComponent("Text").text = cfgSoulMarry.PabilityWord[2]

			UGUIUtil.SetText(self.TextRewardNum, cfgSoulMarry.PabilityWordNum[2])

			self.TextTime1:GetComponent("Text").text = GirlContractUIApi:GetString("TextTime2", getDateText(GirlModule.soulOathPOD.dateData[1] / 1000))
			self.TextDes:GetComponent("Text").text = cfgSoulMarry.Soliloquy[1]
		end

		for j = 0, self.GridText.transform.childCount - 1 do
			local obj = self.GridText.transform:GetChild(0).gameObject

			UnityEngine.GameObject.DestroyImmediate(obj)
		end

		for i = #cfgSoulMarry.FavorWord - 1, 1, -1 do
			local goObj = UnityEngine.Object.Instantiate(self.RenderMould)

			goObj:SetActive(true)

			goObj.transform:Find("Text_01").gameObject:GetComponent("Text").text = GirlContractUIApi:GetString("TextState", i + 1)
			goObj.transform:Find("Text_02").gameObject:GetComponent("Text").text = getDateText(GirlModule.soulOathPOD.dateData[i + 1] / 1000)
			goObj.transform:Find("Text").gameObject:GetComponent("Text").text = cfgSoulMarry.FavorWord[i]

			goObj.transform:SetParent(self.GridText.transform, false)
		end

		self.Review.transform:Find("Text_01").gameObject:GetComponent("Text").text = GirlContractUIApi:GetString("TextState", 5)
		self.Review.transform:Find("Text_02").gameObject:GetComponent("Text").text = getDateText(GirlModule.soulOathPOD.dateData[5] / 1000)
		self.Review.transform:Find("Text").gameObject:GetComponent("Text").text = cfgSoulMarry.FavorWord[4]
		self.itemID = cfgSoulMarry.CostItem[1]

		local needNum = cfgSoulMarry.CostItem[2]
		local haveNum = WarehouseModule.GetItemNumByCfgID(self.itemID)

		self.enough = needNum <= haveNum

		local spendPath = UIGlobalApi.GetIconPath(CfgItemTable[self.itemID].Icon)

		AssetUtil.LoadImage(self, spendPath, self.ImgSpend:GetComponent("Image"))

		self.TextSpend:GetComponent("Text").text = haveNum .. "/" .. needNum
	end
end

function GirlContractUI:OnBtnConclusion()
	if not self.enough then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, SettingPlayerInfoViewApi:GetString("ErrorMsg4", CfgItemTable[self.itemID].Name))

		return
	end

	self.type = 1

	UIModule.Open(Constant.UIControllerName.GirlContractConfirmationUI, Constant.UILayer.UI, self)
end

function GirlContractUI:OnBtnReview()
	self.type = 2

	self:PlayCloseEffect()
end

function GirlContractUI:PlayCloseEffect()
	self.Panel3:SetActive(true)

	self.skeletonAnimation = self.Spine.transform:GetChild(0).gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic)).AnimationState

	self.skeletonAnimation:SetEmptyAnimation(0, 0)
	self.skeletonAnimation:SetAnimation(0, "close", false)

	self.skeletonAnimation.Complete = self.skeletonAnimation.Complete + self.delegateSpineEnd
end

function GirlContractUI:OnSpinetEnd()
	self.skeletonAnimation.Complete = self.skeletonAnimation.Complete - self.delegateSpineEnd

	self.Panel2:SetActive(false)
	self.Panel3:SetActive(false)
	self:PlayMovie()
end

function GirlContractUI:PlayMovie()
	if self.avProView.isCurtain then
		return
	end

	local cfgSoulMarry = GirlModule.GetSoulOathData(self.soulData.soulCid)

	self.avProView:Show(self.UIController.gameObject, self.curtainNode, self.VideoNode, cfgSoulMarry.PlayPrefab, cfgSoulMarry.MarryMovie)
end

function GirlContractUI:OnPlayMovieComplete()
	UIModule.Open(Constant.UIControllerName.GirlContractShowUI, Constant.UILayer.UI, {
		self.soulData,
		self.type
	})
	self.Panel2:SetActive(true)
	self.Panel3:SetActive(false)
end

return GirlContractUI
