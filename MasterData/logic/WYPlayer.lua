-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/view/game/WYPlayer.lua

module("logic.extensions.fbbchallenge.view.game.WYPlayer", package.seeall)

local WYPlayer = class("WYPlayer", FBBGameUnitBase)

function WYPlayer:ctor(go)
	WYPlayer.super.ctor(self, go)
end

function WYPlayer:buildUI()
	WYPlayer.super.buildUI(self)

	self._playerGo = self:getGo("player")
	self._effectHitGo = self:getGo("player/imgHit")

	self:setTweenXOffset(-50)
end

function WYPlayer:bindEvents()
	WYPlayer.super.bindEvents(self)
end

function WYPlayer:unbindEvents()
	WYPlayer.super.unbindEvents(self)
end

function WYPlayer:onEnter()
	WYPlayer.super.onEnter(self)

	self._hp = FbbchallengeConfig.instance:getDefineValue("WY_INIT_POWER", true)

	self:_stopHitEffect()
	self:_setHpText()
end

function WYPlayer:onExit()
	WYPlayer.super.onExit(self)
end

function WYPlayer:update(timeDelta)
	return
end

function WYPlayer:_getImgNumPath()
	return "player/imgNum"
end

function WYPlayer:_getHitEffectGo()
	return self._effectHitGo
end

return WYPlayer
