-- chunkname: @modules/logic/notice/model/NoticeContentListModel.lua

module("modules.logic.notice.model.NoticeContentListModel", package.seeall)

local NoticeContentListModel = class("NoticeContentListModel", MixScrollModel)

function NoticeContentListModel:setNoticeMO(noticeMO)
	self.noticeMO = noticeMO

	if self.noticeMO then
		local content = self:_convertContentUrl(self.noticeMO:getContent())
		local data = not string.nilorempty(content) and cjson.decode(content) or {}

		self:setList(data)
	else
		self:clear()
	end
end

function NoticeContentListModel:_convertContentUrl(content)
	local conrep = string.gsub(content, "[<>]", "|")
	local res = string.split(conrep, "|")
	local result = content

	table.sort(res, function(a, b)
		return #a > #b
	end)

	for _, v in ipairs(res) do
		if string.find(v, "link=2#") then
			local url = string.urldecode(string.gsub(v, "link=2#", ""))
			local urlId = NoticeModel.instance:getNextUrlId()

			result = string.gsub(result, url, tostring(urlId))

			NoticeModel.instance:setNoticeUrl(urlId, url)
		end
	end

	return result
end

function NoticeContentListModel:convertUrl(url)
	local result = string.gsub(url, "?", "@")

	return string.gsub(result, "-", "!")
end

function NoticeContentListModel:decodeUrl(url)
	local res = string.gsub(url, "@", "?")

	return string.gsub(res, "!", "-")
end

function NoticeContentListModel:decodeToJson()
	if self.noticeMO then
		local list = self:getList()

		self.noticeMO:setContent(cjson.encode(list))
	end
end

function NoticeContentListModel:hasTitle()
	if self.noticeMO then
		for _, contentMo in ipairs(self:getList()) do
			if contentMo.type == NoticeContentType.TxtTopTitle then
				return true
			end
		end
	end

	return false
end

function NoticeContentListModel:getCurSelectNoticeTitle()
	return self.noticeMO and self.noticeMO:getTitle() or ""
end

function NoticeContentListModel:getCurSelectNoticeTypeStr()
	return self.noticeMO and NoticeController.instance:getNoticeTypeStr(self.noticeMO) or ""
end

NoticeContentListModel.ContentTileHeight = 97
NoticeContentListModel.TxtSpaceVertical = 7
NoticeContentListModel.ImgSpaceVertical = 0
NoticeContentListModel.ImgTitleSpaceVertical = 21

function NoticeContentListModel:getInfoList(scrollGO)
	local list = self:getList()

	if not list or #list <= 0 then
		return {}
	end

	local txtContent = gohelper.findChildComponent(scrollGO, "#txt_content", typeof(TMPro.TextMeshProUGUI))
	local mixCellInfos = {}

	for _, mo in ipairs(list) do
		if not mo.type then
			logError("notice content type is nil, noticeId = " .. self.noticeMO.id)

			return
		end

		if mo.type == NoticeContentType.TxtTopTitle then
			local mixCellInfo

			table.insert(mixCellInfos, (not mo.content or string.nilorempty(string.gsub(mo.content, "<.->", ""))) and SLFramework.UGUI.MixCellInfo.New(mo.type, 0, nil) or SLFramework.UGUI.MixCellInfo.New(mo.type, NoticeContentListModel.ContentTileHeight, nil))
		elseif mo.type == NoticeContentType.TxtContent then
			local height = GameUtil.getPreferredHeight(txtContent, mo.content)
			local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(mo.type, height + NoticeContentListModel.TxtSpaceVertical, nil)

			table.insert(mixCellInfos, mixCellInfo)
		elseif mo.type == NoticeContentType.ImgInner then
			if not mo.height then
				local filename = SLFramework.FileHelper.GetFileName(string.gsub(self:decodeUrl(mo.content), "?.*", ""), true)

				mo.width, mo.height = NoticeModel.instance:getSpriteCacheDefaultSize(filename)
			end

			local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(mo.type, (mo.height or 100) + NoticeContentListModel.ImgSpaceVertical, nil)

			table.insert(mixCellInfos, mixCellInfo)
		elseif mo.type == NoticeContentType.ImgTitle then
			if not mo.height then
				local filename = SLFramework.FileHelper.GetFileName(string.gsub(self:decodeUrl(mo.content), "?.*", ""), true)

				mo.width, mo.height = NoticeModel.instance:getSpriteCacheDefaultSize(filename)
			end

			local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(mo.type, (mo.height or 100) + NoticeContentListModel.ImgTitleSpaceVertical, nil)

			table.insert(mixCellInfos, mixCellInfo)
		elseif mo.type == NoticeContentType.LangType then
			logNormal("lang type : " .. tostring(mo.curLang))
		else
			logError("notice content type not implement: " .. mo.type)
		end
	end

	return mixCellInfos
end

NoticeContentListModel.instance = NoticeContentListModel.New()

return NoticeContentListModel
