-- chunkname: @modules/logic/fight/model/data/FightCacheFightDataMgr.lua

module("modules.logic.fight.model.data.FightCacheFightDataMgr", package.seeall)

local FightCacheFightDataMgr = FightDataClass("FightCacheFightDataMgr", FightDataMgrBase)

function FightCacheFightDataMgr:onConstructor()
	self.cacheList = {}
	self.cache = {}
end

function FightCacheFightDataMgr:cacheFightWavePush(fightData)
	table.insert(self.cache, fightData)
	table.insert(self.cacheList, fightData)
end

function FightCacheFightDataMgr:getAndRemove()
	return table.remove(self.cache, 1)
end

function FightCacheFightDataMgr:getNextFightData()
	return self.cache[1]
end

return FightCacheFightDataMgr
