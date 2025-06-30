-- chunkname: @IQIGame\\UI\\RoleInfoDetails\\RoleDetailsView.lua

local m = {
	poolList = {},
	skillPoolList = {}
}
local FavorGiftPanel = require("IQIGame.UI.RoleInfoDetails.FavorGiftPanel")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:InitComponent()
	self:InitDelegate()
	self:AddListeners()
end

function m:InitComponent()
	self.favorGiftPanel = FavorGiftPanel.New(self.giftContent, self)
end

function m:InitDelegate()
	function self.delegateOnClickGiftBtn()
		self:OnClickGiftBtn()
	end

	function self.delegateOnClickButtonGiftMask()
		self:OnClickButtonGiftMask()
	end

	function self.prepareAddFavorEvent(value)
		self:PrepareAddFavor(value)
	end

	function self.prepareReduceFavorEvent(value)
		self:PrepareReduceFavor(value)
	end

	function self.HeroFavorRefreshEvent()
		self:RefreshFavorInfo(self.heroCid)
		self.favorGiftPanel:GiveSuccess()
	end
end

function m:AddListeners()
	self.giftBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickGiftBtn)
	self.ButtonGiftMask:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonGiftMask)
end

function m:RemoveListeners()
	self.giftBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickGiftBtn)
	self.ButtonGiftMask:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonGiftMask)
end

function m:OnClickButtonGiftMask()
	self.favorGiftPanel:Close()
end

function m:OnClickGiftBtn()
	if self.warlockData:GetMaxFavorLv() == self.warlockData.favorabilityLevel then
		return
	end

	self.favorGiftPanel:Refresh(self.heroCid)
	self.favorGiftPanel:Open()
end

function m:SetData(heroCid)
	self.cfgHeroData = CfgUtil.GetHeroCfgDataWithID(heroCid)
	self.heroCid = heroCid

	self:RefreshInfo()
	self:RefreshFavorInfo(heroCid)
end

function m:RefreshFavorInfo(heroCid)
	self.warlockData = WarlockModule.GetHeroData(heroCid)

	LuaUtility.SetText(self.levelNumText, self.warlockData.favorabilityLevel)

	local cfgFavorLv = RoleInfoDetailsModule.GetHeroFavorLevelCfg(self.warlockData.cid, self.warlockData.favorabilityLevel)

	LuaUtility.SetText(self.favoriteText, cfgFavorLv.FavorName)

	self.prepareShowAddNum = 0
	self.prepareAddLevel = 0
	self.prepareFavorValue = self.warlockData.favorabilityExp
end

function m:RefreshInfo()
	local item, obj

	for i = 1, 6 do
		item = self.poolList[i]

		if item == nil then
			obj = UnityEngine.Object.Instantiate(self.InfoItemPrefab)

			obj.transform:SetParent(self.InfoItemParent.transform, false)
			obj:SetActive(true)
			table.insert(self.poolList, i, obj)

			item = obj
		end

		self:SetItemCellInfo(item, i)
	end

	UGUIUtil.SetText(self.RoleDetailsText, self.cfgHeroData.Synopsis)
end

function m:SetItemCellInfo(item, index)
	local KeyText = item.transform:Find("Key").gameObject
	local ValueText = item.transform:Find("Value").gameObject
	local value

	if index == 1 then
		value = RoleInfoDetailsUIApi:GetRoleSex(self.cfgHeroData.Sex)
	elseif index == 2 then
		value = self.cfgHeroData.Height
	elseif index == 3 then
		value = self.cfgHeroData.Weight
	elseif index == 4 then
		value = self.cfgHeroData.Birthday
	elseif index == 5 then
		value = self.cfgHeroData.Age
	elseif index == 6 then
		value = self.cfgHeroData.Interest
	end

	UGUIUtil.SetText(KeyText, RoleInfoDetailsUIApi:GetRoleBaseInfo(index))
	UGUIUtil.SetText(ValueText, value)
end

function m:PrepareAddFavor(value)
	local maxLevel = self.warlockData:GetMaxFavorLv()

	if maxLevel <= self.warlockData.favorabilityLevel + self.prepareAddLevel then
		return
	end

	local cfgFavorLv = RoleInfoDetailsModule.GetHeroFavorLevelCfg(self.heroCid, self.warlockData.favorabilityLevel + self.prepareAddLevel)

	self.prepareShowAddNum = self.prepareShowAddNum + value
	self.prepareFavorValue = self.prepareFavorValue + value

	if self.prepareFavorValue >= cfgFavorLv.FavorExp then
		self.prepareFavorValue = self.prepareFavorValue - cfgFavorLv.FavorExp
		self.prepareAddLevel = self.prepareAddLevel + 1
	end

	self:RefreshFavorValue()
end

function m:PrepareReduceFavor(value)
	self.prepareShowAddNum = self.prepareShowAddNum - value
	self.prepareFavorValue = self.prepareFavorValue - value

	if self.prepareFavorValue < 0 then
		local cfgFavorLv = RoleInfoDetailsModule.GetHeroFavorLevelCfg(self.heroCid, self.warlockData.favorabilityLevel + self.prepareAddLevel - 1)

		self.prepareFavorValue = self.prepareFavorValue + cfgFavorLv.FavorExp
		self.prepareAddLevel = self.prepareAddLevel - 1
	end

	self:RefreshFavorValue()
end

function m:ClearFavorPrepare()
	self.prepareShowAddNum = 0
	self.prepareAddLevel = 0
	self.prepareFavorValue = self.warlockData.favorabilityExp

	self:RefreshFavorInfo(self.heroCid)
end

function m:RefreshFavorValue()
	if self.prepareAddLevel == 0 then
		LuaUtility.SetText(self.levelNumText, self.warlockData.favorabilityLevel)
	else
		LuaUtility.SetText(self.levelNumText, self.warlockData.favorabilityLevel .. " + " .. string.format(ColorCfg.Green, self.prepareAddLevel))
	end
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Dispose()
	self.favorGiftPanel:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
