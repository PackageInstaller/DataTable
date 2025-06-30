-- chunkname: @IQIGame\\UI\\Maze\\MazeBattleHeadElement.lua

local Element = {
	heroCid = 0
}

function Element.New(view)
	local obj = Clone(Element)

	obj:__OnInit(view)

	return obj
end

function Element:__OnInit(view)
	self.gameObject = view.gameObject

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.delegateOnClickHeroHead()
		self:OnClickHeroHead()
	end

	self.hpSliderCom = self.hpSlider.gameObject:GetComponent("Slider")
	self.energySliderCom = self.energySlider.gameObject:GetComponent("Slider")

	self:AddListeners()
end

function Element:AddListeners()
	self.gameObject:GetComponent("Button").onClick:AddListener(self.delegateOnClickHeroHead)
end

function Element:RemoveListeners()
	self.gameObject:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickHeroHead)
end

function Element:Show(heroCid)
	self.heroCid = heroCid
	self.heroData = MazeModule.GetHeroData(self.heroCid)

	self.gameObject:SetActive(true)
	self:__RefreshHeroStaticResource()
	self:__RefreshHeroShow()
end

function Element:__RefreshHeroStaticResource()
	local skinDataConfig = CfgHeroSkinTable[self.heroData.heroSkin.skinCid]
	local iconPath = SkinModule.GetHeroSkinImgPathByType(skinDataConfig, Constant.SkinImageType.HeadIcon)

	AssetUtil.LoadImage(self, iconPath, self.heroImg:GetComponent("Image"))

	local heroConfig = CfgHeroTable[self.heroCid]
	local bgPath = RoleDevelopmentApi:GetRoleWarehouseItemBackground(heroConfig.Quality)

	AssetUtil.LoadImage(self, bgPath, self.qualityIcon:GetComponent("Image"))

	self.levelText.gameObject:GetComponent("Text").text = RoleDevelopmentApi:GetRoleWarehouseItemRoleLv(self.heroData.lv)

	local elementPath = WarlockApi:GetElementIconPath(heroConfig.Elements)

	AssetUtil.LoadImage(self, elementPath, self.elementImage:GetComponent("Image"))
end

function Element:__RefreshHeroShow()
	local exData = MazeModule.GetHeroExData(self.heroCid)
	local curHP = WarlockModule.GetHeroHPValueByHeroPOD(self.heroData)

	self.hpSliderCom.value = curHP / exData.maxHP

	local curEnergy = WarlockModule.GetHeroEnergyValueByHeroPOD(self.heroData)

	self.energySliderCom.value = curEnergy / exData.maxEnergy
end

function Element:UpdateHeroInfo()
	self.heroData = MazeModule.GetHeroData(self.heroCid)

	self:__RefreshHeroShow()
end

function Element:OnClickHeroHead()
	MazeModule.OpenFormationUIForFormationOnly()
end

function Element:Hide()
	self.heroCid = 0

	self.gameObject:SetActive(false)
end

function Element:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return Element
