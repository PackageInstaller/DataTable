-- chunkname: @modules/logic/weekwalk/model/WeekwalkHeroInfoMO.lua

module("modules.logic.weekwalk.model.WeekwalkHeroInfoMO", package.seeall)

local WeekwalkHeroInfoMO = pureTable("WeekwalkHeroInfoMO")

function WeekwalkHeroInfoMO:init(info)
	self.heroId = info.heroId
	self.cd = info.cd
end

return WeekwalkHeroInfoMO
