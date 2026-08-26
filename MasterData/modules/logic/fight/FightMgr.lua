-- chunkname: @modules/logic/fight/FightMgr.lua

module("modules.logic.fight.FightMgr", package.seeall)

local FightMgr = class("FightMgr", FightBaseClass)

function FightMgr:onConstructor()
	return
end

function FightMgr:startFight(fightData, roundData)
	FightDataHelper.initDataMgr()
	FightDataHelper.initFightData(fightData)
	FightDataHelper.stageMgr:setStage(FightStageMgr.StageType.Play)
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.Enter)
end

function FightMgr:cancelOperation()
	self:com_sendFightEvent(FightEvent.BeforeCancelOperation)
	FightDataMgr.instance:cancelOperation()
	FightLocalDataMgr.instance:cancelOperation()
	self:com_sendFightEvent(FightEvent.CancelOperation)
end

function FightMgr:reconnectFight()
	return
end

FightMgr.instance = FightMgr.New()

return FightMgr
