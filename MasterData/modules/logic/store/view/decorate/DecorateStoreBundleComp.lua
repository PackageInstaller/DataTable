-- chunkname: @modules/logic/store/view/decorate/DecorateStoreBundleComp.lua

module("modules.logic.store.view.decorate.DecorateStoreBundleComp", package.seeall)

local DecorateStoreBundleComp = class("DecorateStoreBundleComp", LuaCompBase)

function DecorateStoreBundleComp.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, DecorateStoreBundleComp)
end

function DecorateStoreBundleComp:init(go)
	self.go = go
	self._prefabLoader = PrefabInstantiate.Create(self.go)
	self._buddleTypeItems = {}

	self:_addEvents()
end

function DecorateStoreBundleComp:_addEvents()
	StoreController.instance:registerCallback(StoreEvent.DecorateGoodItemClick, self._onGoodItemClick, self)
end

function DecorateStoreBundleComp:_removeEvents()
	StoreController.instance:unregisterCallback(StoreEvent.DecorateGoodItemClick, self._onGoodItemClick, self)
end

function DecorateStoreBundleComp:_onGoodItemClick(goodId)
	if not self._buddleTypeItems then
		return
	end

	local decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(goodId)

	if decorateConfig.fatherGoods > 0 and decorateConfig.fatherGoods ~= self._goodId then
		return
	end

	if decorateConfig.fatherGoods <= 0 then
		return
	end

	self:refresh(goodId)
end

function DecorateStoreBundleComp:refresh(goodId)
	if self._goodId == goodId then
		self:refreshUI()

		return
	end

	self._goodId = goodId

	local decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(goodId)
	local goodCo = StoreConfig.instance:getGoodsConfig(goodId)

	self._storeId = tonumber(goodCo.storeId)

	if decorateConfig and decorateConfig.fatherGoods > 0 then
		self._goodId = decorateConfig.fatherGoods
	end

	self._decorateCo = DecorateStoreConfig.instance:getDecorateConfig(self._goodId)
	self._type = self._decorateCo.bundleType or 1

	if not self._buddleTypeItems[self._type] then
		local prefabPath = string.format("ui/viewres/store/decoratebundle/decoratebundletype%s.prefab", self._type)

		UIBlockMgr.instance:startBlock("waitloadbundle")
		self._prefabLoader:startLoad(prefabPath, self._onLoadResDone, self)
	else
		self:refreshUI()
	end
end

function DecorateStoreBundleComp:_onLoadResDone(loader)
	UIBlockMgr.instance:endBlock("waitloadbundle")

	local goBundle = self._prefabLoader:getInstGO()
	local compFuncs = _G[string.format("DecorateStoreBundleCompType%s", self._type)]

	if compFuncs then
		self._buddleTypeItems[self._type] = {}
		self._buddleTypeItems[self._type].go = goBundle
		self._buddleTypeItems[self._type].comp = compFuncs.Get(goBundle)
	end

	self:refreshUI()
end

function DecorateStoreBundleComp:refreshUI()
	for type, com in pairs(self._buddleTypeItems) do
		gohelper.setActive(com.go, type == self._type)
	end

	if self._buddleTypeItems[self._type] then
		self._buddleTypeItems[self._type].comp:refresh(self._goodId)
	end
end

function DecorateStoreBundleComp:hideAll()
	if not self._buddleTypeItems then
		return
	end

	for type, com in pairs(self._buddleTypeItems) do
		gohelper.setActive(com.go, false)
	end
end

function DecorateStoreBundleComp:destroy()
	MonoHelper.removeLuaComFromGo(self.go, DecorateStoreBundleComp)
	self:_removeEvents()
	UIBlockMgr.instance:endBlock("waitloadbundle")

	if self._prefabLoader then
		self._prefabLoader:dispose()

		self._prefabLoader = nil
	end

	if self._buddleTypeItems then
		for _, item in pairs(self._buddleTypeItems) do
			item.comp:destroy()
		end

		self._buddleTypeItems = nil
	end
end

return DecorateStoreBundleComp
