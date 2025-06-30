-- chunkname: @IQIGame\\UI\\RoleDevelopment\\RoleBreach\\RoleBreachResultView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(heroData)
	self.heroData = heroData

	self:SetRoleBreachState()
end

function m:SetRoleBreachState()
	self:LoadImage(RoleDevelopmentApi:GetBreachStateImg(self.heroData.breakLv - 1), self.CurBreachImg:GetComponent("Image"))
	self:LoadImage(RoleDevelopmentApi:GetBreachFontImg(self.heroData.breakLv - 1), self.CurBreachFont:GetComponent("Image"))
	self:LoadImage(RoleDevelopmentApi:GetNextBreachStateImg(self.heroData.breakLv), self.NextBreachImg:GetComponent("Image"))
	self:LoadImage(RoleDevelopmentApi:GetNextBreachFontImg(self.heroData.breakLv), self.NextBreachFont:GetComponent("Image"))
	self:LoadImage(RoleDevelopmentApi:GetNextBreachFontImg1(self.heroData.breakLv), self.NextBreachImg1:GetComponent("Image"))

	local path = self.heroData:GetCurStaticSkinImagePath(Constant.SkinImageType.HeroResourcesVerticalDraw)
	local goHeroImageCom = self.HeroShadow:GetComponent("Image")

	self:LoadImage(path, goHeroImageCom)

	goHeroImageCom = self.HeroImg:GetComponent("Image")

	self:LoadImage(path, goHeroImageCom)
end

function m:LoadImage(path, imgobj)
	AssetUtil.LoadImage(self, path, imgobj, self.LoadImageSucess, nil, imgobj)
end

function m:LoadImageSucess(assetName, asset, duration, userData)
	userData:SetNativeSize()
	LuaUtility.SetImageRectTransformPivot(userData:GetComponent(typeof(UnityEngine.RectTransform)), userData)
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
