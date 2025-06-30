-- chunkname: @IQIGame\\UI\\MazeTeam\\MazeTeamSubPanel.lua

local m = {
	IsShow = false
}

function m.InitFieldDefaultValues(class, prototype)
	for key, value in pairs(prototype) do
		class[key] = value
	end
end

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:OnInit()
end

function m:OnInit()
	return
end

function m:OnRootUIOpen()
	return
end

function m:OnRootUIClose()
	return
end

function m:Show(dollPOD)
	if not self.IsShow then
		self.View:SetActive(true)
		self:AddListeners()
	end

	self.IsShow = true

	self:OnShow(dollPOD)
end

function m:Hide(isDestroy)
	if self.IsShow then
		self.View:SetActive(false)
		self:RemoveListeners()
	end

	self.IsShow = false

	self:OnHide(isDestroy)
end

function m:OnShow(dollPOD)
	return
end

function m:OnHide(isDestroy)
	return
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:Save()
	return
end

function m:Dispose()
	self:OnDispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function m:OnDispose()
	return
end

return m
