-- chunkname: @modules/logic/sp01/odyssey/view/work/OdysseyShowRewardWork.lua

module("modules.logic.sp01.odyssey.view.work.OdysseyShowRewardWork", package.seeall)

local OdysseyShowRewardWork = class("OdysseyShowRewardWork", BaseWork)
local CLOSE_TIME = 0.34

function OdysseyShowRewardWork:ctor(showGO, showTime, rewardItemType, canShowAddItemList)
	self.showGO = showGO
	self.showTime = showTime
	self.rewardItemType = rewardItemType
	self.canShowAddItemList = canShowAddItemList
	self.anim = self.showGO:GetComponent(gohelper.Type_Animator)
	self.isSetDone = false
end

function OdysseyShowRewardWork:onStart()
	gohelper.setActive(self.showGO, true)
	self.anim:Play("open", 0, 0)
	self.anim:Update(0)
	TaskDispatcher.runDelay(self.onSetDone, self, self.showTime)

	if self.rewardItemType and self.rewardItemType == OdysseyEnum.RewardItemType.Talent then
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.ShowDungeonTalentGetEffect)
	end

	if self.canShowAddItemList then
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.ShowDungeonBagGetEffect)
	end

	self.rewardItemType = nil
	self.canShowAddItemList = false
end

function OdysseyShowRewardWork:onSetDone()
	if self.isSetDone then
		return
	end

	self.isSetDone = true

	self.anim:Play("close", 0, 0)
	self.anim:Update(0)
	TaskDispatcher.cancelTask(self._delayFinish, self)
	TaskDispatcher.runDelay(self._delayFinish, self, CLOSE_TIME)
end

function OdysseyShowRewardWork:_delayFinish()
	self:onDone(true)
end

function OdysseyShowRewardWork:clearWork()
	gohelper.setActive(self.showGO, false)
	TaskDispatcher.cancelTask(self._delayFinish, self)
	TaskDispatcher.cancelTask(self.onSetDone, self)

	if self.animTweenId then
		ZProj.TweenHelper.KillById(self.animTweenId)
	end

	self.rewardItemType = nil
	self.canShowAddItemList = false
	self.isSetDone = false
end

return OdysseyShowRewardWork
