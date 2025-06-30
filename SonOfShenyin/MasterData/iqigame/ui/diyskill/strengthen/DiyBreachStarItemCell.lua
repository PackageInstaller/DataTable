-- chunkname: @IQIGame\\UI\\DiySkill\\Strengthen\\DiyBreachStarItemCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:__Init(view)

	return obj
end

function m:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function m:Show()
	self.gameObject:SetActive(true)
end

function m:SetOnState(isOn)
	self.on:SetActive(isOn)
	self.off:SetActive(not isOn)
end

function m:Hide()
	self.gameObject:SetActive(false)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return m
