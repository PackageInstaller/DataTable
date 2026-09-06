-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/social/view/NewMailView.lua

module("logic.extensions.social.view.NewMailView", package.seeall)

local NewMailView = class("NewMailView", ViewComponent)

function NewMailView:ctor()
	NewMailView.super.ctor(self)
end

function NewMailView:getBigBgList()
	return {
		{
			goPath = "goNoMailRight/imgxiaonuo",
			imageUrl = "ui/bigbg/pet/img_10140_xiaonuo.png"
		}
	}
end

function NewMailView:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnDelete:AddClickListener(self._onClickDelete, self)
	self._btnDeleteAll:AddClickListener(self._onClickDeleteAll, self)
	self._btnReceive:AddClickListener(self._onClickReceive, self)
	self._btnReceiveAll:AddClickListener(self._onClickReceiveAll, self)
	self._btnCopy:AddClickListener(self._onClickbtnCopy, self)
	self._btnLongPress:AddListener(self._onClickbtnLongPress, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function NewMailView:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnDelete:RemoveClickListener()
	self._btnDeleteAll:RemoveClickListener()
	self._btnReceive:RemoveClickListener()
	self._btnReceiveAll:RemoveClickListener()
	self._btnCopy:RemoveClickListener()
	self._btnLongPress:RemoveListener()
	self._customInput:RemoveListener()
end

function NewMailView:buildUI()
	self._btnClose = self:getBtn("btnClose")
	self._mailListView = goutil.findChildComponent(self.mainGO, "scrollMailList", "UITableview")
	self._mailCell = self:getGo("scrollMailList/mailCell")

	goutil.setActive(self._mailCell, false)
	self._mailListView:RegisterCallback(self._mailNumInView, self._mailCellSize, self._mailCellAtIndex, self)
	self._mailListView:RegisterUpdateCellCallback(self._updateMailCell)
	self._mailListView:SetOffsetWithoutRefresh(0)

	self._btnDelete = self:getBtn("goMailInfo/btnDelete")
	self._btnDeleteAll = self:getBtn("btnDeleteAll")
	self._btnReceive = self:getBtn("goMailInfo/btnReceive")
	self._btnReceiveAll = self:getBtn("btnReceiveAll")
	self._goNoMailLeft = self:getGo("goNoMailLeft")
	self._goNoMailRight = self:getGo("goNoMailRight")
	self._goMailInfo = self:getGo("goMailInfo")
	self._txtMailTips = goutil.findChildComponent(self._goNoMailRight, "txtMailTips", "Text")
	self._txtSendTime = goutil.findChildComponent(self._goMailInfo, "txtSendTime", "Text")
	self._txtContent = goutil.findChildComponent(self._goMailInfo, "scrollContent/txtContent", "Text")
	self._txtTitle = goutil.findChildComponent(self._goMailInfo, "txtTitle", "Text")
	self._txtSenderName = goutil.findChildComponent(self._goMailInfo, "txtSenderName", "Text")
	self._attachmentListView = goutil.findChildComponent(self._goMailInfo, "scrollAttachment", "UITableview")
	self._attachmentCell = goutil.findChild(self._goMailInfo, "attachmentCell")

	goutil.setActive(self._attachmentCell, false)
	self._attachmentListView:RegisterCallback(self._attachmentNumInView, self._attachmentCellSize, self._attachmentCellAtIndex, self)
	self._attachmentListView:RegisterUpdateCellCallback(self._updateAttachmentCell)
	self._attachmentListView:SetOffsetWithoutRefresh(0)

	self._txtAttachment = goutil.findChildComponent(self._goMailInfo, "txtAttachment", "Text")
	self._scrollRect = Framework.ScrollRectAdapter.GetFrom(self._goMailInfo, "scrollContent")

	self._scrollRect:AddOnValueChanged(self._onSrollValueChanged, self)

	self._mask = goutil.findChild(self._goMailInfo, "mask")
	self._rectContent = self._txtContent:GetComponent("RectTransform")
	self._scrollViewSizeY = self._scrollRect:GetComponent("RectTransform").sizeDelta.y

	print("y = " .. self._scrollViewSizeY)

	self._txtCount = self:getTxt("txtCount")
	self._btnCopy = self:getBtn("goMailInfo/bubble/btnCopy")
	self._btnLongPress = self:getGo("goMailInfo/scrollContent/txtContent/btnLongPress"):GetComponent(ComponentType.UILongPressed)
	self._bubbleGo = self:getGo("goMailInfo/bubble")
	self._customInput = UICustomInput.Get(self._bubbleGo)
	self._goMailInfoGoTr = self:getGo("goMailInfo"):GetComponent(goutil.Type_RectTransform)
	self._txtBtnCopy = self:getTxt("goMailInfo/bubble/btnCopy/txt")
end

local showMaskThreshold = 10

function NewMailView:_onSrollValueChanged(scroll)
	local isShowMask
	local dragSizeY = self._rectContent.sizeDelta.y - self._scrollViewSizeY
	local isShowMask = dragSizeY > 0 and scroll.y * dragSizeY > showMaskThreshold

	goutil.setActive(self._mask, isShowMask)
end

function NewMailView:_mailNumInView()
	return (self._mailViewDatas or nil) and (#self._mailViewDatas or 0)
end

function NewMailView:_mailCellSize()
	return 336, 82
end

function NewMailView:_mailCellAtIndex(view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._mailCell)
	cell.index = idx

	self:_updateMailCell(view, cell)

	return cell
end

function NewMailView:_updateMailCell(view, cell)
	local idx = cell.index
	local component = ItemMail.AddOnce(cell.gameObject)

	component:onSetMo(self._mailViewDatas[idx + 1])

	return cell
end

function NewMailView:_attachmentNumInView()
	return (self._attachmentViewDatas or nil) and (#self._attachmentViewDatas or 0)
end

function NewMailView:_attachmentCellSize()
	return 10, 100
end

function NewMailView:_attachmentCellAtIndex(view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._attachmentCell)
	cell.index = idx

	self:_updateAttachmentCell(view, cell)

	return cell
end

function NewMailView:_updateAttachmentCell(view, cell)
	local mailMo = MailModel.instance:getMailMoById(MailController.instance:getCurSelectedId())
	local mo = self._attachmentViewDatas[cell.index + 1]
	local point = goutil.findChild(cell.gameObject, "point")
	local proxy = MaterialMgr.setCellByCfg(mo, point)

	if proxy then
		proxy.binder:SetGray(mailMo.gained)
	end

	return cell
end

function NewMailView:destroyUI()
	return
end

function NewMailView:onEnter()
	MailController.instance:registerLocalNotify("selectedMail", self._onSelectMail, self)
	MailController.instance:registerLocalNotify("receiveMails", self._onReceiveMails, self)
	MailController.instance:registerLocalNotify("deleteMails", self._onDeleteMails, self)
	MailController.instance:registerLocalNotify("getMailDatas", self._refresh, self)
	MailBoxAgent.instance:sendGetUserMailsReq()
end

function NewMailView:_refresh(showIndex)
	self._mailViewDatas = MailModel.instance:getAllMails()

	self:_sortMails()

	local isEmpty = not (self._mailViewDatas and #self._mailViewDatas > 0)

	if self._mailViewDatas then
		if not #self._mailViewDatas then
			local count = 0

			self._txtCount.text = langPara("数量：%s/%s", count, SocialConfig.instance:getConfigCfgByKey("MAIL_MAX_SIZE"))

			goutil.setActive(self._goNoMailLeft, isEmpty)
			goutil.setActive(self._mailListView.gameObject, not isEmpty)

			if not isEmpty then
				MailController.instance:setCurSelectedId(self._mailViewDatas[1].mailId)
				self._mailListView:ReloadData()
			end

			self:_updateMailInfoUI()
		end
	end
end

function NewMailView:onEnterFinished()
	return
end

function NewMailView:onExit()
	MailController.instance:unregisterLocalNotify("selectedMail", self._onSelectMail, self)
	MailController.instance:unregisterLocalNotify("receiveMails", self._onReceiveMails, self)
	MailController.instance:unregisterLocalNotify("deleteMails", self._onDeleteMails, self)
	MailController.instance:unregisterLocalNotify("getMailDatas", self._refresh, self)
end

function NewMailView:onExitFinished()
	return
end

function NewMailView:_sortMails()
	if self._mailViewDatas then
		ArraySort.sortOn(self._mailViewDatas, {
			function(a)
				return a.read and 1 or 0
			end,
			function(a)
				return a:getHasAttachment() and 1 or 0
			end,
			function(a)
				return a:getIsNearInvalid() and 1 or 0
			end,
			"sendTime",
			"mailId"
		}, {
			ArraySort.NUMERIC,
			ArraySort.DESCENDING,
			ArraySort.DESCENDING,
			ArraySort.DESCENDING,
			ArraySort.NUMERIC
		})
	end
end

function NewMailView:_updateMailInfoUI(mo)
	goutil.setActive(self._bubbleGo, false)

	self._attachmentViewDatas = {}
	self._copyContent = nil

	if not mo then
		local id = MailController.instance:getCurSelectedId()

		mo = MailModel.instance:getMailMoById(id)
	end

	goutil.setActive(self._goMailInfo, mo ~= nil)
	goutil.setActive(self._goNoMailRight, mo == nil)

	if not mo then
		self._txtMailTips.text = (not self._mailViewDatas or #self._mailViewDatas == 0) and "你还没有邮件哦！\n等会再来看看吧" or "请选择一封邮件阅读"
	else
		do
			local content

			if checknumber(mo.templateId) <= 0 then
				content = self:_processContent(mo.content)
			else
				local templateCfg = SocialConfig.instance:getCfgById(mo.templateId)
				local processContent = self:_processContent(mo.content)

				content = self:getContentBytemplate(processContent, mo.mailParams)
			end

			self._txtContent.text = content
			self._txtTitle.text = mo.title
			self._txtSenderName.text = "发件人：" .. mo.senderName
			self._txtSendTime.text = GameUtil.formatTimeStamp("%Y.%m.%d  %H:%M", mo.sendTime / 1000)

			local isAttachment = mo:getHasAttachment()

			goutil.setActive(self._btnDelete.btn.gameObject, not isAttachment)
			goutil.setActive(self._btnReceive.btn.gameObject, isAttachment)

			self._attachmentViewDatas = mo:getAttachmentDatas()

			self._attachmentListView:ReloadData()
		end
	end

	goutil.setActive(self._txtAttachment.gameObject, self._attachmentViewDatas and #self._attachmentViewDatas > 0)
end

function NewMailView:_onSelectMail(mo)
	MailController.instance:setCurSelectedId(mo.mailId)
	self._mailListView:ReloadData()
	self:_updateMailInfoUI(mo)
end

function NewMailView:_onReceiveMails()
	self:_sortMails()
	self._mailListView:Refresh()
	self:_updateMailInfoUI()
end

function NewMailView:_onDeleteMails(deleteids)
	FloatWordMgr.instance:show("删除成功")

	if #deleteids == 1 then
		self:_refresh()
	else
		self:_refresh()
	end
end

function NewMailView:_updateMailCellById(id)
	for k, v in ipairs(self._mailViewDatas) do
		if v.mailId == id then
			self._mailListView:UpdateCellAtIndex(k - 1)
		end
	end
end

function NewMailView:_onClickClose()
	self:close()
end

function NewMailView:_onClickReceive()
	local mailId = MailController.instance:getCurSelectedId()

	if mailId ~= nil then
		self:_receiveMails({
			mailId
		})
	else
		printInfo("没有选中邮件")
	end
end

function NewMailView:_onClickReceiveAll()
	if self._mailViewDatas ~= nil then
		local mailIds = {}

		for _, v in ipairs(self._mailViewDatas) do
			if v:getHasAttachment() then
				table.insert(mailIds, v.mailId)
			end
		end

		self:_receiveMails(mailIds)
	end
end

function NewMailView:_receiveMails(mailIds)
	if #mailIds == 0 then
		FloatWordMgr.instance:show("没有附件可以领取")
	else
		MailController.instance:sendGainUserMailsReq(mailIds)
	end
end

function NewMailView:_onClickDelete()
	local mailId = MailController.instance:getCurSelectedId()

	if mailId ~= nil then
		if GameUtil.getUserDayData("NewMailView") == true then
			self:_deleteMails({
				mailId
			})
		else
			TipsFacade.instance:openPopupWindowWithTog(lang("tip"), lang("确认要删除本封邮件吗？"), function()
				self:_deleteMails({
					mailId
				})
			end, function()
				return
			end, function()
				GameUtil.saveUserDayData("NewMailView", true)
			end, nil, nil, lang("今日内不再提示"))
		end
	else
		printInfo("没有选中邮件")
	end
end

function NewMailView:_onClickDeleteAll()
	TipsFacade.instance:openPopupWindow(lang("tip"), lang("确认要删除全部邮件吗？"), function()
		local mailIds = MailModel.instance:getAllMailIds()

		self:_deleteMails(mailIds)
	end)
end

function NewMailView:_deleteMails(mailIds)
	local t = {}
	local hasNotRead = false

	local function func()
		MailBoxAgent.instance:sendDeleteUserMailsReq(t)
	end

	for _, mailId in ipairs(mailIds) do
		local mailMo = MailModel.instance:getMailMoById(mailId)

		if not mailMo:getHasAttachment() then
			table.insert(t, mailId)

			if not mailMo.read then
				hasNotRead = true
			end
		end
	end

	if #t == 0 then
		FloatWordMgr.instance:show("没有邮件可以删除")
	elseif hasNotRead then
		TipsFacade.instance:openPopupWindow("提示", "您还有邮件未读，确定删除？", func, nil, "确定", "取消")
	else
		func()
	end
end

function NewMailView:getContentBytemplate(templateContent, params)
	local paramTable = {}

	if not string.nilorempty(params) and not json.decode(params) then
		-- block empty
	end

	return StringUtil.parseJsonParams(templateContent, paramTable)
end

function NewMailView:_processContent(content)
	self._copyContent = nil
	self._jumpUrlContent = nil

	local full = string.match(content, "(<copy>(.*)</copy>)")

	if full then
		local str = string.gsub(full, "<copy>", "")

		str = string.gsub(str, "</copy>", "")
		self._copyContent = str
		self._txtBtnCopy.text = "复制"
		content = string.gsub(content, "<copy>", "")
		content = string.gsub(content, "</copy>", "")

		return content
	end

	local full, url, str = string.match(content, "(<jumpurl=(.-)>(.*)</jumpurl>)")

	if full and url and str then
		self._jumpUrlContent = url
		self._txtBtnCopy.text = "跳转"

		return string.gsub(content, full, str)
	end

	return content
end

function NewMailView:_onClickbtnCopy()
	if self._copyContent then
		Clipboard.copy(self._copyContent)
	elseif self._jumpUrlContent then
		UnityWebBridge.openWebView(self._jumpUrlContent)
	end

	goutil.setActive(self._bubbleGo, false)
end

function NewMailView:_onClickbtnLongPress()
	if string.nilorempty(self._copyContent) and string.nilorempty(self._jumpUrlContent) then
		return
	end

	local screenPos = UGUIToolHelper.GetTouchPosition()
	local localPos = goutil.screenToLocalPos(screenPos, self._goMailInfoGoTr)

	Framework.TransformUtil.SetLocalPos(self._bubbleGo.transform, localPos.x, localPos.y + 40, 0)
	GameUtil.SetActive(self._bubbleGo, true)
end

function NewMailView:_onCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._bubbleGo, false)
	end
end

return NewMailView
