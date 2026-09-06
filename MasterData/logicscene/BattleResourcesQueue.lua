-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/battle/BattleResourcesQueue.lua

module("logicscene.scene.component.battle.BattleResourcesQueue", package.seeall)

local BattleResourcesQueue = class("BattleResourcesQueue", SceneComponentBase)

function BattleResourcesQueue:onExitScene()
	self:clearAll()
end

function BattleResourcesQueue:clearAll()
	self._loadedCallbacks = nil

	if self._resLoaders then
		for k, v in pairs(self._resLoaders) do
			GameUtil.unloadMultiResLoaderResource(v)
		end

		self._resLoaders = nil
	end

	self._resources = nil
	self._isLoadingRes = nil
end

function BattleResourcesQueue:pushResources(resources, callback, callbackObj)
	self._resources = self._resources or {}

	table.insert(self._resources, {
		resources = resources,
		callback = callback,
		callbackObj = callbackObj
	})

	if not self._isLoadingRes then
		self:startLoaded()
	end
end

function BattleResourcesQueue:startLoaded()
	if self._isLoadingRes then
		return
	end

	if self._resources and #self._resources > 0 then
		self._isLoadingRes = true

		local loader = MultiResLoader.New()

		self._resLoaders = self._resLoaders or {}
		self._loadedCallbacks = self._loadedCallbacks or {}
		self._loadedCallbacks[loader] = self._resources[1]

		loader:setResPaths(self._resources[1].resources)
		table.insert(self._resLoaders, loader)
		table.remove(self._resources, 1)
		loader:setAllPreload()
		loader:load(self._onResourcesLoaded, nil, self)
	end
end

function BattleResourcesQueue:_onResourcesLoaded(loader)
	if self._isLoadingRes then
		local callback

		if self._loadedCallbacks then
			callback = self._loadedCallbacks[loader]
		end

		if callback and callback.callback then
			if callback.callbackObj then
				callback.callback(callback.callbackObj, loader)
			else
				callback.callback(loader)
			end
		end

		self._isLoadingRes = nil
	end

	self:startLoaded()
end

return BattleResourcesQueue
