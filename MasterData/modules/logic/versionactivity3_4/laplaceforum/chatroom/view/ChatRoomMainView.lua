-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/view/ChatRoomMainView.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.view.ChatRoomMainView", package.seeall)

local ChatRoomMainView = class("ChatRoomMainView", BaseView)

function ChatRoomMainView:onInitView()
	self._gochatroom = gohelper.findChild(self.viewGO, "root/#go_chatroom")
	self._golucyraintip = gohelper.findChild(self.viewGO, "root/#go_lucyraintip")
	self._btnluckyrain = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_lucyraintip/#btn_lucyrain")
	self._txtluckyname = gohelper.findChildText(self.viewGO, "root/#go_lucyraintip/txt_name")
	self._txtluckytime = gohelper.findChildText(self.viewGO, "root/#go_lucyraintip/#txt_lucytime")
	self._goluckyrainreddot = gohelper.findChild(self.viewGO, "root/#go_lucyraintip/#go_luckyrainreddot")
	self._goraineff = gohelper.findChild(self.viewGO, "root/#go_lucyraintip/vx_loop")
	self._gonpcinteract = gohelper.findChild(self.viewGO, "root/#go_npcinteract")
	self._txtname = gohelper.findChildText(self.viewGO, "root/#go_npcinteract/#txt_name")
	self._imagenpcicon = gohelper.findChildImage(self.viewGO, "root/#go_npcinteract/#image_npcicon")
	self._btnnpc = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_npcinteract/#btn_npc")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ChatRoomMainView:addEvents()
	self._btnluckyrain:AddClickListener(self._btnluckyrainOnClick, self)
	self._btnnpc:AddClickListener(self._btnnpcOnClick, self)
end

function ChatRoomMainView:removeEvents()
	self._btnluckyrain:RemoveClickListener()
	self._btnnpc:RemoveClickListener()
end

function ChatRoomMainView:_btnluckyrainOnClick()
	local isLuckyRainEnd = ChatRoomModel.instance:isActLuckyRainEnd()

	if isLuckyRainEnd then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	local isInLuckyRain, rainId = ChatRoomModel.instance:isInLuckyRain()

	if isInLuckyRain then
		local isRewardGet = ChatRoomModel.instance:isRainRewardGet(rainId)

		if isRewardGet then
			local limitTime = ChatRoomModel.instance:getNextRainLimitTime()

			if limitTime <= 0 then
				GameFacade.showToast(ToastEnum.HasGetLuckyRainReward)
			else
				limitTime = limitTime + TimeUtil.OneMinuteSecond

				local time, format = TimeUtil.secondToRoughTime2(limitTime, false)

				GameFacade.showToast(ToastEnum.NextLuckyRainWillOpen, time .. format)
			end

			return
		end

		local isCouldGet, _ = ChatRoomModel.instance:isRainRewardCouldGet(rainId)

		if isCouldGet then
			Activity225Rpc.instance:sendAct225RedEnvelopeRainStartRequest(self._actId, self._onRainStart, self)
		end

		return
	end

	local limitTime = ChatRoomModel.instance:getNextRainLimitTime()

	if limitTime <= 0 then
		GameFacade.showToast(ToastEnum.HasGetLuckyRainReward)
	else
		limitTime = limitTime + TimeUtil.OneMinuteSecond

		local time, format = TimeUtil.secondToRoughTime2(limitTime, false)

		GameFacade.showToast(ToastEnum.NextLuckyRainWillOpen, time .. format)
	end
end

function ChatRoomMainView:_onRainStart(cmd, resultCode)
	if resultCode ~= 0 then
		return
	end

	ChatRoomController.instance:openChatRoomLuckyRainView()
end

function ChatRoomMainView:_btnnpcOnClick()
	if self._curNpcType == ChatRoomEnum.NpcType.Player then
		local myUserId = PlayerModel.instance:getMyUserId()
		local playerSelf = myUserId == self.interactRoleInfo.roleId

		if playerSelf then
			local playerInfo = PlayerModel.instance:getPlayinfo()

			ChatRoomController.instance:openNpcPlayerInfoView(playerInfo, true)
		else
			PlayerRpc.instance:sendGetOtherPlayerInfoRequest(self.interactRoleInfo.roleId, self._getPlayerInfo, self)
		end
	elseif self._curNpcType == ChatRoomEnum.NpcType.FingerGame then
		ChatRoomController.instance:openChatRoomFingerGameView()
	elseif self._curNpcType == ChatRoomEnum.NpcType.EasterEgg then
		local eggId = self.interactRoleInfo.roleId

		ChatRoomController.instance:openNpcEasterEggView(eggId)
	elseif self._curNpcType == ChatRoomEnum.NpcType.QAndA then
		local questionId = ChatRoomModel.instance:getCurQuestionId()

		if questionId and questionId > 0 then
			ChatRoomController.instance:openNpcQAndAView(questionId)
		end
	end
end

function ChatRoomMainView:_getPlayerInfo(cmd, resultCode, msg)
	if resultCode == 0 then
		ChatRoomController.instance:openNpcPlayerInfoView(msg.playerInfo)
	end
end

function ChatRoomMainView:_editableInitView()
	self:_addSelfEvents()

	self._actId = VersionActivity3_4Enum.ActivityId.LaplaceChatRoom
	self._npcAnim = self._gonpcinteract:GetComponent(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(self._goluckyrainreddot, RedDotEnum.DotNode.V3a4LaplaceChatRoomLuckyRain)
end

function ChatRoomMainView:_addSelfEvents()
	self.addEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnShowNpcPlayerType, self._onShowNpcType, self)
	self.addEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnLucyRainBack, self._refreshLuckyRain, self)
end

function ChatRoomMainView:_removeSelfEvents()
	self.removeEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnShowNpcPlayerType, self._onShowNpcType, self)
	self.removeEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnLucyRainBack, self._refreshLuckyRain, self)
end

function ChatRoomMainView:onOpen()
	self:_refreshUI()
	self:_checkLuckyRainChanged()
	TaskDispatcher.runRepeat(self._checkLuckyRainChanged, self, 0.5)
end

function ChatRoomMainView:_onShowNpcType(roleInfo)
	self.interactRoleInfo = roleInfo

	self:_refreshNpcItem()
end

function ChatRoomMainView:_refreshNpcItem()
	if self.interactRoleInfo then
		if self._curNpcType == self.interactRoleInfo then
			if not self._curNpcType then
				gohelper.setActive(self._gonpcinteract, false)
			end

			return
		end

		self._curNpcType = self.interactRoleInfo

		if not self._curNpcType or self._curNpcType <= 0 then
			return
		end

		local interactCo = Activity225Config.instance:getNpcInteractCo(self._curNpcType)

		if interactCo then
			self._txtname.text = interactCo.interactiveTxt or ""
		end

		gohelper.setActive(self._gonpcinteract, self._curNpcType and self._curNpcType > 0)
		UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._imagenpcicon, interactCo.interactivePng)
	end
end

function ChatRoomMainView:_refreshUI()
	self:_refreshLuckyRain()
end

function ChatRoomMainView:_checkLuckyRainChanged()
	local isLuckyRainEnd = ChatRoomModel.instance:isActLuckyRainEnd()

	if isLuckyRainEnd then
		TaskDispatcher.cancelTask(self._checkLuckyRainChanged, self)

		return
	end

	local isInLuckyRain, rainId = ChatRoomModel.instance:isInLuckyRain()

	if not isInLuckyRain then
		local limitTime = ChatRoomModel.instance:getNextRainLimitTime() + TimeUtil.OneMinuteSecond
		local time, format = TimeUtil.secondToRoughTime2(limitTime, false)

		self._txtluckytime.text = string.format(luaLang("seasonmainview_timeopencondition"), time .. format)
	end

	if self._isInLuckyRain == nil then
		self._isInLuckyRain = isInLuckyRain
	end

	if isInLuckyRain == self._isInLuckyRain then
		return
	end

	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.V3a4LaplaceChatRoomLuckyRain
	})
	self:_refreshLuckyRain()

	self._isInLuckyRain = isInLuckyRain
end

function ChatRoomMainView:_refreshLuckyRain()
	gohelper.setActive(self._goraineff, false)

	local isLuckyRainEnd = ChatRoomModel.instance:isActLuckyRainEnd()

	gohelper.setActive(self._golucyraintip, not isLuckyRainEnd)

	if isLuckyRainEnd then
		return
	end

	local curRainId = ChatRoomModel.instance:getCurRainId()
	local total = #Activity225Config.instance:getRedEnvelopRainCos()

	self._txtluckyname.text = GameUtil.getSubPlaceholderLuaLang(luaLang("laplace_chatroom_luckyrain_title"), {
		curRainId,
		total
	})

	local isInLuckyRain, rainId = ChatRoomModel.instance:isInLuckyRain()

	if not isInLuckyRain then
		local limitTime = ChatRoomModel.instance:getNextRainLimitTime() + TimeUtil.OneMinuteSecond
		local time, format = TimeUtil.secondToRoughTime2(limitTime, false)

		self._txtluckytime.text = string.format(luaLang("seasonmainview_timeopencondition"), time .. format)

		return
	end

	local isRewardGet = ChatRoomModel.instance:isRainRewardGet(rainId)

	if isRewardGet then
		self._txtluckytime.text = luaLang("laplace_chatroom_luckyrain_finish")

		return
	end

	gohelper.setActive(self._goraineff, true)

	self._txtluckytime.text = luaLang("laplace_chatroom_luckyrain_unlock")
end

function ChatRoomMainView:onClose()
	TaskDispatcher.cancelTask(self._checkLuckyRainChanged, self)
end

function ChatRoomMainView:onDestroyView()
	self:_removeSelfEvents()
end

return ChatRoomMainView
