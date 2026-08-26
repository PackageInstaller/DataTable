-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/V3a1_GaoSiNiao_TaskView.lua

module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_TaskView", package.seeall)

local V3a1_GaoSiNiao_TaskView = class("V3a1_GaoSiNiao_TaskView", CorvusTaskView)

function V3a1_GaoSiNiao_TaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/LimitTime/#simage_langtxt")
	self._txtlimittime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_limittime")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a1_GaoSiNiao_TaskView:addEvents()
	return
end

function V3a1_GaoSiNiao_TaskView:removeEvents()
	return
end

function V3a1_GaoSiNiao_TaskView:_editableInitView()
	return
end

function V3a1_GaoSiNiao_TaskView:onUpdateParam()
	V3a1_GaoSiNiao_TaskView.super.onUpdateParam(self)
	self:_showLeftTime()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	TaskDispatcher.runRepeat(self._showLeftTime, self, TimeUtil.OneMinuteSecond)
end

function V3a1_GaoSiNiao_TaskView:onOpen()
	V3a1_GaoSiNiao_TaskView.super.onOpen(self)
end

function V3a1_GaoSiNiao_TaskView:onOpenFinish()
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
end

function V3a1_GaoSiNiao_TaskView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	V3a1_GaoSiNiao_TaskView.super.onClose(self)
end

function V3a1_GaoSiNiao_TaskView:onDestroyView()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	V3a1_GaoSiNiao_TaskView.super.onDestroyView(self)
end

function V3a1_GaoSiNiao_TaskView:_showLeftTime()
	self._txtlimittime.text = self:getActivityRemainTimeStr()
end

function V3a1_GaoSiNiao_TaskView:_refresh()
	self:_setTaskList()
end

return V3a1_GaoSiNiao_TaskView
