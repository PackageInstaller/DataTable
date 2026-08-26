-- chunkname: @modules/logic/character/controller/CharacterRecommedEvent.lua

module("modules.logic.character.controller.CharacterRecommedEvent", package.seeall)

local CharacterRecommedEvent = {}

CharacterRecommedEvent.OnChangeHero = GameUtil.getEventId()
CharacterRecommedEvent.OnCutHeroAnimCB = GameUtil.getEventId()
CharacterRecommedEvent.OnLoadFinishTracedIcon = GameUtil.getEventId()
CharacterRecommedEvent.OnRefreshTraced = GameUtil.getEventId()
CharacterRecommedEvent.OnJumpView = GameUtil.getEventId()

return CharacterRecommedEvent
