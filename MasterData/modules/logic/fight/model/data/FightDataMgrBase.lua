-- chunkname: @modules/logic/fight/model/data/FightDataMgrBase.lua

module("modules.logic.fight.model.data.FightDataMgrBase", package.seeall)

local FightDataMgrBase = FightDataClass("FightDataMgrBase")

function FightDataMgrBase:updateData(fightData)
	return
end

function FightDataMgrBase:onCancelOperation()
	return
end

function FightDataMgrBase:onStageChanged(curStage, preStage)
	return
end

function FightDataMgrBase:com_sendFightEvent(eventId, ...)
	if self.dataMgr.isLocalDataMgr then
		return
	end

	FightController.instance:dispatchEvent(eventId, ...)
end

function FightDataMgrBase:com_sendMsg(msgId, ...)
	if self.dataMgr.isLocalDataMgr then
		return
	end

	FightMsgMgr.sendMsg(msgId, ...)
end

return FightDataMgrBase
