-- chunkname: @IQIGame\\UI\\Friend\\FriendHeroItem.lua

local FriendHeroItem = {}

function FriendHeroItem.New(go, mainView)
	local o = Clone(FriendHeroItem)

	o:Initialize(go, mainView)

	return o
end

function FriendHeroItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function FriendHeroItem:InitMembers()
	return
end

function FriendHeroItem:InitComponent()
	return
end

function FriendHeroItem:InitDelegate()
	return
end

function FriendHeroItem:AddListener()
	return
end

function FriendHeroItem:RemoveListener()
	return
end

function FriendHeroItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function FriendHeroItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function FriendHeroItem:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
end

function FriendHeroItem:Refresh(heroData)
	local WarlockData = WarlockData.New()

	WarlockData:Initialize(heroData, true)

	local heroCfg = CfgUtil.GetCfgHeroDataWithID(heroData.hero and heroData.hero.cid or heroData.cid)

	LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(heroCfg.ProfessionIcon), self.Profession:GetComponent("Image"))
	LuaUtility.LoadImage(self, NoviceSignUIApi:GetElementsImagePath(heroCfg.Elements), self.elementImg:GetComponent("Image"))
	LuaUtility.LoadImage(self, NoviceSignUIApi:GetQualityImagePath(heroCfg.Quality), self.roleQualityImg:GetComponent("Image"))
	LuaUtility.LoadImage(self, WarlockData:GetCurStaticSkinImagePath(Constant.SkinImageType.HeroResourcesHead), self.RoleImg:GetComponent("Image"))
	LuaUtility.SetText(self.RoleLevel, heroData.hero and heroData.hero.lv or heroData.lv)
end

return FriendHeroItem
