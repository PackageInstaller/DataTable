-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KindergartenCourseView.lua

module("logic.extensions.kindergarten.view.KindergartenCourseView", package.seeall)

local KindergartenCourseView = class("KindergartenCourseView", ViewComponent)

function KindergartenCourseView:ctor()
	KindergartenCourseView.super.ctor(self)
end

function KindergartenCourseView:buildUI()
	KindergartenCourseView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnAuto = self:getBtn("btnAuto")
	self._txtDesc1 = self:getTxt("gartenInfo1/txtDesc1")
	self._txtDesc2 = self:getTxt("gartenInfo2/txtDesc2")
	self.scrollerGo = self:getGo("tableview")
	self.cellGo = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function KindergartenCourseView:bindEvents()
	KindergartenCourseView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnAuto, self._onClickAuto, self)
end

function KindergartenCourseView:unbindEvents()
	KindergartenCourseView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnAuto)
end

function KindergartenCourseView:onEnter()
	KindergartenCourseView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.KindergartenOpenClassRes, self._onOpenClassRes, self)
	self.addGEvent(self, GlobalNotify.KindergartenViewResultRes, self._onViewResultRes, self)
	self.addGEvent(self, GlobalNotify.KindergartenGetInfoRes, self._onGetInfoRes, self)

	self._activityId = self:getFirstParam()
	self._kindergartenLevel = KindergartenController.instance:getGartenLevel(self._activityId)

	self:_updateTextShow()
	self:_updateList()
end

function KindergartenCourseView:onExit()
	KindergartenCourseView.super.onExit(self)
	self._scrollList:dispose()
end

function KindergartenCourseView:_onClickTip()
	TipsFacade.instance:openRulesView("kindergarte_manager_rule")
end

function KindergartenCourseView:_onClickAuto()
	if not KindergartenModel.instance:isUnlockAutoFunction(self._activityId) then
		FloatWordMgr.instance:show("在人员招聘中成功招募林林奇，即可解锁本功能噢~")

		return
	end

	UIStateManager.instance:push(ViewName.KindergarteemployView)
end

function KindergartenCourseView:_onOpenClassRes()
	self:_updateTextShow()
	self:_updateList()
end

function KindergartenCourseView:_onGetInfoRes()
	self:_updateTextShow()
	self:_updateList()
end

function KindergartenCourseView:_onViewResultRes()
	KindergartenAgent.instance:sendPM_KindergartenGetInfoReq(self._activityId)
end

function KindergartenCourseView:_updateCell(view, cell, data, tag)
	local cls = GameUtil.AddLuaOnce(cell.gameObject, KCourseCell)

	cls:init(self._activityId, self._kindergartenLevel, data)
end

function KindergartenCourseView:clearCell(cell)
	local cls = GameUtil.AddLuaOnce(cell.gameObject, KCourseCell)

	cls:reset()
end

function KindergartenCourseView:_updateTextShow()
	local cfgLevel = KindergartenConfig.instance:getLevelData(self._activityId, self._kindergartenLevel)
	local totalInfo = KindergartenModel.instance:getInfo(self._activityId)
	local maxPeopleNum = cfgLevel.classStudentCount
	local leftPointDic = KindergartenModel.instance:getLeftQualityPointToday(self._activityId)
	local strengthPoint = leftPointDic[KindergartenModel.STRENGTH]
	local artPoint = leftPointDic[KindergartenModel.ART]
	local intellectPoint = leftPointDic[KindergartenModel.INTELLECT]

	self._txtDesc1.text = string.format("当前幼儿园等级：%d，学生人数：%d/%d，每个班级最多可供 %d 名学生学习", self._kindergartenLevel, totalInfo.curStudentCount, cfgLevel.studentLimit, maxPeopleNum)
	self._txtDesc2.text = string.format("今日可分配艺术点：<color=#FFC880FF>%d</color> 智力点：<color=#FFC880FF>%d</color> 体力点：<color=#FFC880FF>%d</color> 可分配的品质点数每日5点重置", artPoint, intellectPoint, strengthPoint)
end

function KindergartenCourseView:_updateList()
	local cfgLevel = KindergartenConfig.instance:getLevelData(self._activityId, self._kindergartenLevel)

	if not self._classList or #self._classList == 0 then
		self._classList = {}

		local cfgClassList = KindergartenConfig.instance:getClassCfgList(self._activityId)

		for i, v in ipairs(cfgClassList) do
			local info = {}

			info.cfgClass = v
			info.optionNums = KindergartenModel.instance:getClassPoint(self._activityId, v.classId)

			table.insert(self._classList, info)
		end
	end

	self._scrollList:reloadData(self._classList)
end

return KindergartenCourseView
