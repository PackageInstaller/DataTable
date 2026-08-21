-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryUnlockTipView.lua

module("logic.extensions.story.view.StoryUnlockTipView", package.seeall)

local M = class("StoryUnlockTipView", ViewComponent)

function M:buildUI()
	self._txtUnlockTip = self:getText("juqing_hint_836070449")
	self._clickMaskGo = self:getGo("juqing_hint_-2123589924")
end

function M:destroyUI()
	return
end

function M:onEnter()
	local unlockTypeData = self:getFirstParam() or false
	local isBattle = unlockTypeData.index == 1
	local desc = unlockTypeData.desc or false

	self._playFinishCall = unlockTypeData.callBack
	self._playFinishCallHandle = unlockTypeData.handle

	goutil.setActive(self._clickMaskGo, self._playFinishCall)

	desc = desc or isBattle and lang("tip_story_unlock_battle_title") or lang("tip_story_has_unlock_chapater")
	self._txtUnlockTip.text = desc
end

function M:onPlayFinish()
	if self._playFinishCall then
		self._playFinishCall(self._playFinishCallHandle)
	end
end

function M:onEnterFinished()
	self:onPlayFinish()
	self:close()
end

function M:onExit()
	return
end

return M
