-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttian/view/game/SKTPetPlayer.lua

module("logic.extensions.saintknighttian.view.game.SKTPetPlayer", package.seeall)

local SKTPetPlayer = class("SKTPetPlayer", SKTGameUnitBase)

function SKTPetPlayer:ctor(go)
	SKTPetPlayer.super.ctor(self, go)
end

function SKTPetPlayer:buildUI()
	SKTPetPlayer.super.buildUI(self)

	self._playerGo = self:getGo("player")
	self._effectHitGo = self:getGo("player/imgHit")

	self:setTweenXOffset(-50)
end

function SKTPetPlayer:bindEvents()
	SKTPetPlayer.super.bindEvents(self)
end

function SKTPetPlayer:unbindEvents()
	SKTPetPlayer.super.unbindEvents(self)
end

function SKTPetPlayer:onEnter()
	SKTPetPlayer.super.onEnter(self)

	self._hp = SaintKnightTianConfig.instance:getDefineValue("WY_INIT_POWER", true)

	self:_stopHitEffect()
	self:_setHpText()
end

function SKTPetPlayer:onExit()
	SKTPetPlayer.super.onExit(self)
end

function SKTPetPlayer:update(timeDelta)
	return
end

function SKTPetPlayer:_getImgNumPath()
	return "player/imgNum"
end

function SKTPetPlayer:_getHitEffectGo()
	return self._effectHitGo
end

return SKTPetPlayer
