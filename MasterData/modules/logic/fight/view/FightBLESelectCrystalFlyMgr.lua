-- chunkname: @modules/logic/fight/view/FightBLESelectCrystalFlyMgr.lua

module("modules.logic.fight.view.FightBLESelectCrystalFlyMgr", package.seeall)

local FightBLESelectCrystalFlyMgr = class("FightBLESelectCrystalFlyMgr", UserDataDispose)

function FightBLESelectCrystalFlyMgr:initView(goFlyItem, goFlyScriptItem)
	self:__onInit()

	self.goFlyItem = goFlyItem
	self.goFlyScriptItem = goFlyScriptItem

	gohelper.setActive(goFlyItem, false)
	gohelper.setActive(goFlyScriptItem, false)

	self.flyItemPool = {}
	self.flyingItemList = {}
end

function FightBLESelectCrystalFlyMgr:getFlyItem()
	local item

	if #self.flyItemPool > 0 then
		item = table.remove(self.flyItemPool)
	else
		item = FightBLESelectCrystalFlyItem.New()

		item:initItem(self.goFlyItem, self.goFlyScriptItem, self)
	end

	return item
end

function FightBLESelectCrystalFlyMgr:flyItem(item, startPos, endPos, doneCallback, eventCallback, callbackObj)
	item:startFly(startPos, endPos, doneCallback, eventCallback, callbackObj)
	table.insert(self.flyingItemList, item)
end

function FightBLESelectCrystalFlyMgr:onItemFlyDone(flyItem)
	tabletool.removeValue(self.flyingItemList, flyItem)
	table.insert(self.flyItemPool, flyItem)
end

function FightBLESelectCrystalFlyMgr:stopFlyItem(flyItem)
	if flyItem then
		flyItem:stopFly()
		tabletool.removeValue(self.flyingItemList, flyItem)
		table.insert(self.flyItemPool, flyItem)
	end
end

function FightBLESelectCrystalFlyMgr:stopAll()
	for _, flyItem in ipairs(self.flyingItemList) do
		flyItem:stopFly()
		table.insert(self.flyItemPool, flyItem)
	end

	tabletool.clear(self.flyingItemList)
end

function FightBLESelectCrystalFlyMgr:hasFlyingItem()
	return self:getFlyingCount() > 0
end

function FightBLESelectCrystalFlyMgr:getFlyingCount()
	return #self.flyingItemList
end

function FightBLESelectCrystalFlyMgr:destroy()
	for _, flyItem in ipairs(self.flyingItemList) do
		flyItem:destroy()
	end

	for _, flyItem in ipairs(self.flyItemPool) do
		flyItem:destroy()
	end

	self.flyingItemList = nil
	self.flyItemPool = nil

	self:__onDispose()
end

return FightBLESelectCrystalFlyMgr
