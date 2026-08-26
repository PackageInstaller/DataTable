-- chunkname: @modules/logic/social/view/PlayerInfoView.lua

module("modules.logic.social.view.PlayerInfoView", package.seeall)

local PlayerInfoView = class("PlayerInfoView", BaseView)

function PlayerInfoView:onInitView()
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
	self._btnroom = gohelper.findChildButtonWithAudio(self._gobuttonscontainer, "#btn_room")
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

function PlayerInfoView:addEvents()
	self._btnplayerview:AddClickListener(self._btnplayerviewOnClick, self)
	self._btnaddfriend:AddClickListener(self._btnaddfriendOnClick, self)
	self._btnremovefriend:AddClickListener(self._btnremovefriendOnClick, self)
	self._btnroom:AddClickListener(self._btnroomOnClick, self)
	self._btnaddblacklist:AddClickListener(self._btnaddblacklistOnClick, self)
	self._btnremoveblacklist:AddClickListener(self._btnremoveblacklistOnClick, self)
	self._btninformplayer:AddClickListener(self._btninformplayerOnClick, self)
	self._btnremark:AddClickListener(self._btnremarkOnClick, self)
	self._btnplayercard:AddClickListener(self._btnplayercardOnClick, self)
	self._btnclose:AddClickListener(self.closeThis, self)
end

function PlayerInfoView:removeEvents()
	self._btnplayerview:RemoveClickListener()
	self._btnaddfriend:RemoveClickListener()
	self._btnremovefriend:RemoveClickListener()
	self._btnroom:RemoveClickListener()
	self._btnaddblacklist:RemoveClickListener()
	self._btnremoveblacklist:RemoveClickListener()
	self._btninformplayer:RemoveClickListener()
	self._btnremark:RemoveClickListener()
	self._btnplayercard:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function PlayerInfoView:_btnplayercardOnClick()
	if not self._mo then
		return
	end

	PlayerCardController.instance:openPlayerCardView({
		userId = self._mo.userId
	})
	self:closeThis()
end

function PlayerInfoView:_btninformplayerOnClick()
	SocialController.instance:openInformPlayerTipView(self._mo)
end

function PlayerInfoView:_btnremarkOnClick()
	ViewMgr.instance:openView(ViewName.SocialRemarkTipView, self._mo)
	self:closeThis()
end

function PlayerInfoView:_btnplayerviewOnClick()
	local myUserId = PlayerModel.instance:getMyUserId()
	local playerSelf = myUserId == self._mo.userId

	if playerSelf then
		local playerInfo = PlayerModel.instance:getPlayinfo()

		self:closeThis()
		PlayerController.instance:openPlayerView(playerInfo, true)
	else
		PlayerRpc.instance:sendGetOtherPlayerInfoRequest(self._mo.userId, self._getPlayerInfo, self)
	end
end

function PlayerInfoView:_btnaddfriendOnClick()
	SocialController.instance:AddFriend(self._mo.userId)
	self:closeThis()
end

function PlayerInfoView:_btnremovefriendOnClick()
	local userId = self._mo.userId

	GameFacade.showMessageBox(MessageBoxIdDefine.FriendRemoveTip, MsgBoxEnum.BoxType.Yes_No, function()
		FriendRpc.instance:sendRemoveFriendRequest(userId)
	end)
	self:closeThis()
end

function PlayerInfoView:_btnroomOnClick()
	local visitParam = {
		userId = self._mo.userId
	}

	RoomController.instance:enterRoom(RoomEnum.GameMode.Visit, nil, nil, visitParam, nil, nil, true)
end

function PlayerInfoView:_btnaddblacklistOnClick()
	local userId = self._mo.userId

	GameFacade.showMessageBox(MessageBoxIdDefine.AddBlackTip, MsgBoxEnum.BoxType.Yes_No, function()
		FriendRpc.instance:sendAddBlacklistRequest(userId)
	end)
	self:closeThis()
end

function PlayerInfoView:_btnremoveblacklistOnClick()
	FriendRpc.instance:sendRemoveBlacklistRequest(self._mo.userId)
	self:closeThis()
end

function PlayerInfoView:_getPlayerInfo(cmd, resultCode, msg)
	if resultCode == 0 and msg and msg.playerInfo then
		self:closeThis()
		PlayerController.instance:openPlayerView(msg.playerInfo, false, msg.heroCover)
	end
end

function PlayerInfoView:_editableInitView()
	self._playericon = IconMgr.instance:getCommonPlayerIcon(self._goplayericon)

	self._playericon:setEnableClick(false)

	self._parentWidth = recthelper.getWidth(self.viewGO.transform.parent)
	self._parentHeight = recthelper.getHeight(self.viewGO.transform.parent)
end

function PlayerInfoView:_refreshUI()
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

	local name = self._mo.name

	if not string.nilorempty(self._mo.desc) then
		name = self._isSelectInFriend and "<color=#c66030>" .. name .. "<color=#6d6c6b>(" .. self._mo.desc .. ")" or name .. "<color=#6d6c6b>(" .. self._mo.desc .. ")"
	elseif self._isSelectInFriend then
		name = "<color=#c66030>" .. name
	end

	self._txtname.text = name
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
	gohelper.setActive(self._btnroom.gameObject, not self.hideRoomBtn)
end

function PlayerInfoView:_onLoadFinish()
	local assetItem = self._loader:getAssetItem(self._skinPath)
	local viewPrefab = assetItem:GetResource(self._skinPath)

	self._goskinEffect = gohelper.clone(viewPrefab, self._goskinbg)
end

function PlayerInfoView:onOpen()
	self._mo = self.viewParam.mo
	self._worldPos = self.viewParam.worldPos

	if self.viewParam.isSelectInFriend then
		self._isSelectInFriend = self.viewParam.isSelectInFriend
	end

	self.hideRoomBtn = self.viewParam.hideRoomBtn

	self:_refreshUI()
	self:_refreshPos()
end

function PlayerInfoView:onClose()
	return
end

function PlayerInfoView:onUpdateParam()
	self._mo = self.viewParam.mo
	self._worldPos = self.viewParam.worldPos

	if self.viewParam.isSelectInFriend then
		self._isSelectInFriend = self.viewParam.isSelectInFriend
	end

	self:_refreshUI()
	self:_refreshPos()
end

function PlayerInfoView:_refreshPos()
	self._viewWidth = recthelper.getWidth(self._transScroll)
	self._viewHeight = recthelper.getHeight(self._transScroll)

	local offsetX = 326
	local offsetY = self._viewHeight / 2 - 140
	local anchorPos = recthelper.rectToRelativeAnchorPos(self._worldPos, self.viewGO.transform.parent)

	for i = -1, 1, 2 do
		for j = -1, 1, 2 do
			local anchorPosX = anchorPos.x + offsetX * i
			local anchorPosY = anchorPos.y + offsetY * j
			local isOver, isYOver = self:_isOverScreen(anchorPosX, anchorPosY)

			if isOver and isYOver then
				isOver = false
				anchorPosY = self._viewHeight / 2 - self._parentHeight / 2 + 30
			end

			if not isOver then
				recthelper.setAnchor(self.viewGO.transform, anchorPosX, anchorPosY)

				return
			end
		end
	end

	recthelper.setAnchor(self.viewGO.transform, 0, 0)
end

function PlayerInfoView:_isOverScreen(anchorPosX, anchorPosY)
	if math.abs(anchorPosX) * 2 >= self._parentWidth - self._viewWidth then
		return true
	elseif math.abs(anchorPosY) * 2 >= self._parentHeight - self._viewHeight then
		return true, true
	end

	return false
end

function PlayerInfoView:onDestroyView()
	return
end

return PlayerInfoView
