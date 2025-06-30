-- chunkname: @IQIGame\\UI\\Chat\\Expression\\ExpGroupCell.lua

local ExpGroupCell = {}

function ExpGroupCell.New(view)
	local obj = Clone(ExpGroupCell)

	obj:Init(view)

	return obj
end

function ExpGroupCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.imgIcon = self.goIcon:GetComponent("Image")
end

function ExpGroupCell:Refresh(cfgGroupData)
	self.cfgGroupData = cfgGroupData

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(self.cfgGroupData.Icon), self.imgIcon)
end

function ExpGroupCell:OnHide()
	return
end

function ExpGroupCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return ExpGroupCell
