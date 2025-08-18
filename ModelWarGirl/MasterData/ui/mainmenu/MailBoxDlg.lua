-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainMenu\\MailBoxDlg.lua

local ResColor = require("ClientData/ResColor")
local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local ResMail = require("ClientData/ResMail")
local ResClanMail = require("ClientData/ResClanMail")
local ResItem = require("ClientData/ResItem")
local strClassName = "MailBoxDlg"
local MailBoxDlg = Class(strClassName, UIControls.Window)

MailBoxDlg.questionnaireFlagStart = "#questionnaire#"
MailBoxDlg.questionnaireFlagEnd = "#/questionnaire#"

local MailBtnCell = Class("MailBtnCell", UIControls.Child)

function MailBtnCell:ctor(...)
	self:initUI()
end

function MailBtnCell:initUI(...)
	self.titleTxt = UIControls.Label(self, "TextTitle")
	self.pointTxt = UIControls.Label(self, "TextTitle/TextPoint")
	self.pastTimeTxt = UIControls.Label(self, "TextNum")
	self.authorTxt = UIControls.Label(self, "TextFrom/TextAuthor")
	self.stateIcon = UIControls.Image(self, "IconMail")
	self.attachIcon = UIControls.Image(self, "IconGift")
	self.newIcon = UIControls.Image(self, "IconNew")
	self.iconPenalty = UIControls.Image(self, "IconPenalty")
	self.rootBtn = UIControls.Button(self, "")

	self.rootBtn:addEventClick(self._onClickCell)
end

local MailState = {}

MailState.UNREAD_NO_ATTACH = 0
MailState.READ_NO_ATTACH = 1
MailState.UNREAD_HAS_ATTACH = 10
MailState.READ_HAS_ATTACH = 11
MailState.READ_AND_RECEIVE = 12

function MailBtnCell:setMailData(mailData)
	self.mailId = mailData.mailId
	self.mailState = self:_getMailState(mailData.isRead, mailData.hasAttachments, mailData.hasReceive)

	local title, senderStr

	if mailData.isTemplateType then
		if mailData.templateId and ResMail[mailData.templateId] then
			local mailTemplateData = ResMail[mailData.templateId]

			title = mailTemplateData.title
			senderStr = mailTemplateData.sender
		else
			title = mailData.title or ""
			senderStr = mailData.sender
		end
	else
		title = mailData.title
		senderStr = mailData.sender
	end

	local titleResult, hasClip = ClientUtils.subStringByLength(title, UIMiscConfig.MAIL_TITLE_CLIP_LENGTH)

	self.titleTxt:setText(titleResult)
	self.pointTxt:setVisible(hasClip)

	if Const.SHOW_PLAYERNAME_MAIL_TYPE[mailData.mailType] and mailData.sender then
		local name, server = utils.GetPlayerName(mailData.sender)

		self.authorTxt:setText(name)
	elseif senderStr then
		self.authorTxt:setText(senderStr)
	else
		self.authorTxt:setText(Lang.get(13633))
	end

	if self.mailState == MailState.UNREAD_NO_ATTACH or self.mailState == MailState.UNREAD_HAS_ATTACH then
		self.stateIcon:setImage("Atlas/MailBoxAtlas/MailBoxAtlas", "MailClose")
		self.newIcon:setVisible(true)
	else
		self.stateIcon:setImage("Atlas/MailBoxAtlas/MailBoxAtlas", "MailOpen")
		self.newIcon:setVisible(false)
	end

	local checkShowAttachIcon = mailData.hasAttachments and not mailData.hasReceive

	self.attachIcon:setVisible(checkShowAttachIcon)

	local checkShowIconPenalty = false

	if not checkShowAttachIcon and mailData.mailType == Const.MAIL_TYPE_CIRCLE then
		for _, config in pairs(ResClanMail) do
			if config.mailid == mailData.templateId then
				if config.type == Const.CLAN_MAIL_TYPE_MARK_MEMBER or config.type == Const.CLAN_MAIL_TYPE_UNMARK_MEMBER then
					checkShowIconPenalty = true
				end

				break
			end
		end
	end

	self.iconPenalty:setVisible(checkShowIconPenalty)

	if (self.mailState == MailState.UNREAD_HAS_ATTACH or self.mailState == MailState.READ_HAS_ATTACH) and mailData.timeStamp and mailData.periodOfValidity then
		self.pastTimeTxt:setVisible(true)

		local leftPeriod = (mailData.periodOfValidity - ClientUtils.getServerTime()) / 86400

		if leftPeriod < 0 then
			self.pastTimeTxt:setText(Lang.get(30437))
		else
			leftPeriod = math.floor(leftPeriod + 0.5)

			if leftPeriod == 0 then
				leftPeriod = 1
			end

			self.pastTimeTxt:setText(string.format(Lang.get(30022), leftPeriod))
		end
	else
		self.pastTimeTxt:setVisible(false)
	end
end

function MailBtnCell:_getMailState(isRead, hasAttachments, hasReceive)
	if not hasAttachments then
		if isRead then
			return MailState.READ_NO_ATTACH
		else
			return MailState.UNREAD_NO_ATTACH
		end
	elseif not isRead then
		return MailState.UNREAD_HAS_ATTACH
	elseif hasReceive then
		return MailState.READ_AND_RECEIVE
	else
		return MailState.READ_HAS_ATTACH
	end
end

function MailBtnCell:addEventClick(clickFunc)
	self.clickFunc = clickFunc
end

function MailBtnCell:_onClickCell(...)
	if self.clickFunc and self.mailId then
		local firstRead = self.mailState == MailState.UNREAD_NO_ATTACH or self.mailState == MailState.UNREAD_HAS_ATTACH

		self.clickFunc(self.mailId, firstRead)
	end
end

function MailBtnCell:setSelect(targetMailId)
	self.isSelected = targetMailId == self.mailId

	self.rootBtn:setEnable(not self.isSelected)

	local titleColor

	if self.isSelected then
		titleColor = ResColor.WHITE
	elseif self.mailState == MailState.UNREAD_NO_ATTACH or self.mailState == MailState.UNREAD_HAS_ATTACH then
		titleColor = ResColor.WHITE
	else
		titleColor = ResColor.GREYLIGHT
	end

	self.titleTxt:setFontColor(titleColor)
	self.pointTxt:setFontColor(titleColor)
end

function MailBoxDlg:ctor(...)
	self:initUI()
end

function MailBoxDlg:initUI(...)
	self.closeBtn = UIControls.Button(self, "BtnClose")

	self.closeBtn:addEventClick(self._onClickClose)

	self.mailBoxTitleTxt = UIControls.Label(self, "TextNum")
	self.mailBtnPath = "MailList/Content"
	self.getAllBtn = UIControls.Button(self, "BtnGetAll", "Text")

	self.getAllBtn:addEventClick(self._onGetAllAttach)

	self.noneContentTxt = UIControls.Label(self, "TextMailNone")
	self.contentPanel = UIControls.Panel(self, "MailContent")
	self.mailTitleTxt = UIControls.Label(self, "MailContent/BgTitle/TextTitle")
	self.mailNameTxt = UIControls.Label(self, "MailContent/TextName")
	self.mailContentTxt = UIControls.Label(self, "MailContent/TextContentList/Viewport/Content/TextContent")
	self.mailAuthorTxt = UIControls.Label(self, "MailContent/TextAuthor")
	self.mailTimeTxt = UIControls.Label(self, "MailContent/TextTime")
	self.getOneBtn = UIControls.Button(self, "MailContent/BtnGet", "Text")

	self.getOneBtn:addEventClick(self._onGetAttach)

	self.stateImg = UIControls.Panel(self, "MailContent/ImgState")
	self.attachPanel = UIControls.Panel(self, "MailContent/RewardList")
	self.attachListPath = "MailContent/RewardList/Viewport/Content"
	self.textContentScroll = UIControls.ScrollView(self, "MailContent/TextContentList")
	self.awardListScroll = UIControls.ScrollView(self, "MailContent/RewardList")
	self.mailItemList = {}
	self.attachItemList = {}
end

function MailBoxDlg:onOpen()
	MailBoxDlg.super.onOpen(self)
	CurAvatar:sortMailList()

	self.curSelectMailId = nil

	self:refreshMailBox()
end

function MailBoxDlg:refreshMailBox(...)
	self.mailBox = CurAvatar.mainMailBox

	local sortedMailId = self.mailBox:getSortedMailList()

	self.mailBoxTitleTxt:setText(string.format(Lang.get(30436), #sortedMailId))

	if self.curSelectMailId and not self.mailBox:mailExist(self.curSelectMailId) then
		self.curSelectMailId = nil
	end

	self:_setMailList(sortedMailId)
	self:_setMailContent()
end

function MailBoxDlg:selectMailById(mailId, firstRead)
	firstRead = firstRead or false

	self:_onSelectMail(mailId, firstRead)
end

function MailBoxDlg:_setMailList(sortedMailId)
	if not self.mailBox then
		return
	end

	for index, mailId in ipairs(sortedMailId) do
		local mailData = self.mailBox:getMailInfo(mailId)
		local mailBtn = self.mailItemList[index]

		if not mailBtn then
			mailBtn = MailBtnCell(self, self.mailBtnPath, "System/MailBox/BtnMail", 0, 0, true)

			mailBtn:addEventClick(Slot(self._onSelectMail, self))

			self.mailItemList[index] = mailBtn
		end

		mailBtn:setVisible(true)
		mailBtn:setMailData(mailData)
	end

	local btnNum = #self.mailItemList
	local mailNum = #sortedMailId

	if mailNum < btnNum then
		for i = mailNum + 1, btnNum do
			self.mailItemList[i]:setVisible(false)
		end
	end

	for i = 1, btnNum do
		self.mailItemList[i]:setSelect(self.curSelectMailId)
	end

	self.getAllBtn:setVisible(self.mailBox:hasAttachments())
end

function MailBoxDlg:_setMailContent()
	if not self.curSelectMailId or not self.mailBox then
		self.contentPanel:setVisible(false)
		self.noneContentTxt:setVisible(true)
	else
		local mailData = self.mailBox:getMailInfo(self.curSelectMailId)

		if not mailData then
			self.contentPanel:setVisible(false)
			self.noneContentTxt:setVisible(true)

			return
		end

		self.contentPanel:setVisible(true)
		self.noneContentTxt:setVisible(false)

		local mailTitleStr, senderStr, contentStr

		if mailData.isTemplateType then
			if mailData.templateId and ResMail[mailData.templateId] then
				local mailTemplateData = ResMail[mailData.templateId]

				mailTitleStr = mailTemplateData.title
				senderStr = mailTemplateData.sender
				contentStr = mailTemplateData.content

				local needSplit = false

				if mailTemplateData.split and mailTemplateData.split ~= "" then
					needSplit = true
				end

				if mailData.params and #mailData.params > 0 then
					if needSplit then
						contentStr = self:getSplitReplaceContentStr(contentStr, mailData.params, mailData.paramNeedTranslate, mailTemplateData.split)
					else
						for i, p in ipairs(mailData.params) do
							local needTrans = mailData.paramNeedTranslate[i]
							local hasTrans = RegionUtils and RegionUtils.hasAbilityLocalization()

							if needTrans and hasTrans then
								local baseId = tonumber(p)

								contentStr = string.gsub(contentStr, "%$" .. i, Lang.get(baseId))
							else
								contentStr = string.gsub(contentStr, "%$" .. i, p)
							end
						end
					end
				end
			else
				mailTitleStr = mailData.title or ""
				contentStr = mailData.content or ""
				senderStr = mailData.sender
			end
		else
			mailTitleStr = mailData.title
			contentStr = mailData.content
			senderStr = mailData.sender
		end

		if mailData.mailType == Const.MAIL_TYPE_CIRCLE_USER_DEFINED then
			contentStr = ClientUtils.checkMarkIllegal(contentStr)
			mailTitleStr = ClientUtils.checkMarkIllegal(mailTitleStr)
		end

		self.mailTitleTxt:setText(mailTitleStr)

		if senderStr then
			if Const.SHOW_PLAYERNAME_MAIL_TYPE[mailData.mailType] then
				local name, server = utils.GetPlayerName(senderStr)

				self.mailAuthorTxt:setText(name)
			else
				self.mailAuthorTxt:setText(senderStr)
			end
		else
			self.mailAuthorTxt:setText(Lang.get(13633))
		end

		if RegionUtils.isJP() then
			self.mailNameTxt:setText(string.format(Lang.get(45487), CurAvatar:getPlayerName()))
		else
			self.mailNameTxt:setText(CurAvatar:getPlayerName())
		end

		self.mailTimeTxt:setText(ClientUtils.getServerTimeData(mailData.timeStamp, "%Y/%m/%d %H:%M:%S"))

		local hasAttachments = mailData.hasAttachments

		if not hasAttachments then
			self.attachPanel:setVisible(false)
			self.getOneBtn:setVisible(false)
			self.stateImg:setVisible(false)
		else
			self.attachPanel:setVisible(true)
			self.getOneBtn:setVisible(not mailData.hasReceive)
			self.stateImg:setVisible(mailData.hasReceive)
			self:_setAttachGrid(mailData.attachments, mailData.hasReceive)
		end

		self:_setMailContent_JP(contentStr)
	end
end

function MailBoxDlg:getSplitReplaceContentStr(contentStr, params, needTransParas, splitStr)
	local replaceStr = ""

	for i, param in ipairs(params) do
		local param = utils.splitString(param, ",")

		if param and param[1] and param[2] then
			local itemId = tonumber(param[1])
			local itemNum = tonumber(param[2])
			local itemName = ""

			if ResItem and ResItem[itemId] then
				itemName = ResItem[itemId].name
			end

			local needTrans = needTransParas[i]
			local hasTrans = RegionUtils and RegionUtils.hasAbilityLocalization()

			if needTrans and hasTrans then
				itemNum = Lang.get(itemNum)
			end

			if i ~= 1 then
				replaceStr = utils.format("%1s%2s%3s*%4s", replaceStr, splitStr, itemName, itemNum)
			else
				replaceStr = utils.format("%1s%2s*%3s", replaceStr, itemName, itemNum)
			end
		end
	end

	return string.gsub(contentStr, "%$1", replaceStr)
end

function MailBoxDlg:_setAttachGrid(attachments, hasReceive)
	local attachItems = ClientUtils.getAllMailItems(attachments)

	for i, item in ipairs(attachItems) do
		local grid = self.attachItemList[i]

		if grid == nil then
			grid = UIControls.getGridAwardContainer(self, self.attachListPath)
			grid.mDisableWays = true
			self.attachItemList[i] = grid
		end

		grid:setObj(item, not hasReceive)

		local spe = ClientUtils.getItemSpeTypeId(item.id)

		if spe then
			grid:setSpe(true, spe)
		else
			grid:setSpe(false)
		end

		grid:setVisible(true)
	end

	for j = #attachments + 1, #self.attachItemList do
		local grid = self.attachItemList[j]

		grid:setVisible(false)
	end
end

function MailBoxDlg:_setMailContent_JP(contentStr)
	self.getOneBtn:setText(Lang.get(38))

	if RegionUtils.isJP() then
		local _, QStart = string.find(contentStr, self.questionnaireFlagStart)
		local QEnd, _ = string.find(contentStr, self.questionnaireFlagEnd)

		if QStart and QEnd then
			self.questionnaireUrl = string.sub(contentStr, QStart + 1, QEnd - 1)
			contentStr = string.gsub(contentStr, self.questionnaireFlagStart .. self.questionnaireUrl .. self.questionnaireFlagEnd, "")

			if self.questionnaireUrl then
				self.getOneBtn:setText(Lang.get(51865))
				self.getOneBtn:setVisible(true)
			end
		end
	end

	self.mailContentTxt:setText(contentStr)
end

function MailBoxDlg:_resetMailContentScroll()
	self.textContentScroll:gotoTop()
	self.awardListScroll:gotoTop()
end

function MailBoxDlg:_onSelectMail(mailId, firstRead)
	self.questionnaireUrl = nil
	self.curSelectMailId = mailId

	if self.mailBox and firstRead then
		self.mailBox:readMail(mailId)
	end

	self:refreshMailBox()
	self:_resetMailContentScroll()
end

function MailBoxDlg:_onGetAllAttach()
	CurAvatar:getAllAttachs()
end

function MailBoxDlg:_onGetAttach()
	if self.questionnaireUrl then
		SDKAgent.questionnaire(self.questionnaireUrl)
	else
		CurAvatar:getAttach(self.curSelectMailId)
	end
end

function MailBoxDlg:_onClickClose(...)
	self:setVisible(false)
end

return MailBoxDlg
