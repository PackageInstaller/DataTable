-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/social/model/MailMo.lua

module("logic.extensions.social.model.MailMo", package.seeall)

local MailMo = class("MailMo")
local json = require("cjson")

function MailMo:ctor(msg)
	self.mailId = msg.mailId
	self.read = msg.read
	self.gained = msg.gained
	self.sendTime = msg.sendTime
	self.attachment = msg.attachment
	self.attachment = MaterialMgr.filterClothsStr(self.attachment)
	self.title = msg.title or ""
	self.senderName = msg.senderName or ""
	self.content = msg.content or ""
	self.mailParams = msg.mailParams or ""

	local cfg = msg.templateId and SocialConfig.instance:getCfgById(msg.templateId) or nil

	if cfg and (msg.templateId == 25 or msg.templateId == 40 or msg.templateId == 230) then
		self.attachment = MaterialMgr.changeItemStr(self.attachment)
	end

	self:_initAttachment()

	self.timeless = msg.timeless == true
	self.isYear = false

	if cfg then
		if string.nilorempty(msg.title) then
			self.title = StringUtil.parseJsonParams(cfg.title, self.mailParams, true)
		end

		if string.nilorempty(msg.senderName) then
			self.senderName = cfg.senderName
		end

		if string.nilorempty(msg.content) then
			self.content = StringUtil.parseJsonParams(cfg.content, self.mailParams, true)
		end

		self.isYear = cfg.isYear == true
	end

	local limitTime = SocialConfig.instance:getConfigCfgByKey("OUT_DATE_NUM")

	limitTime = checknumber(limitTime)

	local sendDate = GameUtil.time2date(self.sendTime / 1000 - 18000)
	local sendTime = GameUtil.date2time(sendDate.year, sendDate.month, sendDate.day + 1, GameUtil.SERVER_TICK_DAILYR_EFRESH, 0, 0)

	self._expiredTime = sendTime + limitTime * 86400
end

function MailMo:_initAttachment()
	self._attachments = {}

	if not string.nilorempty(self.attachment) then
		local t = string.split(self.attachment, "#")

		for _, v in ipairs(t) do
			local mat = string.split(v, ":")
			local matType = checknumber(mat[1])

			if matType == MatType.Pet then
				local matCount = checknumber(mat[4])

				for i = 1, matCount do
					table.insert(self._attachments, string.format("%s:%s:%s:1", mat[1], mat[2], mat[3]))
				end
			else
				table.insert(self._attachments, v)
			end
		end
	end
end

function MailMo:getShowExpireTime()
	local str = ""

	if self.timeless then
		return str
	end

	local left = math.max(0, self._expiredTime - ServerTime.now())
	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(left)

	str = left >= 86400 and langPara("有效期：%s天%s小时", day, hour) or left >= 3600 and langPara("有效期：%s小时", hour) or langPara("有效期：%s分钟", min)

	return str
end

function MailMo:getLastTime()
	return ServerTime.now() - self.sendTime / 1000
end

function MailMo:getIsNearInvalid()
	if self.timeless then
		return false
	end

	local nowTime = ServerTime.now()
	local now = GameUtil.time2date(nowTime)
	local limitTime = SocialConfig.instance:getConfigCfgByKey("OUT_DATE_NUM")

	limitTime = checknumber(limitTime)
	nowTime = now.hour < 5 and nowTime + (5 - now.hour) * 3600 - now.min * 60 - now.sec - (limitTime + 1) * 24 * 3600 or nowTime - (now.hour - 5) * 3600 - now.min * 60 - now.sec - limitTime * 24 * 3600

	return nowTime > checknumber(self.sendTime / 1000)
end

function MailMo:getHasAttachment()
	if #self._attachments > 0 then
		return not self.gained
	else
		return false
	end
end

function MailMo:getAttachmentDatas()
	return self._attachments
end

return MailMo
