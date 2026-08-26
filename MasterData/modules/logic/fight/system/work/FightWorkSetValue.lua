-- chunkname: @modules/logic/fight/system/work/FightWorkSetValue.lua

module("modules.logic.fight.system.work.FightWorkSetValue", package.seeall)

local FightWorkSetValue = class("FightWorkSetValue", FightWorkItem)

function FightWorkSetValue:onConstructor(handle, key, value)
	self.handle = handle
	self.key = key
	self.value = value
end

function FightWorkSetValue:onStart()
	self.handle[self.key] = self.value

	self:onDone(true)
end

return FightWorkSetValue
