-- chunkname: @IQIGame\\UI\\SettlementUI\\SettlementHeroItemView.lua

local SettlementHeroItemView = {}

function SettlementHeroItemView.New(go, mainView)
	local o = Clone(SettlementHeroItemView)

	o:Initialize(go, mainView)

	return o
end

function SettlementHeroItemView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function SettlementHeroItemView:InitComponent()
	return
end

function SettlementHeroItemView:InitDelegate()
	return
end

function SettlementHeroItemView:AddListener()
	return
end

function SettlementHeroItemView:RemoveListener()
	return
end

function SettlementHeroItemView:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function SettlementHeroItemView:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function SettlementHeroItemView:Refresh(data)
	self.data = data

	local heroCid = self.data.val
	local cfgHero = CfgUtil.GetCfgHeroDataWithID(heroCid)

	LuaUtility.LoadImage(self, CommonSkillTipsUIApi:GetSkillElementIconPath(cfgHero.Elements), self.imageElement:GetComponent("Image"))
	LuaUtility.LoadImage(self, SkinModule.GetHeroCurrentSkinImgPath(heroCid, Constant.SkinImageType.HeadIcon), self.imageHero:GetComponent("Image"))
	LuaUtility.SetText(self.textLevel, self.data.heroLv)
	LuaUtility.SetText(self.textHeroName, cfgHero.Name)
	LuaUtility.SetText(self.textAttackValue, self.data.record)
	LuaUtility.SetText(self.textDefenceValue, math.abs(self.data.injury))
	LuaUtility.SetText(self.textHealthValue, self.data.remedy)
end

function SettlementHeroItemView:RefreshPercent(attack, defence, health)
	LuaUtility.SetText(self.textAttackPercent, string.format("%.2f%%", attack * 100))
	LuaUtility.SetText(self.textDefencePercent, string.format("%.2f%%", defence * 100))
	LuaUtility.SetText(self.textHealthPercent, string.format("%.2f%%", health * 100))
	LuaUtility.SetImageFillAmount(self.attackFill, attack)
	LuaUtility.SetImageFillAmount(self.defenceFill, defence)
	LuaUtility.SetImageFillAmount(self.healthFill, health)
end

function SettlementHeroItemView:OnDestroy()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

return SettlementHeroItemView
