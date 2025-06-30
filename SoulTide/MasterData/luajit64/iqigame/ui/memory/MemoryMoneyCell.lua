-- chunkname: @IQIGame\\UI\\Memory\\MemoryMoneyCell.lua

MemoryMoneyCell = {
	CurrencyCID = 0
}

function MemoryMoneyCell.New(viewGo, currencyCid)
	local o = Clone(MemoryMoneyCell)

	o.CurrencyCID = currencyCid
	o.ViewGo = viewGo
	o.View = {}

	LuaCodeInterface.BindOutlet(viewGo, o.View)

	function o.DelegateOnChangeValue(items)
		o:OnChangeValue(items)
	end

	o:AddEventListeners()
	o:UpdateView()

	return o
end

function MemoryMoneyCell:AddEventListeners()
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateOnChangeValue)
end

function MemoryMoneyCell:RemoveEventListeners()
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateOnChangeValue)
end

function MemoryMoneyCell:Dispose()
	self:RemoveEventListeners()
	self:UnLoadAsset()
	LuaCodeInterface.ClearOutlet(self.ViewGo, self.View)

	self.View = nil
	self.ViewGo = nil
end

function MemoryMoneyCell:OnChangeValue(items)
	local haveNum = WarehouseModule.GetItemNumByCfgID(self.CurrencyCID)

	self.View.ValueText:GetComponent("Text").text = tostring(haveNum)
end

function MemoryMoneyCell:UpdateView()
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[self.CurrencyCID].Icon), self.View.Icon:GetComponent("Image"), self.OnLoadSucceed, self.OnLoadFailed)

	local haveNum = WarehouseModule.GetItemNumByCfgID(self.CurrencyCID)

	self.View.ValueText:GetComponent("Text").text = tostring(haveNum)
end

function MemoryMoneyCell:UpdateNum()
	local haveNum = WarehouseModule.GetItemNumByCfgID(self.CurrencyCID)

	self.View.ValueText:GetComponent("Text").text = tostring(haveNum)
end

function MemoryMoneyCell:UnLoadAsset()
	AssetUtil.UnloadAsset(self)
end

function MemoryMoneyCell:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MemoryMoneyCell:OnLoadFailed(assetName, status, errorMessage, userData)
	logError("error occurs then load currency icon : " .. assetName)
end
