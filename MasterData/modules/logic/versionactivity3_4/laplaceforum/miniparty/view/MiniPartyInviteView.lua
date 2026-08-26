-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/miniparty/view/MiniPartyInviteView.lua

module("modules.logic.versionactivity3_4.laplaceforum.miniparty.view.MiniPartyInviteView", package.seeall)

local MiniPartyInviteView = class("MiniPartyInviteView", BaseView)

function MiniPartyInviteView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "Panel/#simage_FullBG")
	self._btninvite = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Tab/#btn_invite")
	self._goinviteselected = gohelper.findChild(self.viewGO, "Panel/Tab/#btn_invite/#go_inviteselected")
	self._goinvitenum = gohelper.findChild(self.viewGO, "Panel/Tab/#btn_invite/#go_invitenum")
	self._txtinvitenum = gohelper.findChildText(self.viewGO, "Panel/Tab/#btn_invite/#go_invitenum/#txt_invitenum")
	self._btnfriend = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Tab/#btn_friend")
	self._gofriendselected = gohelper.findChild(self.viewGO, "Panel/Tab/#btn_friend/#go_friendselected")
	self._gofriendnum = gohelper.findChild(self.viewGO, "Panel/Tab/#btn_friend/#go_friendnum")
	self._txtfriendnum = gohelper.findChildText(self.viewGO, "Panel/Tab/#btn_friend/#go_friendnum/#txt_friendnum")
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Tab/#btn_check")
	self._gocheckselected = gohelper.findChild(self.viewGO, "Panel/Tab/#btn_check/#go_checkselected")
	self._gochecknum = gohelper.findChild(self.viewGO, "Panel/Tab/#btn_check/#go_checknum")
	self._txtchecknum = gohelper.findChildText(self.viewGO, "Panel/Tab/#btn_check/#go_checknum/#txt_checknum")
	self._goinvite = gohelper.findChild(self.viewGO, "Panel/Content/#go_invite")
	self._gofriend = gohelper.findChild(self.viewGO, "Panel/Content/#go_friend")
	self._gocheck = gohelper.findChild(self.viewGO, "Panel/Content/#go_check")
	self._gofriendempty = gohelper.findChild(self.viewGO, "Panel/Content/#go_friendempty")
	self._gocheckempty = gohelper.findChild(self.viewGO, "Panel/Content/#go_checkempty")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MiniPartyInviteView:addEvents()
	self._btninvite:AddClickListener(self._btninviteOnClick, self)
	self._btnfriend:AddClickListener(self._btnfriendOnClick, self)
	self._btncheck:AddClickListener(self._btncheckOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function MiniPartyInviteView:removeEvents()
	self._btninvite:RemoveClickListener()
	self._btnfriend:RemoveClickListener()
	self._btncheck:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function MiniPartyInviteView:_btninviteOnClick()
	if self._inviteType == MiniPartyEnum.InviteType.Code then
		return
	end

	self._inviteType = MiniPartyEnum.InviteType.Code

	Activity223Rpc.instance:sendGetAct223InfoRequest(self._actId, self._onGetInfoFinished, self)
end

function MiniPartyInviteView:_btnfriendOnClick()
	if self._inviteType == MiniPartyEnum.InviteType.Friend then
		return
	end

	self._inviteType = MiniPartyEnum.InviteType.Friend

	Activity223Rpc.instance:sendGetAct223InfoRequest(self._actId, self._onGetInfoFinished, self)
end

function MiniPartyInviteView:_btncheckOnClick()
	if self._inviteType == MiniPartyEnum.InviteType.Check then
		return
	end

	MiniPartyModel.instance:setAllInviteChecked()

	self._inviteType = MiniPartyEnum.InviteType.Check

	Activity223Rpc.instance:sendGetAct223InfoRequest(self._actId, self._onGetInfoFinished, self)
end

function MiniPartyInviteView:_onGetInfoFinished(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	MiniPartyModel.instance:setAct223Info(msg)

	local hasGrouped = MiniPartyModel.instance:hasGrouped()

	if hasGrouped then
		GameFacade.showToast(ToastEnum.MiniPartySelfHasGrouped)
		self:closeThis()

		return
	end

	MiniPartyModel.instance:setCurInviteType(self._inviteType)
	MiniPartyController.instance:dispatchEvent(MiniPartyEvent.InviteTypeSelectChanged, self._inviteType)
	self:_refresh()
end

function MiniPartyInviteView:_btncloseOnClick()
	self:closeThis()
end

function MiniPartyInviteView:_editableInitView()
	self:_addSelfEvents()

	self._actId = VersionActivity3_4Enum.ActivityId.LaplaceMiniParty
end

function MiniPartyInviteView:_addSelfEvents()
	MiniPartyController.instance:registerCallback(MiniPartyEvent.InviteFriendAgreeBack, self._onTargetUserGrouped, self)
end

function MiniPartyInviteView:_removeSelfEvents()
	MiniPartyController.instance:unregisterCallback(MiniPartyEvent.InviteFriendAgreeBack, self._onTargetUserGrouped, self)
end

function MiniPartyInviteView:_onTargetUserGrouped(userId, isAgree)
	if not isAgree then
		return
	end

	Activity223Rpc.instance:sendGetAct223InfoRequest(self._actId, self._onInviteAgree, self)
end

function MiniPartyInviteView:_onInviteAgree(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	MiniPartyModel.instance:setAct223Info(msg)

	local hasGrouped = MiniPartyModel.instance:hasGrouped()

	if hasGrouped then
		self:closeThis()
	end
end

function MiniPartyInviteView:onOpen()
	self._actId = VersionActivity3_4Enum.ActivityId.LaplaceMiniParty

	self:_refresh()
end

function MiniPartyInviteView:_refresh()
	self._inviteType = MiniPartyModel.instance:getCurInviteType()

	self:_refreshBtns()
	self:_refreshContent()
end

function MiniPartyInviteView:_refreshBtns()
	gohelper.setActive(self._goinviteselected, self._inviteType == MiniPartyEnum.InviteType.Code)
	gohelper.setActive(self._goinvitenum, false)
	gohelper.setActive(self._gofriendselected, self._inviteType == MiniPartyEnum.InviteType.Friend)
	gohelper.setActive(self._gofriendnum, false)
	gohelper.setActive(self._gocheckselected, self._inviteType == MiniPartyEnum.InviteType.Check)

	local uncheckCount = MiniPartyModel.instance:getAllUncheckInviteCount()

	gohelper.setActive(self._gochecknum, uncheckCount > 0)

	if uncheckCount > 0 then
		self._txtchecknum.text = uncheckCount
	end
end

function MiniPartyInviteView:_refreshContent()
	local inviteInfos = MiniPartyModel.instance:getInviteInfos()

	gohelper.setActive(self._gocheckempty, self._inviteType == MiniPartyEnum.InviteType.Check and #inviteInfos == 0)

	local friendMos = MiniPartyModel.instance:getFriendTeams()

	gohelper.setActive(self._gofriendempty, self._inviteType == MiniPartyEnum.InviteType.Friend and #friendMos == 0)
	gohelper.setActive(self._goinvite, self._inviteType == MiniPartyEnum.InviteType.Code)
	gohelper.setActive(self._gofriend, self._inviteType == MiniPartyEnum.InviteType.Friend)
	gohelper.setActive(self._gocheck, self._inviteType == MiniPartyEnum.InviteType.Check)
end

function MiniPartyInviteView:onClose()
	return
end

function MiniPartyInviteView:onDestroyView()
	MiniPartyModel.instance:setCurInviteType(MiniPartyEnum.InviteType.Code)
	self:_removeSelfEvents()
end

return MiniPartyInviteView
