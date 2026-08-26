-- chunkname: @modules/logic/room/view/critter/RoomCritterRenameView.lua

module("modules.logic.room.view.critter.RoomCritterRenameView", package.seeall)

local RoomCritterRenameView = class("RoomCritterRenameView", RoomLayoutInputBaseView)

function RoomCritterRenameView:_editableInitView()
	RoomCritterRenameView.super._editableInitView(self)

	self._txttips = gohelper.findChildText(self.viewGO, "tips/txt_tips")
end

function RoomCritterRenameView:_btnsureOnClick()
	local inputStr = self._inputsignature:GetText()

	if string.nilorempty(inputStr) then
		GameFacade.showToast(ToastEnum.RoomCritterRenameEmpty)

		return
	end

	if self._critterMO then
		RoomCritterController.instance:sendCritterRename(self._critterMO.id, inputStr)
	end
end

function RoomCritterRenameView:_getInputLimit()
	return CommonConfig.instance:getConstNum(ConstEnum.RoomCritterNameLimit)
end

function RoomCritterRenameView:_refreshInitUI()
	local critterMO = self.viewParam.critterMO

	self._critterMO = critterMO

	if critterMO then
		self._inputsignature:SetText(critterMO:getName())
	end

	self._txttitlecn.text = luaLang("room_critter_inputtip_rename_title")
	self._txttitleen.text = "RENAME"
	self._txttips.text = luaLang("room_critter_rename_fontcount_desc")
end

return RoomCritterRenameView
