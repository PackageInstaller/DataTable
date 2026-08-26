-- chunkname: @modules/logic/heroexpbox/controller/HeroExpBoxEvent.lua

module("modules.logic.heroexpbox.controller.HeroExpBoxEvent", package.seeall)

local HeroExpBoxEvent = _M
local _get = GameUtil.getUniqueTb()

HeroExpBoxEvent.SelectHeroItem = _get()

return HeroExpBoxEvent
