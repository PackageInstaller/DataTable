-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyMallCell.lua

local m = {
	isSellOut = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data)
	self.cfgShopData = data

	UGUIUtil.SetText(self.goName, MonsterAcademyMallUIApi:GetString("goItemName", self.cfgShopData.Name))
	UGUIUtil.SetText(self.goBuyTimes, MonsterAcademyMallUIApi:GetString("goBuyTimes", self.cfgShopData.LimitType, MonsterAcademyModule.GetResidueBuyTimes(self.cfgShopData.Id), self.cfgShopData.LimitTimes))
	UGUIUtil.SetText(self.ConditionText, MonsterAcademyMallUIApi:GetString("ConditionText", self.cfgShopData.LimitType, self.cfgShopData.LimitTimes))

	self.isSellOut = self.cfgShopData.LimitTimes ~= 0 and MonsterAcademyModule.GetResidueBuyTimes(self.cfgShopData.Id) == 0

	local path = UIGlobalApi.GetImagePath(CfgGalgameMonsterItemTable[self.cfgShopData.Item].Icon)

	AssetUtil.LoadImage(self, path, self.goIcon:GetComponent("Image"))

	local spendPath = UIGlobalApi.GetImagePath(CfgGalgameMonsterItemTable[self.cfgShopData.SellPrice].Icon)

	AssetUtil.LoadImage(self, spendPath, self.goMoneyIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.goSellNum, self.cfgShopData.ItemNum)
	UGUIUtil.SetText(self.goMoneyNum, self.cfgShopData.Price)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
