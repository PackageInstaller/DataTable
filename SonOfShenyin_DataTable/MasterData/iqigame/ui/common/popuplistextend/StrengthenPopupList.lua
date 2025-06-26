-- chunkname: @IQIGame\\UI\\Common\\PopupListExtend\\StrengthenPopupList.lua

local UIPopupList = require("IQIGame.UI.Common.PopupList.UIPopupList")
local UIPopupListPopupBtn = require("IQIGame/UI/Common/PopupListExtend/StrengthenPopupListBtn")
local ListItem = require("IQIGame/UI/Common/PopupListExtend/StrengthenPopupListItem")
local StrengthenSortingPopupList = Clone(UIPopupList)

function StrengthenSortingPopupList.New(view, selectChangeEvent)
	local obj = Clone(StrengthenSortingPopupList)

	obj:__Init(view, UIPopupListPopupBtn, ListItem, selectChangeEvent)

	return obj
end

return StrengthenSortingPopupList
