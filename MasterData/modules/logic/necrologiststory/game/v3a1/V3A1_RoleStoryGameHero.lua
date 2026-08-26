-- chunkname: @modules/logic/necrologiststory/game/v3a1/V3A1_RoleStoryGameHero.lua

module("modules.logic.necrologiststory.game.v3a1.V3A1_RoleStoryGameHero", package.seeall)

local V3A1_RoleStoryGameHero = class("V3A1_RoleStoryGameHero", LuaCompBase)

function V3A1_RoleStoryGameHero:init(go)
	self.go = go
	self.transform = go.transform
	self.moveDuration = 0.3
end

function V3A1_RoleStoryGameHero:setHeroPos(posX, posY, tween, callback, callbackObj)
	self:clearMoveTween()

	self.callback = callback
	self.callbackObj = callbackObj

	if tween then
		self:showBlock()

		self.moveTweenId = ZProj.TweenHelper.DOAnchorPos(self.transform, posX, posY, self.moveDuration, self.onTweenEnd, self)
	else
		recthelper.setAnchor(self.transform, posX, posY)
		self:onTweenEnd()
	end
end

function V3A1_RoleStoryGameHero:clearMoveTween()
	if self.moveTweenId then
		ZProj.TweenHelper.KillById(self.moveTweenId)

		self.moveTweenId = nil
	end
end

function V3A1_RoleStoryGameHero:onTweenEnd()
	self:closeBlock()

	if self.callback then
		self.callback(self.callbackObj)
	end
end

function V3A1_RoleStoryGameHero:showBlock()
	GameUtil.setActiveUIBlock("V3A1_RoleStoryGameHero", true, false)
end

function V3A1_RoleStoryGameHero:closeBlock()
	GameUtil.setActiveUIBlock("V3A1_RoleStoryGameHero", false, false)
end

function V3A1_RoleStoryGameHero:onDestroy()
	self:closeBlock()
	self:clearMoveTween()
end

return V3A1_RoleStoryGameHero
