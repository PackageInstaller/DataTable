-- chunkname: @modules/logic/room/view/layout/RoomLayoutFindShareView.lua

module("modules.logic.room.view.layout.RoomLayoutFindShareView", package.seeall)

local RoomLayoutFindShareView = class("RoomLayoutFindShareView", RoomLayoutInputBaseView)

function RoomLayoutFindShareView:_editableInitView()
	RoomLayoutFindShareView.super._editableInitView(self)
	gohelper.setActive(gohelper.findChildText(self.viewGO, "tips/txt_tips"), false)
end

function RoomLayoutFindShareView:_btnsureOnClick()
	local inputStr = self._inputsignature:GetText()

	if string.nilorempty(inputStr) then
		GameFacade.showToast(RoomEnum.Toast.LayoutShareCodeEmpty)

		return
	end

	RoomLayoutController.instance:sendGetShareCodeRpc(inputStr)
end

function RoomLayoutFindShareView:_refreshInitUI()
	self._txtinputlang.text = luaLang("room_layoutplan_input_sharecode_tip")
	self._txtbtnsurecn.text = luaLang("room_layoutplan_create_sharecode_map")
	self._txtbtnsureed.text = luaLang("room_layoutplan_create_sharecode_map_en")
	self._txttitlecn.text = luaLang("room_layoutplan_use_sharecode_title")
	self._txttitleen.text = luaLang("room_layoutplan_use_sharecode_title_en")
end

function RoomLayoutFindShareView:_checkLimit()
	local inputValue = self._inputsignature:GetText()
	local inputStr = string.gsub(inputValue, "[^a-zA-Z0-9]", "")
	local limit = RoomEnum.LayoutPlanShareCodeLimit
	local newInput = GameUtil.utf8sub(inputStr, 1, math.min(GameUtil.utf8len(inputStr), limit))

	if newInput ~= inputValue then
		self._inputsignature:SetText(newInput)
	end
end

function RoomLayoutFindShareView:_onInputNameValueChange()
	self:_checkLimit()
end

return RoomLayoutFindShareView
