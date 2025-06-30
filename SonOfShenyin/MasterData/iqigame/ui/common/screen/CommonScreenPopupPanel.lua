-- chunkname: @IQIGame\\UI\\Common\\Screen\\CommonScreenPopupPanel.lua

local LeftContent = require("IQIGame/UI/Common/Screen/CommonScreenPopupLeftContent")
local RightContent = require("IQIGame/UI/Common/Screen/CommonScreenPopupRightContent")
local Panel = {
	selectSubScreenType = 0
}

function Panel.New(view, callback, resetHandler)
	local obj = Clone(Panel)

	obj:__Init(view, callback, resetHandler)

	return obj
end

function Panel:__Init(view, callback, resetHandler)
	self.gameObject = view
	self.callback = callback
	self.resetHandler = resetHandler

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:__InitDelegateFun()

	self.leftContent = LeftContent.New(self.leftContentGo, function(_subType, _value)
		self:__OnChoiceItemSelect(_subType, _value)
	end)
	self.rightContent = RightContent.New(self.rightContentGo, function(value)
		self:__OnSubScreenTypeValueSelect(value)
	end)

	self:__AddListener()
end

function Panel:__InitDelegateFun()
	function self.__OnCloseBGBtnClickEventProxy()
		self:Hide()
	end

	function self.__OnCloseBtnClickEventProxy()
		self:Hide()
	end

	function self.__OnResetBtnClickEventProxy()
		if self.resetHandler ~= nil then
			self.resetHandler()
		end
	end

	function self.__OnOkBtnClickEventProxy()
		if self.callback ~= nil then
			self.callback(self.screenData)
		end

		self:Hide()
	end
end

function Panel:__AddListener()
	self.closeBG:GetComponent("Button").onClick:AddListener(self.__OnCloseBGBtnClickEventProxy)
	self.resetBtn:GetComponent("Button").onClick:AddListener(self.__OnResetBtnClickEventProxy)
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.__OnCloseBtnClickEventProxy)
	self.okBtn:GetComponent("Button").onClick:AddListener(self.__OnOkBtnClickEventProxy)
end

function Panel:__RemoveListener()
	self.closeBG:GetComponent("Button").onClick:RemoveListener(self.__OnCloseBGBtnClickEventProxy)
	self.resetBtn:GetComponent("Button").onClick:RemoveListener(self.__OnResetBtnClickEventProxy)
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.__OnCloseBtnClickEventProxy)
	self.okBtn:GetComponent("Button").onClick:RemoveListener(self.__OnOkBtnClickEventProxy)
end

function Panel:Show(screenData)
	self.gameObject:SetActive(true)

	self.screenData = Clone(screenData)

	self.leftContent:Show(self.screenData)
	ForPairs(self.screenData.itemsTable, function(_subScreenType, _)
		self:__RefreshRightContent(_subScreenType)

		return true
	end)
end

function Panel:Hide()
	self.gameObject:SetActive(false)
end

function Panel:Dispose()
	self:__RemoveListener()
	self.leftContent:Dispose()
	self.rightContent:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function Panel:__OnChoiceItemSelect(subType, value)
	self:__RefreshRightContent(subType)
end

function Panel:__OnSubScreenTypeValueSelect(value)
	local screenItemData = self.screenData.itemsTable[self.selectSubScreenType]

	if not screenItemData:SetValue(value) then
		return
	end

	self.leftContent:RefreshScreenItem(self.selectSubScreenType, screenItemData)
	self.rightContent:UpdateSelect(screenItemData)
end

function Panel:__RefreshRightContent(subScreenType)
	self.selectSubScreenType = subScreenType

	local data = self.screenData.itemsTable[self.selectSubScreenType]

	self.rightContent:Show(self.screenData.screenType, data)
	self.leftContent:RefreshChoiceItemSelectTag(subScreenType)
end

return Panel
