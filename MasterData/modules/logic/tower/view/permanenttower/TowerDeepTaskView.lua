-- chunkname: @modules/logic/tower/view/permanenttower/TowerDeepTaskView.lua

module("modules.logic.tower.view.permanenttower.TowerDeepTaskView", package.seeall)

local TowerDeepTaskView = class("TowerDeepTaskView", BaseView)

function TowerDeepTaskView:onInitView()
	self._btncloseFullView = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeFullView")
	self._scrolltask = gohelper.findChildScrollRect(self.viewGO, "#scroll_task")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerDeepTaskView:addEvents()
	self._btncloseFullView:AddClickListener(self._btncloseFullViewOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.OnDeepTaskRewardGetFinish, self._playGetRewardFinishAnim, self)
end

function TowerDeepTaskView:removeEvents()
	self._btncloseFullView:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, TowerController.instance, TowerEvent.OnDeepTaskRewardGetFinish, self._playGetRewardFinishAnim, self)
end

TowerDeepTaskView.TaskMaskTime = 0.65
TowerDeepTaskView.TaskGetAnimTime = 0.567

function TowerDeepTaskView:_btncloseFullViewOnClick()
	self:closeThis()
end

function TowerDeepTaskView:_btncloseOnClick()
	self:closeThis()
end

function TowerDeepTaskView:_editableInitView()
	self._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self.viewContainer.scrollView)

	self._taskAnimRemoveItem:setMoveInterval(0)
	self._taskAnimRemoveItem:setMoveAnimationTime(TowerDeepTaskView.TaskMaskTime - TowerDeepTaskView.TaskGetAnimTime)

	self.removeIndexTab = {}
end

function TowerDeepTaskView:onUpdateParam()
	return
end

function TowerDeepTaskView:onOpen()
	self._scrolltask.verticalNormalizedPosition = 1

	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_mission_open)
end

function TowerDeepTaskView:_playGetRewardFinishAnim(index)
	if index then
		self.removeIndexTab = {
			index
		}
	end

	TaskDispatcher.runDelay(self.delayPlayFinishAnim, self, TowerDeepTaskView.TaskGetAnimTime)
end

function TowerDeepTaskView:delayPlayFinishAnim()
	self._taskAnimRemoveItem:removeByIndexs(self.removeIndexTab)
end

function TowerDeepTaskView:onClose()
	TaskDispatcher.cancelTask(self.delayPlayFinishAnim, self)
end

function TowerDeepTaskView:onDestroyView()
	return
end

return TowerDeepTaskView
