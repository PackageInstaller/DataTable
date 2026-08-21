-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mail/model/MailMoList.lua

module("logic.extensions.mail.model.MailMoList", package.seeall)

local MailMoList = class("MailMoList", BaseModel)

function MailMoList:ctor()
	self._isCurMailInit = false
	self._curMailList = false
	self._historyMailList = false
end

function MailMoList:onReset()
	self._isCurMailInit = false
	self._curMailList = false
	self._historyMailList = false
end

function MailMoList:reset()
	self:onReset()
end

function MailMoList:initCurMailByAgent(msg)
	self._curMailList = {}
	self._isCurMailInit = true

	local tableLen = #msg.mails

	for i = 1, tableLen do
		local mo = MailMo.New()

		mo:initByAgent(msg.mails[i])

		if not mo:isExpired() then
			mo:setHistory(false)
			table.insert(self._curMailList, mo)
		end
	end

	table.sort(self._curMailList, function(mail1, mail2)
		local rank1 = mail1:getSurveyRank()
		local rank2 = mail2:getSurveyRank()
		local mail1Id = mail1:getId()
		local mail2Id = mail2:getId()
		local mail1ReciveTime = mail1:getReceivedTime()
		local mail2ReciveTime = mail2:getReceivedTime()

		if rank1 == rank2 then
			if mail1ReciveTime == mail2ReciveTime then
				return mail2Id < mail1Id
			end

			return mail2ReciveTime < mail1ReciveTime
		else
			return rank1 < rank2
		end
	end)
end

function MailMoList:initHistoryMailByAgent(msg)
	self._historyMailList = {}

	local tableLen = #msg.mails

	for i = 1, tableLen do
		local mo = MailMo.New()

		mo:initByAgent(msg.mails[i])
		mo:setHistory(true)
		table.insert(self._historyMailList, mo)
	end

	table.sort(self._historyMailList, function(mail1, mail2)
		local rank1 = mail1:getSurveyRank()
		local rank2 = mail2:getSurveyRank()
		local mail1Id = mail1:getId()
		local mail2Id = mail2:getId()
		local mail1ReciveTime = mail1:getReceivedTime()
		local mail2ReciveTime = mail2:getReceivedTime()

		if rank1 == rank2 then
			if mail1ReciveTime == mail2ReciveTime then
				return mail2Id < mail1Id
			end

			return mail2ReciveTime < mail1ReciveTime
		else
			return rank1 < rank2
		end
	end)
end

function MailMoList:takeAllMailAttachment(ids)
	local len = #ids

	for _, v in ipairs(self._curMailList) do
		for i = 1, len do
			if v:getId() == ids[i] then
				v:setIsRead()
				v:setGetReward()
			end
		end
	end
end

function MailMoList:getUnReadMailCount()
	local unReadCount = 0

	for k, v in pairs(self._curMailList or {}) do
		if not v:getIsRead() then
			unReadCount = unReadCount + 1
		end
	end

	return unReadCount
end

function MailMoList:removeAllReadMail(ids)
	local len = #ids

	for i = 1, len do
		for _, v in pairs(self._curMailList) do
			if v:getId() == ids[i] then
				table.removebyvalue(self._curMailList, v)
			end
		end
	end
end

function MailMoList:isCurMailListInit()
	return self._isCurMailInit
end

function MailMoList:getCurMailList()
	return self._curMailList or {}
end

function MailMoList:getHistoryMailList()
	return self._historyMailList or {}
end

function MailMoList:getCanGetReward()
	local hasReward = false
	local hadUnlockSecret = false

	for _, v in ipairs(self._curMailList) do
		if v:getIsSecret() then
			if not v:hasGetReward() and v:hasAttachment() and v:getUnlockState() then
				hasReward = true

				break
			end

			if not v:getUnlockState() then
				hadUnlockSecret = true
			end
		elseif not v:hasGetReward() and v:hasAttachment() then
			hasReward = true

			break
		end
	end

	return hasReward, hadUnlockSecret
end

function MailMoList:checkBackPackIsFull(reward)
	local equipMaxCount = PlayerModel.instance:getBackpackLimit(GameEnum.ItemTypeEnum.EquipItemType, "EquipmentBackpackCapacity")
	local curEquipCount = ItemModel.instance:getItemCountByTS(GameEnum.ItemTypeEnum.EquipItemType, 0)
	local equipCount = 0
	local echoCount = 0
	local curEchoCount = ItemModel.instance:getItemCountByTS(GameEnum.ItemTypeEnum.EchoItemType, 0)
	local echoMaxCount = PlayerModel.instance:getBackpackLimit(GameEnum.ItemTypeEnum.EchoItemType, "EchoItemBackpackCapacity")

	for _, itemData in ipairs(reward) do
		local itemType = itemData:getType()

		if itemType == GameEnum.ItemTypeEnum.EquipItemType then
			equipCount = equipCount + itemData:getCount()

			if equipMaxCount < equipCount + curEquipCount then
				return false
			end
		elseif itemType == GameEnum.ItemTypeEnum.EchoItemType then
			echoCount = echoCount + itemData:getCount()

			if echoMaxCount < echoCount + curEchoCount then
				return false
			end
		end
	end

	return true
end

function MailMoList:changeSelectState(list, id)
	for _, v in ipairs(list) do
		if v:getId() == id then
			v:setSelect(true)
		else
			v:setSelect(false)
		end
	end
end

MailMoList.instance = MailMoList.New()

return MailMoList
