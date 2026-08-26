-- chunkname: @projbooter/hotupdate/optionpackage/OptionPackageHttpWorker.lua

module("projbooter.hotupdate.optionpackage.OptionPackageHttpWorker", package.seeall)

local OptionPackageHttpWorker = class("OptionPackageHttpWorker")

function OptionPackageHttpWorker:ctor()
	self._httpGetterList = {}
	self._httpGetterFinishDict = {}
	self._httpResultDict = {}
end

function OptionPackageHttpWorker:start(httpGeterList, onFinish, finishObj)
	if not httpGeterList or #httpGeterList < 1 then
		self:_runCallBack(onFinish, finishObj)

		return
	end

	self._httpGetterList = {}

	tabletool.addValues(self._httpGetterList, httpGeterList)
	self:_httpGetterStart(onFinish, finishObj)
end

function OptionPackageHttpWorker:stop()
	for _, httpGetter in pairs(self._httpGetterList) do
		if not self._httpGetterFinishDict[httpGetter:getHttpId()] then
			httpGetter:stop()
		end
	end
end

function OptionPackageHttpWorker:checkWorkDone()
	return self:_checkHttpGetResult()
end

function OptionPackageHttpWorker:againGetHttp(onFinish, finishObj)
	self._httpGetterOnFinshFunc = onFinish
	self._httpGetterOnFinshObj = finishObj

	for _, httpGetter in pairs(self._httpGetterList) do
		if not self._httpGetterFinishDict[httpGetter:getHttpId()] then
			httpGetter:start(self._onHttpGetterFinish, self)
		end
	end
end

function OptionPackageHttpWorker:getHttpResult()
	if not self._httpResultDict then
		self:_updateHttpResult()
	end

	return self._httpResultDict
end

function OptionPackageHttpWorker:getPackInfo(packName)
	local httpresultDict = self:getHttpResult()

	if httpresultDict then
		return httpresultDict[packName]
	end
end

function OptionPackageHttpWorker:getDownloadUrl(packName)
	local packInfo = self:getPackInfo(packName)

	if packInfo then
		return packInfo.download_url, packInfo.download_url_bak
	end
end

function OptionPackageHttpWorker:getPackSize(packName)
	local packTb = self:getPackInfo(packName)
	local size = 0

	if packTb and packTb.res then
		for _, oneRes in ipairs(packTb.res) do
			size = size + oneRes.length
		end
	end

	return size
end

function OptionPackageHttpWorker:_httpGetterStart(onFinish, finishObj)
	self._httpGetterOnFinshFunc = onFinish
	self._httpGetterOnFinshObj = finishObj
	self._httpGetterFinishDict = {}
	self._httpResultDict = {}

	for _, httpGetter in pairs(self._httpGetterList) do
		httpGetter:start(self._onHttpGetterFinish, self)
	end
end

function OptionPackageHttpWorker:_onHttpGetterFinish(isSuccess, httpGetter)
	self._httpGetterFinishDict[httpGetter:getHttpId()] = isSuccess

	if isSuccess then
		self:_updateHttpResult()
	end

	local isDone, isAllSuccess = self:_checkHttpGetResult()

	if isDone then
		local cbFunc = self._httpGetterOnFinshFunc
		local cbObj = self._httpGetterOnFinshObj

		self._httpGetterOnFinshFunc = nil
		self._httpGetterOnFinshObj = nil

		self:_runCallBack(cbFunc, cbObj, isAllSuccess)
	end
end

function OptionPackageHttpWorker:_runCallBack(cbFunc, cbObj, isAllSuccess)
	if cbFunc then
		if cbObj ~= nil then
			cbFunc(cbObj, isAllSuccess)
		else
			cbFunc(isAllSuccess)
		end
	end
end

function OptionPackageHttpWorker:_updateHttpResult()
	local result = {}

	for _, httpGetter in pairs(self._httpGetterList) do
		if self._httpGetterFinishDict[httpGetter:getHttpId()] then
			local httpResult = httpGetter:getHttpResult()

			if httpResult then
				for key, value in pairs(httpResult) do
					result[key] = value
				end
			end
		end
	end

	self._httpResultDict = result
end

function OptionPackageHttpWorker:_checkHttpGetResult()
	local isDone = true
	local allSuccess = true

	for _, httpGetter in pairs(self._httpGetterList) do
		local result = self._httpGetterFinishDict[httpGetter:getHttpId()]

		if result == nil then
			isDone = false
			allSuccess = false

			break
		elseif result == false then
			allSuccess = false
		end
	end

	return isDone, allSuccess
end

return OptionPackageHttpWorker
