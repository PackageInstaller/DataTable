-- chunkname: @modules/logic/summon/controller/SummonPoolHistoryController.lua

module("modules.logic.summon.controller.SummonPoolHistoryController", package.seeall)

local SummonPoolHistoryController = class("SummonPoolHistoryController", BaseController)

function SummonPoolHistoryController:onInit()
	return
end

function SummonPoolHistoryController:reInit()
	return
end

function SummonPoolHistoryController:onInitFinish()
	return
end

function SummonPoolHistoryController:addConstEvents()
	return
end

function SummonPoolHistoryController:updateSummonQueryToken(info)
	SummonPoolHistoryModel.instance:setToken(info.token)
	self:_requestWeb()
end

function SummonPoolHistoryController:request()
	if LoginModel.instance.serverIp == nil or LoginModel.instance.serverPort == nil then
		logNormal("serverIp is nil, or serverPort is nil")

		return
	end

	if self._httpWebRequestId then
		return
	end

	if SummonPoolHistoryModel.instance:isTokenValidity() then
		self:_requestWeb()
	else
		SummonRpc.instance:sendSummonQueryTokenRequest()
	end
end

function SummonPoolHistoryController:_requestWeb()
	if self._httpWebRequestId then
		return
	end

	local httpLoginUrl
	local httpLoginUrlInfo = UrlConfig.getConfig().login

	if type(httpLoginUrlInfo) == "table" then
		local channelId = tostring(SDKMgr.instance:getChannelId()) or "100"

		httpLoginUrl = httpLoginUrlInfo[channelId]

		if not httpLoginUrlInfo[channelId] then
			for cid, url in pairs(httpLoginUrlInfo) do
				httpLoginUrl = url

				logError(string.format("httpLoginUrl not exist, channelId=%s\nuse %s:%s", channelId, cid, url or "nil"))

				break
			end
		end
	else
		httpLoginUrl = httpLoginUrlInfo
	end

	local url = string.format("%s/query/summon", httpLoginUrl)
	local data = {}

	table.insert(data, string.format("userId=%s", PlayerModel.instance:getMyUserId()))
	table.insert(data, string.format("token=%s", SummonPoolHistoryModel.instance:getToken()))

	url = url .. "?" .. table.concat(data, "&")
	self._httpWebRequestId = SLFramework.SLWebRequest.Instance:Get(url, self._onHttpWebHistoryDataResponse, self)

	logNormal(url)
end

function SummonPoolHistoryController:_onHttpWebHistoryDataResponse(isSuccess, msg)
	self._httpWebRequestId = nil

	if not isSuccess or string.nilorempty(msg) then
		logNormal(string.format("获取卡池历史失败"))

		return
	end

	local data = cjson.decode(msg)

	if data and data.code and data.code == 200 then
		self._lastGetTime = Time.time

		logNormal(string.format("获取卡池历史成功！！"))
		SummonPoolHistoryModel.instance:onGetInfo(data.data)
		SummonController.instance:dispatchEvent(SummonEvent.onGetSummonPoolHistoryData)
	elseif data then
		logNormal(string.format("获取卡池历史出错了 code = %d", data.code))
	else
		logNormal(string.format("获取卡池历史出错了"))
	end
end

SummonPoolHistoryController.instance = SummonPoolHistoryController.New()

return SummonPoolHistoryController
