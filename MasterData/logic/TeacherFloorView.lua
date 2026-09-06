-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/teachertask/TeacherFloorView.lua

module("logic.extensions.tutorsystem.view.teachertask.TeacherFloorView", package.seeall)

local TeacherFloorView = class("TeacherFloorView", ViewComponent)

function TeacherFloorView:buildUI()
	TeacherFloorView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "openTime/txt")
	self._tabCol = goutil.findChild(self.mainGO, "tabCol")
	self._tabScrollerview = goutil.findChild(self.mainGO, "tabCol/tabScrollerview")
	self._tabScrollercell = goutil.findChild(self.mainGO, "tabCol/tabScrollercell")
	self._contentCol = goutil.findChild(self.mainGO, "contentCol")
	self._tabScrollList = ScrollerList.create(self._tabScrollerview, self._tabScrollercell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function TeacherFloorView:bindEvents()
	TeacherFloorView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function TeacherFloorView:unbindEvents()
	TeacherFloorView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function TeacherFloorView:onEnter()
	TeacherFloorView.super.onEnter(self)

	self._curTabIdx = 1

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.TutorTeaTaskFloorCloseSignal, self.close, self)
	self:_onUpdate()
end

function TeacherFloorView:onExit()
	TeacherFloorView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.TutorTeaTaskFloorCloseSignal, self.close, self)
	self._tabScrollList:dispose()
	self:showTabAt(self._contentCol, "")
end

function TeacherFloorView:_onSetUI()
	return
end

function TeacherFloorView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function TeacherFloorView:_onUpdateData()
	self:_updateTabData()
end

function TeacherFloorView:_onUpdateUI()
	self:_updateTabScrollerList()
	self:_showTabAt()
end

function TeacherFloorView:_updateTabData()
	self._tabDataList = {}

	local gaActivityType = TutorSystemConfig.instance:getTsTeacherGradAwardTaskActivityType()
	local gaActCfg = ActivityDefineController.instance:getActivityCfgByType(gaActivityType)

	if gaActCfg then
		local redIdList = {}

		table.insert(redIdList, EventTaskSummaryController.instance:getCurRedIdByActivityType(gaActivityType))
		table.insert(self._tabDataList, self:_getTabData("出师奖励", redIdList, ViewName.TeacherGradAwardTaskView, gaActCfg.activityId))
	end

	local achActivityType = TutorSystemConfig.instance:getTsTeacherAchTaskActivityType()
	local achActCfg = ActivityDefineController.instance:getActivityCfgByType(achActivityType)

	if achActCfg then
		local redIdList = {}

		table.insert(redIdList, EventTaskSummaryController.instance:getCurRedIdByActivityType(achActivityType))
		table.insert(self._tabDataList, self:_getTabData("成就任务", redIdList, ViewName.TeacherAchvTaskView, achActCfg.activityId))
	end
end

function TeacherFloorView:_getTabData(name, redIdList, viewName, ...)
	return {
		name = name,
		redIdList = redIdList or {},
		viewName = viewName,
		params = {
			...
		}
	}
end

function TeacherFloorView:_updateTabScrollerList()
	self._tabScrollList:reloadData(self._tabDataList)
end

function TeacherFloorView:_updateTabCell(view, cell, data, tag)
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

function TeacherFloorView:_clearTabCell(cell)
	local mainGo = cell.gameObject
	local redPoint = goutil.findChild(mainGo, "redPoint")

	RedPointController.instance:unregRedPoint(redPoint)
	GameUtil.rmClickHandler(mainGo)
end

function TeacherFloorView:_onClickTab(data, idx)
	self._curTabIdx = idx

	self:_onUpdateUI()
end

function TeacherFloorView:_showTabAt()
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

return TeacherFloorView
