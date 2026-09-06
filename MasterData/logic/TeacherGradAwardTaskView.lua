-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tutor/TeacherGradAwardTaskView.lua

module("logic.extensions.eventtasksummary.view.tutor.TeacherGradAwardTaskView", package.seeall)

local TeacherGradAwardTaskView = class("TeacherGradAwardTaskView", EventTaskFather)

function TeacherGradAwardTaskView:buildUI()
	TeacherGradAwardTaskView.super.buildUI(self)

	self._txtStudentNum = goutil.findChildTextComponent(self.mainGO, "txtStudentNum")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "openTime/txt")
end

function TeacherGradAwardTaskView:_onUpdatePlaneUI()
	TeacherGradAwardTaskView.super._onUpdatePlaneUI(self)

	local curProgress = EventTaskSummaryModel.instance:getTaskCurProgress(1)

	self._txtStudentNum.text = string.format("已带领学生：%d", curProgress)

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	if self._txtOpenTime then
		self._txtOpenTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	end
end

function TeacherGradAwardTaskView:_onClickBtnGo(data)
	if string.nilorempty(data.jumpTo) then
		return
	end

	GotoMgr.gotoByString(data.jumpTo)

	if not ViewSetting.instance:isFullScreen(self._viewPresentor.viewName) then
		GlobalDispatcher:dispatch(GlobalNotify.TutorTeaTaskFloorCloseSignal)
	end
end

return TeacherGradAwardTaskView
