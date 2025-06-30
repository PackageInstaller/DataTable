-- chunkname: @IQIGame\\UI\\RoleInfoDetails\\RoleDeedsItemCell.lua

local m = {
	isOpen = true
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:InitDelegate()
	self:AddListeners()
end

function m:InitDelegate()
	function self.DelegateSelectBtn()
		self:OnSelect()
	end
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateSelectBtn)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateSelectBtn)
end

function m:SetData(data, heroCid)
	self.data = data

	self:RemoveSelectListen()
	self:SetUnSelectShow()
	LuaUtility.SetGameObjectShow(self.normalState, ConditionModule.Check(self.data.Condition))
	LuaUtility.SetGameObjectShow(self.lockState, not ConditionModule.Check(self.data.Condition))
	LuaUtility.SetText(self.descTitleText, self.data.TitleName)
	LuaUtility.SetText(self.contentText, self.data.Story)

	if self.data.Condition > 0 then
		LuaUtility.SetText(self.lockText, ConditionModule.GetDesc(self.data.Condition))
	end
end

function m:OnSelect()
	if not ConditionModule.Check(self.data.Condition) then
		return
	end

	net_favorable.viewDeed(self.data.Id, self.data.HeroId)
	self:RemoveSelectListen()

	function self.selectCallBack()
		if self.isSelect then
			self:SetUnSelectShow()
		else
			self:SetSelectShow()
		end
	end

	EventDispatcher.AddEventListener(EventID.RoleDeedsSelect, self.selectCallBack)
end

function m:SetUnSelectShow()
	LuaUtility.SetGameObjectShow(self.bg, false)
	LuaUtility.SetGameObjectShow(self.contentText, false)
	LuaUtility.SetGameObjectShow(self.off, false)
	LuaUtility.SetGameObjectShow(self.on, true)

	self.isSelect = false
end

function m:SetSelectShow()
	LuaUtility.SetGameObjectShow(self.bg, true)
	LuaUtility.SetGameObjectShow(self.contentText, true)
	LuaUtility.SetGameObjectShow(self.off, true)
	LuaUtility.SetGameObjectShow(self.on, false)

	self.isSelect = true
end

function m:OnUnSelect()
	self.Info:SetActive(false)
	self.SelectImage:SetActive(false)
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
	self:RemoveSelectListen()
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function m:RemoveSelectListen()
	if self.selectCallBack then
		EventDispatcher.RemoveEventListenerByType(EventID.RoleDeedsSelect, self.selectCallBack)

		self.selectCallBack = nil
	end
end

return m
