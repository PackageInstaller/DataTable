-- chunkname: @IQIGame\\UI\\Common\\PopupListExtend\\StrengthenPopupListItem.lua

local UIPopupListItem = require("IQIGame.UI.Common.PopupList.UIPopupListItem")
local StrengthenPopupListItem = Clone(UIPopupListItem)

function StrengthenPopupListItem.New(view, clickEvent)
	local obj = Clone(StrengthenPopupListItem)

	obj:__Init(view, clickEvent)

	return obj
end

function StrengthenPopupListItem:ExtendShowFunc(_data, _isSelect)
	self.Checkmark:SetActive(_isSelect)
	UGUIUtil.SetText(self.Text, UIGlobalApi.GetStrengthenPopupListItemText(_isSelect, _data))
end

return StrengthenPopupListItem
