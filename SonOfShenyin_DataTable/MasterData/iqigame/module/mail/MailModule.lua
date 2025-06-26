-- chunkname: @IQIGame\\Module\\Mail\\MailModule.lua

MailModule = {
	isNotPrompt = false,
	isDelSpecialMail = false,
	newMailCount = 0,
	specialMailCid = 37000001,
	mailDic = {},
	PickUpCallback = Queue.New(),
	GetMailsByTypeCallback = Queue.New()
}

function MailModule.ReloadMail(data)
	MailModule.newMailCount = data
	MailModule.mailDic = {}

	MailModule.GetAllMails()
end

function MailModule.GetMailByMailID(mailId)
	for i, v in pairs(MailModule.mailDic) do
		if v.id == mailId then
			return v
		end
	end

	return nil
end

function MailModule.SortEvent(tb1, tb2)
	local r = false
	local aIsRead = tb1.isRead == true and 1 or 0
	local bIsRead = tb2.isRead == true and 1 or 0
	local aTime = tonumber(tb1.createTime)
	local bTime = tonumber(tb2.createTime)

	if aIsRead == bIsRead then
		r = bTime < aTime
	else
		r = aIsRead < bIsRead
	end

	return r
end

function MailModule.OnNoticeGetItem(itemAwards)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemAwards)
end

function MailModule.GetAllMails()
	net_mail.getMails(Constant.MailType.TypeSystem)
end

function MailModule.ReadMail(mailId)
	net_mail.readMail(mailId)
end

function MailModule.PickUp(mailIdList, isAll, callback)
	if callback ~= nil then
		MailModule.PickUpCallback:Enqueue(callback)
	end

	net_mail.pickUp(mailIdList, isAll)
end

function MailModule.DelMail(mailIdList, isAll)
	net_mail.delMail(mailIdList, isAll)
end

function MailModule.SendGetMailsByType(mailType, callback)
	if callback ~= nil then
		MailModule.GetMailsByTypeCallback:Enqueue(callback)
	end

	net_mail.getMails(mailType)
end

function MailModule.GetAllMailsResult(mails)
	MailModule.mailDic = {}

	local mailData

	for i, v in pairs(mails) do
		if v.cid ~= MailModule.specialMailCid then
			mailData = MailModule.GetMailByMailID(v.id)

			if mailData == nil then
				mailData = MailData.New()

				mailData:Init(v)

				MailModule.mailDic[#MailModule.mailDic + 1] = mailData
			end
		end
	end

	table.sort(MailModule.mailDic, MailModule.SortEvent)
	EventDispatcher.Dispatch(EventID.GetAllMailsEvent)
end

function MailModule.ReadMailResult(mailId)
	local mailData = MailModule.GetMailByMailID(mailId)

	if mailData ~= nil then
		mailData.isRead = true
	end

	EventDispatcher.Dispatch(EventID.MailDataChangeEvent, mailId)
end

function MailModule.PickUpResult(mails, getItems)
	if getItems ~= nil then
		MailModule.OnNoticeGetItem(getItems)
	end

	local mailData

	for i, v in pairs(mails) do
		mailData = MailModule.GetMailByMailID(v.id)

		if mailData ~= nil then
			mailData.isHasItem = v.isHasItem
			mailData.isRead = v.isRead
		end
	end

	EventDispatcher.Dispatch(EventID.GetAllMailsEvent)

	if MailModule.PickUpCallback.Size > 0 then
		local callback = MailModule.PickUpCallback:Dequeue()

		callback(mails, getItems)
	end
end

function MailModule.DelMailResult(mails)
	for i = #MailModule.mailDic, 1, -1 do
		local mailData = MailModule.mailDic[i]

		for k, v in pairs(mails) do
			if v == mailData.id then
				table.remove(MailModule.mailDic, i)

				break
			end
		end
	end

	EventDispatcher.Dispatch(EventID.DeleteMailEvent, mails)
end

function MailModule.NotifyNewMail(newMailCount)
	if MailModule.newMailCount ~= nil and newMailCount > MailModule.newMailCount then
		-- block empty
	end

	MailModule.newMailCount = newMailCount

	EventDispatcher.Dispatch(EventID.NewMailCountChangeEvent)
end

function MailModule.GetMailsByTypeResult(mails)
	if MailModule.GetMailsByTypeCallback.Size > 0 then
		local callback = MailModule.GetMailsByTypeCallback:Dequeue()

		callback(mails)
	end
end

function MailModule.GetSpaceIsNotEnough()
	return CfgDiscreteDataTable[49].Data[1] - #MailModule.mailDic <= CfgDiscreteDataTable[72].Data[1]
end

function MailModule.GetIsExpiringSoon()
	for k, v in pairs(MailModule.mailDic) do
		if v.expireTime > 0 and v.expireTime - PlayerModule.GetServerTime() <= CfgDiscreteDataTable[73].Data[1] * 60 * 60 then
			return true
		end
	end

	return false
end

function MailModule.GetNoReadMailCount()
	return MailModule.newMailCount
end
