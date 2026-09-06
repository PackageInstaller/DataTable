-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttian/view/game/SKXTPlayer.lua

module("logic.extensions.saintknighttian.view.game.SKXTPlayer", package.seeall)

local SKXTPlayer = class("SKXTPlayer", SKTGameUnitBase)

function SKXTPlayer:ctor(go)
	SKXTPlayer.super.ctor(self, go)
end

function SKXTPlayer:buildUI()
	SKXTPlayer.super.buildUI(self)

	self._playerGo = self:getGo("player")
	self._txtScore = self:getText("player/txtScore")
	self._effectGo = self:getGo("effect")
	self._effectHitGo = self:getGo("player/imgHit")

	self:setTweenXOffset(-50)
end

function SKXTPlayer:bindEvents()
	SKXTPlayer.super.bindEvents(self)
end

function SKXTPlayer:unbindEvents()
	SKXTPlayer.super.unbindEvents(self)
end

function SKXTPlayer:onEnter(viewRef)
	SKXTPlayer.super.onEnter(self)

	self._hp = SaintKnightTianConfig.instance:getDefineValue("FBB_INIT_POWER", true)

	self:_setEffect(viewRef)
	self:exitBattle()
	self:_stopHitEffect()
	self:_setHpText()
end

function SKXTPlayer:onExit()
	SKXTPlayer.super.onExit(self)
	UIEffectManager.instance:stopEffect(self._effectHandler)
end

function SKXTPlayer:_getImgNumPath()
	return "player/imgNum"
end

function SKXTPlayer:_setEffect(viewRef)
	local effName = "20220701/xiaotian_youxi/fx_xiaotian_feng.prefab"

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)
	end

	self._effectHandler = UIEffectManager.instance:playEffect(viewRef, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(23)
end

function SKXTPlayer:enterBattle()
	goutil.setActive(self._effectGo, false)
end

function SKXTPlayer:exitBattle()
	goutil.setActive(self._effectGo, true)
end

function SKXTPlayer:_getHitEffectGo()
	return self._effectHitGo
end

return SKXTPlayer
