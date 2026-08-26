-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyAddRoomView.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyAddRoomView", package.seeall)

local PartyGameLobbyAddRoomView = class("PartyGameLobbyAddRoomView", BaseView)

function PartyGameLobbyAddRoomView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btnexit = gohelper.findChildButtonWithAudio(self.viewGO, "root/go_addRoom/#btn_exit")
	self._btninput = gohelper.findChildButtonWithAudio(self.viewGO, "root/go_addRoom/#btn_input")
	self._inputinform = gohelper.findChildInputField(self.viewGO, "root/go_addRoom/#btn_input/#input_inform")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "root/go_addRoom/#btn_add")
	self._gogrey = gohelper.findChild(self.viewGO, "root/go_addRoom/#btn_add/#go_grey")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PartyGameLobbyAddRoomView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnexit:AddClickListener(self._btnexitOnClick, self)
	self._btninput:AddClickListener(self._btninputOnClick, self)
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
end

function PartyGameLobbyAddRoomView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnexit:RemoveClickListener()
	self._btninput:RemoveClickListener()
	self._btnadd:RemoveClickListener()
end

function PartyGameLobbyAddRoomView:_btncloseOnClick()
	self:closeThis()
	PartyGameLobbyController.instance:setRoomState(PartyGameLobbyEnum.RoomState.None)
end

function PartyGameLobbyAddRoomView:_btnexitOnClick()
	self:closeThis()
	PartyGameLobbyController.instance:setRoomState(PartyGameLobbyEnum.RoomState.None)
end

function PartyGameLobbyAddRoomView:_btninputOnClick()
	return
end

function PartyGameLobbyAddRoomView:_btnaddOnClick()
	local txt = self._inputinform:GetText()
	local roomId = tonumber(txt) or 1

	PartyRoomRpc.instance:simpleJoinPartyRoomReq(roomId)
end

function PartyGameLobbyAddRoomView:_editableInitView()
	self._inputinform = gohelper.findChildTextMeshInputField(self.viewGO, "root/go_addRoom/#btn_input/#input_inform")

	NavigateMgr.instance:addEscape(self.viewName, self._btnexitOnClick, self)
end

function PartyGameLobbyAddRoomView:_onValueChanged()
	local txt = self._inputinform:GetText()

	gohelper.setActive(self._gogrey, string.len(txt) <= 0)
end

function PartyGameLobbyAddRoomView:onOpen()
	self._inputinform:AddOnValueChanged(self._onValueChanged, self)
	self:_onValueChanged()
end

function PartyGameLobbyAddRoomView:onClose()
	self._inputinform:RemoveOnValueChanged()
end

function PartyGameLobbyAddRoomView:onDestroyView()
	return
end

return PartyGameLobbyAddRoomView
