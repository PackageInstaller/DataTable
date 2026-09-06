-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/teachertask/TeacherScheduleFloorView.lua

module("logic.extensions.tutorsystem.view.teachertask.TeacherScheduleFloorView", package.seeall)

local TeacherScheduleFloorView = class("TeacherScheduleFloorView", ViewComponent)

function TeacherScheduleFloorView:buildUI()
	TeacherScheduleFloorView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "openTime/txt")
	self._playerInfo = goutil.findChild(self.mainGO, "playerInfo")
	self._head = goutil.findChild(self.mainGO, "playerInfo/head")
	self._btnSendFlower = goutil.findChild(self.mainGO, "playerInfo/btnSendFlower")
	self._btnPlayInfo = goutil.findChild(self.mainGO, "playerInfo/btnPlayInfo")
	self._txtNameInPlayerInfo = goutil.findChildTextComponent(self.mainGO, "playerInfo/txtName")
	self._txtPower = goutil.findChildTextComponent(self.mainGO, "playerInfo/power/txt")
	self._txtScore = goutil.findChildTextComponent(self.mainGO, "playerInfo/score/txt")
	self._tabCol = goutil.findChild(self.mainGO, "tabCol")
	self._tabScrollerview = goutil.findChild(self.mainGO, "tabCol/tabScrollerview")
	self._tabScrollercell = goutil.findChild(self.mainGO, "tabCol/tabScrollercell")
	self._contentCol = goutil.findChild(self.mainGO, "contentCol")
	self._tabScrollList = ScrollerList.create(self._tabScrollerview, self._tabScrollercell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function TeacherScheduleFloorView:bindEvents()
	TeacherScheduleFloorView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSendFlower, self._onClickBtnSendFlower, self)
end

function TeacherScheduleFloorView:unbindEvents()
	TeacherScheduleFloorView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSendFlower)
end

function TeacherScheduleFloorView:onEnter()
	TeacherScheduleFloorView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._userId = params[1]
	self._curTabIdx = 1

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.TutorMainInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.TutorGainGrowthTaskInfo, self._onUpdate, self)
	self:_onUpdate()
end

function TeacherScheduleFloorView:onExit()
	TeacherScheduleFloorView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.TutorMainInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.TutorGainGrowthTaskInfo, self._onUpdate, self)
	self._tabScrollList:dispose()
	self:showTabAt(self._contentCol, "")
	HeadItemController.instance:resetHeadCell(self._head)
end

function TeacherScheduleFloorView:_onSetUI()
	return
end

function TeacherScheduleFloorView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function TeacherScheduleFloorView:_onUpdateData()
	self:_updateTabData()
end

function TeacherScheduleFloorView:_onUpdateUI()
	self:_updateTabScrollerList()
	self:_showTabAt()
	self:_updatePlaneUI()
end

function TeacherScheduleFloorView:_updatePlaneUI()
	local stuInfo = TutorSystemModel.instance:getStuInfoAsTea(self._userId)

	HeadItemController.instance:setHeadCellByInfo(self._head, stuInfo.headInfo.headInfo)
	GameUtil.addClickHandler(self._btnPlayInfo, function()
		local groupType = FriendModel.instance:getGroupTypeById(userId)

		UIStateManager.instance:open(ViewName.playerInfo, stuInfo.headInfo, groupType, self._btnPlayInfo)
	end, self)

	self._txtNameInPlayerInfo.text = stuInfo.headInfo.headInfo.userName
	self._txtPower.text = string.format("战力：<color=#20b376>%s</color>", stuInfo.headInfo.maxZdl or 0)

	local progress = TutorSystemModel.instance:getMyStudentTaskProgressAsTea(self._userId)
	local maxTaskProgress = TutorSystemConfig.instance:getTsStuPrizeMaxProgress()

	self._txtScore.text = string.format("出师积分：<color=#20b376>%s</color>/%s", progress, maxTaskProgress)
end

function TeacherScheduleFloorView:_updateTabData()
	self._tabDataList = {}

	table.insert(self._tabDataList, self:_getTabData("学生基础任务", nil, ViewName.StuBaseTaskScheduleView, self._userId))
	table.insert(self._tabDataList, self:_getTabData("学生周任务", nil, ViewName.StuGrowthTaskScheduleView, self._userId))
end

function TeacherScheduleFloorView:_getTabData(name, redIdList, viewName, ...)
	return {
		name = name,
		redIdList = redIdList or {},
		viewName = viewName,
		params = {
			...
		}
	}
end

function TeacherScheduleFloorView:_updateTabScrollerList()
	self._tabScrollList:reloadData(self._tabDataList)
end

function TeacherScheduleFloorView:_updateTabCell(view, cell, data, tag)
	local idx = cell.index + 1
	local mainGo = cell.gameObject
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local UIChangeGroup = mainGo:GetComponent(typeof(UIChangeGroup))

	txtName.text = data.name

	if #data.redIdList == 0 then
		GameUtil.SetActive(redPoint, false)
	else
		RedPointController.instance:regRedPoint(redPoint, unpack(data.redIdList))
	end

	UIChangeGroup:SetState(self._curTabIdx == idx and 1 or 0)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, data, idx))
end

function TeacherScheduleFloorView:_clearTabCell(cell)
	local mainGo = cell.gameObject
	local redPoint = goutil.findChild(mainGo, "redPoint")

	RedPointController.instance:unregRedPoint(redPoint)
	GameUtil.rmClickHandler(mainGo)
end

function TeacherScheduleFloorView:_onClickTab(data, idx)
	self._curTabIdx = idx

	self:_onUpdateUI()
end

function TeacherScheduleFloorView:_showTabAt()
	local data = self._tabDataList[self._curTabIdx]

	if data == nil then
		return
	end

	if data.params then
		self:showTabAt(self._contentCol, data.viewName, unpack(data.params))
	else
		self:showTabAt(self._contentCol, data.viewName)
	end
end

function TeacherScheduleFloorView:_onClickBtnSendFlower()
	local stuInfo = TutorSystemModel.instance:getStuInfoAsTea(self._userId)

	SendFlowerController.instance:openSendFlowerView(stuInfo.headInfo.headInfo)
end

return TeacherScheduleFloorView
