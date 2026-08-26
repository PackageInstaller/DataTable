-- chunkname: @modules/logic/fight/fightcomponent/FightAssetItem.lua

module("modules.logic.fight.fightcomponent.FightAssetItem", package.seeall)

local FightAssetItem = class("FightAssetItem", FightBaseClass)
local resMgr = SLFramework.ResMgr.Instance

function FightAssetItem:onConstructor(url)
	self.url = url
	self.allDependencies = {}
	self.callbackList = {}
	self.refCounter = 0
end

function FightAssetItem:startLoad(callback, handle, param)
	local assetItem = self.assetItem

	if assetItem then
		if callback then
			callback(handle, self.success, assetItem, param)
		end

		return
	else
		local callbackData = {}

		callbackData.callback = callback
		callbackData.handle = handle
		callbackData.param = param

		table.insert(self.callbackList, callbackData)
	end

	if self.loading then
		return
	end

	self.loading = true

	loadAbAsset(self.url, false, self.onLoadCallback, self)
end

function FightAssetItem:onLoadCallback(assetItem)
	self.assetItem = assetItem

	local url = assetItem.ResPath
	local success = assetItem.IsLoadSuccess

	self.success = success

	assetItem:Retain()

	if not success then
		logError("资源加载失败,URL:" .. url)
	end

	local allDependencies = assetItem.allDependencies

	for i = 0, allDependencies.Count - 1 do
		local dependency = allDependencies[i]

		table.insert(self.allDependencies, dependency)
		FightGameMgr.loaderMgr:loadAsset(dependency.ResPath)
	end

	for i = 1, #self.callbackList do
		local callbackData = self.callbackList[i]
		local handle = callbackData.handle
		local callback = callbackData.callback
		local param = callbackData.param

		if callback then
			callbackData.callback(handle, success, assetItem, param)
		end
	end
end

function FightAssetItem:onDestructor()
	removeAssetLoadCb(self.url, self.onLoadCallback, self)

	local assetItem = self.assetItem

	if assetItem then
		assetItem:Release()

		if assetItem.ReferenceCount <= 1 then
			resMgr:ClearItem(assetItem)
		end

		for i = 1, #self.allDependencies do
			local dependency = self.allDependencies[i]

			FightGameMgr.loaderMgr:unloadAsset(dependency.ResPath)
		end
	end
end

return FightAssetItem
