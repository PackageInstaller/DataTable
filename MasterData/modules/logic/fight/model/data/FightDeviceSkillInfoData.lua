-- chunkname: @modules/logic/fight/model/data/FightDeviceSkillInfoData.lua

module("modules.logic.fight.model.data.FightDeviceSkillInfoData", package.seeall)

local FightDeviceSkillInfoData = FightDataClass("FightDeviceSkillInfoData")

function FightDeviceSkillInfoData:onConstructor(proto)
	self.skillId = proto.skillId
	self.costType = proto.costType
	self.costValue = proto.costValue
	self.isStop = proto.isStop
end

function FightDeviceSkillInfoData:resetStopAttr()
	self.isStop = false
end

function FightDeviceSkillInfoData:setStop(isStop)
	self.isStop = isStop
end

return FightDeviceSkillInfoData
