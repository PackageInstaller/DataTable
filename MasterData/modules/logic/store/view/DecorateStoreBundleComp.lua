-- chunkname: @modules/logic/store/view/DecorateStoreBundleComp.lua

module("modules.logic.store.view.DecorateStoreBundleComp", package.seeall)

local DecorateStoreBundleComp = class("DecorateStoreBundleComp", LuaCompBase)

function DecorateStoreBundleComp.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, DecorateStoreBundleComp)
end

function DecorateStoreBundleComp:init(go)
	self.go = go
	self._prefabLoader = PrefabInstantiate.Create(self.go)
	self._isLoadDone = false
	self._isInitDone = false
end

function DecorateStoreBundleComp:addEventListeners()
	return
end

function DecorateStoreBundleComp:removeEventListeners()
	return
end

function DecorateStoreBundleComp:onUpdateMO(goodsId)
	if self._goodsId == goodsId then
		self:refreshUI()

		return
	end

	self._goodsId = goodsId
	self._isInitDone = true

	self:_loadRes()
end

function DecorateStoreBundleComp:_loadRes()
	if not gohelper.isNil(self._goBundle) then
		gohelper.destroy(self._goBundle)

		self._goBundle = nil
	end

	self._prefabLoader:startLoad(string.format("ui/viewres/store/decoratebundle/%s.prefab", self._goodsId, self._onLoadResDone, self))
end

function DecorateStoreBundleComp:_onLoadResDone(loader)
	self._goBundle = loader:getResInst()
	self._isLoadDone = true

	self:refreshUI()
end

function DecorateStoreBundleComp:refreshUI()
	if not self._isLoadDone or not self._isInitDone then
		return
	end

	self:reallyRefreshUI()
end

function DecorateStoreBundleComp:reallyRefreshUI()
	return
end

function DecorateStoreBundleComp:onDestroy()
	self._prefabLoader = nil
end

return DecorateStoreBundleComp
