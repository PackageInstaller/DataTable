-- chunkname: @IQIGame\\UI\\ActiveWeekend\\NewPlayerGrowUp\\TabLeftCell.lua

local TabLeftCell = {}

function TabLeftCell.New(view)
	local obj = Clone(TabLeftCell)

	obj:Init(view)

	return obj
end

function TabLeftCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.toggleHelper = self.View:GetComponent("ToggleHelperComponent")

	self:OnAddListeners()
end

function TabLeftCell:Refresh(index, weekIndex)
	self.index = index
	self.weekIndex = weekIndex

	self:RefreshMisc()
end

function TabLeftCell:OnHide()
	return
end

function TabLeftCell:OnDestroy()
	self:OnRemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function TabLeftCell:OnAddListeners()
	return
end

function TabLeftCell:OnRemoveListeners()
	return
end

function TabLeftCell:RefreshMisc()
	self.toggleHelper.text = ActiveWeekendUIApi:GetString("growUpViewTabLeftTxt", self.index)

	local showRedPoint = ActiveWeekendModule.CheckRedPointOnGrowDay(self.weekIndex, self.index)

	self.toggleHelper.transform:Find("goDown/RedPoint").gameObject:SetActive(showRedPoint)
	self.toggleHelper.transform:Find("goUp/RedPoint").gameObject:SetActive(showRedPoint)
end

return TabLeftCell
