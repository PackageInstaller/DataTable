-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/social/controller/MailController.lua

module("logic.extensions.social.controller.MailController", package.seeall)

local MailController = class("MailController", BaseController)

function MailController:ctor()
	MailController.super.ctor(self)
end

function MailController:onInit()
	self.needNotifyTips = false
	MailModel.instance.isDataInit = false

	self.registerNotify(self, GlobalNotify.MainUIEntered, self.onCheckMailOutDateTips, self)
end

function MailController:onReset()
	self.needNotifyTips = false
	MailModel.instance.isDataInit = false

	self.registerNotify(self, GlobalNotify.MainUIEntered, self.onCheckMailOutDateTips, self)
end

function MailController:onCheckMailOutDateTips()
	if self.needNotifyTips then
		self.needNotifyTips = false

		TipsFacade.instance:openTipWindow("邮件过期", lang("tip_mail_outdate"), nil, "确定")
	end
end

function MailController:notifyOutDateTips()
	if ViewMgr.instance:isOpen(ViewName.MainUI) then
		TipsFacade.instance:openTipWindow("邮件过期", lang("tip_mail_outdate"), nil, "确定")
	else
		self.needNotifyTips = true
	end
end

function MailController:openMailView()
	if MailModel.instance.isDataInit then
		UIStateManager.instance:push(ViewName.social)
	else
		MailBoxAgent.instance:sendGetUserMailsReq()
	end
end

function MailController:getCurSelectedId()
	return self._selectedMailId or 0
end

function MailController:setCurSelectedId(id)
	self._selectedMailId = id

	local mailMo = MailModel.instance:getMailMoById(id)

	if mailMo and not mailMo.read then
		MailModel.instance:onReadUserMails({
			id
		})
		MailBoxAgent.instance:sendReadUserMailsReq({
			id
		})
	end
end

function MailController:sendGainUserMailsReq(mailIds)
	self._changeSetIds = self._changeSetIds or {}
	self._cachedMailIds = mailIds
	self._isOverFlow = false

	self.registerLocalNotify(self, "receivePartMails", self._onReceivePartMails, self)
	MailBoxAgent.instance:sendGainUserMailsReq(self:getTop10MailIdFromCache())
end

function MailController:_onReceivePartMails(changeSetId, overflowmp)
	table.insert(self._changeSetIds, changeSetId)

	self._isOverFlow = self._isOverFlow or overflowmp ~= nil and #overflowmp > 0

	if #self._cachedMailIds == 0 then
		if self._isOverFlow then
			FloatWordMgr.instance:show("拥有数量已达到上限，请清理背包后再领取")
		end

		self.unregisterLocalNotify(self, "receivePartMails", self._onReceivePartMails, self)
		self:localNotify("receiveMails")
		MaterialFacade.instance:popAndShowChangeSetItems(self._changeSetIds)

		self._changeSetIds = {}
	else
		MailBoxAgent.instance:sendGainUserMailsReq(self:getTop10MailIdFromCache())
	end
end

function MailController:getTop10MailIdFromCache()
	local mailIds = {}
	local i = 1
	local len = #self._cachedMailIds

	while i <= math.min(10, len) do
		table.insert(mailIds, self._cachedMailIds[1])
		table.remove(self._cachedMailIds, 1)

		i = i + 1
	end

	return mailIds
end

MailController.instance = MailController.New()

return MailController
