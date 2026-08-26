-- chunkname: @modules/logic/versionactivity2_2/warmup/view/V2a2_WarmUpLeftView_DayBase.lua

module("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_DayBase", package.seeall)

local V2a2_WarmUpLeftView_DayBase = class("V2a2_WarmUpLeftView_DayBase", RougeSimpleItemBase)
local csAnimatorPlayer = SLFramework.AnimatorPlayer
local csTweenHelper = ZProj.TweenHelper
local kGuideUnknown = -1
local kGuidePeak = 0
local kGuideHasInteractive = 1

function V2a2_WarmUpLeftView_DayBase:ctor(ctorParam)
	RougeSimpleItemBase.ctor(self, ctorParam)
	self:markIsFinishedInteractive(false)
end

function V2a2_WarmUpLeftView_DayBase:_editableInitView()
	RougeSimpleItemBase._editableInitView(self)

	self._beforeGo = gohelper.findChild(self.viewGO, "before")
	self._afterGo = gohelper.findChild(self.viewGO, "after")
	self._animPlayer_before = csAnimatorPlayer.Get(self._beforeGo)
	self._animPlayer_after = csAnimatorPlayer.Get(self._afterGo)
	self._anim_before = self._animPlayer_before and self._animPlayer_before.animator
	self._anim_after = self._animPlayer_after and self._animPlayer_after.animator

	self:setActive_before(false)
	self:setActive_after(false)

	self._guideState = kGuideUnknown
	self._isDestroying = false
end

function V2a2_WarmUpLeftView_DayBase:episodeId()
	return self._episodeId
end

function V2a2_WarmUpLeftView_DayBase:_internal_setEpisode(episodeId)
	self._episodeId = episodeId
end

function V2a2_WarmUpLeftView_DayBase:setActive(isActive)
	gohelper.setActive(self.viewGO, isActive)
end

function V2a2_WarmUpLeftView_DayBase:setActive_before(isActive)
	gohelper.setActive(self._beforeGo, isActive)
end

function V2a2_WarmUpLeftView_DayBase:setActive_after(isActive)
	gohelper.setActive(self._afterGo, isActive)
end

function V2a2_WarmUpLeftView_DayBase:saveState(value)
	assert(value ~= 1999, "please call saveStateDone instead")

	local c = self:_assetGetViewContainer()

	c:saveState(self:episodeId(), value)
end

function V2a2_WarmUpLeftView_DayBase:getState(defaultValue)
	local c = self:_assetGetViewContainer()

	return c:getState(self:episodeId(), defaultValue)
end

function V2a2_WarmUpLeftView_DayBase:saveStateDone(isDone)
	local c = self:_assetGetViewContainer()

	c:saveStateDone(self:episodeId(), isDone)
end

function V2a2_WarmUpLeftView_DayBase:checkIsDone()
	local c = self:_assetGetViewContainer()

	return c:checkIsDone(self:episodeId())
end

function V2a2_WarmUpLeftView_DayBase:openDesc()
	local c = self:_assetGetViewContainer()

	return c:openDesc()
end

function V2a2_WarmUpLeftView_DayBase:setPosToEnd(endTrans, startTrans, isTween, duration, cb, cbObj)
	local v2 = recthelper.rectToRelativeAnchorPos(endTrans.position, startTrans.parent)

	if isTween then
		self._tweenIds = self._tweenIds or {}

		csTweenHelper.KillByObj(startTrans)

		local tweenId = csTweenHelper.DOAnchorPos(startTrans, v2.x, v2.y, duration or 0.2, cb, cbObj)

		table.insert(self._tweenIds, tweenId)
	else
		recthelper.setAnchor(startTrans, v2.x, v2.y)
	end
end

function V2a2_WarmUpLeftView_DayBase:tweenAnchorPos(t, x, y, duration, cb, cbObj)
	GameUtil.onDestroyViewMember_TweenId(self, "_tweenId_DOAnchorPos")

	self._tweenId_DOAnchorPos = csTweenHelper.DOAnchorPos(t, x, y, duration or 0.2, cb, cbObj)
end

function V2a2_WarmUpLeftView_DayBase:onDestroyView()
	self._isDestroying = true

	GameUtil.onDestroyViewMember_TweenId(self, "_tweenId_DOAnchorPos")

	if self._tweenIds then
		for _, tweenId in ipairs(self._tweenIds) do
			csTweenHelper.KillById(tweenId)
		end

		self._tweenIds = nil
	end

	CommonDragHelper.instance:setGlobalEnabled(true)
	RougeSimpleItemBase.onDestroyView(self)
end

local kAnimNameList = {
	"click",
	"click_r",
	"in",
	"out",
	"finish",
	"idle",
	"loop"
}
local kPlayAnimPrefix_before = "playAnim_before_"
local kPlayAnimPrefix_after = "playAnim_after_"
local kPlayAnimRawPrefix_before = "playAnimRaw_before_"
local kPlayAnimRawPrefix_after = "playAnimRaw_after_"

local function kDummyFunc()
	return
end

for _, animName in ipairs(kAnimNameList) do
	V2a2_WarmUpLeftView_DayBase[kPlayAnimPrefix_before .. animName] = function(self, cb, cbObj)
		if not self._beforeGo.activeInHierarchy then
			self:setActive_before(true)
		end

		self._animPlayer_before:Play(animName, cb or kDummyFunc, cbObj)
	end
	V2a2_WarmUpLeftView_DayBase[kPlayAnimRawPrefix_before .. animName] = function(self, layer, normalizedTime)
		local animator = self._anim_before

		animator.enabled = true

		animator:Play(animName, layer, normalizedTime)
	end
	V2a2_WarmUpLeftView_DayBase[kPlayAnimPrefix_after .. animName] = function(self, cb, cbObj)
		if not self._afterGo.activeInHierarchy then
			self:setActive_after(true)
		end

		self._animPlayer_after:Play(animName, cb or kDummyFunc, cbObj)
	end
	V2a2_WarmUpLeftView_DayBase[kPlayAnimRawPrefix_after .. animName] = function(self, layer, normalizedTime)
		local animator = self._anim_after

		animator.enabled = true

		animator:Play(animName, layer, normalizedTime)
	end
end

function V2a2_WarmUpLeftView_DayBase:markGuided()
	self._guideState = kGuideHasInteractive
end

function V2a2_WarmUpLeftView_DayBase:markIsFinishedInteractive(isFinished)
	self._isFinishInteractive = isFinished
end

function V2a2_WarmUpLeftView_DayBase:isFinishInteractive()
	return self._isFinishInteractive
end

function V2a2_WarmUpLeftView_DayBase:_onDragBegin()
	self:_setActive_guide(false)
	self:markGuided()
end

function V2a2_WarmUpLeftView_DayBase:_setActive_guide(isActive)
	gohelper.setActive(self._guideGo, isActive)
end

function V2a2_WarmUpLeftView_DayBase:setData()
	if self:isFinishInteractive() then
		return
	end

	if self._isDestroying then
		return
	end

	CommonDragHelper.instance:setGlobalEnabled(true)

	local isDone = self:checkIsDone()

	self:_setActive_guide(not isDone and self._guideState <= kGuideUnknown)
end

function V2a2_WarmUpLeftView_DayBase:onDataUpdateFirst()
	if self:checkIsDone() then
		self._guideState = kGuidePeak or kGuideUnknown
	end

	self:_setActive_guide(true)
end

function V2a2_WarmUpLeftView_DayBase:onDataUpdate()
	if self:isFinishInteractive() then
		return
	end

	self:setData()
end

function V2a2_WarmUpLeftView_DayBase:onSwitchEpisode()
	local isDone = self:checkIsDone()

	if self._guideState == kGuidePeak and not isDone then
		self._guideState = kGuideUnknown - 1
	elseif self._guideState < kGuideUnknown and isDone then
		self._guideState = kGuidePeak
	end

	self:setData()
end

return V2a2_WarmUpLeftView_DayBase
