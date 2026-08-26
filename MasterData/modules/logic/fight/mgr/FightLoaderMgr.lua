-- chunkname: @modules/logic/fight/mgr/FightLoaderMgr.lua

module("modules.logic.fight.mgr.FightLoaderMgr", package.seeall)

local FightLoaderMgr = class("FightLoaderMgr", FightBaseClass)

function FightLoaderMgr:onConstructor()
	self.url2Item = {}
end

function FightLoaderMgr:loadAsset(url, callback, handle, param)
	local item = self:registLoadAssetItem(url)

	item:startLoad(callback, handle, param)
end

function FightLoaderMgr:registLoadAssetItem(url)
	local item = self.url2Item[url]

	if not item then
		item = self:newClass(FightAssetItem, url)
		self.url2Item[url] = item
	end

	item.refCounter = item.refCounter + 1

	return item
end

function FightLoaderMgr:getAsset(url)
	return self.url2Item[url]
end

function FightLoaderMgr:unloadAsset(url)
	local item = self.url2Item[url]

	if item then
		item.refCounter = item.refCounter - 1

		if item.refCounter <= 0 then
			item:disposeSelf()

			self.url2Item[url] = nil
		end
	end
end

function FightLoaderMgr:onDestructor()
	return
end

return FightLoaderMgr
