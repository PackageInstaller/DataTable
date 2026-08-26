-- chunkname: @modules/logic/fight/model/data/FightDevicePowerData.lua

module("modules.logic.fight.model.data.FightDevicePowerData", package.seeall)

local FightDevicePowerData = FightDataClass("FightDevicePowerData")

function FightDevicePowerData:onConstructor(proto)
	self.id = proto.id

	self:setPower(proto.power)
end

FightDevicePowerData.PowerType = {
	Server = 1,
	Client = 2,
	Show = 3
}

function FightDevicePowerData:setPowerType(powerType)
	self.powerType = powerType
end

function FightDevicePowerData:setPower(power)
	self.power = power
end

return FightDevicePowerData
