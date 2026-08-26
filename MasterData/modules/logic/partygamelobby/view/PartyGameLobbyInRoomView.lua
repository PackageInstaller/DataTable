-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyInRoomView.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyInRoomView", package.seeall)

local PartyGameLobbyInRoomView = class("PartyGameLobbyInRoomView", BaseView)

function PartyGameLobbyInRoomView:onInitView()
	self._goFriend = gohelper.findChild(self.viewGO, "root/roomList/roomInfo/#go_Friend")
	self._btnexit = gohelper.findChildButtonWithAudio(self.viewGO, "root/roomList/roomInfo/#btn_exit")
	self._goheadicon = gohelper.findChild(self.viewGO, "root/roomList/roomInfo/#go_headicon")
	self._txtroom = gohelper.findChildText(self.viewGO, "root/roomList/roomInfo/#txt_room")
	self._btnarrow2 = gohelper.findChildButtonWithAudio(self.viewGO, "root/roomList/roomInfo/#btn_arrow2")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/roomList/roomInfo/layout/#txt_num")
	self._txttotal = gohelper.findChildText(self.viewGO, "root/roomList/roomInfo/layout/#txt_total")
	self._goExpand = gohelper.findChild(self.viewGO, "root/roomList/#go_Expand")
	self._btnCopy = gohelper.findChildButtonWithAudio(self.viewGO, "root/roomList/#go_Expand/#btn_Copy")
	self._txtnum2 = gohelper.findChildText(self.viewGO, "root/roomList/#go_Expand/#btn_Copy/#txt_num2")
	self._btninvite = gohelper.findChildButtonWithAudio(self.viewGO, "root/roomList/#go_Expand/Btn/#btn_invite")
	self._gogrey1 = gohelper.findChild(self.viewGO, "root/roomList/#go_Expand/Btn/#btn_invite/#go_grey1")
	self._golight1 = gohelper.findChild(self.viewGO, "root/roomList/#go_Expand/Btn/#btn_invite/#go_light1")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "root/roomList/#go_Expand/Btn/#btn_start")
	self._gogrey2 = gohelper.findChild(self.viewGO, "root/roomList/#go_Expand/Btn/#btn_start/#go_grey2")
	self._golight2 = gohelper.findChild(self.viewGO, "root/roomList/#go_Expand/Btn/#btn_start/#go_light2")
	self._btnprepare = gohelper.findChildButtonWithAudio(self.viewGO, "root/roomList/#go_Expand/Btn/#btn_prepare")
	self._golight3 = gohelper.findChild(self.viewGO, "root/roomList/#go_Expand/Btn/#btn_prepare/#go_light3")
	self._btncancelprepare = gohelper.findChildButtonWithAudio(self.viewGO, "root/roomList/#go_Expand/Btn/#btn_cancelprepare")
	self._golight4 = gohelper.findChild(self.viewGO, "root/roomList/#go_Expand/Btn/#btn_cancelprepare/#go_light4")
	self._btnarrow = gohelper.findChildButtonWithAudio(self.viewGO, "root/roomList/#go_Expand/#btn_arrow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PartyGameLobbyInRoomView:addEvents()
	self._btnexit:AddClickListener(self._btnexitOnClick, self)
	self._btnarrow2:AddClickListener(self._btnarrow2OnClick, self)
	self._btnCopy:AddClickListener(self._btnCopyOnClick, self)
	self._btninvite:AddClickListener(self._btninviteOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnprepare:AddClickListener(self._btnprepareOnClick, self)
	self._btncancelprepare:AddClickListener(self._btncancelprepareOnClick, self)
	self._btnarrow:AddClickListener(self._btnarrowOnClick, self)
end

function PartyGameLobbyInRoomView:removeEvents()
	self._btnexit:RemoveClickListener()
	self._btnarrow2:RemoveClickListener()
	self._btnCopy:RemoveClickListener()
	self._btninvite:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self._btnprepare:RemoveClickListener()
	self._btncancelprepare:RemoveClickListener()
	self._btnarrow:RemoveClickListener()
end

function PartyGameLobbyInRoomView:_btnarrow2OnClick()
	self:_changeExpand()
end

function PartyGameLobbyInRoomView:_btnarrowOnClick()
	self:_changeExpand()
end

function PartyGameLobbyInRoomView:_changeExpand()
	self._isExpanded = not self._isExpanded
	self._expandCanvas.interactable = self._isExpanded
	self._expandCanvas.blocksRaycasts = self._isExpanded
	self._animator.enabled = true

	self._animator:Play(self._isExpanded and "unfold" or "fold")
	gohelper.setActive(self._btnarrow2, not self._isExpanded)
	gohelper.setActive(self._btnarrow, self._isExpanded)
end

function PartyGameLobbyInRoomView:_btncancelprepareOnClick()
	PartyRoomRpc.instance:sendChangePartyRoomStatusRequest(PlayerModel.instance:getMyUserId(), PartyGameRoomModel.instance:getRoomId(), PartyGameLobbyEnum.RoomOperateState.NotReady)
end

function PartyGameLobbyInRoomView:_btnexitOnClick()
	GameFacade.showOptionMessageBox(MessageBoxIdDefine.PartyGameLobbyTips5, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.NotShow, self._onExitPartyRoom, nil, nil, self)
end

function PartyGameLobbyInRoomView:_onExitPartyRoom()
	PartyRoomRpc.instance:sendExitPartyRoomRequest(PlayerModel.instance:getMyUserId(), PartyGameRoomModel.instance:getRoomId())
end

function PartyGameLobbyInRoomView:_btnCopyOnClick()
	ZProj.UGUIHelper.CopyText(self._txtnum2.text)
	GameFacade.showToast(ToastEnum.ClickPlayerId)
end

function PartyGameLobbyInRoomView:_btninviteOnClick()
	PartyRoomRpc.instance:sendGetInviteListRequest(PlayerModel.instance:getMyUserId(), PartyGameRoomModel.instance:getRoomId())
end

function PartyGameLobbyInRoomView:_btnstartOnClick()
	if not self:_isAllReady() then
		GameFacade.showToast(ToastEnum.ParyGameNotAllReady)

		return
	end

	PartyMatchRpc.instance:sendStartPartyMatchRequest(PlayerModel.instance:getMyUserId(), PartyGameRoomModel.instance:getRoomId())
end

function PartyGameLobbyInRoomView:_isAllReady()
	return PartyGameRoomModel.instance:isAllReady()
end

function PartyGameLobbyInRoomView:_btnprepareOnClick()
	PartyRoomRpc.instance:sendChangePartyRoomStatusRequest(PlayerModel.instance:getMyUserId(), PartyGameRoomModel.instance:getRoomId(), PartyGameLobbyEnum.RoomOperateState.Ready)
end

function PartyGameLobbyInRoomView:_editableInitView()
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.KickOutPlayer, self._onKickOutPlayer, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.PartyRoomInfoPush, self._onPartyRoomInfoPush, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.ChangePartyRoomStatus, self._onChangePartyRoomStatus, self)
	NavigateMgr.instance:addEscape(self.viewName, self._btnexitOnClick, self)

	self._isExpanded = true
	self._animator = self.viewGO:GetComponent("Animator")
	self._expandCanvas = self._goExpand:GetComponent(typeof(UnityEngine.CanvasGroup))
end

function PartyGameLobbyInRoomView:_onKickOutPlayer()
	self:_updateNum()
	self:_updateBtnStatus()
end

function PartyGameLobbyInRoomView:_onChangePartyRoomStatus()
	self:_updateBtnStatus()
end

function PartyGameLobbyInRoomView:_onPartyRoomInfoPush()
	self:_updateNum()
	self:_updateBtnStatus()

	local diffMap = PartyGameRoomModel.instance:getDiffMap()
	local socialFriendModel = SocialListModel.instance:getModel(SocialEnum.Type.Friend)

	for id, v in pairs(diffMap) do
		local mo = socialFriendModel:getById(id)

		if mo then
			PartyGameLobbyController.instance:showNewPlayerEnterTip(id)
		end
	end

	PartyGameRoomModel.instance:clearDiffMap()
end

function PartyGameLobbyInRoomView:_updateBtnStatus()
	local myPlayerInfo = PartyGameRoomModel.instance:getMyPlayerInfo()
	local isRoomOwner = myPlayerInfo.isRoomOwner
	local isReady = myPlayerInfo.status == PartyGameLobbyEnum.RoomOperateState.Ready

	gohelper.setActive(self._btnstart, isRoomOwner)
	gohelper.setActive(self._btnprepare, not isReady and not isRoomOwner)
	gohelper.setActive(self._btncancelprepare, isReady and not isRoomOwner)

	if isRoomOwner then
		local isAllReady = self:_isAllReady()

		gohelper.setActive(self._gogrey2, not isAllReady)
		gohelper.setActive(self._golight2, isAllReady)
	end
end

function PartyGameLobbyInRoomView:onOpen()
	self._txtnum2.text = PartyGameRoomModel.instance:getRoomId()
	self._txttotal.text = PartyGameLobbyEnum.MaxPlayerCount

	self:_updateNum()
	self:_updateBtnStatus()
end

function PartyGameLobbyInRoomView:_updateNum()
	local num = PartyGameRoomModel.instance:getPlayerNum()

	self._txtnum.text = num
	self._btninvite.button.interactable = num < PartyGameLobbyEnum.MaxPlayerCount
end

function PartyGameLobbyInRoomView:onClose()
	return
end

function PartyGameLobbyInRoomView:onDestroyView()
	return
end

return PartyGameLobbyInRoomView
