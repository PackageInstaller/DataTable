-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandChangeRoom\\HomeLandChangePageCell.lua

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

function m:SetData(data, startNum, endNum)
	self.Index = data
	self.ToggleMould:GetComponent("ToggleHelperComponent").text = HomeLandChangeRoomUIApi:GetString("PageIndex", startNum, endNum)
end

function m:SetSelect(top)
	self.ToggleMould:GetComponent("Toggle").isOn = top
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
