-- chunkname: @modules/logic/weekwalk/model/WeekwalkPrayInfoMO.lua

module("modules.logic.weekwalk.model.WeekwalkPrayInfoMO", package.seeall)

local WeekwalkPrayInfoMO = pureTable("WeekwalkPrayInfoMO")

function WeekwalkPrayInfoMO:init(info)
	self.id = info.id
	self.sacrificeHeroId = info.sacrificeHeroId
	self.blessingHeroId = info.blessingHeroId
	self.heroAttribute = info.heroAttribute
	self.heroExAttribute = info.heroExAttribute
	self.passiveSkills = info.passiveSkills
end

return WeekwalkPrayInfoMO
