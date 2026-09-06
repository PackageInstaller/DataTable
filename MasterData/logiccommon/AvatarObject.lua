-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatarobject/AvatarObject.lua

module("logiccommon.common.avatar.avatarobj.AvatarObject", package.seeall)

local AvatarObject = class("AvatarObject")

function AvatarObject:ctor()
	if self._resLoader then
		self._resloader:clear()
	end

	self._visible = true
	self._assetPath = nil
	self._layer = nil
	self._parent = nil
	self._cacheLast = self:_isCacheLast()
	self._resLoader = AvatarResLoaderNew.New(self._cacheLast, self.loadedHandle, self)
end

function AvatarObject:_isCacheLast()
	return true
end

function AvatarObject:load(assetPath)
	if assetPath ~= nil then
		self._assetPath = assetPath

		if self:getResPath() == self._assetPath and self:isLoaded() then
			self:callBackHandle(self._resLoader)
		else
			self._resLoader:load(self._assetPath)
		end
	end
end

function AvatarObject:isLoaded()
	return self._resLoader:isLoaded()
end

function AvatarObject:isObjLoaded()
	return self._resLoader:isObjLoaded()
end

function AvatarObject:getResPath()
	return self._resLoader:getResPath() or "avatar res  nil path"
end

function AvatarObject:loadedHandle(loader)
	self:callBackHandle(loader)
end

function AvatarObject:callBackHandle(loader)
	self:_updateLayer()
	self:_updateParent()
end

function AvatarObject:getResObject()
	return self._resLoader:getResObject()
end

function AvatarObject:getGameObject()
	return self._resLoader:getGameObject()
end

function AvatarObject:setLayer(layer)
	if layer then
		self._layer = layer

		if self._layer then
			local resObject = self:getGameObject()

			if resObject then
				Framework.GameObjectUtil.SetLayerRecursively(resObject, self._layer)
			end
		end

		self._resLoader:setLayer(self._layer)
	end
end

function AvatarObject:getLayer()
	return self._layer
end

function AvatarObject:_updateLayer()
	self:setLayer(self._layer)
end

function AvatarObject:setParent(parent)
	self._parent = parent

	local resObject = self:getGameObject()

	if resObject then
		resObject.transform:SetParent(self._parent)
	end

	self._resLoader:setParent(self._parent)
end

function AvatarObject:getParent()
	return self._parent
end

function AvatarObject:_updateParent()
	if self._parent then
		self:setParent(self._parent)
	end
end

function AvatarObject:setVisible(visible)
	self._visible = checkbool(visible)

	local resObject = self:getGameObject()

	if resObject then
		GameUtil.SetActive(resObject, self._visible)
	end
end

function AvatarObject:destroy()
	self:setVisible(false)

	if self._resLoader then
		self._resLoader:clear()
	end

	self._assetPath = nil
	self._layer = nil
	self._parent = nil
end

return AvatarObject
