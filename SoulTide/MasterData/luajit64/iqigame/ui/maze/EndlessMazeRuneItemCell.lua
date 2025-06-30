-- chunkname: @IQIGame\\UI\\Maze\\EndlessMazeRuneItemCell.lua

local m = {
	Interactive = true,
	IsActive = true
}

function m.New(view, customOnClick, interactive)
	local obj = Clone(m)

	obj:Init(view, customOnClick, interactive)

	return obj
end

function m:Init(view, customOnClick, interactive)
	self.View = view
	self.CustomOnClickCallback = customOnClick
	self.Interactive = interactive == nil or interactive

	function self.DelegateOnClick()
		self:OnClick()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClick)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClick)
end

function m:SetData(itemData)
	self.ItemData = itemData

	self:SetActive(itemData ~= nil)

	if itemData == nil then
		return
	end

	self:SetDataByCfgData(itemData:GetCfg(), true)
end

function m:SetDataByCfgData(cfgItemData, isFromItemData)
	if not isFromItemData then
		self.ItemData = nil
	end

	self.CfgItemData = cfgItemData

	self.View:SetActive(cfgItemData ~= nil)

	if cfgItemData == nil then
		return
	end

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.View:GetComponentInChildren(typeof(UnityEngine.UI.Image)))
end

function m:OnClick()
	if not self.Interactive then
		return
	end

	if self.CustomOnClickCallback ~= nil then
		self.CustomOnClickCallback()

		return
	end

	ItemModule.OpenTipByData(self.ItemData)
end

function m:Hide()
	self:SetActive(false)
end

function m:SetActive(value)
	self.IsActive = value

	for i = 0, self.View.transform.childCount - 1 do
		self.View.transform:GetChild(i).gameObject:SetActive(value)
	end
end

function m:Reset()
	self:SetActive(true)
end

function m:GetRoot()
	return self.View.transform:Find("Root").gameObject
end

function m:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)

	self.View = nil
	self.CustomOnClickCallback = nil
	self.ItemData = nil
	self.CfgItemData = nil
end

return m
