-- chunkname: @modules/logic/mail/model/MailCategroyMo.lua

module("modules.logic.mail.model.MailCategroyMo", package.seeall)

local MailCategroyMo = class("MailCategroyMo")

function MailCategroyMo:ctor()
	self.id = 0
	self.mailId = 1
	self.state = MailEnum.ReadStatus.Unread
	self.createTime = 0
	self.params = ""
	self.itemGroup = {}
	self.sender = ""
	self.senderMap = {}
	self.senderType = 1
	self.titleMap = {}
	self.title = ""
	self.contentMap = {}
	self.icon = ""
	self.addressee = ""
	self.copy = ""
	self.jumpTitle = ""
	self.jump = ""
	self.expireTime = 0
	self.image = ""
	self.needShowToast = 0
	self.specialTag = nil
	self.isLock = nil
end

function MailCategroyMo:init(info)
	self.mailId = info.id
	self.sender = self:getTemplateSender()
	self.title = self:getTemplateTitle()
	self.icon = info.icon
	self.addressee = info.addressee
	self.copy = info.copy
	self.jumpTitle = self:getTemplateJumpTitle()
	self.jump = info.jump
	self.image = info.image
	self.specialTag = info.specialTag
	self.senderType = info.senderType
	self.isLock = info.isLock
end

function MailCategroyMo:getItem(iteminfo, configInfo)
	local orderedInfo = {}

	if configInfo then
		for _, config in ipairs(configInfo) do
			local configParams = string.split(config, "#")

			for i, item in ipairs(iteminfo) do
				local itemParams = string.split(item, "#")

				if configParams[1] == itemParams[1] and configParams[2] == itemParams[2] and configParams[3] == itemParams[3] then
					table.insert(orderedInfo, item)
					table.remove(iteminfo, i)

					break
				end
			end
		end
	end

	for i = 1, #iteminfo do
		local item = iteminfo[i]

		table.insert(orderedInfo, item)
	end

	for k, v in pairs(orderedInfo) do
		local info = string.split(v, "#")

		table.insert(self.itemGroup, info)
	end
end

function MailCategroyMo:getExpireTime(time)
	self.expireTime = time
end

function MailCategroyMo:getRpc(state, createTime, params, incrId, needShowToast, mailId, isLock)
	self.id = tonumber(incrId)
	self.state = state
	self.createTime = createTime
	self.params = params
	self.needShowToast = needShowToast
	self.mailId = mailId
	self.isLock = isLock
end

function MailCategroyMo:getMailType1(info)
	self.mailId = 0
	self.id = tonumber(info.incrId)
	self.params = info.params
	self.state = info.state
	self.createTime = info.createTime
	self.senderMap = cjson.decode(info.sender)
	self.titleMap = cjson.decode(info.title)
	self.contentMap = cjson.decode(info.content)
	self.copy = info.copy
	self.expireTime = info.expireTime
	self.senderType = info.senderType or 1
	self.jumpTitle = not string.nilorempty(info.jumpTitle) and cjson.decode(info.jumpTitle) or nil
	self.jump = not string.nilorempty(info.jump) and cjson.decode(info.jump) or nil
	self.isLock = info.isLock
end

function MailCategroyMo:getLangTitle()
	local curLang = LangSettings.instance:getCurLangShortcut()

	if not self.titleMap[curLang] then
		local title = self:getTemplateTitle()

		if self.titleMap[curLang] then
			return self.titleMap[curLang]
		end
	end
end

function MailCategroyMo:getJumpLink()
	if self.mailId == 0 then
		local curLang = LangSettings.instance:getCurLangShortcut()

		return (self.jump or nil) and (self.jump[curLang] or "")
	end

	return self.jump
end

function MailCategroyMo:getSenderType()
	if self.senderType == 0 or self.senderType == nil then
		return 1
	end

	return self.senderType
end

function MailCategroyMo:getTemplateTitle()
	local co = lua_mail.configDict[self.mailId]

	if not co then
		return ""
	end

	return co.title
end

function MailCategroyMo:getTemplateJumpTitle()
	if self.mailId == 0 then
		local curLang = LangSettings.instance:getCurLangShortcut()

		return (self.jumpTitle or nil) and (self.jumpTitle[curLang] or "")
	end

	local co = lua_mail.configDict[self.mailId]

	return co.jumpTitle
end

function MailCategroyMo:getLangSender()
	local curLang = LangSettings.instance:getCurLangShortcut()

	if not self.senderMap[curLang] then
		local sender = self:getTemplateSender()

		if self.senderMap[curLang] then
			return self.senderMap[curLang]
		end
	end
end

function MailCategroyMo:getTemplateSender()
	local co = lua_mail.configDict[self.mailId]

	if not co then
		return ""
	end

	return co.sender
end

function MailCategroyMo:haveBonus()
	return self.itemGroup[1][3] ~= nil
end

function MailCategroyMo:getLangContent()
	local curLang = LangSettings.instance:getCurLangShortcut()

	if not self.contentMap[curLang] then
		local content = self:getTemplateContent()

		if self.contentMap[curLang] then
			return self.contentMap[curLang]
		end
	end
end

function MailCategroyMo:getTemplateContent()
	local co = lua_mail.configDict[self.mailId]

	if not co then
		return ""
	end

	if self.params ~= "" then
		local langContent = co.content
		local contents = string.split(self.params, "#")

		langContent = GameUtil.getSubPlaceholderLuaLang(langContent, contents)

		return langContent
	else
		return co.content
	end
end

function MailCategroyMo:hasLockOp()
	if self.isLock == true or self.isLock == false then
		return true
	end

	return false
end

return MailCategroyMo
