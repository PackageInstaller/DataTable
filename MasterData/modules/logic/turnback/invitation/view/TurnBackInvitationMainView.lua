-- chunkname: @modules/logic/turnback/invitation/view/TurnBackInvitationMainView.lua

module("modules.logic.turnback.invitation.view.TurnBackInvitationMainView", package.seeall)

local TurnBackInvitationMainView = class("TurnBackInvitationMainView", BaseView)

TurnBackInvitationMainView.TIME_REFRESH_DURATION = 10

function TurnBackInvitationMainView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/Right/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/Right/#txt_LimitTime")
	self._txtnum = gohelper.findChildText(self.viewGO, "Root/Right/#txt_num")
	self._scrolldes = gohelper.findChildScrollRect(self.viewGO, "Root/Right/#scroll_des")
	self._btninvite = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Right/#btn_invite")
	self._btncopy = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Right/#btn_copy")
	self._simagebook = gohelper.findChildSingleImage(self.viewGO, "Root/Left/#simage_book")
	self._txttitle = gohelper.findChildText(self.viewGO, "Root/Left/#txt_title")
	self._simageplayerheadicon = gohelper.findChildSingleImage(self.viewGO, "Root/Left/#simage_playerheadicon")
	self._goframenode = gohelper.findChild(self.viewGO, "Root/Left/#simage_playerheadicon/#go_framenode")
	self._goplayer1 = gohelper.findChild(self.viewGO, "Root/Left/#go_player1")
	self._goplayer2 = gohelper.findChild(self.viewGO, "Root/Left/#go_player2")
	self._goplayer3 = gohelper.findChild(self.viewGO, "Root/Left/#go_player3")
	self._goLongClick = gohelper.findChild(self.viewGO, "Root/Right/#go_copyLongClick")
	self._btnCopyClick = gohelper.findChildClick(self.viewGO, "Root/Right/#go_copyLongClick")
	self._btnreward = gohelper.findChildClick(self.viewGO, "Root/Right/#btn_reward")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TurnBackInvitationMainView:addEvents()
	self._btninvite:AddClickListener(self._btninviteOnClick, self)
	self._btncopy:AddClickListener(self._btncopyOnClick, self)
	self._btnCopyClick:AddClickListener(self._btncopyOnClick, self)
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self._btnCopyLongPress:AddLongPressListener(self._btncopyOnClick, self)
	self.addEventCb(self, TurnBackInvitationController.instance, TurnBackInvitationEvent.OnGetInfoSuccess, self._refreshUI, self)
end

function TurnBackInvitationMainView:removeEvents()
	self._btninvite:RemoveClickListener()
	self._btncopy:RemoveClickListener()
	self._btnCopyClick:RemoveClickListener()
	self._btnreward:RemoveClickListener()
	self._btnCopyLongPress:RemoveLongPressListener()
	self.removeEventCb(self, TurnBackInvitationController.instance, TurnBackInvitationEvent.OnGetInfoSuccess, self._refreshUI, self)
end

function TurnBackInvitationMainView:_btninviteOnClick()
	local url = TurnBackInvitationModel.instance:getLoginUrl()

	WebViewController.instance:openWebView(url, false, self.OnWebViewBack, self)
end

function TurnBackInvitationMainView:_btncopyOnClick()
	local activityInfo = TurnBackInvitationModel.instance:getInvitationInfo(self._actId)

	if not activityInfo then
		return
	end

	local inviteCode = activityInfo.inviteCode

	if not inviteCode then
		return
	end

	ZProj.UGUIHelper.CopyText(inviteCode)
	ToastController.instance:showToast(ToastEnum.ClickPlayerId)
end

function TurnBackInvitationMainView:_btnrewardOnClick()
	local itemId = CurrencyEnum.CurrencyType.FreeDiamondCoupon

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, itemId, false, nil, nil)
end

function TurnBackInvitationMainView:OnWebViewBack(errorType, msg)
	if errorType == WebViewEnum.WebViewCBType.Cb then
		local msgParamList = string.split(msg, "#")
		local eventName = msgParamList[1]

		if eventName == "webClose" then
			TurnBackInvitationController.instance:getInvitationInfo(self._actId)
			ViewMgr.instance:closeView(ViewName.WebView)
		elseif eventName == "saveImage" and msgParamList[2] then
			Base64Util.saveImage(msgParamList[2])
		end
	end
end

function TurnBackInvitationMainView:_editableInitView()
	self._friendItemList = {}

	local goList = {
		self._goplayer1,
		self._goplayer2,
		self._goplayer3,
		self._goplayer4
	}

	for _, go in ipairs(goList) do
		local item = TurnBackInvitationFriendItem.New()

		item:init(go)
		table.insert(self._friendItemList, item)
	end

	self._loader = MultiAbLoader.New()
	self._btnCopyLongPress = SLFramework.UGUI.UILongPressListener.Get(self._goLongClick)

	self._btnCopyLongPress:SetLongPressTime({
		0.5,
		99999
	})
end

function TurnBackInvitationMainView:onUpdateParam()
	return
end

function TurnBackInvitationMainView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TurnBackH5.play_ui_rolesopen)
	self:_checkParent()
	self:_refreshData()
end

function TurnBackInvitationMainView:_refreshData()
	self._actId = self.viewParam.actId

	TurnBackInvitationController.instance:getInvitationInfo(self._actId)
end

function TurnBackInvitationMainView:_checkParent()
	local parentGO = self.viewParam.parent

	if parentGO then
		gohelper.addChild(parentGO, self.viewGO)
	end

	self._actId = self.viewParam.actId
end

function TurnBackInvitationMainView:_refreshUI()
	local activityInfo = TurnBackInvitationModel.instance:getInvitationInfo(self._actId)
	local len = #self._friendItemList
	local infoLen = #activityInfo.invitePlayers

	for i = 1, len do
		local item = self._friendItemList[i]

		if i <= infoLen then
			item:setData(activityInfo.invitePlayers[i])
		else
			item:setEmpty()
		end
	end

	self._txtnum.text = activityInfo.inviteCode

	self:_refreshTime()

	if TurnBackInvitationModel.instance:isActOpen(self._actId) then
		TaskDispatcher.runRepeat(self._refreshTime, self, self.TIME_REFRESH_DURATION)
	end

	self:_refreshPlayerInfo()
end

function TurnBackInvitationMainView:_refreshTime()
	local actInfo = ActivityModel.instance:getActMO(self._actId)
	local endTime = actInfo:getRealEndTimeStamp()
	local nowTime = ServerTime.now()

	if endTime <= nowTime then
		self._txtLimitTime.text = luaLang("ended")

		return
	end

	self._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(endTime - nowTime)
end

function TurnBackInvitationMainView:_refreshPlayerInfo()
	local info = PlayerModel.instance:getPlayinfo()
	local config = lua_item.configDict[info.portrait]

	self._liveHeadIcon = self._liveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._simageplayerheadicon)

	self._liveHeadIcon:setLiveHead(config.id)

	local lang = luaLang("turnabck_invitation_title")

	self._txttitle.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang, info.name)

	local effectArr = string.split(config.effect, "#")

	if #effectArr > 1 then
		if config.id == tonumber(effectArr[#effectArr]) then
			gohelper.setActive(self._goframenode, true)

			if not self.frame then
				local framePath = "ui/viewres/common/effect/frame.prefab"

				self._loader:addPath(framePath)
				self._loader:startLoad(self._onLoadCallback, self)
			end
		end
	else
		gohelper.setActive(self._goframenode, false)
	end
end

function TurnBackInvitationMainView:_onLoadCallback()
	local framePrefab = self._loader:getFirstAssetItem():GetResource()

	gohelper.clone(framePrefab, self._goframenode, "frame")

	self.frame = gohelper.findChild(self._goframenode, "frame")

	local img = self.frame:GetComponent(gohelper.Type_Image)

	img.enabled = false

	local iconwidth = recthelper.getWidth(self._simageplayerheadicon.transform)
	local framenodewidth = recthelper.getWidth(self.frame.transform)
	local scale = 1.41 * (iconwidth / framenodewidth)

	transformhelper.setLocalScale(self.frame.transform, scale, scale, 1)
end

function TurnBackInvitationMainView:onClose()
	TaskDispatcher.cancelTask(self._refreshTime, self)
end

function TurnBackInvitationMainView:onDestroyView()
	self._friendItemList = nil
end

function TurnBackInvitationMainView:registerEvent()
	return
end

function TurnBackInvitationMainView:unRegisterEvent()
	return
end

return TurnBackInvitationMainView
