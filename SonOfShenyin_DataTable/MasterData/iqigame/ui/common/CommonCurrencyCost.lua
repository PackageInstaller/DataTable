-- chunkname: @IQIGame\\UI\\Common\\CommonCurrencyCost.lua

local CommonCurrencyCost = {}

function CommonCurrencyCost.New(go, mainView)
	local o = Clone(CommonCurrencyCost)

	o:Initialize(go, mainView)

	return o
end

function CommonCurrencyCost:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function CommonCurrencyCost:InitComponent()
	return
end

function CommonCurrencyCost:InitDelegate()
	return
end

function CommonCurrencyCost:AddListener()
	return
end

function CommonCurrencyCost:RemoveListener()
	return
end

function CommonCurrencyCost:Refresh(currencyItemCid, needCount)
	local itemCfg = CfgUtil.GetItemCfgDataWithID(currencyItemCid)

	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(itemCfg.Icon), self.imageIcon:GetComponent("Image"))

	local hasNum = WarehouseModule.GetItemNumByCfgID(itemCfg.Id)

	LuaUtility.SetText(self.textHas, hasNum)
	LuaUtility.SetText(self.textNeed, needCount)

	return needCount <= hasNum
end

return CommonCurrencyCost
