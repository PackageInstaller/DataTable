-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/miniparty/view/MiniPartyInviteCodeView.lua

module("modules.logic.versionactivity3_4.laplaceforum.miniparty.view.MiniPartyInviteCodeView", package.seeall)

local MiniPartyInviteCodeView = class("MiniPartyInviteCodeView", BaseView)

function MiniPartyInviteCodeView:onInitView()
	self._goinvite = gohelper.findChild(self.viewGO, "Panel/Content/#go_invite")
	self._btninviteok = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Content/#go_invite/#btn_inviteok")
	self._gosend = gohelper.findChild(self.viewGO, "Panel/Content/#go_invite/#input_send")
	self._txtnum = gohelper.findChildText(self.viewGO, "Panel/Content/#go_invite/playerNum/txt_title/#txt_num")
	self._gocopy = gohelper.findChild(self.viewGO, "Panel/Content/#go_invite/playerNum/#go_copy")
	self._btncopy = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Content/#go_invite/playerNum/#go_copy/#btn_copy")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MiniPartyInviteCodeView:addEvents()
	self._btninviteok:AddClickListener(self._btninviteokOnClick, self)
	self._btncopy:AddClickListener(self._btncopyOnClick, self)
end

function MiniPartyInviteCodeView:removeEvents()
	self._btninviteok:RemoveClickListener()
	self._btncopy:RemoveClickListener()
end

function MiniPartyInviteCodeView:_btninviteokOnClick()
	Activity223Rpc.instance:sendGetAct223InfoRequest(self._actId, self._onGetInfoFinished, self)
end

function MiniPartyInviteCodeView:_onGetInfoFinished(cmd, resultCode, msg)
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

	local inviteCode = self._inputsend.text

	if LuaUtil.isEmptyStr(inviteCode) then
		GameFacade.showToast(ToastEnum.MiniPartyInviteCodeInput)

		return
	end

	local isIllegalStr = string.find(inviteCode, "[^%w]")

	if isIllegalStr then
		GameFacade.showToast(ToastEnum.MiniPartyNotFoundInviteCode)

		return
	end

	local str = MiniPartyModel.instance:getInviteCode()

	if inviteCode == str then
		GameFacade.showToast(ToastEnum.MiniPartyInviteCodeOther)

		return
	end

	Activity223Rpc.instance:sendAct223InviteRequest(self._actId, inviteCode, 0)
end

function MiniPartyInviteCodeView:_btncopyOnClick()
	local str = MiniPartyModel.instance:getInviteCode()

	ZProj.UGUIHelper.CopyText(str)
	ToastController.instance:showToast(ToastEnum.MiniPartyInviteCodeCopy)
end

function MiniPartyInviteCodeView:_editableInitView()
	self._inputsend = gohelper.onceAddComponent(self._gosend, typeof(TMPro.TMP_InputField))
	self._actId = VersionActivity3_4Enum.ActivityId.LaplaceMiniParty
end

function MiniPartyInviteCodeView:onOpen()
	self:_refresh()
end

function MiniPartyInviteCodeView:_refresh()
	self._txtnum.text = MiniPartyModel.instance:getInviteCode()
end

function MiniPartyInviteCodeView:onClose()
	return
end

function MiniPartyInviteCodeView:onDestroyView()
	return
end

return MiniPartyInviteCodeView
