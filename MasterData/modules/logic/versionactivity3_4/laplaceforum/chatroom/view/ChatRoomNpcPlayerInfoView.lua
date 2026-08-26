-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/view/ChatRoomNpcPlayerInfoView.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.view.ChatRoomNpcPlayerInfoView", package.seeall)

local ChatRoomNpcPlayerInfoView = class("ChatRoomNpcPlayerInfoView", BaseView)

function ChatRoomNpcPlayerInfoView:onInitView()
	self._transScroll = gohelper.findChild(self.viewGO, "Scroll_view").transform
	self._goplayericon = gohelper.findChild(self.viewGO, "Scroll_view/Viewport/Content/playerinfo/#go_playericon")
	self._goimagebg = gohelper.findChild(self.viewGO, "Scroll_view/Viewport/Content/bg/normal2")
	self._goskinbg = gohelper.findChild(self.viewGO, "Scroll_view/Viewport/Content/bg/actskin")
	self._txtname = gohelper.findChildText(self.viewGO, "Scroll_view/Viewport/Content/playerinfo/#txt_name")
	self._txtlevel = gohelper.findChildText(self.viewGO, "Scroll_view/Viewport/Content/playerinfo/level/#txt_level")
	self._gobuttonscontainer = gohelper.findChild(self.viewGO, "Scroll_view/Viewport/Content/buttonscontainer")
	self._btnplayerview = gohelper.findChildButtonWithAudio(self._gobuttonscontainer, "#btn_playerview")
	self._btnaddfriend = gohelper.findChildButtonWithAudio(self._gobuttonscontainer, "#btn_addfriend")
	self._btnremovefriend = gohelper.findChildButtonWithAudio(self._gobuttonscontainer, "#btn_removefriend")
	self._btnaddblacklist = gohelper.findChildButtonWithAudio(self._gobuttonscontainer, "#btn_addblacklist")
	self._btnremoveblacklist = gohelper.findChildButtonWithAudio(self._gobuttonscontainer, "#btn_removeblacklist")
	self._btninformplayer = gohelper.findChildButtonWithAudio(self._gobuttonscontainer, "#btn_informplayer")
	self._btnremark = gohelper.findChildButtonWithAudio(self._gobuttonscontainer, "#btn_remark")
	self._btnplayercard = gohelper.findChildButtonWithAudio(self._gobuttonscontainer, "#btn_personalcard")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._hasSkin = false

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ChatRoomNpcPlayerInfoView:addEvents()
	self._btnplayerview:AddClickListener(self._btnplayerviewOnClick, self)
	self._btnaddfriend:AddClickListener(self._btnaddfriendOnClick, self)
	self._btnremovefriend:AddClickListener(self._btnremovefriendOnClick, self)
	self._btnaddblacklist:AddClickListener(self._btnaddblacklistOnClick, self)
	self._btnremoveblacklist:AddClickListener(self._btnremoveblacklistOnClick, self)
	self._btninformplayer:AddClickListener(self._btninformplayerOnClick, self)
	self._btnremark:AddClickListener(self._btnremarkOnClick, self)
	self._btnplayercard:AddClickListener(self._btnplayercardOnClick, self)
	self._btnclose:AddClickListener(self.closeThis, self)
end

function ChatRoomNpcPlayerInfoView:removeEvents()
	self._btnplayerview:RemoveClickListener()
	self._btnaddfriend:RemoveClickListener()
	self._btnremovefriend:RemoveClickListener()
	self._btnaddblacklist:RemoveClickListener()
	self._btnremoveblacklist:RemoveClickListener()
	self._btninformplayer:RemoveClickListener()
	self._btnremark:RemoveClickListener()
	self._btnplayercard:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function ChatRoomNpcPlayerInfoView:_btnplayercardOnClick()
	if not self._mo then
		return
	end

	PlayerCardController.instance:openPlayerCardView({
		hideHomeBtn = true,
		userId = self._mo.userId
	})
end

function ChatRoomNpcPlayerInfoView:_btninformplayerOnClick()
	SocialController.instance:openInformPlayerTipView(self._mo)
end

function ChatRoomNpcPlayerInfoView:_btnremarkOnClick()
	ViewMgr.instance:openView(ViewName.SocialRemarkTipView, self._mo)
	self:closeThis()
end

function ChatRoomNpcPlayerInfoView:_btnplayerviewOnClick()
	local myUserId = PlayerModel.instance:getMyUserId()
	local playerSelf = myUserId == self._mo.userId

	if playerSelf then
		local playerInfo = PlayerModel.instance:getPlayinfo()

		self:closeThis()
		PlayerController.instance:openPlayerView(playerInfo, true, nil, true)
	else
		PlayerRpc.instance:sendGetOtherPlayerInfoRequest(self._mo.userId, self._getPlayerInfo, self)
	end
end

function ChatRoomNpcPlayerInfoView:_btnaddfriendOnClick()
	Activity225Rpc.instance:sendAct225ApplyFriendRequest(VersionActivity3_4Enum.ActivityId.LaplaceChatRoom)
	SocialController.instance:AddFriend(self._mo.userId)
	self:closeThis()
end

function ChatRoomNpcPlayerInfoView:_btnremovefriendOnClick()
	local userId = self._mo.userId

	GameFacade.showMessageBox(MessageBoxIdDefine.FriendRemoveTip, MsgBoxEnum.BoxType.Yes_No, function()
		FriendRpc.instance:sendRemoveFriendRequest(userId)
	end)
	self:closeThis()
end

function ChatRoomNpcPlayerInfoView:_btnaddblacklistOnClick()
	local userId = self._mo.userId

	GameFacade.showMessageBox(MessageBoxIdDefine.AddBlackTip, MsgBoxEnum.BoxType.Yes_No, function()
		FriendRpc.instance:sendAddBlacklistRequest(userId)
	end)
	self:closeThis()
end

function ChatRoomNpcPlayerInfoView:_btnremoveblacklistOnClick()
	FriendRpc.instance:sendRemoveBlacklistRequest(self._mo.userId)
	self:closeThis()
end

function ChatRoomNpcPlayerInfoView:_getPlayerInfo(cmd, resultCode, msg)
	if resultCode == 0 and msg and msg.playerInfo then
		self:closeThis()
		PlayerController.instance:openPlayerView(msg.playerInfo, false, msg.heroCover, true)
	end
end

function ChatRoomNpcPlayerInfoView:_editableInitView()
	self._playericon = IconMgr.instance:getCommonPlayerIcon(self._goplayericon)

	self._playericon:setEnableClick(false)

	self._parentWidth = recthelper.getWidth(self.viewGO.transform.parent)
	self._parentHeight = recthelper.getHeight(self.viewGO.transform.parent)
end

function ChatRoomNpcPlayerInfoView:_refreshUI()
	if not self._mo.bg or self._mo.bg == 0 then
		self._hasSkin = false
	else
		self._hasSkin = true
		self._skinPath = string.format("ui/viewres/social/playerinfoview_bg_%s.prefab", self._mo.bg)
		self._loader = MultiAbLoader.New()

		self._loader:addPath(self._skinPath)
		self._loader:startLoad(self._onLoadFinish, self)
	end

	gohelper.setActive(self._goimagebg, not self._hasSkin)
	gohelper.setActive(self._goskinbg, self._hasSkin)
	self._playericon:onUpdateMO(self._mo)
	self._playericon:setShowLevel(false)

	self._txtname.text = self._mo.name
	self._txtlevel.text = self._mo.level

	local myUserId = PlayerModel.instance:getMyUserId()
	local isPlayerSelf = myUserId == self._mo.userId
	local isFriend = SocialModel.instance:isMyFriendByUserId(self._mo.userId)
	local isBlackList = SocialModel.instance:isMyBlackListByUserId(self._mo.userId)

	gohelper.setActive(self._btnaddfriend.gameObject, not isFriend)
	gohelper.setActive(self._btnremovefriend.gameObject, isFriend)
	gohelper.setActive(self._btnremark.gameObject, isFriend)
	gohelper.setActive(self._btnaddblacklist.gameObject, not isBlackList and not isPlayerSelf)
	gohelper.setActive(self._btnremoveblacklist.gameObject, isBlackList and not isPlayerSelf)
end

function ChatRoomNpcPlayerInfoView:_onLoadFinish()
	local assetItem = self._loader:getAssetItem(self._skinPath)
	local viewPrefab = assetItem:GetResource(self._skinPath)

	self._goskinEffect = gohelper.clone(viewPrefab, self._goskinbg)
end

function ChatRoomNpcPlayerInfoView:onOpen()
	self._mo = self.viewParam.mo

	self:_refreshUI()
end

function ChatRoomNpcPlayerInfoView:onClose()
	return
end

function ChatRoomNpcPlayerInfoView:onDestroyView()
	return
end

return ChatRoomNpcPlayerInfoView
