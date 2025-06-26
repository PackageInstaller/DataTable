-- chunkname: @IQIGame\\UI\\Common\\CommonSortingPopupListView.lua

local UIPopupList = require("IQIGame.UI.Common.PopupList.UIPopupList")
local UIPopupListPopupBtn = require("IQIGame.UI.Common.PopupList.UIPopupListPopupBtn")
local UIPopupListItem = require("IQIGame.UI.Common.PopupList.UIPopupListItem")
local ListItem = Clone(UIPopupListItem)

function ListItem.New(view, clickEvent)
	local obj = Clone(ListItem)

	obj:__Init(view, clickEvent)

	return obj
end

function ListItem:ExtendShowFunc(_data, _isSelect)
	self.Checkmark:SetActive(_isSelect)
	UGUIUtil.SetText(self.Text, UIGlobalApi.GetPopupListItemText(_isSelect, _data))
end

local PopupButton = Clone(UIPopupListPopupBtn)

function PopupButton.New(view, clickEventHandler)
	local obj = Clone(PopupButton)

	obj:__Init(view, clickEventHandler)

	return obj
end

function PopupButton:ExtendShowFunc(data, isSelect)
	if isSelect then
		self.NormalState:SetActive(false)
		self.SelectState:SetActive(true)
	else
		self.NormalState:SetActive(true)
		self.SelectState:SetActive(false)
	end

	local text = LuaUtility.StrIsNullOrEmpty(data) and UIGlobalApi.GetPopupListEmptyText() or data

	UGUIUtil.SetText(self.DescText, UIGlobalApi.GetPopupListButtonText(isSelect, text))
end

local CommonSortingPopupListView = Clone(UIPopupList)

function CommonSortingPopupListView.New(view, selectChangeEvent)
	local obj = Clone(CommonSortingPopupListView)

	obj:__Init(view, PopupButton, ListItem, selectChangeEvent)

	return obj
end

function CommonSortingPopupListView.GetEquipSortingData()
	return CommonSortingPopupListApi:GetEquipSortingData()
end

function CommonSortingPopupListView.GetSkillSortingData()
	return CommonSortingPopupListApi:GetSkillSortingData()
end

function CommonSortingPopupListView.GetItemSortingData()
	return CommonSortingPopupListApi:GetItemSortingData()
end

function CommonSortingPopupListView.GetRoleSortingData()
	return CommonSortingPopupListApi:GetRoleSortingData()
end

return CommonSortingPopupListView
