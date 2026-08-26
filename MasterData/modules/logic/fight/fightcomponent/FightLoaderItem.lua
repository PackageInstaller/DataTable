-- chunkname: @modules/logic/fight/fightcomponent/FightLoaderItem.lua

module("modules.logic.fight.fightcomponent.FightLoaderItem", package.seeall)

local FightLoaderItem = class("FightLoaderItem", FightBaseClass)

function FightLoaderItem:onConstructor(url, callback, handle, param)
	self.url = url
	self.callback = callback
	self.handle = handle
	self.param = param
end

function FightLoaderItem:startLoad()
	self.item = FightGameMgr.loaderMgr:registLoadAssetItem(self.url)

	self.item:startLoad(self.onAssetLoaded, self)
end

function FightLoaderItem:onAssetLoaded(success, assetItem)
	if self:__isActive() then
		self.callback(self.handle, success, assetItem, self.param)
	end
end

function FightLoaderItem:onDestructor()
	if self.item then
		FightGameMgr.loaderMgr:unloadAsset(self.url)
	end
end

return FightLoaderItem
