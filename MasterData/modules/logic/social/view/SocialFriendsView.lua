-- chunkname: @modules/logic/social/view/SocialFriendsView.lua

module("modules.logic.social.view.SocialFriendsView", package.seeall)

local SocialFriendsView = class("SocialFriendsView", BaseView)

function SocialFriendsView:onInitView()
	self._gohas = gohelper.findChild(self.viewGO, "#go_has")
	self._gono = gohelper.findChild(self.viewGO, "#go_no")
	self._goRight = gohelper.findChild(self.viewGO, "#go_has/right")
	self._simagecharbg = gohelper.findChildSingleImage(self.viewGO, "#go_has/right/#simage_chartbg")
	self._goSkinbg = gohelper.findChild(self.viewGO, "#go_has/right/#go_skinbg")
	self._gomessage = gohelper.findChild(self.viewGO, "#go_has/right/#go_message")
	self._scrollmessage = gohelper.findChildScrollRect(self.viewGO, "#go_has/right/#go_message/#scroll_message")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_has/right/#go_message/#scroll_message/viewport/#go_content")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_has/right/#txt_name")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._isSelectBtn = false
	self._isSelfBg = true
	self._isopen = false
	self._selectitemList = {}
	self._currentselectbg = nil

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SocialFriendsView:addEvents()
	return
end

function SocialFriendsView:removeEvents()
	return
end

function SocialFriendsView:_editableInitView()
	self._friendChatCD = nil

	self._simagecharbg:LoadImage(ResUrl.getSocialIcon("img_chat_bg.png"))

	self._isSelfBg = SocialModel.instance:isSelectSocialBg()
end

function SocialFriendsView:_loadBg()
	if self.viewParam then
		local skinId = self.viewParam.skinId

		self._btnViews = self._btnViews or {}

		if not skinId then
			if self._isSelfBg then
				skinId = PlayerCardModel.instance:getPlayerCardSkinId()
			else
				if not self._selectFriend then
					return
				end

				local playerMO = SocialModel.instance:getPlayerMO(self._selectFriend)

				skinId = playerMO.bg
			end
		end

		if skinId == self._currentselectbg then
			return
		end

		local themeViewRes = SocialEnum.ThemeViewResPath[skinId]

		self._btnViewPath = themeViewRes and themeViewRes.socialfriendsbtnview and themeViewRes.socialfriendsbtnview or SocialEnum.ThemeViewResPath[0].socialfriendsbtnview

		if not self._btnViews[self._btnViewPath] then
			if not string.nilorempty(self._btnViewPath) then
				if self._btnViewLoader then
					self._btnViewLoader:dispose()

					self._btnViewLoader = nil
				end

				self._btnViewLoader = MultiAbLoader.New()

				self._btnViewLoader:addPath(self._btnViewPath)
				self._btnViewLoader:startLoad(self._onLoadBtnViewFinish, self)
			end
		else
			self:_refreshBtnView()
		end

		if self._goskinEffect then
			gohelper.destroy(self._goskinEffect)

			self._goskinEffect = nil
		end

		if skinId and skinId ~= 0 then
			self._hasSkin = true
			self._skinPath = string.format("ui/viewres/player/playercard/playercardskinpreview_%s.prefab", skinId)
			self._loader = MultiAbLoader.New()

			self._loader:addPath(self._skinPath)
			self._loader:startLoad(self._onLoadFinish, self)
		else
			self._hasSkin = false
		end

		gohelper.setActive(self._goSkinbg, self._hasSkin)
		gohelper.setActive(self._simagecharbg.gameObject, not self._hasSkin)

		if self._isopen and not self._hasSkin then
			self._animator.enabled = true

			self._animator:Play("open", 0, 0)
		end

		self._currentselectbg = skinId

		self.viewContainer:checkBGView(skinId)
		PlayerCardController.instance:checkPlayCardSpecialBgm(skinId)
	end
end

function SocialFriendsView:_onLoadFinish()
	local assetItem = self._loader:getAssetItem(self._skinPath)
	local viewPrefab = assetItem:GetResource(self._skinPath)

	self._goskinEffect = gohelper.clone(viewPrefab, self._goSkinbg)
	self._animator.enabled = true

	self._animator:Play("open", 0, 0)
end

function SocialFriendsView:_onLoadBtnViewFinish()
	if not string.nilorempty(self._btnViewPath) and not self._btnViews[self._btnViewPath] then
		local btnViewItem = self._btnViewLoader:getAssetItem(self._btnViewPath)
		local btnViewPrefab = btnViewItem:GetResource(self._btnViewPath)
		local btnView = gohelper.clone(btnViewPrefab, self._goRight)

		self._btnViews[self._btnViewPath] = MonoHelper.addNoUpdateLuaComOnceToGo(btnView, SocialFriendsBtnView, self)
	end

	self:_refreshBtnView()
end

function SocialFriendsView:_refreshBtnView()
	if self._btnViews then
		self._curBtnView = self._btnViews[self._btnViewPath]

		for path, view in pairs(self._btnViews) do
			gohelper.setActive(view.viewGO, path == self._btnViewPath)
		end
	end

	if self._curBtnView then
		self._curBtnView:setSelfBg(self._isSelfBg)
		self._curBtnView:selectFriend(self._selectFriend)
	end
end

function SocialFriendsView:onOpen()
	self.addEventCb(self, SocialController.instance, SocialEvent.FriendsInfoChanged, self._refreshUI, self)
	self.addEventCb(self, SocialController.instance, SocialEvent.SelectFriend, self._refreshMessageView, self)
	self.addEventCb(self, SocialController.instance, SocialEvent.MessageInfoChanged, self._refreshMessageView, self)
	self.addEventCb(self, SocialController.instance, SocialEvent.AddUnknownFriend, self._onAddUnknownFriend, self)
	self.addEventCb(self, SocialController.instance, SocialEvent.FriendDescChange, self._ondescChange, self)
	self.addEventCb(self, SocialController.instance, SocialEvent.CutSelectSocialBg, self.selectUseSkin, self)
	SocialListModel.instance:sortFriendList()
	FriendRpc.instance:sendGetFriendInfoListRequest()

	if self._notFirst then
		self:_refreshUI()
	else
		self:_refreshUI(true)
	end

	self._notFirst = true
	self._preSendInfo = nil

	if self.viewParam and self.viewParam.preSendInfo then
		self._preSendInfo = self.viewParam.preSendInfo

		if self._curBtnView then
			self._curBtnView:setPreSendInfo(self._preSendInfo)
			self._curBtnView:setInputText(self._preSendInfo.content)
		end
	end

	self:_loadBg()

	self._isopen = true
end

function SocialFriendsView:selectUseSkin(isSelf)
	self._isSelfBg = isSelf

	SocialModel.instance:setSelectSocialBg(isSelf)
	self:_loadBg()
end

function SocialFriendsView:_onAddUnknownFriend()
	FriendRpc.instance:sendGetFriendInfoListRequest()
end

function SocialFriendsView:onClose()
	self.removeEventCb(self, SocialController.instance, SocialEvent.FriendsInfoChanged, self._refreshUI, self)
	self.removeEventCb(self, SocialController.instance, SocialEvent.SelectFriend, self._refreshMessageView, self)
	self.removeEventCb(self, SocialController.instance, SocialEvent.MessageInfoChanged, self._refreshMessageView, self)
	self.removeEventCb(self, SocialController.instance, SocialEvent.AddUnknownFriend, self._onAddUnknownFriend, self)
	self.removeEventCb(self, SocialController.instance, SocialEvent.FriendDescChange, self._ondescChange, self)
	self.removeEventCb(self, SocialController.instance, SocialEvent.CutSelectSocialBg, self.selectUseSkin, self)
end

function SocialFriendsView:_refreshUI(open)
	local friendsCount = SocialModel.instance:getFriendsCount()

	if not open then
		gohelper.setActive(self._gohas, friendsCount > 0)
		gohelper.setActive(self._gono, friendsCount <= 0)
	else
		gohelper.setActive(self._gohas, friendsCount > 0)
		gohelper.setActive(self._gono, false)
	end

	local selectFriend = SocialModel.instance:getSelectFriend()

	if not selectFriend then
		local friendList = SocialListModel.instance:getModel(SocialEnum.Type.Friend):getList()

		if friendList and #friendList > 0 then
			local playerMO = friendList[1]

			SocialModel.instance:setSelectFriend(playerMO.userId)
		end
	end

	self:_refreshMessageView()
end

function SocialFriendsView:_refreshMessageView()
	local selectFriend = SocialModel.instance:getSelectFriend()

	if not selectFriend then
		gohelper.setActive(self._gomessage, false)

		self._txtname.text = ""
		self._selectFriend = nil

		return
	end

	gohelper.setActive(self._gomessage, true)
	SocialMessageModel.instance:clearMessageUnread(SocialEnum.ChannelType.Friend, selectFriend)

	local bottom = recthelper.getHeight(self._scrollmessage.transform) >= recthelper.getHeight(self._gocontent.transform) or self._scrollmessage.verticalNormalizedPosition <= 0.01 or self._selectFriend ~= selectFriend
	local changed = self._selectFriend ~= selectFriend

	if changed then
		if self._preSendInfo and self._preSendInfo.recipientId == self._selectFriend then
			self:_clearPreSendInfo()
		end

		if self._curBtnView then
			self._curBtnView:setInputText("")
		end
	end

	self._selectFriend = selectFriend

	self:_ondescChange()

	if self._curBtnView then
		self._curBtnView:selectFriend(selectFriend)
	end

	local messageMOList = SocialMessageModel.instance:getSocialMessageMOList(SocialEnum.ChannelType.Friend, self._selectFriend)

	SocialMessageListModel.instance:setMessageList(messageMOList)

	if bottom then
		self._scrollmessage.verticalNormalizedPosition = 0
	end

	self:selectUseSkin(self._isSelfBg)
end

function SocialFriendsView:_clearPreSendInfo()
	self._preSendInfo = nil

	if self.viewParam and self.viewParam.preSendInfo then
		self.viewParam.preSendInfo = nil
	end

	if self._curBtnView then
		self._curBtnView:clearPreSendInfo()
	end
end

function SocialFriendsView:_ondescChange(id)
	if id and id ~= self._selectFriend then
		return
	end

	local playerMO = SocialModel.instance:getPlayerMO(self._selectFriend)

	self._txtname.text = string.nilorempty(playerMO.desc) and tostring(playerMO.name) or playerMO.desc
end

function SocialFriendsView:onUpdateParam()
	return
end

function SocialFriendsView:onDestroyView()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._btnViewLoader then
		self._btnViewLoader:dispose()

		self._btnViewLoader = nil
	end

	self._simagecharbg:UnLoadImage()
	PlayerCardController.instance:stopCardSpecialBgm()
end

return SocialFriendsView
