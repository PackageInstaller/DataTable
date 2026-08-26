-- chunkname: @modules/common/res/AssetMO.lua

module("modules.common.res.AssetMO", package.seeall)

local AssetMO = class("AssetMO")

function AssetMO:ctor(assetItem)
	self:setAssetItem(assetItem)
end

function AssetMO:setAssetItem(assetItem)
	local oldAsstet = self._assetItem

	self._refCount = 0
	self.IsLoadSuccess = assetItem.IsLoadSuccess
	self._url = assetItem.AssetUrl
	self._assetItem = assetItem

	self._assetItem:Retain()

	if oldAsstet then
		self:_clearItem(oldAsstet)
	end
end

function AssetMO:getUrl()
	return self._url
end

function AssetMO:getResource(resName, resType)
	if self.IsLoadSuccess then
		self:_addRef()

		return self._assetItem:GetResource(resName, resType)
	end
end

function AssetMO:getInstance(resName, resType, parent, prefabName)
	if self.IsLoadSuccess then
		local resource = self._assetItem:GetResource(resName, resType)
		local go = gohelper.clone(resource, parent, prefabName)
		local comp = MonoHelper.addNoUpdateLuaComOnceToGo(go, AssetInstanceComp)

		go:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false

		comp:setAsset(self)
		self:_addRef()

		return go
	end
end

function AssetMO:canRelease()
	return self._refCount <= 0
end

function AssetMO:release()
	self:_subRef()
end

function AssetMO:tryDispose()
	self:_dispose()
end

function AssetMO:_dispose()
	ResMgr.removeAsset(self)
	self._assetItem:Release()
	self:_clearItem(self._assetItem)

	self._assetItem = nil
	self._refCount = 0

	logWarn(string.format("lua释放资源给C#——→%s", self._url))
end

function AssetMO:_clearItem(assetItem)
	if assetItem.ReferenceCount == 1 then
		SLFramework.ResMgr.Instance:ClearItem(assetItem)
	end
end

function AssetMO:_addRef()
	self._refCount = self._refCount + 1
end

function AssetMO:_subRef()
	self._refCount = self._refCount - 1
end

return AssetMO
