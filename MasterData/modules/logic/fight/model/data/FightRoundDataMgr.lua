-- chunkname: @modules/logic/fight/model/data/FightRoundDataMgr.lua

module("modules.logic.fight.model.data.FightRoundDataMgr", package.seeall)

local FightRoundDataMgr = FightDataClass("FightRoundDataMgr", FightDataMgrBase)

function FightRoundDataMgr:onConstructor()
	self.dataList = {}

	if isDebugBuild then
		self.originDataList = {}
	end

	self.curRoundData = nil
	self.originCurRoundData = nil
	self.enterData = nil
end

function FightRoundDataMgr:setRoundData(roundData)
	self.curRoundData = roundData

	table.insert(self.dataList, roundData)
end

function FightRoundDataMgr:setOriginRoundData(originRoundData)
	self.originCurRoundData = originRoundData

	table.insert(self.originDataList, self.originCurRoundData)
end

function FightRoundDataMgr:getRoundData()
	return self.curRoundData
end

function FightRoundDataMgr:getPreRoundData()
	return self.dataList[#self.dataList - 1]
end

function FightRoundDataMgr:getOriginRoundData()
	return self.originCurRoundData
end

function FightRoundDataMgr:getOriginPreRoundData()
	return self.originDataList[#self.originDataList - 1]
end

function FightRoundDataMgr:getAllOriginRoundData()
	return self.originDataList
end

function FightRoundDataMgr:onCancelOperation()
	return
end

function FightRoundDataMgr:onStageChanged()
	return
end

return FightRoundDataMgr
