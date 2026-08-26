-- chunkname: @modules/common/others/LoaderComponent.lua

module("modules.common.others.LoaderComponent", package.seeall)

local LoaderComponent = class("LoaderComponent", UserDataDispose)

function LoaderComponent:ctor()
	self:__onInit()

	self._urlDic = {}
	self._callback = {}
	self._assetDic = self:getUserDataTb_()
	self._assetList = self:getUserDataTb_()
	self._failedDic = {}
	self._listLoadCallback = {}
end

function LoaderComponent:getAssetItem(url)
	return self._assetDic[url]
end

function LoaderComponent:loadAsset(url, call_back, handler, failedCallback, param)
	if self.component_dead then
		return
	end

	if self._failedDic[url] then
		if failedCallback then
			failedCallback(handler, url, param)
		end

		return
	end

	if self._assetDic[url] then
		call_back(handler, self._assetDic[url], param)

		return
	end

	self._callback[url] = self._callback[url] or {}

	table.insert(self._callback[url], {
		call_back = call_back,
		handler = handler,
		failedCallback = failedCallback,
		param = param
	})

	if not self._urlDic[url] then
		self._urlDic[url] = true

		loadAbAsset(url, false, self._onLoadCallback, self)
	end
end

function LoaderComponent:loadListAsset(urlList, oneCallback, finishCallback, handler, oneFailedCallback, listFailedCallback)
	if self.component_dead then
		return
	end

	if finishCallback then
		self._listLoadCallback[urlList] = {
			finishCallback = finishCallback,
			handler = handler,
			listFailedCallback = listFailedCallback
		}
	end

	for i, v in ipairs(urlList) do
		self:loadAsset(v, oneCallback, handler, oneFailedCallback)
	end

	self:_invokeUrlListCallback()
end

function LoaderComponent:_invokeUrlListCallback()
	if not self._listLoadCallback then
		return
	end

	if self.component_dead then
		return
	end

	for k, v in pairs(self._listLoadCallback) do
		local count = 0
		local failed = false

		for index, url in ipairs(k) do
			if self._assetDic[url] then
				count = count + 1
			end

			if self._failedDic[url] then
				count = count + 1
				failed = true
			end
		end

		if count == #k then
			if failed then
				if v.listFailedCallback then
					v.listFailedCallback(v.handler)
				end
			else
				v.finishCallback(v.handler)
			end

			self._listLoadCallback[k] = nil

			if self.component_dead then
				return
			end
		end
	end
end

function LoaderComponent:_onLoadCallback(assetItem)
	if self.component_dead then
		return
	end

	local url = assetItem.ResPath
	local success = assetItem.IsLoadSuccess

	if success then
		table.insert(self._assetList, assetItem)

		self._assetDic[url] = assetItem

		assetItem:Retain()
	else
		self._failedDic[url] = true

		logError("资源加载失败,URL:" .. url)
	end

	if self._callback[url] then
		for i, v in ipairs(self._callback[url]) do
			if success then
				v.call_back(v.handler, assetItem, v.param)
			elseif v.failedCallback then
				v.failedCallback(v.handler, url, v.param)
			end

			if self.component_dead then
				return
			end
		end
	end

	self:_invokeUrlListCallback()

	self._callback[url] = nil
end

function LoaderComponent:releaseSelf()
	self.component_dead = true

	for k, v in pairs(self._urlDic) do
		removeAssetLoadCb(k, self._onLoadCallback, self)
	end

	if self._assetList then
		for i, assetItem in ipairs(self._assetList) do
			assetItem:Release()
		end

		self._assetList = nil
	end

	self._urlDic = nil
	self._callback = nil
	self._listLoadCallback = nil
	self._failedDic = nil

	self:__onDispose()
end

return LoaderComponent
