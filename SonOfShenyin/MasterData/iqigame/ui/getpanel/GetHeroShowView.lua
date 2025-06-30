-- chunkname: @IQIGame\\UI\\GetPanel\\GetHeroShowView.lua

local m = {}

function m.New(view, ConfrimCallBack)
	local obj = Clone(m)

	obj:Init(view, ConfrimCallBack)

	return obj
end

function m:Init(view, ConfrimCallBack)
	self.View = view
	self.ConfrimCallBack = ConfrimCallBack

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateConfirmBtnClick()
		self:OnConfirmBtnClick()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.delegateConfirmBtnClick)
end

function m:RemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.delegateConfirmBtnClick)
end

function m:SetData(heroCid)
	local herocid = heroCid
	local herocfg = CfgHeroTable[herocid]
	local path = SkinModule.GetHeroDefaultSkinImgPath(heroCid, Constant.SkinImageType.HeroResourcesVerticalDraw)
	local goImgHeroCom = self.goImgHero:GetComponent("Image")

	AssetUtil.LoadImage(self, path, goImgHeroCom, function()
		goImgHeroCom:SetNativeSize()
		self:Show()
		LuaUtility.SetImageRectTransformPivot(goImgHeroCom:GetComponent(typeof(UnityEngine.RectTransform)), goImgHeroCom)
	end, nil)

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

function m:ShowEffect(quality)
	if self.effectID ~= nil then
		GameEntry.Effect:StopEffect(self.effectID)
	end

	self.effectID = GameEntry.Effect:PlayUIMountPointEffect(LotteryUIApi:GetImgShowEffect(quality), 50000, 0, self.View, 0)
end

function m:LoadImg(path, imgcom)
	AssetUtil.LoadImage(self, path, imgcom, self.LoadImageSucessCallBack, nil, imgcom)
end

function m:LoadImageSucessCallBack(assetName, asset, duration, userData)
	userData:SetNativeSize()
	LuaUtility.SetImageRectTransformPivot(userData.rectTransform, userData)
	self:Show()
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:OnConfirmBtnClick()
	if self.ConfrimCallBack then
		self.ConfrimCallBack()
	end

	self:Hide()
end

function m:Dispose()
	if self.effectID ~= nil then
		GameEntry.Effect:StopEffect(self.effectID)
	end

	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
