-- chunkname: @IQIGame\\UI\\Memory\\MemoryTopView.lua

MemoryTopView = {}

function MemoryTopView.New(ui)
	local cloneObject = Clone(MemoryTopView)

	cloneObject:InitView(ui)

	return cloneObject
end

function MemoryTopView:InitView(ui)
	self.goView = ui

	LuaCodeInterface.BindOutlet(ui, self)
	self:CloseUI()
end

function MemoryTopView:CloseUI()
	self.goView.gameObject:SetActive(false)
end

function MemoryTopView:OpenUI()
	self.goView.gameObject:SetActive(true)
end

function MemoryTopView:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end
