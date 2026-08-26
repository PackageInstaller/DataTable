-- chunkname: @modules/logic/character/controller/CharacterDestinyEvent.lua

module("modules.logic.character.controller.CharacterDestinyEvent", package.seeall)

local CharacterDestinyEvent = {}

CharacterDestinyEvent.OnRankUpReply = 1
CharacterDestinyEvent.OnLevelUpReply = 2
CharacterDestinyEvent.OnUnlockStoneReply = 3
CharacterDestinyEvent.OnUseStoneReply = 4
CharacterDestinyEvent.OnHeroRedDotReadReply = 5
CharacterDestinyEvent.OnUnlockSlot = 6
CharacterDestinyEvent.onClickReshapeBtn = 7
CharacterDestinyEvent.OnShowStone = 8

return CharacterDestinyEvent
