-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGameBag\\PlaceGameBagExchangeItemCell.lua

local m = {}

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
	self.exchangeData = data

	local isOpen = self.exchangeData:IsOpen()

	self.Lock:SetActive(not isOpen)
	self.Unlock:SetActive(isOpen)
	self.TextLockCondition:SetActive(not isOpen)
	UGUIUtil.SetText(self.TextName, self.exchangeData:GetCfgData().Name)
	UGUIUtil.SetText(self.TextLockName, self.exchangeData:GetCfgData().Name)
	UGUIUtil.SetText(self.TextCheckName, self.exchangeData:GetCfgData().Name)
	UGUIUtil.SetText(self.TextCondition, PlaceGameBagUIApi:GetString("ExchangeCondition", self.exchangeData:GetCfgData().NeedTower))
	UGUIUtil.SetText(self.TextLockCondition, PlaceGameBagUIApi:GetString("ExchangeCondition", self.exchangeData:GetCfgData().NeedTower))
end

function m:SetSelect(top)
	self.Check:SetActive(top)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
