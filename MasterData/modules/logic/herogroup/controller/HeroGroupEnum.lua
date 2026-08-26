-- chunkname: @modules/logic/herogroup/controller/HeroGroupEnum.lua

module("modules.logic.herogroup.controller.HeroGroupEnum", package.seeall)

local HeroGroupEnum = _M

HeroGroupEnum.GroupType = {
	Abyss = 2,
	WeekWalk_2 = 1
}
HeroGroupEnum.saveOldVersion = 1
HeroGroupEnum.saveTrialVersion = 2

return HeroGroupEnum
