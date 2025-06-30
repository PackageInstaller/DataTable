-- chunkname: @IQIGame\\UI\\GetHeroShowUI.lua

local GetHeroShowUI = {}

GetHeroShowUI = Base:Extend("GetHeroShowUI", "IQIGame.Onigao.UI.GetHeroShowUI", GetHeroShowUI)

function GetHeroShowUI:OnInit()
	function self.delegateConfirmBtnClick()
		self:OnConfirmBtnClick()
	end
end

function GetHeroShowUI:GetPreloadAssetPaths()
	return nil
end

function GetHeroShowUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GetHeroShowUI:IsManualShowOnOpen(userData)
	return false
end

function GetHeroShowUI:GetBGM(userData)
	return nil
end

function GetHeroShowUI:OnOpen(heroCid)
	self.HeroData = WarlockModule.WarlockDataDic[heroCid]

	self:OpenHeroShow()
end

function GetHeroShowUI:OnClose(userData)
	return
end

function GetHeroShowUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.delegateConfirmBtnClick)
end

function GetHeroShowUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.delegateConfirmBtnClick)
end

function GetHeroShowUI:OnPause()
	return
end

function GetHeroShowUI:OnResume()
	return
end

function GetHeroShowUI:OnCover()
	return
end

function GetHeroShowUI:OnReveal()
	return
end

function GetHeroShowUI:OnRefocus(userData)
	return
end

function GetHeroShowUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GetHeroShowUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GetHeroShowUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GetHeroShowUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GetHeroShowUI:OnDestroy()
	if self.effectID ~= nil then
		GameEntry.Effect:StopEffect(self.effectID)
	end

	AssetUtil.UnloadAsset(self)
end

function GetHeroShowUI:OpenHeroShow()
	local herocfg = CfgHeroTable[self.HeroData.cid]
	local path = self.HeroData:GetCurStaticSkinImagePath(Constant.SkinImageType.HeroResourcesVerticalDraw)
	local goHeroImageCom = self.goImgHero:GetComponent("Image")

	AssetUtil.LoadImage(self, path, goHeroImageCom, function()
		goHeroImageCom:SetNativeSize()
		LuaUtility.SetImageRectTransformPivot(goHeroImageCom:GetComponent(typeof(UnityEngine.RectTransform)), goHeroImageCom)
	end)

	path = UIGlobalApi.GetImagePath(herocfg.ElementsIcon)

	self:LoadImg(path, self.PropertyImg:GetComponent("Image"))

	path = LotteryUIApi:GetHeroProfessionImg(1, herocfg.Profession)

	self:LoadImg(path, self.ProfessionImg:GetComponent("Image"))
	self.heroStar:GetComponent("SimpleStarComponent"):UpdateView(herocfg.Quality, 0)
	UGUIUtil.SetText(self.goHeroDesc, herocfg.Synopsis)
	UGUIUtil.SetText(self.goHeroName, herocfg.Name)
	UGUIUtil.SetText(self.goEnName, herocfg.EnglishName)
	self:ShowEffect(herocfg.Quality)
end

function GetHeroShowUI:OnConfirmBtnClick()
	UIModule.CloseSelf(self)
end

function GetHeroShowUI:ShowEffect(quality)
	if self.effectID ~= nil then
		GameEntry.Effect:StopEffect(self.effectID)
	end

	self.effectID = GameEntry.Effect:PlayUIMountPointEffect(LotteryUIApi:GetImgShowEffect(quality), 50000, 0, self.EffectPoint, 0)
end

function GetHeroShowUI:LoadImg(path, imgcom)
	AssetUtil.LoadImage(self, path, imgcom, self.LoadImageSucessCallBack, nil, imgcom)
end

function GetHeroShowUI:LoadImageSucessCallBack(assetName, asset, duration, userData)
	userData:SetNativeSize()
end

return GetHeroShowUI
