-- chunkname: @IQIGame\\UI\\Common\\PopupListExtend\\StrengthenPopupListBtn.lua

local UIPopupListPopupBtn = require("IQIGame.UI.Common.PopupList.UIPopupListPopupBtn")
local StrengthenPopupListBtn = Clone(UIPopupListPopupBtn)

function StrengthenPopupListBtn.New(view, clickEventHandler)
	local obj = Clone(StrengthenPopupListBtn)

	obj:__Init(view, clickEventHandler)

	return obj
end

function StrengthenPopupListBtn:ExtendShowFunc(data, isSelect)
	if isSelect then
		self.NormalState:SetActive(false)
		self.SelectState:SetActive(true)
	else
		self.NormalState:SetActive(true)
		self.SelectState:SetActive(false)
	end

	local text = LuaUtility.StrIsNullOrEmpty(data) and UIGlobalApi.GetPopupListEmptyText() or data

	UGUIUtil.SetText(self.DescText, UIGlobalApi.GetStrengthenPopupListButtonText(isSelect, text))
end

return StrengthenPopupListBtn
