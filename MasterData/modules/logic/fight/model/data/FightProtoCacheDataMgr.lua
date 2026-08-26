-- chunkname: @modules/logic/fight/model/data/FightProtoCacheDataMgr.lua

module("modules.logic.fight.model.data.FightProtoCacheDataMgr", package.seeall)

local FightProtoCacheDataMgr = FightDataClass("FightProtoCacheDataMgr", FightDataMgrBase)

function FightProtoCacheDataMgr:onConstructor()
	self.roundProtoList = {}
	self.fightProtoList = {}
end

function FightProtoCacheDataMgr:addFightProto(proto)
	table.insert(self.fightProtoList, proto)
end

function FightProtoCacheDataMgr:addRoundProto(proto)
	table.insert(self.roundProtoList, proto)
end

function FightProtoCacheDataMgr:getLastRoundProto()
	return self.roundProtoList[#self.roundProtoList]
end

function FightProtoCacheDataMgr:getPreRoundProto()
	return self.roundProtoList[#self.roundProtoList - 1]
end

function FightProtoCacheDataMgr:getLastRoundNum()
	local preRoundProto = self:getPreRoundProto()

	if preRoundProto then
		return preRoundProto.curRound
	end
end

function FightProtoCacheDataMgr:getRoundNumByRoundProto(roundProto)
	local preRoundProto

	for i, v in ipairs(self.roundProtoList) do
		if v == roundProto then
			preRoundProto = self.roundProtoList[i - 1]

			break
		end
	end

	if preRoundProto then
		return preRoundProto.curRound
	end
end

return FightProtoCacheDataMgr
