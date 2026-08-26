-- chunkname: @modules/logic/fight/model/data/FightLockOperateDataMgr.lua

module("modules.logic.fight.model.data.FightLockOperateDataMgr", package.seeall)

local FightLockOperateDataMgr = FightDataClass("FightLockOperateDataMgr", FightDataMgrBase)

function FightLockOperateDataMgr:onConstructor()
	return
end

function FightLockOperateDataMgr:isLock()
	if FightDataHelper.stateMgr:getIsAuto() then
		return true
	end

	if FightDataHelper.stateMgr.isReplay then
		return true
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.AutoCardPlaying) then
		return true
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.SendOperation2Server) then
		return true
	end

	return false
end

return FightLockOperateDataMgr
