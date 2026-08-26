-- chunkname: @modules/common/global/GameGlobalMgr.lua

module("modules.common.global.GameGlobalMgr", package.seeall)

local GameGlobalMgr = class("GameGlobalMgr")

function GameGlobalMgr:ctor()
	LuaEventSystem.addEventMechanism(self)
end

function GameGlobalMgr:initLangFont()
	if self._langFont == nil then
		self._langFont = GameLangFont.New()
	end
end

function GameGlobalMgr:init()
	self._screenState = GameScreenState.New()
	self._loadingState = GameLoadingState.New()
	self._fullViewState = GameFullViewState.New()
	self._msgTooOfterCheck = GameMsgTooOftenCheck.New()
	self._msgLockState = GameMsgLockState.New()
	self._screenBrightness = GameScreenBrightness.New()
	self._screenTouch = GameScreenTouch.New()

	self:initLangFont()
	GoHelperExtend.activateExtend()
	StringExtend.activateExtend()
	LuaMixScrollViewExtended.activateExtend()
	CustomAnimContainer.activateCustom()
	GameStateMgr.instance:init()
	GameTimeMgr.instance:init()
	GameGCMgr.instance:init()

	if GameAdaptionBgMgr and GameAdaptionBgMgr.instance then
		GameAdaptionBgMgr.instance:tryAddEvents()
	end
end

function GameGlobalMgr:getScreenState()
	return self._screenState
end

function GameGlobalMgr:getFullViewState()
	return self._fullViewState
end

function GameGlobalMgr:getLoadingState()
	return self._loadingState
end

function GameGlobalMgr:getLangFont()
	return self._langFont
end

function GameGlobalMgr:getMsgLockState()
	return self._msgLockState
end

function GameGlobalMgr:playTouchEffect(pos)
	self._screenTouch:playTouchEffect(pos)
end

function GameGlobalMgr:refreshTouchEffectSkin()
	self._screenTouch:refreshEffect()
end

function GameGlobalMgr:isBanGC()
	return self._fullViewState:isBanGC()
end

GameGlobalMgr.instance = GameGlobalMgr.New()

return GameGlobalMgr
