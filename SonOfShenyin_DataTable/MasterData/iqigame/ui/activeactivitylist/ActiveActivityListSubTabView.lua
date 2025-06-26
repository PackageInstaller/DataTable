-- chunkname: @IQIGame\\UI\\ActiveActivityList\\ActiveActivityListSubTabView.lua

local m = {}

function m.New(view, onClickEvent)
	local obj = Clone(m)

	obj:Init(view, onClickEvent)

	return obj
end

function m:Init(view, onClickEvent)
	self.View = view
	self.OnClickEvent = onClickEvent

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickBtn()
		self:OnClickBtn()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtn)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtn)
end

function m:SetData(tabCfg)
	self.cfgID = tabCfg.Id
	self.cfg = tabCfg

	UGUIUtil.SetText(self.selectSubActivityName, self.cfg.Name)
	UGUIUtil.SetText(self.unSelectSubActivityName, self.cfg.Name)
end

function m:RefreshRedDot()
	LuaUtility.SetGameObjectShow(self.RedDot, ActiveActivityListModule.GetRedDotTypeByType(self.cfg))
end

function m:OnClickBtn()
	if self.OnClickEvent ~= nil then
		self.OnClickEvent(self.cfgID)
		self:OnSelected()
	end
end

function m:OnSelected()
	LuaUtility.SetGameObjectShow(self.Select, true)
	LuaUtility.SetGameObjectShow(self.UnSelect, false)
end

function m:OnUnSelected()
	LuaUtility.SetGameObjectShow(self.Select, false)
	LuaUtility.SetGameObjectShow(self.UnSelect, true)
end

function m:GetCfgID()
	return self.cfgID
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
