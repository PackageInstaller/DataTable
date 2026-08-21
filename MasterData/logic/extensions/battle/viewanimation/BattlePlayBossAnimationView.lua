-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewanimation/BattlePlayBossAnimationView.lua

module("logic.extensions.battle.viewanimation.BattlePlayBossAnimationView", package.seeall)

local M = class("BattlePlayBossAnimationView", ViewComponent)

function M:buildUI()
	self._bgClickBtn = self:getBtnByPath("bg")
	self._continueBtn = self:getBtnByPath("btnSkip")
	self._enterVideo = self:getGoByPath("enterVideo")
	self._openEffect = CriWareVideoMgr.Get(self._enterVideo)
end

function M:_setButtonState(active)
	goutil.setActive(self._continueBtn.gameObject, active)
end

function M:destroyUI()
	self._continueBtn = nil
	self._index = nil

	if self._openEffect then
		self._openEffect:DestroyMovie()
	end
end

function M:_setEvent(add)
	return
end

function M:bindEvents()
	self._continueBtn:AddClickListener(self._onClickContinue, self)
	self._bgClickBtn:AddClickListener(self._onClickBg, self)
end

function M:unbindEvents()
	self._continueBtn:RemoveClickListener()
	self._bgClickBtn:RemoveClickListener()
end

function M:_onClickBg()
	self:_setButtonState(true)
end

function M:onEnter()
	self._url = self:getFirstParam()

	self:_setEvent(true)
	goutil.setActive(self.mainGO, false)
	self:_setButtonState(false)
	self:_onShowJumpView()
end

function M:_onShowJumpView(evt)
	LoadingFacade.instance:hideLoading()
	goutil.setActive(self.mainGO, true)
	goutil.setActive(self._enterVideo, true)

	local fullVideoPath = GameUrl.getVideoUrl(self._url)

	self._openEffect:PlayMovie(fullVideoPath, true, false, self._onPlayFinished, self)
end

function M:_onPlayFinished()
	self._openEffect:StopMovie()
	goutil.setActive(self._enterVideo, false)
	GlobalDispatcher:dispatchEvent(EventType.BOSS_ANIMATION_PLAY_FINISH)
end

function M:onExit()
	self._openEffect:Reset()
	self:_setEvent(false)
end

function M:_onClickContinue()
	self:_onPlayFinished()
end

return M
