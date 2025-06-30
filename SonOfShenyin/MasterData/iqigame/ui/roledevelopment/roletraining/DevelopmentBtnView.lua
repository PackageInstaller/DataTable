-- chunkname: @IQIGame\\UI\\RoleDevelopment\\RoleTraining\\DevelopmentBtnView.lua

local m = {}

function m.New(view, ClickEvent, targetView)
	local obj = Clone(m)

	obj:Init(view, ClickEvent, targetView)

	return obj
end

function m:Init(view, ClickEvent, targetView)
	self.View = view
	self.ClickEvent = ClickEvent
	self.targetView = targetView

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnBtnClick()
		self:OnSelectBtnClick()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnClick)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnClick)
end

function m:SetData()
	return
end

function m:SetSelectState(state)
	LuaUtility.SetGameObjectShow(self.On, state)
	LuaUtility.SetGameObjectShow(self.Off, not state)
end

function m:SetLockState(state)
	if self.LockState then
		LuaUtility.SetGameObjectShow(self.LockState, state)
	end
end

function m:OnSelectBtnClick()
	if self.ClickEvent ~= nil then
		self.ClickEvent()
	end
end

function m:SetTargetViewHide()
	self:SetTargetViewState(false)
end

function m:SetTargetViewState(state)
	if state then
		self.targetView:Show()
	else
		self.targetView:Hide()
	end
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	if self.targetView then
		self.targetView:Dispose()
	end

	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
