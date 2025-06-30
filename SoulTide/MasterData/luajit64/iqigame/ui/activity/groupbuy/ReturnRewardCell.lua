-- chunkname: @IQIGame\\UI\\Activity\\GroupBuy\\ReturnRewardCell.lua

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

function m:SetData(id, number)
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[id].Icon), self.Icon:GetComponent("Image"))
	UGUIUtil.SetText(self.TextNum, tostring(math.ceil(number)))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
