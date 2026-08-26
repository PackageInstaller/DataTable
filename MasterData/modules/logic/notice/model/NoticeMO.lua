-- chunkname: @modules/logic/notice/model/NoticeMO.lua

module("modules.logic.notice.model.NoticeMO", package.seeall)

local NoticeMO = pureTable("NoticeMO")
local Lang2Key = {
	jp = "ja-JP",
	ko = "ko",
	zh = "zh-CN",
	tw = "zh-TW",
	thai = "thai",
	en = "en"
}

function NoticeMO:init(info)
	self.id = info.id
	self.gameId = info.gameId
	self.order = info.order
	self.noticeTypes = info.noticeTypes
	self.noticePositionTypes = info.noticePositionTypes
	self.noticeLabelType = info.noticeLabelType
	self.beginTime = info.beginTime
	self.endTime = info.endTime
	self.noticeLabelTypeName = info.noticeLabelTypeName
	self.isTop = info.isTop
	self.contentMap = info.contentMap

	for _, content in pairs(self.contentMap) do
		for _, url in ipairs(content.imageUrl) do
			self:addImageUrl(url)
		end
	end
end

function NoticeMO:getTitle()
	local contentMO = self:getLangContent()

	return contentMO.title
end

function NoticeMO:getContent()
	local contentMO = self:getLangContent()

	return contentMO.content
end

function NoticeMO:getLangContent()
	local curLang = LangSettings.instance:getCurLangShortcut()

	if not Lang2Key[curLang] then
		local key = curLang
		local content = self.contentMap[key]

		if content then
			return content
		end

		local defaultLang = LangSettings.instance:getDefaultLangShortcut()

		key = Lang2Key[defaultLang] or defaultLang
		content = self.contentMap[key]

		if self.contentMap[key] then
			return content
		end

		for l, c in pairs(self.contentMap) do
			return c
		end
	end
end

function NoticeMO:setContent(content, lang)
	for l, c in pairs(self.contentMap) do
		if not lang or lang == l then
			c.content = content
		end
	end
end

function NoticeMO:addImageUrl(url)
	self.imgUrlDict = self.imgUrlDict or {}

	local fileName = SLFramework.FileHelper.GetFileName(url, false)

	self.imgUrlDict[fileName] = url
end

function NoticeMO:isNormalStatus()
	local now = ServerTime.now()

	return now > self.beginTime / 1000 and now < self.endTime / 1000
end

return NoticeMO
