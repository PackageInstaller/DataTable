-- chunkname: @modules/logic/herogrouppreset/controller/HeroGroupPresetEvent.lua

module("modules.logic.herogrouppreset.controller.HeroGroupPresetEvent", package.seeall)

local HeroGroupPresetEvent = _M
local _get = GameUtil.getUniqueTb()

HeroGroupPresetEvent.UpdateGroupName = _get()
HeroGroupPresetEvent.UseHeroGroup = _get()
HeroGroupPresetEvent.ClickHero = _get()
HeroGroupPresetEvent.ClickEquip = _get()
HeroGroupPresetEvent.ChangeEquip = _get()
HeroGroupPresetEvent.UpdateHeroGroupSort = _get()

return HeroGroupPresetEvent
