-- chunkname: @IQIGame\\UI\\RoleDevelopment\\ItemCell\\ChangeHeroItem.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.heroHeadImg = self.HeroImg:GetComponent("Image")
end

function m:SetData(heroData, selectHeroCid)
	AssetUtil.LoadImage(self, heroData:GetCurStaticSkinImagePath(Constant.SkinImageType.HeroResourcesHead), self.heroHeadImg, nil, nil, nil, false)

	if selectHeroCid == heroData.cid then
		self:Selected()
	else
		self:UnSelect()
	end
end

function m:Selected()
	self.SelectState:SetActive(true)
end

function m:UnSelect()
	self.SelectState:SetActive(false)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
