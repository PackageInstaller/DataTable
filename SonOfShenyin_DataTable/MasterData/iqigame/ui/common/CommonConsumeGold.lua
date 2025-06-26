-- chunkname: @IQIGame\\UI\\Common\\CommonConsumeGold.lua

CommonConsumeGold = {}

function CommonConsumeGold.New(view)
	local obj = Clone(CommonConsumeGold)

	obj:Init(view)

	return obj
end

function CommonConsumeGold:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function CommonConsumeGold:SetData(needCount)
	local hasCount = WarehouseModule.GetItemNumByCfgID(self.itemCid)
	local isEnough = needCount <= hasCount

	if isEnough == true or isEnough == nil then
		UGUIUtil.SetText(self.needMoney, "<color=#FFFFFF>" .. needCount .. "</color>")
	else
		UGUIUtil.SetText(self.needMoney, "<color=#FF0000>" .. needCount .. "</color>")
	end

	local adapter = LuaUtility.GetComponent(self.bottomBg, typeof(UISizeAdapter))

	adapter:UpdateSize()

	return isEnough
end

function CommonConsumeGold:SetAllMoney()
	UGUIUtil.SetText(self.allMoneyText, "/" .. WarehouseModule.GetItemNumByCfgID(self.itemCid))
end

function CommonConsumeGold:InitIconImg(itemCid)
	if itemCid == nil or LuaUtility.StrIsNullOrEmpty(CfgItemTable[itemCid].SmallIcon) then
		logError(string.format("该道具%s未配置SmallIcon", itemCid))

		return
	end

	self.itemCid = itemCid

	local path = UIGlobalApi.GetIconPath(CfgItemTable[itemCid].SmallIcon)

	self:LoadImg(path)
end

function CommonConsumeGold:LoadImg(path)
	AssetUtil.LoadImage(self, path, self.IconImg:GetComponent("Image"), function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.View:GetComponent("RectTransform"))
	end)
end

function CommonConsumeGold:Show()
	self.View:SetActive(true)
end

function CommonConsumeGold:Hide()
	self.View:SetActive(false)
end

function CommonConsumeGold:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
