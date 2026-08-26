-- chunkname: @modules/logic/fight/system/work/FightWorkRecordDouQuQuData.lua

module("modules.logic.fight.system.work.FightWorkRecordDouQuQuData", package.seeall)

local FightWorkRecordDouQuQuData = class("FightWorkRecordDouQuQuData", FightWorkItem)

function FightWorkRecordDouQuQuData:onStart()
	local mgr = FightDataModel.instance.douQuQuMgr

	mgr.entity2HeroId = mgr.entity2HeroId or {}

	local index = mgr.index

	mgr.entity2HeroId[index] = {}

	for k, v in pairs(FightDataHelper.entityMgr:getAllEntityMO()) do
		mgr.entity2HeroId[index][v.id] = v.modelId
	end

	self:onDone(true)
end

return FightWorkRecordDouQuQuData
