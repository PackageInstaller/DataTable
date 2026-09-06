-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/notice/controller/NoticeController.lua

module("logic.extensions.notice.controller.NoticeController", package.seeall)

local NoticeController = class("NoticeController", BaseController)
local json = require("cjson")

function NoticeController:onInit()
	self._isFromLoginView = false
	self._isPrepareOpen = false
	self._isOpenWebView = false

	NoticeBoard.registerOnRequestNoticeInfoListener(self._handleOnRequestNoticeInfoListener, self)
	GlobalDispatcher:addListener(GlobalNotify.ApplicationPause, self._handleOnApplicationPause, self)
end

function NoticeController:onReset()
	removetimer(self._onNoticeReqTimeout, self)
end

function NoticeController:_handleOnApplicationPause()
	return
end

function NoticeController:_handleOnRequestNoticeInfoListener(content, statusCode)
	removetimer(self._onNoticeReqTimeout, self)

	if TableUtil.isTableEmpty(content) then
		forcePrint("isTableEmpty")

		return
	end

	NoticeModel.instance:clearNoticeList()
	NoticeModel.instance:setRequestNoticeList(true)

	for noticeType, noticeList in pairs(content) do
		for index, noticeJson in pairs(noticeList) do
			local mo = NoticeMO.New()

			mo.id = checknumber(noticeJson.id)
			mo.flag = checknumber(noticeJson.flag)
			mo.type = checknumber(noticeJson.moduleCode)
			mo.level = checknumber(noticeJson.level)
			mo.title = noticeJson.title
			mo.url = noticeJson.url
			mo.isAlter = checknumber(noticeJson.isAlter) == 1
			mo.order = checknumber(noticeJson.order)

			NoticeModel.instance:addNotice(mo)
		end
	end

	NoticeModel.instance:sort()

	if self._checkAlterNotices then
		self._checkAlterNotices = false

		local hasAlterNotices = NoticeModel.instance:hasAlterNotices()

		forcePrint(" LoginView:_checkShowNoticeView==是否有提醒类型公告==" .. (hasAlterNotices and "true" or "false"))

		if not hasAlterNotices then
			self._isPrepareOpen = false
		end
	end

	if self._isPrepareOpen and (self._isFromLoginView or ReConnectionMgr.instance:isConnected()) then
		if NoticeModel.instance:hasAnyData() then
			UIStateManager.instance:open(ViewName.NoticeView)
		else
			self._isPrepareOpen = false
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.onGameNoticeBack)
end

function NoticeController:requestNoticeInfo()
	forcePrint("requestNoticeInfo==请求公告信息")
	self:getNoticeInfoByHttpConnect()
	settimer(2, self._onNoticeReqTimeout, self)
end

function NoticeController:getNoticeInfoByHttpConnect()
	local url = (CSGameUtil.GetGameConfigUrlType() == 3 or CSGameUtil.GetGameConfigUrlType() == 4 or CSGameUtil.GetGameConfigUrlType() == 5) and "https://noticemgr-test.172tt.com/noticeinfo/v5/getNoticeInfo.json" or "https://noticemgr.qutang.fun/noticeinfo/v5/getNoticeInfo.json"
	local osType = -1

	if Framework.OSDef.RunOS == Framework.OSDef.Android then
		osType = 0
	elseif Framework.OSDef.RunOS == Framework.OSDef.IOS then
		osType = 1
	end

	local form = UnityEngine.WWWForm.New()

	form:AddField("gameId", BootstrapUtil.getGameId())
	form:AddField("platformId", BootstrapUtil.getPlatformId())
	form:AddField("cochannelId", LoginModel.instance:getCoChannelId())
	form:AddField("packageVersion", checknumber(BootstrapUtil.getGameVersionCode()))
	form:AddField("version", "-1")
	form:AddField("zoneId", "-1")
	form:AddField("osType", osType)
	form:AddField("langCode", "zh-CN")
	form:AddField("serverId", "-1")
	Framework.HttpConnnection.Instance:RequestWithForm(url, form, function(isSuccess, msg)
		if isSuccess then
			local status, data = pcall(json.decode, msg)

			if status == true and data.code == 0 then
				self:_handleOnRequestNoticeInfoListener(data.data.value, status)
			else
				printInfo("============_handleHttpWebGetNoticeInfoResponse info msg Failed=========")
				printInfo(msg)
			end
		else
			printInfo("============_handleHttpWebGetNoticeInfoResponse info msg Failed=========")
			printInfo(msg)
		end
	end, 3)
end

function NoticeController:_onNoticeReqTimeout()
	forcePrint("_onNoticeReqTimeout==请求公告信息超时")
	removetimer(self._onNoticeReqTimeout, self)
	GlobalDispatcher:dispatch(GlobalNotify.onGameNoticeBack)
end

function NoticeController:openNoticeView(isFromLoginView, alterNotices)
	if BootstrapPjaqGameConfigMgr.isReview then
		return
	end

	forcePrint("openNoticeView==打开公告面板")

	self._isFromLoginView = not not isFromLoginView
	self._isPrepareOpen = true
	self._checkAlterNotices = alterNotices

	if NoticeModel.instance:isRequesetNoticeList() then
		UIStateManager.instance:open(ViewName.NoticeView)
	else
		self:requestNoticeInfo()
	end
end

function NoticeController:closeNoticeView()
	self._isPrepareOpen = false

	self:closeWebView()
end

function NoticeController:openWebView(x, y, width, height, noticeMO)
	if self._isOpenWebView then
		self:switchWebViewContent(noticeMO)
	else
		local noticeItemJson = {
			id = noticeMO.id,
			flag = noticeMO.flag,
			moduleCode = noticeMO.type,
			title = noticeMO.title,
			url = noticeMO.url,
			order = noticeMO.order
		}

		NoticeBoard.openNoticeView(x, y, width, height, {
			noticeItemJson
		})

		self._isOpenWebView = true
	end
end

function NoticeController:switchWebViewContent(noticeMO)
	local noticeItemJson = {
		id = noticeMO.id,
		flag = noticeMO.flag,
		moduleCode = noticeMO.type,
		title = noticeMO.title,
		url = noticeMO.url,
		order = noticeMO.order
	}

	NoticeBoard.switchNotice({
		noticeItemJson
	})
end

function NoticeController:closeWebView()
	forcePrint("NoticeController:closeWebView")

	if self._isOpenWebView then
		forcePrint("NoticeBoard.closeNoticeViewNoticeBoard.closeNoticeView")
		NoticeBoard.closeNoticeView()

		self._isOpenWebView = false
	end
end

NoticeController.instance = NoticeController.New()

return NoticeController
