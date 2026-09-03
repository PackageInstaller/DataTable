-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/mail/model/MailItem.lua

MailItem = class("MailItem", objectlua.Object, _M)

MailItem:has("_timeLeft", {
	is = "r"
})
MailItem:has("_id", {
	is = "rw"
})
MailItem:has("_expire", {
	is = "rw"
})
MailItem:has("_isRead", {
	is = "rw"
})
MailItem:has("_items", {
	is = "rw"
})
MailItem:has("_source", {
	is = "rw"
})
MailItem:has("_subtype", {
	is = "rw"
})
MailItem:has("_content", {
	is = "rw"
})
MailItem:has("_title", {
	is = "rw"
})
MailItem:has("_sendDate", {
	is = "rw"
})
MailItem:has("_expireAfterRead", {
	is = "rw"
})
MailItem:has("_topStatus", {
	is = "rw"
})
MailItem:has("_mailConfigId", {
	is = "rw"
})
MailItem:has("_tag", {
	is = "rw"
})
MailItem:has("_customData", {
	is = "rw"
})
MailItem:has("_quickGet", {
	is = "rw"
})
MailItem:has("_showIcon", {
	is = "rw"
})
MailItem:has("_receiveMailItems", {
	is = "rw"
})
MailItem:has("_mailType", {
	is = "rw"
})
MailItem:has("_version", {
	is = "rw"
})

function MailItem:initialize()
	super.initialize(self)

	self._timeLeft = 0
	self._id = 0
	self._expire = 0
	self._isRead = 0
	self._items = {}
	self._source = ""
	self._subtype = 0
	self._content = ""
	self._title = ""
	self._topStatus = 0
	self._mailConfigId = 0
	self._tag = ""
	self._customData = {}
	self._quickGet = 0
	self._showIcon = ""
	self._receiveMailItems = true
	self._mailType = MailType.kNormal
	self._version = {}
end

function MailItem:dispose()
	super.dispose(self)
end

function MailItem:synchronizeModel(data)
	self._mailConfigId = data.mailConfigId

	if self._mailConfigId == "" or self._mailConfigId == nil then
		self._title = data.title
		self._content = tostring(data.content)
		self._source = data.source
	else
		local mailConfig = ConfigReader:requireRecordById("Mail", tostring(data.mailConfigId))

		self._title = mailConfig.Title or ""
		self._content = mailConfig.Content or ""
		self._source = mailConfig.Name or ""
		self._showIcon = mailConfig.Icon
	end

	self._customData = {}

	if data.customData then
		for k, v in pairs(data.customData) do
			if k == "activityId" then
				local activityConfig = ConfigReader:getDataByNameIdAndKey("Activity", v, "Title")

				self._customData[k] = Strings:get(activityConfig)
			else
				self._customData[k] = v
			end
		end
	end

	self._id = data.id

	if data.expireTime and data.expireTime ~= -1 then
		self._expire = data.expireTime
	end

	self._isRead = data.read
	self._subtype = data.subtype
	self._sendDate = data.sendTime
	self._topStatus = data.topStatus
	self._tag = data.tag
	self._expireAfterRead = data.expireAfterRead
	self._quickGet = data.isOneKey
	self._items = self:getMailRewardData(data.items) or {}
	self._receiveMailItems = data.receiveMailItems

	if not self:isItemMail() then
		self._receiveMailItems = true
	end

	if data.mailType then
		self._mailType = data.mailType
	end

	if data.version then
		self._version = data.version
	end

	table.sort(self._items, function(a, b)
		local isADiamond = a.tag == "diamond"
		local isBDiamond = b.tag == "diamond"

		if isADiamond or isBDiamond then
			return isADiamond
		end

		local isAGold = a.tag == "gold"
		local isBGold = b.tag == "gold"

		if isAGold or isBGold then
			return isAGold
		end

		return tostring(a.tag) < tostring(b.tag)
	end)
end

function MailItem:isItemMail()
	return #self._items > 0
end

function MailItem:isReceive()
	return self._receiveMailItems
end

function MailItem:getMailRewardData(rewardsConfig)
	local rewardsData = {}

	if rewardsConfig then
		for i, value in pairs(rewardsConfig) do
			local reward = {}

			reward.code = value.rewardObject.code
			reward.type = value.rewardObject.type
			reward.amount = value.rewardObject.amount
			reward.tag = value.rewardObject.tag
			rewardsData[#rewardsData + 1] = reward
		end
	end

	return rewardsData
end
