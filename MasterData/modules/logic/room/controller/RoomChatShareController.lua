-- chunkname: @modules/logic/room/controller/RoomChatShareController.lua

module("modules.logic.room.controller.RoomChatShareController", package.seeall)

local RoomChatShareController = class("RoomChatShareController", BaseController)

function RoomChatShareController:onInit()
	self:clear()
end

function RoomChatShareController:reInit()
	self:clear()
end

function RoomChatShareController:clear()
	return
end

function RoomChatShareController:chatSeekShare(socialMessageMO)
	local isOpen = RoomLayoutController.instance:isOpen()

	if not isOpen then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanShareCodeNotOpen)

		return
	end

	if RoomLayoutModel.instance:isNeedRpcGet() then
		RoomRpc.instance:sendGetRoomPlanInfoRequest(self._onPlanInfoChatSeekShare, self)

		return
	end

	self._seekShareMsgMO = socialMessageMO

	self:_chatSeekShare()
end

function RoomChatShareController:_onPlanInfoChatSeekShare(cmd, resultCode, msg)
	if resultCode == 0 then
		self:_chatSeekShare()
	end
end

function RoomChatShareController:_chatSeekShare()
	local layoutMO = RoomLayoutModel.instance:getById(RoomEnum.LayoutUsedPlanId)

	if layoutMO:isSharing() then
		self:_sendChatSeekShare()

		return
	end

	if layoutMO:isEmpty() or not layoutMO:haveEdited() then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanNotCanShare)

		return
	end

	local canShareCount = RoomLayoutModel.instance:getCanShareCount()

	if canShareCount <= 0 then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanShareCodeNotNum)

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.RoomLayoutPlanCanShareCount, MsgBoxEnum.BoxType.Yes_No, self._sendShareRoomPlanRequest, nil, nil, self, nil, nil, canShareCount)
end

function RoomChatShareController:_sendShareRoomPlanRequest()
	RoomRpc.instance:sendShareRoomPlanRequest(RoomEnum.LayoutUsedPlanId, self._onShareRoomPlanReply, self)
end

function RoomChatShareController:_onShareRoomPlanReply(cmd, resultCode, msg)
	if resultCode == 0 then
		self:_sendChatSeekShare()
	end
end

function RoomChatShareController:_sendChatSeekShare()
	if not self._seekShareMsgMO then
		return
	end

	local layoutMO = RoomLayoutModel.instance:getById(0)

	if layoutMO:isSharing() then
		local info = self._seekShareMsgMO

		self._seekShareMsgMO = nil

		local extData = layoutMO:getShareCode()
		local msgType = ChatEnum.MsgType.RoomShareCode
		local sendValue = formatLuaLang("room_chat_share_code_content", extData)

		ChatRpc.instance:sendSendMsgRequest(info.channelType, info.senderId, sendValue, msgType, extData)
	end
end

function RoomChatShareController:chatShareCode(socialMessageMO)
	RoomLayoutController.instance:copyShareCodeTxt(socialMessageMO.extData)
end

RoomChatShareController.instance = RoomChatShareController.New()

return RoomChatShareController
