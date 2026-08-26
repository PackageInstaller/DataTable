-- chunkname: @modules/logic/versionactivity2_5/challenge/view/task/Act183TaskBaseItem.lua

module("modules.logic.versionactivity2_5.challenge.view.task.Act183TaskBaseItem", package.seeall)

local Act183TaskBaseItem = class("Act183TaskBaseItem", MixScrollCell)

function Act183TaskBaseItem:init(go)
	self.go = go
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.go)
end

function Act183TaskBaseItem:onUpdateMO(mo, mixType, param)
	self._mo = mo

	self:playAnim()
end

function Act183TaskBaseItem:playAnim()
	local isPlayOpenAnim = UnityEngine.Time.frameCount - Act183TaskListModel.instance.startFrameCount < 10

	if isPlayOpenAnim then
		self._animName = UIAnimationName.Open or UIAnimationName.Idle
	end

	gohelper.setActive(self.go, false)
	TaskDispatcher.cancelTask(self._playAnimByName, self)

	if isPlayOpenAnim then
		TaskDispatcher.runDelay(self._playAnimByName, self, (self._index - 1) * 0.03)

		return
	end

	self:_playAnimByName()
end

function Act183TaskBaseItem:_playAnimByName()
	gohelper.setActive(self.go, true)

	if not self._animName or not self.go.activeInHierarchy then
		return
	end

	self._animatorPlayer:Play(self._animName, self._onPlayAnimDone, self)
end

function Act183TaskBaseItem:_onPlayAnimDone()
	return
end

function Act183TaskBaseItem:onDestroy()
	TaskDispatcher.cancelTask(self._playAnimByName, self)
	self:setBlock(false)
end

function Act183TaskBaseItem:setBlock(isblock)
	if isblock then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("Act183TaskBaseItem_ReceiveReward")
	else
		UIBlockMgrExtend.setNeedCircleMv(true)
		UIBlockMgr.instance:endBlock("Act183TaskBaseItem_ReceiveReward")
	end
end

return Act183TaskBaseItem
