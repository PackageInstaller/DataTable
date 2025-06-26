-- chunkname: @IQIGame\\UI\\Common\\PopupList\\UIPopupList.lua

local UIPopupListPopupView = require("IQIGame.UI.Common.PopupList.UIPopupListPopupView")
local UIPopupList = {
	SelectIndex = -1
}

function UIPopupList.New(view, btnController, itemController, selectChangeEvent)
	local obj = Clone(UIPopupList)

	obj:__Init(view, btnController, itemController, selectChangeEvent)

	return obj
end

function UIPopupList:__Init(view, btnController, itemController, selectChangeEvent)
	self.gameObject = view
	self.onSelectChangeEvent = selectChangeEvent

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.btnController = btnController.New(self.PopupButton, function()
		self:__OnShowPopup()
	end)
	self.popupView = UIPopupListPopupView.New(self.PopupPanel, self, itemController, function(_index)
		self:__OnPopupItemSelectEventHandler(_index)
	end)

	self:__AddListeners()
end

function UIPopupList:__AddListeners()
	return
end

function UIPopupList:__RemoveListeners()
	return
end

function UIPopupList:Dispose()
	self:__RemoveListeners()
	self.btnController:Dispose()
	self.popupView:Dispose()

	self.PopupsData = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function UIPopupList:SetData(popupsData, selectIndex, isNotice)
	self.gameObject:SetActive(true)

	self.PopupsData = popupsData
	self.SelectIndex = selectIndex

	self:__OnChangeSelectShow(isNotice)
end

function UIPopupList:Hide()
	self.gameObject:SetActive(false)
end

function UIPopupList:SetStaticButtonData(staticBtnText, staticBtnIndex)
	self.popupView:SetStaticBtnData(staticBtnText, staticBtnIndex)
end

function UIPopupList:ShowNormal()
	self:__OnHidePopup()
end

function UIPopupList:GetSelectData()
	return self.PopupsData[self.SelectIndex]
end

function UIPopupList:ChangeSelect(index, isNotice)
	self.SelectIndex = index

	self:__OnChangeSelectShow(isNotice)
end

function UIPopupList:__OnChangeSelectShow(isNotice)
	self:__OnHidePopup()

	if not isNotice then
		return
	end

	if self.onSelectChangeEvent ~= nil then
		self.onSelectChangeEvent(self.SelectIndex)
	end
end

function UIPopupList:__OnShowPopup()
	if self.popupView.gameObject.activeSelf then
		self:__OnHidePopup()

		return
	end

	self.btnController:RefreshShow(self:GetSelectData(), true)
	self.popupView:Show()
end

function UIPopupList:__OnHidePopup()
	self.btnController:RefreshShow(self:GetSelectData(), false)
	self.popupView:Hide()
end

function UIPopupList:__OnPopupItemSelectEventHandler(index)
	self:ChangeSelect(index, true)
end

return UIPopupList
