-- chunkname: @modules/logic/fight/model/data/FightEntityExDataMgr.lua

module("modules.logic.fight.model.data.FightEntityExDataMgr", package.seeall)

local FightEntityExDataMgr = FightDataClass("FightEntityExDataMgr", FightDataMgrBase)

function FightEntityExDataMgr:onConstructor()
	self.exDataDic = {}
end

function FightEntityExDataMgr:getById(entityId)
	local data = self.exDataDic[entityId]

	if not data then
		data = FightEntityExData.New()
		self.exDataDic[entityId] = data
	end

	return data
end

function FightEntityExDataMgr:onStageChanged()
	return
end

return FightEntityExDataMgr
