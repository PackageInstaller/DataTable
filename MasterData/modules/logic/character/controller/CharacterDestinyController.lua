-- chunkname: @modules/logic/character/controller/CharacterDestinyController.lua

module("modules.logic.character.controller.CharacterDestinyController", package.seeall)

local CharacterDestinyController = class("CharacterDestinyController", BaseController)

function CharacterDestinyController:onInit()
	return
end

function CharacterDestinyController:onInitFinish()
	return
end

function CharacterDestinyController:addConstEvents()
	return
end

function CharacterDestinyController:reInit()
	return
end

function CharacterDestinyController:openCharacterDestinySlotView(heroMo)
	local param = {
		heroMo = heroMo
	}

	ViewMgr.instance:openView(ViewName.CharacterDestinySlotView, param)
end

function CharacterDestinyController:openCharacterDestinyStoneView(heroMo)
	local param = {
		heroMo = heroMo
	}

	ViewMgr.instance:openView(ViewName.CharacterDestinyStoneView, param)
end

function CharacterDestinyController:onRankUp(heroId)
	HeroRpc.instance:setDestinyRankUpRequest(heroId)
end

function CharacterDestinyController:onRankUpReply(heroId)
	self:dispatchEvent(CharacterDestinyEvent.OnRankUpReply, heroId)
end

function CharacterDestinyController:onLevelUp(heroId, level)
	HeroRpc.instance:setDestinyLevelUpRequest(heroId, level)
end

function CharacterDestinyController:onLevelUpReply(heroId, level)
	self:dispatchEvent(CharacterDestinyEvent.OnLevelUpReply, heroId, level)
end

function CharacterDestinyController:onUnlockStone(heroId, stoneId)
	HeroRpc.instance:setDestinyStoneUnlockRequest(heroId, stoneId)
end

function CharacterDestinyController:onUnlockStoneReply(heroId, stoneId)
	self:dispatchEvent(CharacterDestinyEvent.OnUnlockStoneReply, heroId, stoneId)
end

function CharacterDestinyController:onUseStone(heroId, stoneId)
	HeroRpc.instance:setDestinyStoneUseRequest(heroId, stoneId)
end

function CharacterDestinyController:onUseStoneReply(heroId, stoneId)
	self:dispatchEvent(CharacterDestinyEvent.OnUseStoneReply, heroId, stoneId)
end

function CharacterDestinyController:onHeroRedDotReadReply(heroId, redDot)
	self:dispatchEvent(CharacterDestinyEvent.OnHeroRedDotReadReply, heroId, redDot)
end

CharacterDestinyController.instance = CharacterDestinyController.New()

return CharacterDestinyController
