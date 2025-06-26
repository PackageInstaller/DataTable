-- chunkname: @IQIGame\\UI\\FunctionPreview\\TabCell.lua

local TabCell = {}

function TabCell.New(view)
	local obj = Clone(TabCell)

	obj:Init(view)

	return obj
end

function TabCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tgHelper = self.goToggleHelper:GetComponent("ToggleHelperComponent")
end

function TabCell:Refresh(cfgForecastData)
	self.tgHelper.text = FunctionPreviewUIApi:GetString("goTabName", cfgForecastData.Title)
end

function TabCell:OnHide()
	return
end

function TabCell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return TabCell
