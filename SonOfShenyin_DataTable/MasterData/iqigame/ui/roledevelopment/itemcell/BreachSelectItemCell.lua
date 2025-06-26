-- chunkname: @IQIGame\\UI\\RoleDevelopment\\ItemCell\\BreachSelectItemCell.lua

local m = {}

function m.New(view, gridIndex)
	local obj = Clone(m)

	obj:Init(view, gridIndex)

	return obj
end

function m:Init(view, gridIndex)
	self.View = view
	self.GridIndex = gridIndex

	LuaCodeInterface.BindOutlet(self.View, self)

	self.MaterialItemCell = ItemCell.New(self.ItemSlot, false)

	LuaUtility.SetGameObjectShow(self.ItemSlot, false)

	function self.DelegateOnClickSelectBtn()
		self:OnSelect()
	end

	self.instanceID = nil

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelectBtn)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelectBtn)
end

function m:SetData(itemData, instanceID)
	self.ItemData = itemData
	self.instanceID = instanceID

	self.MaterialItemCell:SetItem(self.ItemData)
	LuaUtility.SetGameObjectShow(self.ItemSlot, true)
	LuaUtility.SetGameObjectShow(self.BottomImg, false)
end

function m:OnSelect()
	EventDispatcher.Dispatch(EventID.DiySkillSelectMaterialItemEvent)
end

function m:InitState()
	LuaUtility.SetGameObjectShow(self.BottomImg, true)
	LuaUtility.SetGameObjectShow(self.ItemSlot, false)

	self.instanceID = nil
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
