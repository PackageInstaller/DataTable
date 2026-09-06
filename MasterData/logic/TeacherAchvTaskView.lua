-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tutor/TeacherAchvTaskView.lua

module("logic.extensions.eventtasksummary.view.tutor.TeacherAchvTaskView", package.seeall)

local TeacherAchvTaskView = class("TeacherAchvTaskView", EventTaskFather)

function TeacherAchvTaskView:buildUI()
	TeacherAchvTaskView.super.buildUI(self)

	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "openTime/txt")
end

function TeacherAchvTaskView:_onUpdatePlaneUI()
	TeacherAchvTaskView.super._onUpdatePlaneUI(self)

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	if self._txtOpenTime then
		self._txtOpenTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	end
end

function TeacherAchvTaskView:_onClickBtnGo(data)
	if string.nilorempty(data.jumpTo) then
		return
	end

	GotoMgr.gotoByString(data.jumpTo)

	if not ViewSetting.instance:isFullScreen(self._viewPresentor.viewName) then
		GlobalDispatcher:dispatch(GlobalNotify.TutorTeaTaskFloorCloseSignal)
	end
end

return TeacherAchvTaskView
