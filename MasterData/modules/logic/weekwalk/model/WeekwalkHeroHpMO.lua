-- chunkname: @modules/logic/weekwalk/model/WeekwalkHeroHpMO.lua

module("modules.logic.weekwalk.model.WeekwalkHeroHpMO", package.seeall)

local WeekwalkHeroHpMO = pureTable("WeekwalkHeroHpMO")

function WeekwalkHeroHpMO:init(info)
	self.heroId = info.heroId
	self.hp = info.hp
	self.buff = info.buff
end

function WeekwalkHeroHpMO:setValue(heroId, buff, hp)
	self.heroId = heroId
	self.buff = buff
	self.hp = hp
end

return WeekwalkHeroHpMO
