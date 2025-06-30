-- chunkname: @IQIGame\\UI\\Common\\Screen\\CommonScreenControllerView.lua

local CommonSortingPopupListView = require("IQIGame.UI.Common.CommonSortingPopupListView")
local CommonScreenPopupPanel = require("IQIGame/UI/Common/Screen/CommonScreenPopupPanel")
local m = {
	sortIndex = 0,
	ascending = true
}

function m.New(view, changeHandler)
	local obj = Clone(m)

	obj:__Init(view, changeHandler)

	return obj
end

function m:__Init(view, changeHandler)
	self.gameObject = view
	self.changeCallback = changeHandler

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:__InitEventDelegate()
	self.btn:GetComponent("Button").onClick:AddListener(self.__OnShowScreenBtnClickEventProxy)
	self.orderButton:GetComponent("Button").onClick:AddListener(self.__OnOrderBtnClickEventProxy)
	self.orderButton.gameObject:SetActive(false)

	self.sortPopupList = CommonSortingPopupListView.New(self.sortPopup, function(_index)
		self:__OnSortingTypeChange(_index)
	end)

	self.sortPopupList:Hide()

	if self.screenPopup ~= nil then
		self.screenPopupPanel = CommonScreenPopupPanel.New(self.screenPopup, function(_screenData)
			self:__OnScreenValueChange(_screenData)
		end, function()
			self:__OnResetScreenValue()
		end)

		self.screenPopupPanel:Hide()
	end
end

function m:__InitEventDelegate()
	function self.__OnShowScreenBtnClickEventProxy()
		if self.refreshEquipSuitData then
			EquipModule.CalculateCurrentSuitNumListWithPartIndex(0)
		end

		self.screenPopupPanel:Show(self.screenData)
	end

	function self.__OnOrderBtnClickEventProxy()
		self:__OnSortOrderChange()
	end
end

function m:SetSortPopupData(popupsData, selectIndex)
	self.sortIndex = selectIndex

	self.sortPopupList:SetData(popupsData, selectIndex, false)
end

function m:SetSortOrderData(ascending)
	self.ascending = ascending

	self.orderButton.gameObject:SetActive(true)
end

function m:ResetSortPopupIndex(index, isNotice)
	self.sortPopupList:ChangeSelect(index, isNotice)
end

function m:SetScreenPopupData(screenData, refreshEquipSuitData)
	self.screenData = screenData
	self.refreshEquipSuitData = refreshEquipSuitData

	if self.screenData == nil then
		self.btn.gameObject:SetActive(false)
	else
		self.btn.gameObject:SetActive(true)
		self.screenData:UpdateValueTable()
	end
end

function m:__OnSortingTypeChange(index)
	self.sortIndex = index

	self:__ExecuteChangeCallback(true)
end

function m:__OnSortOrderChange()
	self.ascending = not self.ascending

	self:__ExecuteChangeCallback(true)
end

function m:__OnScreenValueChange(screenData)
	self.screenData = screenData

	self.screenData:UpdateValueTable()
	self.changeCallback(false)
end

function m:__OnResetScreenValue()
	if self.resetScreenDataEvent ~= nil then
		self.screenData = self.resetScreenDataEvent()
	end

	self.screenPopupPanel:Show(self.screenData)
end

function m:__ExecuteChangeCallback(isSortChange)
	if self.changeCallback == nil then
		return
	end

	self.changeCallback(isSortChange)
end

function m:Dispose()
	self.btn:GetComponent("Button").onClick:RemoveListener(self.__OnShowScreenBtnClickEventProxy)
	self.orderButton:GetComponent("Button").onClick:RemoveListener(self.__OnOrderBtnClickEventProxy)
	self.sortPopupList:Dispose()

	if self.screenPopupPanel ~= nil then
		self.screenPopupPanel:Dispose()
	end
end

return m
