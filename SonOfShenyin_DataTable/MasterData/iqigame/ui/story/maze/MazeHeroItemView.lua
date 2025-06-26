-- chunkname: @IQIGame\\UI\\Story\\Maze\\MazeHeroItemView.lua

local MazeHeroItemView = {}

function MazeHeroItemView.New(go, mainView)
	local o = Clone(MazeHeroItemView)

	o:Initialize(go, mainView)

	return o
end

function MazeHeroItemView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function MazeHeroItemView:InitComponent()
	self.grayComponent = self.gameObject:GetComponent("GrayComponent")
end

function MazeHeroItemView:InitDelegate()
	return
end

function MazeHeroItemView:AddListener()
	return
end

function MazeHeroItemView:RemoveListener()
	return
end

function MazeHeroItemView:OnDestroy()
	return
end

function MazeHeroItemView:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function MazeHeroItemView:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function MazeHeroItemView:Refresh(Data)
	self.data = Data

	local currentHp = self.data.attr[Constant.Attribute.TYPE_HP]
	local maxHp = self.data.attr[Constant.Attribute.TYPE_HP_MAX]

	LuaUtility.SetImageFillAmount(self.HPImage, currentHp / maxHp)
	self.grayComponent:SetGray(currentHp <= 0)

	local currentEnergy = self.data.attr[Constant.Attribute.TYPE_ENERGY]
	local maxEnergy = self.data.attr[Constant.Attribute.TYPE_ENERGY_MAX]

	LuaUtility.SetImageFillAmount(self.EnergyImage, currentEnergy / maxEnergy)

	local skinID = self.data.skin[Constant.SkinType.StaticImage].skinCid
	local path = SkinModule.GetHeroSkinImgPathByTypeWithSkinCid(skinID, Constant.SkinImageType.HeadIcon)

	LuaUtility.LoadImage(self, path, self.heroHeadImg:GetComponent("Image"))
end

return MazeHeroItemView
