-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/MaterialViewLoader.lua

module("logic.extensions.material.proxy.MaterialViewLoader", package.seeall)

local MaterialViewLoader = class("MaterialViewLoader")

function MaterialViewLoader:ctor()
	self._res = nil
	self._asset = nil
	self._poolLen = 10
	self._goPool = {}
	self.isLoading = false
	self.callBackPool = {}
end

function MaterialViewLoader:loadAsset(path, callback)
	if self.isLoading == false then
		self.isLoading = true

		self:checkCanCallBack(callback)
		self:startLoadAsset(path)
	else
		self:checkCanCallBack(callback)
	end
end

function MaterialViewLoader:doAllCallBack()
	for k, func in pairs(self.callBackPool) do
		self:doCallBack(func)
	end

	self.callBackPool = {}
end

function MaterialViewLoader:checkCanCallBack(callback)
	if self._asset ~= nil then
		self:doCallBack(callback)
	elseif callback ~= nil then
		table.insert(self.callBackPool, callback)
	end
end

function MaterialViewLoader:doCallBack(callback)
	if callback ~= nil then
		local go = self:getOrCreateView()

		callback(go, self)
	end
end

function MaterialViewLoader:getOrCreateView()
	local count = #self._goPool
	local go

	return count < 1 and goutil.clone(self._asset) or table.remove(self._goPool)
end

function MaterialViewLoader:retrunObject(obj)
	if obj ~= nil and obj.transform ~= nil then
		local count = #self._goPool

		if count >= self._poolLen then
			goutil.destroy(obj, true)
		else
			table.insert(self._goPool, obj)
		end
	end
end

function MaterialViewLoader:clear()
	local count = #self._goPool

	if count > 0 then
		local obj

		for i = 1, count do
			goutil.destroy(self._goPool[i], true)

			self._goPool[i] = nil
		end
	end

	self.callBackPool = {}

	if self._res ~= nil then
		self._res:Release()
		GameUtil.unloadResource(self._res)

		self._res = nil
	end
end

function MaterialViewLoader:rmCallBack(callBack)
	for k, func in pairs(self.callBackPool) do
		if callBack == func then
			self.callBackPool[k] = nil
		end
	end
end

function MaterialViewLoader:startLoadAsset(resPath)
	local function onLoaded(res)
		if res.IsSuccess ~= true then
			return
		end

		self._res = res

		res:Retain()

		self._asset = res:GetAsset(nil, nil)

		self:doAllCallBack()
	end

	getres(resPath, onLoaded, nil, ResType.AssetBundle, true)
end

return MaterialViewLoader
