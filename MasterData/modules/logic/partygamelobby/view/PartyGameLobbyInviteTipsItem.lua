-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyInviteTipsItem.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyInviteTipsItem", package.seeall)

local PartyGameLobbyInviteTipsItem = class("PartyGameLobbyInviteTipsItem", ListScrollCellExtend)

function PartyGameLobbyInviteTipsItem:onInitView()
	self._goheadicon = gohelper.findChild(self.viewGO, "root/go_tips/#go_headicon")
	self._txtname = gohelper.findChildText(self.viewGO, "root/go_tips/#txt_name")
	self._txtstate = gohelper.findChildText(self.viewGO, "root/go_tips/#txt_state")
	self._btnrefuse = gohelper.findChildButtonWithAudio(self.viewGO, "root/go_tips/#btn_refuse")
	self._btnagree = gohelper.findChildButtonWithAudio(self.viewGO, "root/go_tips/#btn_agree")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PartyGameLobbyInviteTipsItem:addEvents()
	self._btnrefuse:AddClickListener(self._btnrefuseOnClick, self)
	self._btnagree:AddClickListener(self._btnagreeOnClick, self)
end

function PartyGameLobbyInviteTipsItem:removeEvents()
	self._btnrefuse:RemoveClickListener()
	self._btnagree:RemoveClickListener()
end

function PartyGameLobbyInviteTipsItem:_btnrefuseOnClick()
	self._isRefuse = true

	self:_doExit()
end

function PartyGameLobbyInviteTipsItem:_doExit()
	if self._isDelete then
		return
	end

	self._isDelete = true

	self:_exit()
end

function PartyGameLobbyInviteTipsItem:_btnagreeOnClick()
	if self._isDelete then
		return
	end

	self._isDelete = true

	if PartyGameTrialController.instance:InTrial() then
		self._isAgree = false

		ToastController.instance:showToast(ToastEnum.PartyGame_InTrial)
	else
		self._isAgree = true
	end

	self:_exit()
end

function PartyGameLobbyInviteTipsItem:_exit()
	ToastController.instance:dispatchEvent(ToastEvent.RecycleFixedToast, self._toastItem)
	self._animator:Play("out")
end

function PartyGameLobbyInviteTipsItem:_editableInitView()
	local rootGo = gohelper.findChild(self.viewGO, "root")

	self._animator = rootGo:GetComponent("Animator")
	self._playericon = IconMgr.instance:getCommonPlayerIcon(self._goheadicon)

	self._playericon:setEnableClick(false)
	self._playericon:setShowLevel(false)

	local fill = gohelper.findChildImage(self.viewGO, "root/go_tips/progress/fill")

	self._tweenId = ZProj.TweenHelper.DOFillAmount(fill, 0, ToastParamEnum.LifeTime[ToastEnum.PartyGameLobbyInviteTip] - 1, self._tweenDone, self)
end

function PartyGameLobbyInviteTipsItem:_tweenDone()
	self:_doExit()
end

function PartyGameLobbyInviteTipsItem:_editableAddEvents()
	return
end

function PartyGameLobbyInviteTipsItem:_editableRemoveEvents()
	return
end

function PartyGameLobbyInviteTipsItem:onUpdateMO(mo, toastItem)
	self._toastItem = toastItem
	self._extraParams = mo.extraParams

	local socialFriendModel = SocialListModel.instance:getModel(SocialEnum.Type.Friend)
	local friendMo = socialFriendModel:getById(mo.id)

	self._txtname.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("partygame_invite_desc"), friendMo.name)

	self._playericon:onUpdateMO(friendMo)
end

function PartyGameLobbyInviteTipsItem:onSelect(isSelect)
	return
end

function PartyGameLobbyInviteTipsItem:onDestroyView()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	if self._isAgree then
		PartyRoomRpc.instance:sendClearSuccessMatchInfoRequest()
		PartyRoomRpc.instance:simpleJoinPartyRoomReq(self._extraParams.roomId)
		PartyGameStatHelper.instance:partyGameInvite(StatEnum.PartyGameEnum.AcceptInvite, 0, self._extraParams.roomId)
	else
		PartyRoomRpc.instance:sendRefuseInviteRequest(PlayerModel.instance:getMyUserId(), self._extraParams.roomId, self._extraParams.fromUserId, self._isRefuse and PartyGameLobbyEnum.RefuseType.Active)
	end
end

return PartyGameLobbyInviteTipsItem
