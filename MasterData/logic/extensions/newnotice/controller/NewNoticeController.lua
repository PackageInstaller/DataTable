-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newnotice/controller/NewNoticeController.lua

module("logic.extensions.newnotice.controller.NewNoticeController", package.seeall)

local NewNoticeController = class("NewNoticeController", BaseController)

function NewNoticeController:onInit()
	self._isOpenView = false

	NoticeBoard.registerOnRequestNoticeInfoListener(self._onRequestNoticeInfoListener, self)
	GlobalDispatcher:addEventListener(EventType.APPLICATION_PAUSE, self._onHandleOnApplicationPause, self)
end

function NewNoticeController:onReset()
	return
end

function NewNoticeController:_onHandleOnApplicationPause()
	self:closeNoticeView()
end

function NewNoticeController:openNoticeView(isIgnoreAlter)
	if BootstrapGameConfigMgr.getIsReview() then
		return
	end

	local url = BootstrapGameConfigMgr.getNoticeUrl()

	if url then
		NoticeBoard.setServerUrl(url)
	end

	NewNoticeModel.instance:setIgnoreAlert(isIgnoreAlter)
	NoticeBoard.requestNoticeInfo(BootstrapGameConfigMgr.getHotUpdateAppCode(), tostring(BootstrapUtil.getPlatformId()), tonumber(BootstrapUtil.getGameVersionCode()))
end

function NewNoticeController:closeNoticeView()
	ViewMgr.instance:close(ViewName.NewNoticeView)
end

function NewNoticeController:_onRequestNoticeInfoListener(content)
	printWarn("lzr.._onRequestNoticeInfoListener", content)

	if not content then
		return
	end

	NewNoticeModel.instance:clearNoticeList()
	NewNoticeModel.instance:setRequestNoticeList(true)

	local isAlter = false

	for noticeType, noticeList in pairs(content) do
		for index, noticeJson in pairs(noticeList) do
			local mo = NewNoticeMO.New()

			mo.id = noticeJson.id
			mo.moduleCode = noticeJson.moduleCode
			mo.flag = noticeJson.flag
			mo.title = noticeJson.title
			mo.url = noticeJson.url
			mo.order = noticeJson.order
			mo.isAlter = noticeJson.isAlter
			mo.level = noticeJson.level
			mo.flagName = noticeJson.flagName
			isAlter = isAlter or tonumber(noticeJson.isAlter) == 1
			isAlter = isAlter or tonumber(mo.flag) == NewNoticeEnum.FlagType.URGENT or tonumber(mo.flag) == NewNoticeEnum.FlagType.IMPORTANT

			NewNoticeModel.instance:addNotice(mo)
		end
	end

	NewNoticeModel.instance:sort()

	if NewNoticeModel.instance:hasNotice() and (isAlter or NewNoticeModel.instance:getIgnoreAlert()) then
		ViewMgr.instance:open(ViewName.NewNoticeView)
	end
end

function NewNoticeController:openWebView(x, y, width, height, noticeMO)
	if self._isOpenView then
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

		self._isOpenView = true
	end
end

function NewNoticeController:switchWebViewContent(noticeMO)
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

function NewNoticeController:closeWebView()
	if self._isOpenView then
		NoticeBoard.closeNoticeView()

		self._isOpenView = false
	end

	MainPopController.instance:showNext()
end

NewNoticeController.instance = NewNoticeController.New()

return NewNoticeController
