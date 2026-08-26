-- chunkname: @modules/logic/versionactivity3_4/chg/flow/ChgAddStartHPWork.lua

module("modules.logic.versionactivity3_4.chg.flow.ChgAddStartHPWork", package.seeall)

local ChgAddStartHPWork = class("ChgAddStartHPWork", GaoSiNiaoWorkBase)

function ChgAddStartHPWork.s_create(targetItem, fromHP, toHP, durationSec)
	local work = ChgAddStartHPWork.New()

	work._targetItem = targetItem
	work._fromHP = fromHP
	work._toHP = toHP
	work._durationSec = durationSec or 0.2

	return work
end

local kNumAnimDurationSec = 1

function ChgAddStartHPWork:onStart()
	self:clearWork()

	if not self._targetItem then
		self:onSucc()

		return
	end

	local deltaHP = self._toHP - self._fromHP

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(self._fromHP, self._toHP, self._durationSec, self._onFrameCallback, nil, self)
	self._tmpNumItem = self._targetItem:playDeltaNumAnim(deltaHP)

	TaskDispatcher.runDelay(self._onNumAnimDone, self, kNumAnimDurationSec)
end

function ChgAddStartHPWork:_onFrameCallback(value)
	local num = math.floor(value)

	self._targetItem:_refreshNum(num)
end

function ChgAddStartHPWork:_onNumAnimDone()
	self:_recycleNum()
	self:onSucc()
end

function ChgAddStartHPWork:clearWork()
	self:_recycleNum()
	GameUtil.onDestroyViewMember_TweenId(self, "_tweenId")
	TaskDispatcher.cancelTask(self._onNumAnimDone, self)
	ChgAddStartHPWork.super.clearWork(self)
end

function ChgAddStartHPWork:_recycleNum()
	if not self._tmpNumItem then
		return
	end

	if self._targetItem then
		self._targetItem:stopDeltaNumAnim(self._tmpNumItem)

		self._tmpNumItem = nil
	end
end

return ChgAddStartHPWork
