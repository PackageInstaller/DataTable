-- chunkname: @modules/logic/versionactivity3_7/travelgo/model/TravelGoBattleEventMO.lua

module("modules.logic.versionactivity3_7.travelgo.model.TravelGoBattleEventMO", package.seeall)

local TravelGoBattleEventMO = pureTable("TravelGoBattleEventMO", TravelGoEventMO)

function TravelGoBattleEventMO:onSetData()
	return
end

function TravelGoBattleEventMO:setBattleResult(isEnd, isWin)
	self.isEnd = isEnd
	self.isWin = isWin
end

function TravelGoBattleEventMO:getResultRewardStr()
	return self.cfg.result1reward
end

return TravelGoBattleEventMO
