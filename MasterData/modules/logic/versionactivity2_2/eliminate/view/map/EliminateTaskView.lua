-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/map/EliminateTaskView.lua

module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateTaskView", package.seeall)

local EliminateTaskView = class("EliminateTaskView", BaseView)

function EliminateTaskView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function EliminateTaskView:addEvents()
	return
end

function EliminateTaskView:removeEvents()
	return
end

function EliminateTaskView:_editableInitView()
	self._txtremaintime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
end

function EliminateTaskView:onUpdateParam()
	return
end

function EliminateTaskView:onOpen()
	self.addEventCb(self, EliminateMapController.instance, EliminateMapEvent.UpdateTask, self.refreshRight, self)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	self:refreshLeft()
	self:refreshRight()
end

function EliminateTaskView:refreshLeft()
	return
end

function EliminateTaskView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_2Enum.ActivityId.Dungeon]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txtremaintime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
end

function EliminateTaskView:refreshRight()
	EliminateTaskListModel.instance:initTask()
	EliminateTaskListModel.instance:sortTaskMoList()
	EliminateTaskListModel.instance:refreshList()
end

function EliminateTaskView:onClose()
	return
end

function EliminateTaskView:onDestroyView()
	return
end

return EliminateTaskView
