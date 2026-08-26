-- chunkname: @modules/logic/social/view/SocialMessageItem.lua

module("modules.logic.social.view.SocialMessageItem", package.seeall)

local SocialMessageItem = class("SocialMessageItem", ListScrollCellExtend)

function SocialMessageItem:onInitView()
	self._goleft = gohelper.findChild(self.viewGO, "#go_left")
	self._txtnameleft = gohelper.findChildText(self.viewGO, "#go_left/textcontainer/#txt_nameleft")
	self._txtcontentleft = gohelper.findChildText(self.viewGO, "#go_left/textcontainer/content/contentbg/#txt_contentleft")
	self._goplayericonleft = gohelper.findChild(self.viewGO, "#go_left/#go_playericonleft")
	self._goright = gohelper.findChild(self.viewGO, "#go_right")
	self._goplayericonright = gohelper.findChild(self.viewGO, "#go_right/#go_playericonright")
	self._txtnameright = gohelper.findChildText(self.viewGO, "#go_right/textcontainer/#txt_nameright")
	self._gochattime = gohelper.findChild(self.viewGO, "#go_chattime")
	self._txtchattime = gohelper.findChildText(self.viewGO, "#go_chattime/#txt_chattime")
	self._btnopleft = gohelper.findChildButtonWithAudio(self.viewGO, "#go_left/textcontainer/content/contentbg/#txt_contentleft/#btn_opleft")
	self._txtopleft = gohelper.findChildText(self.viewGO, "#go_left/textcontainer/content/contentbg/#txt_contentleft/#btn_opleft/#txt_opleft")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_right/textcontainer/content")
	self._gowarm = gohelper.findChild(self.viewGO, "#go_warm")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SocialMessageItem:addEvents()
	self.addEventCb(self, SocialController.instance, SocialEvent.FriendDescChange, self.updateDesc, self)
	self.addEventCb(self, SocialController.instance, SocialEvent.CutSelectSocialBg, self.selectUseSkin, self)
	self._btnopleft:AddClickListener(self._btnopleftOnClick, self)
	self._btnopright:AddClickListener(self._btnoprightOnClick, self)
end

function SocialMessageItem:removeEvents()
	self.removeEventCb(self, SocialController.instance, SocialEvent.FriendDescChange, self.updateDesc, self)
	self.removeEventCb(self, SocialController.instance, SocialEvent.CutSelectSocialBg, self.selectUseSkin, self)
	self._btnopleft:RemoveClickListener()
	self._btnopright:RemoveClickListener()
end

function SocialMessageItem:selectUseSkin(isSelf)
	if self.viewParam then
		if not self.viewParam.skinId then
			local skinId = PlayerCardModel.instance:getPlayerCardSkinId()

			if not isSelf then
				local selectFriend = SocialModel.instance:getSelectFriend()
				local playerMO = SocialModel.instance:getPlayerMO(selectFriend)

				skinId = playerMO.bg
			end

			self:refreshCountBg(skinId)
			self:_refreshUI()
		end
	end
end

function SocialMessageItem:_btnopleftOnClick()
	SocialMessageController.instance:opMessageOnClick(self._mo)
end

function SocialMessageItem:_btnoprightOnClick()
	SocialMessageController.instance:opMessageOnClick(self._mo)
end

function SocialMessageItem:_editableInitView()
	self._countentBg = self:getUserDataTb_()

	for i = 1, self._gocontent.transform.childCount do
		local child = self._gocontent.transform:GetChild(i - 1).gameObject
		local split = string.split(child.name, "_")
		local id = tonumber(split[2]) or 0

		self._countentBg[id] = child

		gohelper.setActive(child, false)
	end
end

function SocialMessageItem:refreshCountBg(skinId)
	local showId = skinId

	if not self._countentBg[skinId] then
		showId = 0
	end

	if self._btnopright then
		self._btnopright:RemoveClickListener()
	end

	for id, bg in pairs(self._countentBg) do
		if id == showId then
			self._btnopright = gohelper.findChildButtonWithAudio(bg, "#txt_contentright/#btn_opright")
			self._txtopright = gohelper.findChildText(bg, "#txt_contentright/#btn_opright/#txt_opright")
			self._txtcontentright = gohelper.findChildText(bg, "#txt_contentright")

			self._btnopright:AddClickListener(self._btnoprightOnClick, self)
		end

		gohelper.setActive(bg, id == showId)
	end

	self:_refreshUI()
end

function SocialMessageItem:_refresh()
	local isSelfBg = SocialModel.instance:isSelectSocialBg()

	self:selectUseSkin(isSelfBg)
end

function SocialMessageItem:_refreshUI()
	if self._mo.chattime then
		gohelper.setActive(self._gochattime, true)
		gohelper.setActive(self._goright, false)
		gohelper.setActive(self._goleft, false)

		self._txtchattime.text = self._mo.chattime

		gohelper.setActive(self._gowarm, false)

		return
	end

	if self._mo.showWarm then
		gohelper.setActive(self._gochattime, false)
		gohelper.setActive(self._goright, false)
		gohelper.setActive(self._goleft, false)
		gohelper.setActive(self._gowarm, true)

		return
	end

	gohelper.setActive(self._gowarm, false)
	gohelper.setActive(self._gochattime, false)

	local myUserId = PlayerModel.instance:getMyUserId()
	local playerMO = SocialModel.instance:getPlayerMO(self._mo.senderId)

	gohelper.setActive(self._goright, myUserId == self._mo.senderId)
	gohelper.setActive(self._goleft, myUserId ~= self._mo.senderId)

	local isShowOp = self._mo:isHasOp()

	if myUserId == self._mo.senderId then
		if not self._playericonright then
			self._playericonright = IconMgr.instance:getCommonPlayerIcon(self._goplayericonright)

			self._playericonright:setScale(1.1)
		end

		if playerMO then
			self._playericonright:onUpdateMO(playerMO)
		else
			self._playericonright:setMOValue(self._mo.senderId, self._mo.senderName, self._mo.level, self._mo.portrait, 0)
		end

		self._playericonright:setShowLevel(false)

		self._txtnameright.text = self._mo:getSenderName()
		self._txtcontentright.text = LuaUtil.replaceSpace(self._mo.content)

		gohelper.setActive(self._btnopright, isShowOp)

		if isShowOp then
			self._txtopright.text = self:_getOpTetStr(self._mo.msgType)
		end
	else
		if not self._playericonleft then
			self._playericonleft = IconMgr.instance:getCommonPlayerIcon(self._goplayericonleft)

			self._playericonleft:setScale(1.1)
		end

		if playerMO then
			self._playericonleft:onUpdateMO(playerMO)
		else
			self._playericonleft:setMOValue(self._mo.senderId, self._mo.senderName, self._mo.level, self._mo.portrait, 0)
		end

		self._playericonleft:setShowLevel(false)

		local name = self._mo:getSenderName()

		if playerMO and not string.nilorempty(playerMO.desc) then
			self._txtnameleft.text = playerMO.desc
		end

		self._txtcontentleft.text = LuaUtil.replaceSpace(self._mo.content)

		gohelper.setActive(self._btnopleft, isShowOp)

		if isShowOp then
			self._txtopleft.text = self:_getOpTetStr(self._mo.msgType)
		end
	end
end

function SocialMessageItem:_getOpTetStr(msgType)
	if ChatEnum.MsgTypeOPLang[msgType] then
		return luaLang(ChatEnum.MsgTypeOPLang[msgType])
	end

	return ""
end

function SocialMessageItem:updateDesc(id)
	if id == self._mo.senderId then
		self:_refresh()
	end
end

function SocialMessageItem:onUpdateMO(mo)
	self._mo = mo

	self:_refresh()
end

function SocialMessageItem:onDestroy()
	return
end

return SocialMessageItem
