-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/view/game/FbbPlayer.lua

module("logic.extensions.fbbchallenge.view.game.FbbPlayer", package.seeall)

local FbbPlayer = class("FbbPlayer", FBBGameUnitBase)

function FbbPlayer:ctor(go)
	FbbPlayer.super.ctor(self, go)
end

function FbbPlayer:buildUI()
	FbbPlayer.super.buildUI(self)

	self._playerGo = self:getGo("player")
	self._txtScore = self:getText("player/txtScore")
	self._effectGo = self:getGo("effect")
	self._effectHitGo = self:getGo("player/imgHit")

	self:setTweenXOffset(-50)
end

function FbbPlayer:bindEvents()
	FbbPlayer.super.bindEvents(self)
end

function FbbPlayer:unbindEvents()
	FbbPlayer.super.unbindEvents(self)
end

function FbbPlayer:onEnter(viewRef)
	FbbPlayer.super.onEnter(self)

	local raceId = FbbchallengeConfig.instance:getDefineValue("RACE_ID", true)

	self._hp = FbbchallengeConfig.instance:getDefineValue("FBB_INIT_POWER", true)

	self:_setEffect(viewRef)
	self:exitBattle()
	self:_stopHitEffect()
	self:_setHpText()
end

function FbbPlayer:onExit()
	FbbPlayer.super.onExit(self)
	UIEffectManager.instance:stopEffect(self._effectHandler)
end

function FbbPlayer:_getImgNumPath()
	return "player/imgNum"
end

function FbbPlayer:_setEffect(viewRef)
	local effName = "fx_ui_fengbaobao/fx_ui_fbbyanwu.prefab"

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)
	end

	self._effectHandler = UIEffectManager.instance:playEffect(viewRef, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(22)
end

function FbbPlayer:enterBattle()
	goutil.setActive(self._effectGo, false)
end

function FbbPlayer:exitBattle()
	goutil.setActive(self._effectGo, true)
end

function FbbPlayer:_getHitEffectGo()
	return self._effectHitGo
end

return FbbPlayer
