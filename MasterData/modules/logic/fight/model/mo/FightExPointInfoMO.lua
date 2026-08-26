-- chunkname: @modules/logic/fight/model/mo/FightExPointInfoMO.lua

module("modules.logic.fight.model.mo.FightExPointInfoMO", package.seeall)

local FightExPointInfoMO = pureTable("FightExPointInfoMO")

function FightExPointInfoMO:init(info)
	self.uid = info.uid
	self.exPoint = info.exPoint
	self.powerInfos = info.powerInfos

	if info.HasField then
		if info:HasField("currentHp") then
			self.currentHp = info.currentHp
		end
	else
		self.currentHp = info.currentHp
	end
end

return FightExPointInfoMO
