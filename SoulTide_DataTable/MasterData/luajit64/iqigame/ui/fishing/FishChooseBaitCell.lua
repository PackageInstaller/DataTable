-- chunkname: @IQIGame\\UI\\Fishing\\FishChooseBaitCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetData(data)
	self.itemData = data

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.itemData:GetCfg().Icon), self.Icon:GetComponent("Image"))
	UGUIUtil.SetText(self.TagNoChooseNum, self.itemData.num)
	UGUIUtil.SetText(self.TagChooseNum, self.itemData.num)
end

function m:SetSelect(top)
	self.Choose:SetActive(top)
	self.TagChoose:SetActive(top)
	self.TagNoChoose:SetActive(not top)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
