-- chunkname: @modules/logic/fight/fightcomponent/FightLoaderList.lua

module("modules.logic.fight.fightcomponent.FightLoaderList", package.seeall)

local FightLoaderList = class("FightLoaderList", FightBaseClass)

function FightLoaderList:onConstructor(urlList, oneCallback, finishCallback, handle, paramList)
	self.urlList = urlList
	self.oneCallback = oneCallback
	self.finishCallback = finishCallback
	self.handle = handle
	self.paramList = paramList or {}
	self.count = 0
	self.urlDic = {}
end

function FightLoaderList:startLoad()
	for i, url in ipairs(self.urlList) do
		local item = self.newClass(self, FightLoaderItem, url, self.onOneLoadCallback, self, self.paramList[i])

		self.urlDic[url] = item

		item:startLoad()
	end
end

function FightLoaderList:onOneLoadCallback(success, loader, param)
	if self.oneCallback then
		self.oneCallback(self.handle, success, loader, param)
	end

	self.count = self.count + 1

	if self.count == #self.urlList and self.finishCallback then
		self.finishCallback(self.handle, self)
	end
end

function FightLoaderList:getAssetItem(url)
	local item = self.urlDic[url]

	if item then
		item = item.item

		if item then
			return item.assetItem
		end
	end
end

function FightLoaderList:onDestructor()
	return
end

return FightLoaderList
