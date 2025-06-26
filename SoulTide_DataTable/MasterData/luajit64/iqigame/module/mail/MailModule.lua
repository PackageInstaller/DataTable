-- chunkname: @IQIGame\\Module\\Mail\\MailModule.lua

MailModule = {
	newMailCount = 0,
	mailDic = {},
	PickUpCallback = Queue.New(),
	GetMailsByTypeCallback = Queue.New()
}

function MailModule.ReloadMail(data)
	MailModule.newMailCount = data
	MailModule.mailDic = {}
end

function MailModule.GetMailByMailID(mailId)
	for i, v in pairs(MailModule.mailDic) do
		if v.Id == mailId then
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
	local addItems = {}

	for i, v in pairs(itemAwards) do
		table.insert(addItems, {
			cid = v.cid,
			num = v.num
		})
	end

	if #addItems > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, addItems)
	end
end

function MailModule.GetAllMails()
	net_mail.getMails(0)
end

function MailModule.ReadMail(mailId)
	net_mail.readMail(mailId)
end

function MailModule.PickUp(mailIdList, callback)
	if callback ~= nil then
		MailModule.PickUpCallback:Enqueue(callback)
	end

	net_mail.pickUp(mailIdList)
end

function MailModule.DelMail(mailIdList)
	net_mail.delMail(mailIdList)
end

function MailModule.SendGetMailsByType(mailType, callback)
	if callback ~= nil then
		MailModule.GetMailsByTypeCallback:Enqueue(callback)
	end

	net_mail.getMails(mailType)
end

function MailModule.GetAllMailsResult(mails)
	local mailData

	for i, v in pairs(mails) do
		mailData = MailModule.GetMailByMailID(v.id)

		if mailData == nil then
			mailData = MailData.New()

			mailData:Init(v)

			MailModule.mailDic[#MailModule.mailDic + 1] = mailData
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
	local isAllSameType = true
	local lastType

	for i = 1, #mails do
		local mailPOD = mails[i]
		local cfgMailData = CfgMailTable[mailPOD.cid]

		if lastType ~= nil and lastType ~= cfgMailData.MailType then
			isAllSameType = false

			break
		end

		lastType = cfgMailData.MailType
	end

	if (not isAllSameType or lastType == Constant.MailType.TypeSystem) and getItems ~= nil then
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
			if v == mailData.Id then
				table.remove(MailModule.mailDic, i)

				break
			end
		end
	end

	EventDispatcher.Dispatch(EventID.DeleteMailEvent, mails)
end

function MailModule.NotifyNewMail(newMailCount)
	if MailModule.newMailCount == nil or newMailCount > MailModule.newMailCount then
		GameEntry.LuaEvent:Fire(nil, L2DJumpToStateEventArgs():Fill(Constant.L2D_CustomStateName.NewMail))
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
