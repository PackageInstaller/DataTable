-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KindergartenCourseResultView.lua

module("logic.extensions.kindergarten.view.KindergartenCourseResultView", package.seeall)

local KindergartenCourseResultView = class("KindergartenCourseResultView", ViewComponent)

function KindergartenCourseResultView:buildUI()
	KindergartenCourseResultView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self.scrollerGo = self:getGo("tableview")
	self.cellGo = self:getGo("tableview/tablecell")
	self._emptyGo = self:getGo("emptyGo")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function KindergartenCourseResultView:bindEvents()
	KindergartenCourseResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function KindergartenCourseResultView:unbindEvents()
	KindergartenCourseResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function KindergartenCourseResultView:onEnter()
	KindergartenCourseResultView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.KindergartenViewResultRes, self._onViewResultRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._classId = params[2]
	self._isShowJobTendency = params[3]
	self._info = KindergartenModel.instance:getInfo(self._activityId)

	for i, v in ipairs(self._info.classList) do
		if v.classId == self._classId then
			self._classInfo = v

			break
		end
	end

	if self._isShowJobTendency == true then
		KindergartenAgent.instance:sendPM_KindergartenViewResultReq(self._activityId, self._classId)
	else
		self:_updateInfoList()
	end
end

function KindergartenCourseResultView:onExit()
	KindergartenCourseResultView.super.onExit(self)
	self._scrollList:dispose()
end

function KindergartenCourseResultView:_onViewResultRes()
	self:_updateInfoList()
end

function KindergartenCourseResultView:_updateCell(view, cell, data, tag)
	local txt1 = goutil.findChildTextComponent(cell, "txt1")
	local txt2 = goutil.findChildTextComponent(cell, "txt2")
	local txt3 = goutil.findChildTextComponent(cell, "txt3")
	local txt4 = goutil.findChildTextComponent(cell, "txt4")
	local txt5 = goutil.findChildTextComponent(cell, "txt5")
	local txt6 = goutil.findChildTextComponent(cell, "txt6")
	local uiChangeGroup = cell.gameObject:GetComponent(ComponentType.UIChangeGroup)
	local isTalent = data.studentType == KindergartenModel.TalentStudent
	local value = isTalent and 1 or 0

	uiChangeGroup:SetState(value)

	txt1.text = langPara("学生编号 %d", data.studentId)
	txt2.text = data.growthRate

	local cfg = KindergartenConfig.instance:getJobCfg(self._activityId, data.jobId)

	if self._isShowJobTendency then
		txt6.text = cfg.jobName or "?"
	end

	for i, qualityPoint in ipairs(data.qualityPointList) do
		if qualityPoint.pointType == KindergartenModel.STRENGTH then
			txt4.text = qualityPoint.value
		elseif qualityPoint.pointType == KindergartenModel.ART then
			txt5.text = qualityPoint.value
		elseif qualityPoint.pointType == KindergartenModel.INTELLECT then
			txt3.text = qualityPoint.value
		end
	end
end

function KindergartenCourseResultView:clearCell(cell)
	return
end

function KindergartenCourseResultView:_updateInfoList()
	local studentList = {}

	if self._isShowJobTendency == true then
		for i, v in ipairs(KindergartenModel.instance:getCourseResultStudents()) do
			table.insert(studentList, v)
		end
	else
		for i, v in ipairs(self._classInfo.studentList) do
			table.insert(studentList, v)
		end
	end

	table.sort(studentList, function(a, b)
		if a.studentType ~= b.studentType then
			return a.studentType > b.studentType
		else
			return a.studentId < b.studentId
		end
	end)
	self._scrollList:reloadData(studentList)
	GameUtil.SetActive(self._emptyGo, #(studentList or {}) == 0)
end

return KindergartenCourseResultView
