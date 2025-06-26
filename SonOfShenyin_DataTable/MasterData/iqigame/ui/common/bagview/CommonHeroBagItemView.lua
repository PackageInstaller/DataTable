-- chunkname: @IQIGame\\UI\\Common\\BagView\\CommonHeroBagItemView.lua

local CommonBagItemView = require("IQIGame/UI/Common/BagView/CommonBagItemView")
local HeroItemCell = Clone(CommonBagItemView)

function HeroItemCell:__OnShow()
	local heroData = self.itemData

	self:__HeroItemCell_OnShow(heroData)
end

function HeroItemCell:__HeroItemCell_OnShow(heroData)
	local iconPath = heroData:GetCurStaticSkinImagePath(Constant.SkinImageType.HeroResourcesHead)

	AssetUtil.LoadImage(self, iconPath, self.heroImg:GetComponent("Image"))

	local bgPath = RoleDevelopmentApi:GetRoleWarehouseItemBackground(heroData:GetCfg().Quality)

	AssetUtil.LoadImage(self, bgPath, self.qualityIcon:GetComponent("Image"))

	self.levelText.gameObject:GetComponent("Text").text = RoleDevelopmentApi:GetRoleWarehouseItemRoleLv(heroData.lv)

	local elementPath = WarlockApi:GetElementIconPath(heroData:GetCfg().Elements)

	AssetUtil.LoadImage(self, elementPath, self.elementImage:GetComponent("Image"))

	local professionIconPath = WarlockApi:GetProfessionIconPath(heroData:GetCfg().Profession)

	AssetUtil.LoadImage(self, professionIconPath, self.propertyImage:GetComponent("Image"))
end

function HeroItemCell:__OnDispose()
	AssetUtil.UnloadAsset(self)
end

return HeroItemCell
