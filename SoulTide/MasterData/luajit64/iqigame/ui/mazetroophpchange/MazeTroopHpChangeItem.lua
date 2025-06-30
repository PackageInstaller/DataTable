-- chunkname: @IQIGame\\UI\\MazeTroopHpChange\\MazeTroopHpChangeItem.lua

local m = {
	IsAdd = false
}

function m.New(view, isAdd)
	local obj = Clone(m)

	obj:Init(view, isAdd)

	return obj
end

function m:Init(view, isAdd)
	self.View = view
	self.IsAdd = isAdd

	LuaCodeInterface.BindOutlet(self.View, self)

	self.LabelText:GetComponent("Text").text = MazeTroopHpChangeUIApi:GetString("LabelText", isAdd)
end

function m:SetData(value)
	self.ValueText:GetComponent("Text").text = MazeTroopHpChangeUIApi:GetString("ValueText", value)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
