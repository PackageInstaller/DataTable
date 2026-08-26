-- chunkname: @modules/logic/notice/controller/NoticeController.lua

module("modules.logic.notice.controller.NoticeController", package.seeall)

local NoticeController = class("NoticeController", BaseController)

function NoticeController:onInit()
	return
end

function NoticeController:addConstEvents()
	self.addEventCb(self, self, NoticeEvent.OnSelectNoticeItem, self.onSelectNoticeMo, self)
end

function NoticeController:onSelectNoticeMo(noticeMo)
	local var_3_0 = StatEnum.EventName.NoticeShow
	local var_3_1 = {}

	if self.autoOpen then
		var_3_1[StatEnum.EventProperties.NoticeShowType] = StatEnum.NoticeShowType.Auto or StatEnum.NoticeShowType.Click
	end

	var_3_1[StatEnum.EventProperties.NoticeType] = self:getNoticeTypeStr(noticeMo)
	var_3_1[StatEnum.EventProperties.NoticeTitle] = noticeMo:getTitle()

	StatController.instance:track(var_3_0, var_3_1)
	self:setAutoOpenNoticeView(false)
end

function NoticeController:setAutoOpenNoticeView(auto)
	self.autoOpen = auto
end

function NoticeController:getNoticeTypeStr(noticeMo)
	if not noticeMo or not noticeMo.noticeTypes then
		return ""
	end

	local typeStr = ""

	for _, type in ipairs(noticeMo.noticeTypes) do
		if not StatEnum.NoticeType[type] then
			typeStr = string.nilorempty(typeStr) and StatEnum.NoticeType[type] or typeStr .. "-" .. StatEnum.NoticeType[type]
		end
	end

	return typeStr
end

function NoticeController:openNoticeView()
	local now = Time.time

	if not self._lastGetNoticeTime or now - self._lastGetNoticeTime > 10 then
		self.startRequest(self, self._openNoticeView, self)

		self._lastGetNoticeTime = now

		return
	end

	self:_openNoticeView()
end

function NoticeController:_openNoticeView()
	ViewMgr.instance:openView(ViewName.NoticeView)
end

function NoticeController:startRequest(callback, callbackObj, beforeLogin)
	if GameFacade.isExternalTest() then
		if callback then
			callback(callbackObj, true, "")
		end
	else
		self._callback = callback
		self._callbackObj = callbackObj
		self._beforeLogin = beforeLogin

		self:stopRequest()

		local gameId = tostring(SDKMgr.instance:getGameId())
		local channelId = tostring(SDKMgr.instance:getChannelId())
		local subChannelId = tostring(SDKMgr.instance:getSubChannelId())
		local serverType = tostring(GameChannelConfig.getServerType())
		local url = GameUrlConfig.getNoticeUrl() .. "/noticecp/client/query"
		local reqUrl = string.format("%s?gameId=%s&channelId=%s&subChannelId=%s&serverType=%s", url, gameId, channelId, subChannelId, serverType)

		logNormal(string.format("发起公告请求 url : %s", reqUrl))

		self._reqId = SLFramework.SLWebRequest.Instance:Get(reqUrl, self._reqCallback, self)
	end
end

function NoticeController:stopRequest()
	if self._reqId then
		SLFramework.SLWebRequest.Instance:Stop(self._reqId)

		self._reqId = nil
		self._callback = nil
		self._callbackObj = nil
	end
end

function NoticeController:_reqCallback(isSuccess, msg)
	self._reqId = nil

	if isSuccess and not string.nilorempty(msg) then
		local data = cjson.decode(msg)

		if data and data.code and data.code == 200 then
			self._lastGetNoticeTime = Time.time

			logNormal(string.format("获取公告：%s", cjson.encode(data.data)))
			NoticeModel.instance:onGetInfo(data.data)
			NoticeController.instance:dispatchEvent(NoticeEvent.OnGetNoticeInfo)
		elseif data then
			logNormal(string.format("获取公告出错了 code = %d", data.code))
			NoticeController.instance:dispatchEvent(NoticeEvent.OnGetNoticeInfoFail)
		else
			logNormal(string.format("获取公告出错了"))
			NoticeController.instance:dispatchEvent(NoticeEvent.OnGetNoticeInfoFail)
		end
	else
		logNormal(string.format("获取公告失败了"))
		NoticeController.instance:dispatchEvent(NoticeEvent.OnGetNoticeInfoFail)
	end

	if self._beforeLogin and NoticeModel.instance:hasBeforeLoginNotice() then
		BootNoticeView.instance:init(self._beforeLoginNoticeFinished, self, isSuccess, msg)
	else
		self:_beforeLoginNoticeFinished(isSuccess, msg)
	end
end

function NoticeController:_beforeLoginNoticeFinished(isSuccess, msg)
	local callback = self._callback
	local callbackObj = self._callbackObj

	self._callback = nil
	self._callbackObj = nil
	self._beforeLogin = nil

	if callback then
		if callbackObj then
			self._callback(callbackObj, isSuccess, msg)
		else
			self._callback(isSuccess, msg)
		end
	end
end

function NoticeController:getNoticeConfig(callback, callbackObj)
	if GameFacade.isExternalTest() then
		if callback then
			callback(callbackObj, true, "")
		end
	else
		self._getCoCallback = callback
		self._getCoCallbackObj = callbackObj

		self:stopGetConfigRequest()

		local gameId = tostring(SDKMgr.instance:getGameId())
		local channelId = tostring(SDKMgr.instance:getChannelId())
		local subChannelId = tostring(SDKMgr.instance:getSubChannelId())
		local serverType = tostring(GameChannelConfig.getServerType())
		local url = GameUrlConfig.getNoticeUrl() .. "/noticecp/config"
		local reqUrl = string.format("%s?gameId=%s&channelId=%s&subChannelId=%s&serverType=%s", url, gameId, channelId, subChannelId, serverType)

		logNormal(string.format("拿公告配置url : %s", reqUrl))

		self._getCoReqId = SLFramework.SLWebRequest.Instance:Get(reqUrl, self._getCoReqCallback, self)
	end
end

function NoticeController._isNil(obj)
	return not obj or tostring(obj) == "userdata: NULL"
end

function NoticeController:_getCoReqCallback(isSuccess, msg)
	self._getCoReqId = nil

	if isSuccess and not string.nilorempty(msg) then
		logNormal(string.format("获取公告配置：%s", msg))

		local data = cjson.decode(msg)

		if data and data.code and data.code == 200 then
			local co = data.data
			local cgfType
			local var_14_0

			if not self._isNil(co.shootFaceConfig) then
				cgfType = co.shootFaceConfig.type
				var_14_0 = cgfType and tonumber(cgfType) or nil
			end

			NoticeModel.instance:setAutoSelectType(var_14_0)
		end
	end

	local callback = self._getCoCallback
	local callbackObj = self._getCoCallbackObj

	self._getCoCallback = nil
	self._getCoCallbackObj = nil

	if callback then
		if callbackObj then
			self._getCoCallback(callbackObj, isSuccess, msg)
		else
			self._getCoCallback(isSuccess, msg)
		end
	end
end

function NoticeController:stopGetConfigRequest()
	if self._getCoReqId then
		SLFramework.SLWebRequest.Instance:Stop(self._getCoReqId)

		self._getCoReqId = nil
		self._getCoCallback = nil
		self._getCoCallbackObj = nil
	end
end

NoticeController.instance = NoticeController.New()

return NoticeController
