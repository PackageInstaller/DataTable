-- chunkname: @modules/logic/mail/controller/MailController.lua

module("modules.logic.mail.controller.MailController", package.seeall)

local MailController = class("MailController", BaseController)

function MailController:open()
	ViewMgr.instance:openView(ViewName.MailView)
end

function MailController:onInit()
	self.showTitles = {}
	self.maxCacheMailToast = 3
	self.delayShowViews = nil
	self.recordedMailIdKey = "recordedMailIdKey"
	self.recordedIdDelimiter = ";"
	self.showedMailIds = {}
end

function MailController:onInitFinish()
	self:initShowedMailIds()
end

function MailController:addConstEvents()
	return
end

function MailController:reInit()
	return
end

function MailController:initInfo()
	self.showTitles = {}

	local mailList = MailModel.instance:getMailList()
	local mailInfoList = {}

	for _, mailMo in ipairs(mailList) do
		if mailMo.state == MailEnum.ReadStatus.Unread and mailMo.needShowToast == 1 and not self:isShowedMail(mailMo.id) then
			if #self.showTitles >= self.maxCacheMailToast then
				self:recordShowedMailId(mailMo.id)
			else
				table.insert(self.showTitles, 1, {
					id = mailMo.id,
					title = mailMo.title
				})
			end
		end

		local mailInfo = {
			id = mailMo.id,
			title = mailMo.title,
			is_lock = mailMo.isLock == true,
			is_read = mailMo.state == MailEnum.ReadStatus.Read,
			mail_id = mailMo.mailId
		}

		if mailMo:haveBonus() then
			mailInfo.is_gain = mailMo.state == MailEnum.ReadStatus.Read
		end

		table.insert(mailInfoList, mailInfo)
	end

	self:logNormal("init info, show mail length is " .. tostring(#self.showTitles))
	MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, self._onCheckFuncUnlock, self)
	GuideController.instance:registerCallback(GuideEvent.FinishGuide, self._onFinishGuide, self)
	StatController.instance:track(StatEnum.EventName.MailCache, {
		[StatEnum.EventProperties.MailInfo] = mailInfoList
	})
end

function MailController:addShowToastMail(incrId, title)
	table.insert(self.showTitles, {
		id = incrId,
		title = title
	})

	if #self.showTitles > self.maxCacheMailToast then
		local tempMailMo = table.remove(self.showTitles, 1)

		self:recordShowedMailId(tempMailMo.id)
	end
end

function MailController:initShowedMailIds()
	local playerStr = PlayerPrefsHelper.getString(self.recordedMailIdKey, "")

	self.showedMailIds = {}

	if not string.nilorempty(playerStr) then
		for _, v in ipairs(string.split(playerStr, self.recordedIdDelimiter)) do
			local value = tonumber(v)

			if value then
				table.insert(self.showedMailIds, value)
			end
		end
	end
end

function MailController:isShowedMail(mailIncrId)
	for _, mailId in ipairs(self.showedMailIds) do
		if mailId == mailIncrId then
			return true
		end
	end

	return false
end

function MailController:isDelayShow()
	self.delayShowViews = self.delayShowViews or {
		ViewName.LoadingView,
		ViewName.FightView,
		ViewName.FightSuccView,
		ViewName.FightFailView,
		ViewName.StoryView,
		ViewName.SummonView,
		ViewName.LoginView,
		ViewName.SignInView
	}

	for k, v in ipairs(self.delayShowViews) do
		if ViewMgr.instance:isOpen(v) then
			self:logNormal("current view is " .. v)

			return true
		end
	end

	local forbidGuides = GuideController.instance:isForbidGuides()

	if not forbidGuides then
		self:logNormal("not forbid guide , check guide")

		local guideId = GuideModel.instance:getDoingGuideId()

		if guideId then
			self:logNormal("get doing guide Id is " .. tostring(guideId))

			return true
		end

		if not GuideModel.instance:isGuideFinish(GuideModel.instance:lastForceGuideId()) then
			self:logNormal("last force guide Id not finish")

			return true
		end
	else
		self:logNormal("forbid guide, skip check guide, check next")
	end

	return false
end

function MailController:showGetMailToast(incrId, title)
	self:addShowToastMail(incrId, title)

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Mail) then
		self:logNormal("receive new mail, but not unlock MailModel , register OnFuncUnlockRefresh event ")
		OpenController.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, self._onCheckFuncUnlock, self)
		MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, self._onCheckFuncUnlock, self)

		return
	end

	self:showOrRegisterEvent()
end

function MailController:tryShowMailToast()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Mail) then
		MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, self._onCheckFuncUnlock, self)
	else
		self:showOrRegisterEvent()
	end
end

function MailController:showOrRegisterEvent()
	if self:isDelayShow() then
		self:logNormal("cat not show mail Toast, register event ...")
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	else
		self:logNormal("can show mail Toast ...")
		self:reallyShowToast()
	end
end

function MailController:_onCheckFuncUnlock()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Mail) then
		MainController.instance:unregisterCallback(MainEvent.OnFuncUnlockRefresh, self._onCheckFuncUnlock, self)
		OpenController.instance:unregisterCallback(OpenEvent.GetOpenInfoSuccess, self._onCheckFuncUnlock, self)
		self:logNormal("unlock mail model callback, check show mail ...")
		self:showOrRegisterEvent()
	end
end

function MailController:_onOpenViewFinish()
	self:logNormal("close finish event ")

	if self:isDelayShow() then
		self:logNormal("cat not show mail Toast")

		return
	else
		self:logNormal("can show mail Toast")
		self:reallyShowToast()
	end
end

function MailController:_onFinishGuide(guideId)
	self:logNormal("receive finish guide push ...")

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Mail) then
		self:logNormal("receive finish guide push, but mail model not open , do nothing and return ...")

		return
	end

	self:showOrRegisterEvent()
end

function MailController:reallyShowToast()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, self._onCheckFuncUnlock, self)

	local readedMailIds = MailModel.instance:getReadedMailIds()

	self:logNormal("start show ...")

	for _, mailMo in ipairs(self.showTitles) do
		if readedMailIds[mailMo.id] then
			self:logNormal(string.format("need show mail {id:%s, title:%s}, but it`s been read", mailMo.id, mailMo.title))
			self:recordShowedMailId(mailMo.id)
		else
			self:logNormal(string.format("need show mail {id:%s, title:%s}, can show", mailMo.id, mailMo.title))
			self:showToast(mailMo)
		end
	end

	self.showTitles = {}
end

function MailController:showToast(mailMo)
	GameFacade.showToast(ToastEnum.MailToast, mailMo.title, mailMo.id)
	self:recordShowedMailId(mailMo.id)
end

function MailController:recordShowedMailId(mailIncrId)
	if self:isShowedMail(mailIncrId) then
		return
	end

	table.insert(self.showedMailIds, mailIncrId)
	PlayerPrefsHelper.setString(self.recordedMailIdKey, table.concat(self.showedMailIds, self.recordedIdDelimiter))
end

function MailController:logNormal(msg)
	logNormal("【mail toast】" .. msg)
end

function MailController:onReceiveMailLockReply(resultCode, msg)
	if resultCode == 0 then
		local id = tonumber(msg.incrId)

		MailModel.instance:lockMail(id, msg.lock)
		self:dispatchEvent(MailEvent.OnMailLockReply, id, msg.lock)

		if msg.lock then
			if not ToastEnum.V3a2MailLock then
				local toastId = ToastEnum.V3a2MailUnLock

				GameFacade.showToast(toastId, MailModel.instance:getLockCount(), MailModel.instance:getLockMax())

				local mailMO = MailModel.instance:getItemList(id)

				if mailMO then
					local var_21_1 = {}

					if msg.lock then
						var_21_1[StatEnum.EventProperties.OperationType] = StatEnum.MailOperationType.Lock or StatEnum.MailOperationType.Unlock
					end

					var_21_1[StatEnum.EventProperties.MailId] = id
					var_21_1[StatEnum.EventProperties.NoticeTitle] = mailMO.title

					StatController.instance:track(StatEnum.EventName.MailLockOperation, var_21_1)
				end
			end
		end
	end
end

MailController.instance = MailController.New()

return MailController
