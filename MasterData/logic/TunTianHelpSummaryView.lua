-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianhelp/view/TunTianHelpSummaryView.lua

module("logic.extensions.tuntianhelp.view.TunTianHelpSummaryView", package.seeall)

local TunTianHelpSummaryView = class("TunTianHelpSummaryView", ViewComponent)

function TunTianHelpSummaryView:buildUI()
	TunTianHelpSummaryView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")

	local jumpScrollerview = goutil.findChild(self.mainGO, "jumpCol/jumpScrollerview")
	local jumpScrollercell = goutil.findChild(self.mainGO, "jumpCol/jumpScrollercell")

	self._jumpScrollList = ScrollerList.create(jumpScrollerview, jumpScrollercell, GameUtil.handler(self._updateJumpCell, self), GameUtil.handler(self._clearJumpCell, self))
end

function TunTianHelpSummaryView:bindEvents()
	TunTianHelpSummaryView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function TunTianHelpSummaryView:unbindEvents()
	TunTianHelpSummaryView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function TunTianHelpSummaryView:onEnter()
	TunTianHelpSummaryView.super.onEnter(self)

	self._jumpPlanId = TunTianHelpController.instance:getJumpPlanId()

	if self._jumpPlanId <= 0 then
		local text = "活动不在开启期限内"

		local function func()
			self:close()
		end

		local btnText = "确定"
		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade.instance:openTipWindow("提示", text, func, btnText, alignment)

		return
	end

	self._summaryBaseData = TunTianHelpConfig.instance:getTthSummaryBaseData(self._jumpPlanId)
	self._funcId = self._summaryBaseData.funcId

	self:_onSetUI()
	self:_onUpdate()
end

function TunTianHelpSummaryView:onExit()
	TunTianHelpSummaryView.super.onExit(self)
	self:_onClearJumpCol()
end

function TunTianHelpSummaryView:_onSetUI()
	local startStamp, endStamp

	if not string.nilorempty(self._summaryBaseData.startTime) then
		startStamp = GameUtil.string2time(self._summaryBaseData.startTime)
	end

	if self._txtOpenTime then
		self._txtOpenTime.text = "活动时间：" .. GameUtil.getFormatTimeByStamp(startStamp, (not string.nilorempty(self._summaryBaseData.startTime) or nil) and GameUtil.string2time(self._summaryBaseData.endTime))
	end
end

function TunTianHelpSummaryView:_onUpdate()
	self:_onUpdateJumpColData()
	self:_onUpdateJumpColUI()
end

function TunTianHelpSummaryView:_onUpdateJumpColData()
	self._jumpInfoList = {}

	local jumpDataList = TunTianHelpConfig.instance:getTthSummaryJumpDataList(self._jumpPlanId)

	for _, data in ipairs(jumpDataList) do
		local info = {}

		info.data = data
		info.jumpId = data.jumpId
		info.timePeriod = TunTianHelpController.instance:getTimePeriodAsTthSummary(self._jumpPlanId, data.jumpId)
		self._jumpInfoList[info.jumpId] = info
	end
end

function TunTianHelpSummaryView:_onUpdateJumpColUI()
	local infoList = {}

	for _, info in ipairs(self._jumpInfoList) do
		table.insert(infoList, info)
	end

	self._jumpScrollList:reloadData(infoList)
end

function TunTianHelpSummaryView:_onClearJumpCol()
	self._jumpScrollList:dispose()
end

function TunTianHelpSummaryView:_updateJumpCell(view, cell, info, tag)
	local data = info.data
	local mainGo = cell.gameObject
	local txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	GameUtil.setUIGroupIdx(mainGo, data.showTypeIdx)

	local fTimeStr = ""
	local startDate, endDate

	if not string.nilorempty(data.startTime) then
		startDate = GameUtil.string2date(data.startTime)
	end

	if not string.nilorempty(data.endTime) then
		endDate = GameUtil.string2date(data.endTime)
	end

	if startDate == nil and endDate == nil then
		local activityType, activityId = data.activityParams[1], data.activityParams[2]

		if activityType ~= nil and activityId ~= nil then
			local startStamp, endStamp = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, activityId)

			endDate = GameUtil.time2date(endStamp)
			startDate = GameUtil.time2date(startStamp)
		end
	end

	if startDate == nil and endDate == nil then
		fTimeStr = ""
	elseif startDate and endDate then
		fTimeStr = string.format("%s.%s-%s.%s", startDate.month, startDate.day, endDate.month, endDate.day)
	elseif startDate == nil and startDate then
		fTimeStr = string.format("%s.%s 结束", endDate.month, endDate.day)
	elseif startDate and startDate == nil then
		fTimeStr = string.format("%s.%s 开始", startDate.month, startDate.day)
	end

	txtTime.text = fTimeStr
	txtName.text = data.name

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickJumpCellBtnGo, self, info))
end

function TunTianHelpSummaryView:_clearJumpCell(cell)
	return
end

function TunTianHelpSummaryView:_onClickJumpCellBtnGo(info)
	if info.timePeriod ~= GameUtil.inTimePeriod then
		FloatWordMgr.instance:show("活动不在开启期限内")

		return
	end

	if not ViewSetting.instance:isFullScreen(self._viewPresentor.viewName) then
		self:close()
	end

	if not string.nilorempty(info.data.gotoStr) then
		GotoMgr.gotoByString(info.data.gotoStr)
	end
end

return TunTianHelpSummaryView
