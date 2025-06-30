-- chunkname: @IQIGame\\UI\\ActiveWeekend\\TabTopCell.lua

local TabTopCell = {}

function TabTopCell.New(view, mainView)
	local obj = Clone(TabTopCell)

	obj:Init(view, mainView)

	return obj
end

function TabTopCell:Init(view, mainView)
	self.View = view
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)

	self.toggle = self.View:GetComponent("Toggle")

	function self.onClickToggleDelegate(isOn)
		self:OnClickToggle(isOn)
	end

	self.signRedPoint1 = self.toggle.transform:Find("goDown/RedPoint").gameObject
	self.signRedPoint2 = self.toggle.transform:Find("goUp/RedPoint").gameObject

	self:OnAddListeners()
end

function TabTopCell:Open(index, defaultIndex)
	self.index = index

	self.View:SetActive(true)

	self.toggle.interactable = ActiveWeekendModule.CheckTopToggleCanClick(self.index)
	self.toggle.isOn = self.index == defaultIndex

	self:RefreshMisc()
	self:RefreshRedPoint()
end

function TabTopCell:Close()
	self.toggle.isOn = false

	self:OnHide()
	self.View:SetActive(false)
end

function TabTopCell:OnHide()
	return
end

function TabTopCell:OnDestroy()
	self.mainView = nil

	self:OnRemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function TabTopCell:OnAddListeners()
	self.toggle.onValueChanged:AddListener(self.onClickToggleDelegate)
end

function TabTopCell:OnRemoveListeners()
	self.toggle.onValueChanged:RemoveListener(self.onClickToggleDelegate)
end

function TabTopCell:OnClickToggle(isOn)
	if isOn then
		self.mainView:OnClickTabTop(self.index)
	end
end

function TabTopCell:RefreshMisc()
	self.View:GetComponent("ToggleHelperComponent").text = ActiveWeekendUIApi:GetString("tabTopTxt", self.index)
end

function TabTopCell:RefreshRedPoint()
	if self.index == 1 or self.index == 2 then
		local showRedPoint = ActiveWeekendModule.CheckRedPointOnWeek(self.index)

		self.signRedPoint1:SetActive(showRedPoint)
		self.signRedPoint2:SetActive(showRedPoint)
	end
end

return TabTopCell
