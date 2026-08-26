-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_TaskView.lua

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_TaskView", package.seeall)

local V3a4_Chg_TaskView = class("V3a4_Chg_TaskView", CorvusTaskView)

function V3a4_Chg_TaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/LimitTime/#simage_langtxt")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a4_Chg_TaskView:addEvents()
	return
end

function V3a4_Chg_TaskView:removeEvents()
	return
end

function V3a4_Chg_TaskView:_editableInitView()
	return
end

function V3a4_Chg_TaskView:onUpdateParam()
	V3a4_Chg_TaskView.super.onUpdateParam(self)
end

function V3a4_Chg_TaskView:onOpen()
	V3a4_Chg_TaskView.super.onOpen(self)
	self:_showLeftTime()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	TaskDispatcher.runRepeat(self._showLeftTime, self, TimeUtil.OneMinuteSecond)
end

function V3a4_Chg_TaskView:onOpenFinish()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function V3a4_Chg_TaskView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	V3a4_Chg_TaskView.super.onClose(self)
end

function V3a4_Chg_TaskView:onDestroyView()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	V3a4_Chg_TaskView.super.onDestroyView(self)
end

function V3a4_Chg_TaskView:_showLeftTime()
	self._txtLimitTime.text = self:getActivityRemainTimeStr()
end

function V3a4_Chg_TaskView:_onSuccessGetBonus()
	local c = self.viewContainer

	c:scrollModel():refreshData()
end

return V3a4_Chg_TaskView
