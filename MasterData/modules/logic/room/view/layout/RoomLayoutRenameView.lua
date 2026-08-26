-- chunkname: @modules/logic/room/view/layout/RoomLayoutRenameView.lua

module("modules.logic.room.view.layout.RoomLayoutRenameView", package.seeall)

local RoomLayoutRenameView = class("RoomLayoutRenameView", RoomLayoutInputBaseView)

function RoomLayoutRenameView:_btnsureOnClick()
	local inputStr = self._inputsignature:GetText()

	if string.nilorempty(inputStr) then
		GameFacade.showToast(RoomEnum.Toast.LayoutRenameEmpty)

		return
	end

	if self._layoutMO then
		RoomLayoutController.instance:sendSetRoomPlanNameRpc(self._layoutMO.id, inputStr)
	end
end

function RoomLayoutRenameView:_refreshInitUI()
	local layoutMO = RoomLayoutListModel.instance:getSelectMO()

	self._layoutMO = layoutMO

	if layoutMO then
		self._inputsignature:SetText(layoutMO:getName())
	end

	self._txttitlecn.text = luaLang("room_layoutplan_rename_title")
	self._txttitleen.text = "RENAME"
end

return RoomLayoutRenameView
