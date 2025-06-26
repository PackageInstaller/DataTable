-- chunkname: @IQIGame\\Module\\Mail\\MailData.lua

MailData = {}

function MailData.New()
	local o = Clone(MailData)

	return o
end

function MailData:Init(mailPOD)
	table.covered(self, mailPOD)

	if self.cid ~= nil and self.cid > 0 then
		local cfgGiftInfo = CfgMailTable[mailPOD.cid]

		self.title = string.format(cfgGiftInfo.Title, unpack(string.split(mailPOD.title, "|")))
		self.sender = string.format(cfgGiftInfo.Sender, unpack(string.split(mailPOD.sender, "|")))
		self.content = string.format(CfgMailTable[self.cid].Content, unpack(string.split(mailPOD.content, "|")))
	else
		self.title = mailPOD.title
		self.sender = CfgMailTable[CfgDiscreteDataTable[46].Data[1]].Sender
		self.content = string.gsub(mailPOD.content, "\\n", "\n")
	end
end
