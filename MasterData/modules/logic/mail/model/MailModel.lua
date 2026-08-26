-- chunkname: @modules/logic/mail/model/MailModel.lua

module("modules.logic.mail.model.MailModel", package.seeall)

local MailModel = class("MailModel", BaseModel)

function MailModel:onInit()
	self._curCategoryId = 0
	self._categoryList = {}
	self._categoryListItem = {}
	self._readedMailIds = {}

	TaskDispatcher.cancelTask(self.delExpiredMail, self)
end

function MailModel:reInit()
	self._curCategoryId = 0
	self._categoryList = {}
	self._categoryListItem = {}
	self._readedMailIds = {}

	TaskDispatcher.cancelTask(self.delExpiredMail, self)
end

function MailModel:setMailList()
	MailCategroyModel.instance:setCategoryList(self._categoryList, true)
end

function MailModel:getReadedMailIds()
	return self._readedMailIds
end

function MailModel:getMailList()
	return self._categoryList
end

function MailModel:onGetMailItemList(mail)
	self._categoryList = {}

	for _, x in pairs(mail) do
		local mailMO = self:initMailMO(x)

		if mailMO then
			table.insert(self._categoryList, mailMO)

			if mailMO.state == MailEnum.ReadStatus.Read then
				self._readedMailIds[mailMO.id] = true
			end
		end
	end

	self:checkExpiredMail()
	MailCategroyModel.instance:setCategoryList(self._categoryList, true)
end

function MailModel:checkExpiredMail()
	TaskDispatcher.cancelTask(self.delExpiredMail, self)

	self._willDelId = 0

	local nearestTime = 0
	local newTable = {}
	local delIds = {}

	for i, mailMO in ipairs(self._categoryList) do
		local expireTime = mailMO.expireTime

		expireTime = tonumber(expireTime)

		if expireTime <= 0 then
			table.insert(newTable, mailMO)
		else
			expireTime = expireTime / 1000

			local diffTime = expireTime - ServerTime.now()

			if diffTime > 0 then
				if diffTime < nearestTime or nearestTime == 0 then
					self._willDelId = mailMO.id
					nearestTime = diffTime
				end

				table.insert(newTable, mailMO)
			else
				table.insert(delIds, mailMO.id)
			end
		end
	end

	self._categoryList = newTable

	if self._willDelId ~= 0 then
		TaskDispatcher.runDelay(self.delExpiredMail, self, nearestTime)
	end

	if #delIds > 0 then
		MailCategroyModel.instance:setCategoryList(self._categoryList)
		MailCategroyModel.instance:refreshCategoryList(delIds)
	end
end

function MailModel:delExpiredMail()
	local ids = {
		self._willDelId
	}

	self:delMail(ids)
	self:checkExpiredMail()
end

function MailModel:initMailMO(mail)
	local co = {}
	local cataCo = MailConfig.instance:getCategoryCO()

	for _, v in pairs(cataCo) do
		table.insert(co, v)
	end

	if mail.mailId ~= 0 then
		for _, v in pairs(co) do
			if v.id == mail.mailId then
				local cateMo = MailCategroyMo.New()

				cateMo:init(v)

				local infos = string.split(mail.attachment, "|")
				local configInfos = string.split(v.attachment, "|")

				cateMo:getItem(infos, configInfos)
				cateMo:getRpc(mail.state, mail.createTime, mail.params, mail.incrId, v.needShowToast, mail.mailId, mail.isLock)

				if mail.expireTime ~= nil then
					cateMo:getExpireTime(mail.expireTime)
				end

				return cateMo
			end
		end
	else
		local cateMo1 = MailCategroyMo.New()

		cateMo1:getMailType1(mail)
		cateMo1:getItem(string.split(mail.attachment, "|"))

		return cateMo1
	end
end

function MailModel:readMail(id)
	local ids = {
		id
	}

	for _, x in pairs(self._categoryList) do
		if id == x.id then
			x.state = MailEnum.ReadStatus.Read
		end
	end

	self._readedMailIds[id] = true

	MailCategroyModel.instance:setCategoryList(self._categoryList)
	MailCategroyModel.instance:refreshCategoryItem(ids)
end

function MailModel:readAllMail(co)
	local ids = {}

	for _, v in pairs(co) do
		table.insert(ids, tonumber(v))
	end

	if ids and next(ids) then
		for _, v in pairs(ids) do
			for _, x in pairs(self._categoryList) do
				if v == x.id then
					x.state = MailEnum.ReadStatus.Read
				end
			end

			self._readedMailIds[v] = true
		end
	end

	MailCategroyModel.instance:setCategoryList(self._categoryList)
	MailCategroyModel.instance:refreshCategoryItem(ids)
end

function MailModel:delMail(ids)
	local delFlag = false

	for _, v in pairs(ids) do
		for _, x in pairs(self._categoryList) do
			if v == x.id then
				table.remove(self._categoryList, _)

				delFlag = true

				break
			end
		end
	end

	if delFlag then
		MailCategroyModel.instance:setCategoryList(self._categoryList)
		MailCategroyModel.instance:refreshCategoryList(ids)
	end
end

function MailModel:lockMail(id, isLock)
	for _, mo in pairs(self._categoryList) do
		if mo.id == id then
			mo.isLock = isLock
		end
	end
end

function MailModel:getLockCount()
	local count = 0

	for _, mo in pairs(self._categoryList) do
		if mo.isLock == true then
			count = count + 1
		end
	end

	return count
end

function MailModel:getLockMax()
	return MainEnum.MaxLockCount
end

function MailModel:getItemList(id)
	for _, v in pairs(self._categoryList) do
		if v.id == id then
			return v
		end
	end

	return nil
end

function MailModel:getCount()
	return #self._categoryList
end

function MailModel:getUnreadCount()
	local count = 0

	for _, v in pairs(self._categoryList) do
		if v.state == MailEnum.ReadStatus.Unread then
			count = count + 1
		end
	end

	return count
end

function MailModel:addMailModel(co)
	local mailMO = self:initMailMO(co[1])

	if not mailMO then
		return
	end

	table.insert(self._categoryList, 1, mailMO)
	self:checkExpiredMail()
	MailCategroyModel.instance:setCategoryList(self._categoryList)
	MailCategroyModel.instance:addMail()

	if mailMO.mailId ~= 0 and mailMO.needShowToast == 1 then
		MailController.instance:showGetMailToast(mailMO.id, mailMO.title)
	end
end

MailModel.instance = MailModel.New()

return MailModel
