-- chunkname: @modules/logic/notice/view/items/NoticeContentBaseItem.lua

module("modules.logic.notice.view.items.NoticeContentBaseItem", package.seeall)

local NoticeContentBaseItem = class("NoticeContentBaseItem", UserDataDispose)

function NoticeContentBaseItem:init(go, types)
	self:__onInit()

	self.itemGo = go
	self.types = types
end

function NoticeContentBaseItem:addEventListeners()
	return
end

function NoticeContentBaseItem:removeEventListeners()
	return
end

function NoticeContentBaseItem:onUpdateMO(mo)
	self.mo = mo

	if self:includeType(self.mo.type) then
		self:show()
	else
		self:hide()
	end
end

function NoticeContentBaseItem:includeType(type)
	return tabletool.indexOf(self.types, type)
end

function NoticeContentBaseItem:show()
	return
end

function NoticeContentBaseItem:hide()
	return
end

function NoticeContentBaseItem:jump(type, url, link1, useWebView, recordUser)
	url = string.trim(url)

	if type == NoticeContentType.LinkType.InnerLink then
		logNormal("click inner link : " .. url)
		GameFacade.jump(url)
	elseif type == NoticeContentType.LinkType.OutLink then
		local fillUrl = NoticeModel.instance:getNoticeUrl(tonumber(url))

		fillUrl = fillUrl and (string.find(fillUrl, "http") and fillUrl or "http://" .. fillUrl) or url
		fillUrl = string.gsub(fillUrl, "\\", "")

		logNormal("Open Url :" .. tostring(fillUrl))

		if useWebView then
			WebViewController.instance:openWebView(fillUrl, recordUser)
		else
			if recordUser then
				fillUrl = WebViewController.instance:getRecordUserUrl(fillUrl)
			end

			GameUtil.openURL(fillUrl)
		end
	elseif type == NoticeContentType.LinkType.DeepLink then
		local deepUrl = url
		local httpsUrl = link1 and string.trim(link1)

		if string.nilorempty(httpsUrl) then
			local urlList = string.split(deepUrl, "//")

			httpsUrl = "https://" .. urlList[2]
		end

		logNormal("Open Http Url : " .. httpsUrl)
		logNormal("Open Deep Url : " .. deepUrl)
		GameUtil.openDeepLink(httpsUrl, deepUrl)
	elseif type == NoticeContentType.LinkType.Time then
		local msg = "时间戳 ： " .. url

		logNormal(msg)
	end
end

function NoticeContentBaseItem:onDestroy()
	self:__onDispose()
end

return NoticeContentBaseItem
