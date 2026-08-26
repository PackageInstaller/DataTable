-- chunkname: @modules/logic/social/view/SocialFriendsBtnView.lua

module("modules.logic.social.view.SocialFriendsBtnView", package.seeall)

local SocialFriendsBtnView = class("SocialFriendsBtnView", LuaCompBase)

function SocialFriendsBtnView:ctor(parentView)
	self._parentView = parentView
end

function SocialFriendsBtnView:init(go)
	self.viewGO = go
	self._btnselect = gohelper.findChildButtonWithAudio(self.viewGO, "#go_settingbackground/btn_click")
	self._goselect = gohelper.findChild(self.viewGO, "#go_settingbackground/btn_click/selected")
	self._gounselect = gohelper.findChild(self.viewGO, "#go_settingbackground/btn_click/unselect")
	self._gotips = gohelper.findChild(self.viewGO, "#go_settingbackground/go_tips")
	self._btnclosetips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_settingbackground/go_tips/#btn_close")
	self._inputsend = gohelper.findChildTextMeshInputField(self.viewGO, "send/#input_send")
	self._btnsend = gohelper.findChildButtonWithAudio(self.viewGO, "send/#btn_send")
	self._txtcd = gohelper.findChildText(self.viewGO, "send/#btn_send/#txt_cd")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._isSelectBtn = false
	self._isopen = false
	self._selectitemList = {}
	self._currentselectbg = nil

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SocialFriendsBtnView:addEventListeners()
	self._btnsend:AddClickListener(self._btnsendOnClick, self)
	self._btnselect:AddClickListener(self._btnselectOnClick, self)
	self._btnclosetips:AddClickListener(self._btnclosetipsOnClick, self)
end

function SocialFriendsBtnView:removeEventListeners()
	self._btnsend:RemoveClickListener()
	self._btnselect:RemoveClickListener()
	self._btnclosetips:RemoveClickListener()
end

function SocialFriendsBtnView:setSelfBg(isSelfBg)
	self._isSelfBg = isSelfBg

	for _, item in ipairs(self._selectitemList) do
		gohelper.setActive(item.goselect, item.isSelf == isSelfBg)
		gohelper.setActive(item.gounselect, item.isSelf ~= isSelfBg)
	end
end

function SocialFriendsBtnView:_editableInitView()
	self._txtcd.text = luaLang("social_chat_send")

	self:_refreshSelect()

	for i = 1, 2 do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(self.viewGO, "#go_settingbackground/go_tips/bg/item" .. i)
		item.btn = gohelper.findChildButton(item.go, "#btn_option")
		item.goselect = gohelper.findChild(item.go, "txt_option/selected")
		item.gounselect = gohelper.findChild(item.go, "txt_option/unselect")
		item.isSelf = i == SocialEnum.SelectEnum.Self

		item.btn:AddClickListener(self.selectUseSkin, self, item.isSelf)
		table.insert(self._selectitemList, item)
	end
end

function SocialFriendsBtnView:_btnselectOnClick()
	self._isSelectBtn = not self._isSelectBtn

	self:_refreshSelect()
end

function SocialFriendsBtnView:_btnclosetipsOnClick()
	self._isSelectBtn = false

	self:_refreshSelect()
end

function SocialFriendsBtnView:_refreshSelect()
	gohelper.setActive(self._goselect, self._isSelectBtn)
	gohelper.setActive(self._gounselect, not self._isSelectBtn)
	gohelper.setActive(self._gotips, self._isSelectBtn)
end

function SocialFriendsBtnView:_btnsendOnClick()
	if self._friendChatCD then
		GameFacade.showToast(ToastEnum.SocialFriends1)

		return
	end

	local sendValue = self._inputsend:GetText()

	if string.nilorempty(sendValue) then
		GameFacade.showToast(ToastEnum.SocialFriends2)

		return
	end

	local replacedSpaceValue = string.gsub(sendValue, " ", "")

	if string.nilorempty(replacedSpaceValue) then
		GameFacade.showToast(ToastEnum.SocialFriends2)
		self:setInputText("")

		return
	end

	self._friendChatCD = SocialEnum.FriendChatCD
	self._txtcd.text = string.format("%ds", math.ceil(self._friendChatCD))
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(SocialEnum.FriendChatCD, 0, SocialEnum.FriendChatCD, self._onTimeUpdate, self._onTimeEnd, self, nil, EaseType.Linear)

	local msgType = 0
	local extData = ""

	if self._preSendInfo and self._preSendInfo.recipientId == self._selectFriend then
		msgType = self._preSendInfo.msgType
		extData = self._preSendInfo.extData

		self:clearPreSendInfo()
	end

	ChatRpc.instance:sendSendMsgRequest(SocialEnum.ChannelType.Friend, self._selectFriend, sendValue, msgType, extData, self._onSendMsgReply, self)
end

function SocialFriendsBtnView:_onSendMsgReply(cmd, resultCode, msg)
	if resultCode == 0 then
		self:setInputText("")

		local info = self._preSendInfo

		if info and msg.recipientId == info.recipientId and msg.msgType == msg.msgType then
			self:clearPreSendInfo()
		end
	end
end

function SocialFriendsBtnView:selectFriend(selectFriend)
	self._selectFriend = selectFriend
end

function SocialFriendsBtnView:setPreSendInfo(info)
	self._preSendInfo = info
end

function SocialFriendsBtnView:clearPreSendInfo()
	self._preSendInfo = nil
end

function SocialFriendsBtnView:_onTimeUpdate(value)
	self._friendChatCD = value
	self._txtcd.text = string.format("%ds", math.ceil(self._friendChatCD))
end

function SocialFriendsBtnView:_onTimeEnd()
	self._friendChatCD = nil
	self._txtcd.text = luaLang("social_chat_send")
	self._tweenId = nil
end

function SocialFriendsBtnView:setInputText(content)
	self._inputsend:SetText(content)
end

function SocialFriendsBtnView:closeTips()
	self:_btnclosetipsOnClick()
end

function SocialFriendsBtnView:selectUseSkin(isSelf)
	for _, item in ipairs(self._selectitemList) do
		gohelper.setActive(item.goselect, item.isSelf == isSelf)
		gohelper.setActive(item.gounselect, item.isSelf ~= isSelf)
	end

	SocialController.instance:dispatchEvent(SocialEvent.CutSelectSocialBg, isSelf)
end

function SocialFriendsBtnView:onUpdateParam()
	return
end

function SocialFriendsBtnView:onDestroy()
	for _, item in ipairs(self._selectitemList) do
		item.btn:RemoveClickListener()
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

return SocialFriendsBtnView
