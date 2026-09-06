-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/pool/CommonObjectPool.lua

module("logiccommon.common.viewlib.pool.CommonObjectPool", package.seeall)

local CommonObjectPool = class("CommonObjectPool")

function CommonObjectPool:ctor(container, resPath, capacity)
	self._container = container
	self._capacity = capacity
	self._resPath = resPath
	self._objectAsset = nil
	self._objectAssetPool = nil
end

function CommonObjectPool:init()
	self._objectAsset = CommonPreloader.instance:getAsset(self._resPath)

	if not self._objectAsset then
		printError("get asset from CommonPreloader failed, while resPath=", self._resPath)
	end

	self._objectAssetPool = ObjectPool.New(self._capacity, function()
		local go = self:_cloneObject()

		if go and not goutil.isNil(go) then
			goutil.setActive(go, false)
			goutil.addChildToParent(go, self._container)
		end

		return go
	end, function(go)
		if go and not goutil.isNil(go) then
			goutil.destroy(go)
		end
	end, function(go)
		if go and not goutil.isNil(go) then
			goutil.setActive(go, false)
			goutil.addChildToParent(go, self._container)
		end
	end)
end

function CommonObjectPool:_cloneObject()
	if self._objectAsset then
		return goutil.clone(self._objectAsset)
	end
end

function CommonObjectPool:clear()
	self._objectAsset = nil

	if self._objectAssetPool then
		self._objectAssetPool:clear()

		self._objectAssetPool = nil
	end
end

function CommonObjectPool:fetchObject()
	if self._objectAssetPool then
		return self._objectAssetPool:fetchObject()
	end
end

function CommonObjectPool:returnObject(inst)
	if self._objectAssetPool then
		self._objectAssetPool:returnObject(inst)
	else
		goutil.destroy(inst)
	end
end

return CommonObjectPool
