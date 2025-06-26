-- chunkname: @IQIGame\\Module\\Mail\\MailData.lua

MailData = {}

function MailData.New()
	local o = Clone(MailData)

	return o
end

function MailData:Init(mailPOD)
	self.Id = mailPOD.id
	self.cid = mailPOD.cid
	self.isRead = mailPOD.isRead
	self.isHasItem = mailPOD.isHasItem
	self.createTime = mailPOD.createTime
	self.expireTime = mailPOD.expireTime
	self.itemList = mailPOD.itemList

	if self.cid ~= nil and self.cid > 0 and CfgMailTable[mailPOD.cid] ~= nil then
		local cfgGiftInfo = CfgMailTable[mailPOD.cid]

		self.title = string.format(cfgGiftInfo.Title, unpack(string.split(mailPOD.title, "|")))
		self.sender = string.format(cfgGiftInfo.Sender, unpack(string.split(mailPOD.sender, "|")))
		self.content = string.format(CfgMailTable[self.cid].Content, unpack(string.split(mailPOD.content, "|")))
	else
		self.title = mailPOD.title
		self.sender = mailPOD.sender
		self.content = mailPOD.content
	end

	self.content = string.gsub(self.content, "\\n", "")
end
