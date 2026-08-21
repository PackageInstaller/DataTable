-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/loader/SingleResLoader.lua

module("logic.common.loader.SingleResLoader", package.seeall)

local SingleResLoader = class("SingleResLoader")

function SingleResLoader:ctor()
	self._url = false
	self._handler = Handler.New()
end

function SingleResLoader:load(url, callback, callbackSelf)
	if self:isSameResource(url) then
		return
	end

	self:clear()

	self._url = url

	self._handler:setListener(callback, callbackSelf)
	getres(url, self._onResourceLoaded, self, nil, false)
end

function SingleResLoader:clear()
	if not self._url then
		return
	end

	if self._resource then
		self._resource:Release()

		self._resource = false
	else
		removeresl(self._url, self._onResourceLoaded, self)
	end

	self._url = false

	self._handler:clear()
end

function SingleResLoader:isSameResource(url)
	return self._url == url
end

function SingleResLoader:getUrl()
	return self._url
end

function SingleResLoader:getResource()
	return self._resource
end

function SingleResLoader:getResInstance()
	local res = self:getResource()
	local prefab = res and res:GetMainAsset()

	return prefab and goutil.clone(prefab)
end

function SingleResLoader:isLoaded()
	return self._resource and true or false
end

function SingleResLoader:_onResourceLoaded(resource)
	if resource.IsSuccess then
		self._resource = resource

		self._resource:Retain()
	end

	self._handler:call(resource, self)
end

return SingleResLoader
