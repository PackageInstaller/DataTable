-- chunkname: @modules/logic/mail/view/MailView.lua

module("modules.logic.mail.view.MailView", package.seeall)

local MailView = class("MailView", BaseView)

function MailView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg")
	self._simagebgleft = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bgleft")
	self._simagewave = gohelper.findChildSingleImage(self.viewGO, "mailtipview/#go_right/#simage_wave")
	self._btndeleteallmail = gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_deleteallmail")
	self._btngetallbatch = gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_getallbatch")
	self._txtmailcount = gohelper.findChildText(self.viewGO, "mailtipview/mailcount/mailcount/#txt_mailcount")
	self._txtunreadmailcount = gohelper.findChildText(self.viewGO, "mailtipview/mailcount/#txt_unreadmailcount")
	self._goemptyleft = gohelper.findChild(self.viewGO, "mailtipview/#go_emptyleft")
	self._goemptyright = gohelper.findChild(self.viewGO, "mailtipview/#go_emptyright")
	self._goright = gohelper.findChild(self.viewGO, "mailtipview/#go_right")
	self._imgstamp = gohelper.findChildImage(self.viewGO, "mailtipview/#go_right/#image_stamp")
	self._scrollcontent = gohelper.findChildScrollRect(self.viewGO, "mailtipview/#go_right/#scroll_content")
	self._sccontent = gohelper.findChild(self.viewGO, "mailtipview/#go_right/#scroll_content/viewport/content")
	self._txtmailTitle = gohelper.findChildText(self.viewGO, "mailtipview/#go_right/#txt_mailTitle")
	self._txtsender = gohelper.findChildText(self.viewGO, "mailtipview/#go_right/sender/#txt_sender")
	self._txtsendtxt = gohelper.findChildText(self.viewGO, "mailtipview/#go_right/senddate/#txt_sendtxt")
	self._txtexpireTime = gohelper.findChildText(self.viewGO, "mailtipview/#go_right/time/#txt_expireTime")
	self._gosignature = gohelper.findChild(self.viewGO, "mailtipview/#go_right/#scroll_content/viewport/content/#go_signature")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "mailtipview/#go_right/#go_rewards/#scroll_reward")
	self._btnget = gohelper.findChildButtonWithAudio(self.viewGO, "mailtipview/#go_right/#btn_get")
	self._gohasgotten = gohelper.findChild(self.viewGO, "mailtipview/#go_right/#go_rewards/#go_hasgotten")
	self._imagehasgottenbg = gohelper.findChildImage(self.viewGO, "mailtipview/#go_right/#go_rewards/#go_hasgotten/#image_hasgottenbg")
	self._gorewardItem = gohelper.findChild(self.viewGO, "mailtipview/#go_right/#scroll_enclosure/Viewport/Content/#go_rewardItem")
	self._goselectone = gohelper.findChild(self.viewGO, "mailtipview/#go_selectone")
	self._imagetopicon = gohelper.findChildImage(self.viewGO, "mailtipview/#go_left/#image_topicon")
	self._rewardContent = gohelper.findChild(self.viewGO, "mailtipview/#go_right/#go_rewards/#scroll_reward/viewport/content")
	self._contentTrs = self._rewardContent.transform
	self._gorewardsBg = gohelper.findChild(self.viewGO, "mailtipview/#go_right/#go_rewards/#go_rewardsBg")
	self._gojump = gohelper.findChild(self.viewGO, "mailtipview/#go_right/#go_jump")
	self._txtjump = gohelper.findChildText(self.viewGO, "mailtipview/#go_right/#go_jump/#txt_jump")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "mailtipview/#go_right/#go_jump/#txt_jump/#btn_jump")
	self._scrollmail = gohelper.findChildScrollRect(self.viewGO, "mailtipview/#go_left/#scroll_mail")
	self._gomonthcard = gohelper.findChild(self.viewGO, "mailtipview/#go_right/#go_monthcard")
	self._btnrenew = gohelper.findChildButtonWithAudio(self.viewGO, "mailtipview/#go_right/#go_monthcard/#btn_renew")
	self._simagecardicon = gohelper.findChildSingleImage(self.viewGO, "mailtipview/#go_right/#go_monthcard/#simage_cardicon")
	self._gomodifyname = gohelper.findChild(self.viewGO, "mailtipview/#go_right/#go_modifyname")
	self._btnmodifyname = gohelper.findChildButtonWithAudio(self.viewGO, "mailtipview/#go_right/#go_modifyname/#btn_modifyname")
	self._btnLock = gohelper.findChildButtonWithAudio(self.viewGO, "mailtipview/#go_right/#txt_mailTitle/#btn_Lock")
	self._goLock = gohelper.findChild(self.viewGO, "mailtipview/#go_right/#txt_mailTitle/#btn_Lock/#go_Lock")
	self._goUnlock = gohelper.findChild(self.viewGO, "mailtipview/#go_right/#txt_mailTitle/#btn_Lock/#go_Unlock")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MailView:addEvents()
	self._btndeleteallmail:AddClickListener(self._btndeleteallmailOnClick, self)
	self._btngetallbatch:AddClickListener(self._btngetallbatchOnClick, self)
	self._btnget:AddClickListener(self._btngetOnClick, self)
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
	self._btnrenew:AddClickListener(self._btnrenewOnClick, self)
	self._btnmodifyname:AddClickListener(self._btnmodifynameOnClick, self)
	self._btnLock:AddClickListener(self._btnLockOnClick, self)
end

function MailView:removeEvents()
	self._btndeleteallmail:RemoveClickListener()
	self._btngetallbatch:RemoveClickListener()
	self._btnget:RemoveClickListener()
	self._btnjump:RemoveClickListener()
	self._btnrenew:RemoveClickListener()
	self._btnmodifyname:RemoveClickListener()
	self._btnLock:RemoveClickListener()
	self._scrollcontent:RemoveOnValueChanged()
end

function MailView:_btndeleteallmailOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.MailSureToDeleteAll, MsgBoxEnum.BoxType.Yes_No, function()
		MailRpc.instance:sendDeleteMailBatchRequest(1)
	end)
end

function MailView:_btngetallbatchOnClick()
	MailRpc.instance:sendReadMailBatchRequest(1)
end

function MailView:_btnrenewOnClick()
	StoreController.instance:openStoreView(StoreEnum.StoreId.Package, StoreEnum.MonthCardGoodsId)
end

function MailView:_btnmodifynameOnClick()
	self:closeThis()

	local playerInfo = PlayerModel.instance:getPlayinfo()

	PlayerController.instance:openPlayerView(playerInfo, true)
	ViewMgr.instance:openView(ViewName.PlayerModifyNameView)
end

function MailView:_btngetOnClick()
	if self._selectMO and self._selectMO.state ~= MailEnum.ReadStatus.Read then
		MailRpc.instance:sendReadMailRequest(self._selectMO.id)
	end
end

function MailView:_btnjumpOnClick()
	local jump = self._selectMO:getJumpLink()

	if self._selectMO and not string.nilorempty(jump) then
		local rawUrl, id = string.match(jump, "^SoJump#(.+)#(.+)$")

		if rawUrl then
			local data = {}

			data.url = rawUrl
			data.id = id

			local resultJson = cjson.encode(data)

			SDKMgr.instance:openSoJump(resultJson)
		else
			GameUtil.openURL(self:_analysisJumpUrl(jump))
		end

		MailRpc.instance:sendMarkMailJumpRequest(self._selectMO.id)
		self:_onClickUrlTrack(self._selectMO, jump)
	end
end

require("tolua.reflection")
tolua.loadassembly("SL_AS")

local MailView_SdkNativeUtil_Type = tolua.findtype("gamesdk.SdkNativeUtil")
local MailView_BoolReturnMethod = tolua.getmethod(MailView_SdkNativeUtil_Type, "BoolReturnMethod", typeof("System.String"), typeof("System.String"), typeof("System.String"))

function MailView:_analysisJumpUrl(url)
	local arr = string.split(url, "|")

	if #arr > 1 then
		local urlType = arr[1]

		if urlType == "TrafficJump" then
			local WXURL = arr[2]
			local noWXURL = arr[3]

			if not arr[4] then
				local biz_name = ""

				if string.len(biz_name) > 0 then
					biz_name = string.urlencode(string.urlencode(biz_name))
				end

				local hasWX = MailView_BoolReturnMethod:Call(SDKNativeUtil.nativeClsName, "isPlatformClientValid", "2")
				local finalUrl = hasWX and WXURL or noWXURL

				finalUrl = not string.find(finalUrl, "?") and finalUrl .. "?" or finalUrl .. "&"

				local timestamp = ServerTime.now()
				local salt = "881957120b6dc0ce40470e55cd433cd3"
				local userId = SDKMgr.instance:getGameId() .. "|" .. LoginModel.instance.channelUserId .. "|" .. PlayerModel.instance:getMyUserId()

				userId = Base64Util.encode(userId)

				local signStr = userId .. "|" .. biz_name .. "|" .. LoginModel.instance.channelId .. "|" .. timestamp .. "|" .. salt
				local sign = GameLuaMD5.sumhexa(signStr)
				local extend = sign .. "|" .. timestamp .. "|" .. SDKMgr.instance:getChannelId()
				local extendBase64 = Base64Util.encode(extend)

				finalUrl = finalUrl .. "userid=" .. userId .. "&biz_name=" .. biz_name .. "&extend=" .. extendBase64

				return finalUrl
			end
		elseif urlType == "H5AutoLogin" then
			return (WebViewController.instance:getRecordUserUrl(arr[2]))
		end
	end

	return url
end

function MailView:_btnLockOnClick()
	if self._selectMO and self._selectMO:hasLockOp() then
		local isLock = self._selectMO.isLock ~= true

		if isLock and MailModel.instance:getLockCount() >= MailModel.instance:getLockMax() then
			GameFacade.showToast(ToastEnum.V3a2MailMaxLock)

			return
		end

		MailRpc.instance:sendMailLockRequest(self._selectMO.id, isLock)
	end
end

function MailView:_editableInitView()
	self.addEventCb(self, MailController.instance, MailEvent.OnMailCountChange, self._refreshCount, self)
	self.addEventCb(self, MailController.instance, MailEvent.UpdateSelectMail, self._updateSelectMail, self)
	self.addEventCb(self, MailController.instance, MailEvent.OnMailRead, self._onMailRead, self)
	self.addEventCb(self, MailController.instance, MailEvent.OnMailDel, self._onMailDel, self)
	self.addEventCb(self, MailController.instance, MailEvent.OnMailLockReply, self._onMailLock, self)
	gohelper.setActive(self._gomodifyname, false)

	self.orginalPos = self._scrollreward.transform.localPosition
	self._txtsignature = self._gosignature:GetComponent(typeof(TMPro.TMP_Text))
	self._rectmask2DOneWay = self._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2DOneWay))
	self._rectmask2DOneWay.enabled = true

	self._simagebg:LoadImage(ResUrl.getMailBg("mail_bg2"))
	self._simagebgleft:LoadImage(ResUrl.getMailBg("mail_bg1"))
	self._simagewave:LoadImage(ResUrl.getMailBg("huawen_003"))
	self._simagecardicon:LoadImage(ResUrl.getMailBg("bg_youjiantishi"))
	gohelper.setActive(self._goright, false)
	gohelper.setActive(self._gorewardItem, false)
	MailModel.instance:setMailList()
	self:_refreshCount()
	gohelper.addUIClickAudio(self._btndeleteallmail.gameObject, AudioEnum.UI.UI_Mail_delete)

	self._hyperLinkClick = self._txtsignature:GetComponent(typeof(ZProj.TMPHyperLinkClick))

	self._hyperLinkClick:SetClickListener(self._onHyperLinkClick, self)
end

function MailView:_onHyperLinkClick(url)
	if not string.nilorempty(url) then
		local rawUrl, id = string.match(url, "^SoJump#(.+)#(.+)$")

		if rawUrl then
			local data = {}

			data.url = rawUrl
			data.id = id

			local resultJson = cjson.encode(data)

			SDKMgr.instance:openSoJump(resultJson)
		else
			GameUtil.openURL(url)
		end
	end

	self:_onClickUrlTrack(nil, url)
end

function MailView:_onClickUrlTrack(mo, url)
	local mailMO = mo or self._selectMO

	if not mailMO or string.nilorempty(url) then
		return
	end

	local mailInfoList = {
		{
			id = mailMO.id,
			mail_id = mailMO.mailId,
			title = mailMO.title,
			url = url
		}
	}

	StatController.instance:track(StatEnum.EventName.MailUrClick, {
		[StatEnum.EventProperties.MailInfo] = mailInfoList
	})
end

function MailView:_refreshCount()
	self:_trySelectFirstMail()

	local count = MailModel.instance:getCount()
	local unreadCount = MailModel.instance:getUnreadCount()

	self._txtmailcount.text = count .. "/" .. CommonConfig.instance:getConstStr(ConstEnum.MailMaxCount)
	self._txtunreadmailcount.text = unreadCount

	gohelper.setActive(self._goemptyright, count <= 0)
	gohelper.setActive(self._goemptyleft, count <= 0)
	gohelper.setActive(self._imagetopicon.gameObject, count > 0)
	gohelper.setActive(self._goselectone, not self._selectMO and count > 0)
end

function MailView:_trySelectFirstMail()
	local mailList = MailCategroyModel.instance:getList()

	if not self._selectMO and #mailList > 0 then
		self._scrollmail.verticalNormalizedPosition = 1

		MailCategroyModel.instance:selectCell(1, true)
	end
end

function MailView:_updateSelectMail(mo)
	if self._selectMO then
		local update = self._selectMO.id == mo.id

		self._selectMO = mo

		gohelper.setActive(self._goright, self._selectMO)

		local count = MailModel.instance:getCount()

		gohelper.setActive(self._goselectone, not self._selectMO and count > 0)

		if not update then
			self._txtmailTitle.text = mo:getLangTitle()
			self._txtsender.text = mo:getLangSender()
			self._txtsendtxt.text = TimeUtil.timestampToString3(mo.createTime / 1000)
			self._txtexpireTime.text = self:_getExpireTimeString(mo.expireTime)
			self._txtsignature.text = mo:getLangContent()
			self.senderType = "img_yp_" .. mo:getSenderType()

			UISpriteSetMgr.instance:setMailSprite(self._imgstamp, self.senderType, true)

			if string.nilorempty(mo:getJumpLink()) then
				gohelper.setActive(self._gojump.gameObject, false)
			else
				gohelper.setActive(self._gojump.gameObject, true)

				self._txtjump.text = type(mo.jumpTitle) ~= "table" and string.nilorempty(mo.jumpTitle) and luaLang("mail_jump_title") or mo:getTemplateJumpTitle()
			end

			self._scrollcontent.verticalNormalizedPosition = 1
			self._scrollreward.horizontalNormalizedPosition = 0

			if mo:haveBonus() then
				gohelper.setActive(self._scrollreward.gameObject, true)
			else
				if mo.state ~= MailEnum.ReadStatus.Read then
					MailRpc.instance:sendReadMailRequest(mo.id)
				end

				gohelper.setActive(self._scrollreward.gameObject, false)
			end

			self:handleSpecialTag(mo)
		end

		if mo:haveBonus() then
			gohelper.setActive(self._btnget.gameObject, mo.state ~= MailEnum.ReadStatus.Read)
			gohelper.setActive(self._gohasgotten.gameObject, mo.state == MailEnum.ReadStatus.Read)
			gohelper.setActive(self._gorewardsBg, true)

			local itemList = ItemConfig.instance:getStackItemList(mo.itemGroup)

			for i, item in ipairs(itemList) do
				item.state = mo.state
			end

			recthelper.setWidth(self._imagehasgottenbg.transform, 318 + 60 * math.min(5, #itemList - 1))

			local rewardRes = self.viewContainer._viewSetting.otherRes[2]

			self._rewards = self._rewards or {}

			for i = 1, #itemList do
				if not self._rewards[i] then
					local go = self:getResInst(rewardRes, self._rewardContent)

					self._rewards[i] = MailRewardItem.New()

					self._rewards[i]:init(go)
				end

				gohelper.setActive(self._rewards[i].go, true)
				self._rewards[i]:onUpdateMO(itemList[i])
			end

			for i = #itemList + 1, #self._rewards do
				gohelper.setActive(self._rewards[i].go, false)
			end

			transformhelper.setLocalPosXY(self._scrollreward.transform, 999999, 999999)
			TaskDispatcher.runDelay(self.setRewardsPos, self, 0)
		else
			gohelper.setActive(self._btnget.gameObject, false)
			gohelper.setActive(self._gohasgotten.gameObject, false)
			gohelper.setActive(self._gorewardsBg.gameObject, false)
		end

		self:_setMailScrollHeight((string.nilorempty(mo:getJumpLink()) or nil) and (not mo:haveBonus() and mo.specialTag ~= MailEnum.SpecialTag.MonthExpired and 570 or 375))
		self:_setContentHeight()

		local scrollheight = recthelper.getHeight(self._scrollcontent.transform)
		local contentheight = recthelper.getHeight(self._sccontent.transform)

		self._rectmask2DOneWay.enabled = scrollheight < contentheight

		self:_updateMailLockUI()
	end
end

function MailView:_updateMailLockUI()
	if self._selectMO then
		local hasLockOp = self._selectMO:hasLockOp()

		gohelper.setActive(self._btnLock, self._selectMO)

		if self._selectMO then
			local isLock = self._selectMO.isLock

			gohelper.setActive(self._goLock, isLock)
			gohelper.setActive(self._goUnlock, not isLock)
		end
	end
end

function MailView:_setContentHeight()
	local padding = 10
	local goheight = recthelper.getHeight(self._txtsignature.transform)
	local height = goheight + padding

	recthelper.setHeight(self._sccontent.transform, height)
end

function MailView:handleSpecialTag(mo)
	if mo ~= nil and mo.specialTag ~= 0 then
		gohelper.setActive(self._gomonthcard, mo.specialTag == MailEnum.SpecialTag.MonthExpired)
		gohelper.setActive(self._gomodifyname, mo.specialTag == MailEnum.SpecialTag.ModifyName)
	else
		gohelper.setActive(self._gomonthcard, false)
		gohelper.setActive(self._gomodifyname, false)
	end
end

function MailView:setRewardsPos()
	if not self._contentTrs then
		return
	end

	local contentWidth = recthelper.getWidth(self._contentTrs)
	local maxWidth = recthelper.getWidth(self._scrollreward.transform)

	transformhelper.setLocalPosXY(self._scrollreward.transform, maxWidth <= contentWidth and self.orginalPos.x or self.orginalPos.x + (maxWidth - contentWidth) / 2, self.orginalPos.y)
end

function MailView:_onMailRead(ids)
	if self._selectMO then
		for i, id in ipairs(ids) do
			if self._selectMO.id == id then
				self:_updateSelectMail(self._selectMO)
			end
		end
	end
end

function MailView:_onMailDel(ids)
	if self._selectMO then
		for i, id in ipairs(ids) do
			if self._selectMO and self._selectMO.id == id then
				gohelper.setActive(self._goright, false)

				self._selectMO = nil
			end
		end
	end
end

function MailView:_onMailLock(id, isLock)
	MailCategroyModel.instance:onModelUpdate()
	self:_updateMailLockUI()
end

function MailView:onUpdateParam()
	return
end

function MailView:onDestroyView()
	if self._rewards then
		for i = 1, #self._rewards do
			self._rewards[i]:onDestroy()
		end
	end

	self._simagebg:UnLoadImage()
	self._simagebgleft:UnLoadImage()
	self._simagewave:UnLoadImage()
	self._simagecardicon:UnLoadImage()
end

function MailView:onOpen()
	return
end

function MailView:onClose()
	return
end

function MailView:_getExpireTimeString(time)
	if time == 0 then
		return luaLang("mail_not_expire_time")
	end

	local time1 = time / 1000
	local expTime1 = time1 - ServerTime.now()

	if expTime1 <= 0 then
		return ""
	end

	expTime1 = expTime1 / 86400

	local day = expTime1

	if day > 1 then
		return string.format("%d", day) .. luaLang("mail_dayslate")
	else
		local hour = day * 24

		if hour > 1 then
			return string.format("%d", hour) .. luaLang("mail_hourlate")
		else
			local minute = hour * 60

			if minute > 1 then
				return string.format("%d", minute) .. luaLang("mail_minutelate")
			else
				return 1 .. luaLang("mail_minutelate")
			end
		end
	end
end

function MailView:_setMailScrollHeight(_perfectScrollHeight)
	local _gomailcontent = gohelper.findChild(self._scrollcontent.gameObject, "viewport/content")

	ZProj.UGUIHelper.RebuildLayout(_gomailcontent.transform)

	local _curmailcontentHeight = recthelper.getHeight(_gomailcontent.transform)

	recthelper.setHeight(self._scrollcontent.transform, _perfectScrollHeight)

	self.couldScroll = _perfectScrollHeight < _curmailcontentHeight
end

return MailView
