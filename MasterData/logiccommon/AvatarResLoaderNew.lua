-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatartool/AvatarResLoaderNew.lua

module("logiccommon.common.avatar.AvatarResLoaderNew", package.seeall)

local AvatarResLoaderNew = class("AvatarResLoaderNew")

function AvatarResLoaderNew:ctor(cacheLast, loadedHandler, loadedHandlerObj)
	self._cacheLast = cacheLast
	self._loadedHandler = loadedHandler
	self._loadedHandlerObj = loadedHandlerObj
	self._lastResObject = nil
	self._resObject = nil
	self._lastAssetPath = nil
	self._assetPath = nil
end

function AvatarResLoaderNew:setPreRecycleHandler(handler, handlerObj)
	self._preRecycleHandler = handler
	self._preRecycleHandlerObj = handlerObj
end

function AvatarResLoaderNew:load(assetPath)
	if self._assetPath == assetPath then
		return
	end

	self:_clearLastResObject()

	if self._cacheLast then
		self._lastResObject = self._resObject
		self._lastAssetPath = self._assetPath
		self._resObject = nil
	else
		self:_clearResObject()
	end

	self._assetPath = assetPath
	self._resObject = AvatarsMgrNew.instance:newObject(assetPath, self._onAvatarResLoaded, self)
end

function AvatarResLoaderNew:getResObject()
	return self._resObject
end

function AvatarResLoaderNew:getResPath()
	return self._assetPath
end

function AvatarResLoaderNew:getGameObject()
	if self._resObject then
		return self._resObject.go
	end
end

function AvatarResLoaderNew:clear()
	self:_clearResObject()
	self:_clearLastResObject()
end

function AvatarResLoaderNew:isLoaded()
	if not self._assetPath then
		return true
	end

	return self._resObject and true
end

function AvatarResLoaderNew:isObjLoaded()
	if not self._assetPath then
		return true
	end

	return self._resObject and self._resObject.go and self._resObject.isEnabled
end

function AvatarResLoaderNew:setParent(parent)
	if self._resObject then
		self._resObject:setParent(parent)
		self._resObject:setLocalPos(0, 0, 0)
		self._resObject:setRotation(0, 0, 0)
		self._resObject:setScale(1, 1, 1)
	end
end

function AvatarResLoaderNew:setLayer(layer)
	return
end

function AvatarResLoaderNew:_onAvatarResLoaded(resObject)
	if resObject == self._resObject then
		self:_clearLastResObject()

		if self._loadedHandler then
			if self._loadedHandlerObj then
				self._loadedHandler(self._loadedHandlerObj, self)
			else
				self:_loadedHandler()
			end
		end
	else
		AvatarsMgrNew.instance:recycleObject(resObject)
	end
end

function AvatarResLoaderNew:_clearLastResObject()
	if self._lastResObject then
		self:_preHandleRecycle(self._lastResObject)
		AvatarsMgrNew.instance:recycleObject(self._lastResObject)

		self._lastResObject = nil
	end

	self._lastAssetPath = nil
end

function AvatarResLoaderNew:_clearResObject()
	if self._resObject then
		self:_preHandleRecycle(self._resObject)
		AvatarsMgrNew.instance:recycleObject(self._resObject)

		self._resObject = nil
	end

	self._assetPath = nil
end

function AvatarResLoaderNew:_preHandleRecycle(resObject)
	if self._preRecycleHandler then
		if self._preRecycleHandlerObj then
			self._preRecycleHandler(self._preRecycleHandlerObj, self, resObject)
		else
			self:_preRecycleHandler(resObject)
		end
	end
end

return AvatarResLoaderNew
