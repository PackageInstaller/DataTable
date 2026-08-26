-- chunkname: @modules/spine/SpinePrefabInstantiate.lua

module("modules.spine.SpinePrefabInstantiate", package.seeall)

local SpinePrefabInstantiate = class("SpinePrefabInstantiate", LuaCompBase)

function SpinePrefabInstantiate.Create(containerGO)
	return MonoHelper.addNoUpdateLuaComOnceToGo(containerGO, SpinePrefabInstantiate)
end

function SpinePrefabInstantiate:init(containerGO)
	self._containerGO = containerGO
	self._path = nil
	self._assetPath = nil
	self._assetItem = nil
	self._instGO = nil
	self._finishCallback = nil
	self._callbackTarget = nil
end

function SpinePrefabInstantiate:startLoad(bundlePath, assetPath, finishCallback, callbackTarget)
	self._path = bundlePath
	self._assetPath = assetPath
	self._finishCallback = finishCallback
	self._callbackTarget = callbackTarget

	loadAbAsset(self._path, false, self._onLoadCallback, self)
end

function SpinePrefabInstantiate:getPath()
	return self._path
end

function SpinePrefabInstantiate:getAssetItem()
	return self._assetItem
end

function SpinePrefabInstantiate:getInstGO()
	return self._instGO
end

function SpinePrefabInstantiate:dispose()
	if self._path then
		removeAssetLoadCb(self._path, self._onLoadCallback, self)
	end

	if self._assetItem then
		self._assetItem:Release()
	end

	gohelper.destroy(self._instGO)

	self._path = nil
	self._assetPath = nil
	self._assetItem = nil
	self._instGO = nil
	self._finishCallback = nil
	self._callbackTarget = nil
end

function SpinePrefabInstantiate:onDestroy()
	self:dispose()

	self._containerGO = nil
end

function SpinePrefabInstantiate:_onLoadCallback(assetItem)
	if assetItem.IsLoadSuccess then
		local oldAsstet = self._assetItem

		self._assetItem = assetItem

		self._assetItem:Retain()

		if oldAsstet then
			oldAsstet:Release()
		end

		local asset = self._assetItem:GetResource(self._assetPath)

		self._instGO = gohelper.clone(asset, self._containerGO)

		if self._finishCallback then
			if self._callbackTarget then
				self._finishCallback(self._callbackTarget, self)
			else
				self:_finishCallback()
			end
		end
	end
end

return SpinePrefabInstantiate
