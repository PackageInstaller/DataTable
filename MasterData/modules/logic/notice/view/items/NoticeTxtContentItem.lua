-- chunkname: @modules/logic/notice/view/items/NoticeTxtContentItem.lua

module("modules.logic.notice.view.items.NoticeTxtContentItem", package.seeall)

local NoticeTxtContentItem = class("NoticeTxtContentItem", NoticeContentBaseItem)

function NoticeTxtContentItem:init(go, types)
	NoticeTxtContentItem.super.init(self, go, types)

	self.txtContent = gohelper.findChildText(go, "#txt_content", typeof(TMPro.TextMeshProUGUI))
	self.goContent = self.txtContent.gameObject
	self.hyperLinkClick = gohelper.onceAddComponent(self.txtContent.gameObject, typeof(ZProj.TMPHyperLinkClick))
end

function NoticeTxtContentItem:addEventListeners()
	self.hyperLinkClick:SetClickListener(self._onClickTextMeshProLink, self)
end

function NoticeTxtContentItem:_onClickTextMeshProLink(url)
	logNormal(string.format("on click hyper link, type : %s, link : %s", self.mo.linkType, self.mo.link))

	if not string.nilorempty(self.mo.link) then
		self:jump(self.mo.linkType, self.mo.link, self.mo.link1)
	end
end

function NoticeTxtContentItem:show()
	gohelper.setActive(self.goContent, true)

	local content = self.mo.content

	self.txtContent.text = self:formatTime(content)
end

function NoticeTxtContentItem:formatTime(content)
	local timeStrList
	local timeFindPattern = NoticeEnum.FindTimePattern
	local startIndex = 1

	while true do
		local s, e, _, zone, text = string.find(content, timeFindPattern, startIndex)

		if not s then
			break
		end

		local type, index, timeTable = NoticeHelper.getTimeMatchIndexAndTimeTable(text)

		if not type then
			type = NoticeEnum.FindTimeType.MD_HM
			index = 1
		end

		timeStrList = timeStrList or {}
		timeTable = os.date("*t", TimeUtil.getTimeStamp(timeTable, tonumber(zone)))

		table.insert(timeStrList, {
			s = s,
			e = e,
			content = NoticeHelper.buildTimeByType(type, index, timeTable)
		})

		startIndex = e + 1
	end

	if not timeStrList then
		return content
	end

	local contentList = {}
	local start = 1

	if timeStrList then
		for _, timeObj in ipairs(timeStrList) do
			local s, e = timeObj.s, timeObj.e
			local pre = content:sub(start, s - 1)
			local middle = timeObj.content

			table.insert(contentList, pre)
			table.insert(contentList, middle)

			start = e + 1
		end
	end

	table.insert(contentList, content:sub(start))

	return table.concat(contentList)
end

function NoticeTxtContentItem:hide()
	gohelper.setActive(self.goContent, false)
end

return NoticeTxtContentItem
