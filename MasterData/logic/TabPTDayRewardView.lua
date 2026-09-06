-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/common/rewarddesc/TabPTDayRewardView.lua

module("logic.extensions.peaktournament.view.common.rewarddesc.TabPTDayRewardView", package.seeall)

local TabPTDayRewardView = class("TabPTDayRewardView", ViewComponent)

function TabPTDayRewardView:buildUI()
	TabPTDayRewardView.super.buildUI(self)

	self._btnGet = goutil.findChild(self.mainGO, "btnGet")
	self._imgHasGain = goutil.findChild(self.mainGO, "imgHasGain")
	self._itemScrollerview = goutil.findChild(self.mainGO, "itemCol/itemScrollerview")
	self._itemScrollercell = goutil.findChild(self.mainGO, "itemCol/itemScrollercell")
	self._itemScrollList = ScrollerList.create(self._itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
end

function TabPTDayRewardView:bindEvents()
	TabPTDayRewardView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGet, self._onClickBtnGet, self)
end

function TabPTDayRewardView:unbindEvents()
	TabPTDayRewardView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGet)
end

function TabPTDayRewardView:onEnter()
	TabPTDayRewardView.super.onEnter(self)

	self._activityId = PeakTournamentController.instance:getCurActivityId()

	if self._activityId == 0 then
		FloatWordMgr.instance:show("缺失活动id")
		self:close()

		return
	end

	local params = self:getOpenParam() or {}

	self._pageIdx = checknumber(params[1])

	if self._pageIdx == 0 then
		printError("缺失pageIdx,无法读取数据,请检查配置表传入参数( 该页面为页签页面,可检查配置表 yk-运营-页签框架.xlsx )")
		self:close()

		return
	end

	self._taskCfg = PeakTournamentConfig.instance:getPtQuaTaskCfgWithPageIdxById(self._activityId, self._pageIdx)

	if self._taskCfg == nil then
		printError(string.format("不存在任务配置( activityId = %s | pageIdx = %s )", self._activityId, self._pageIdx))
		self:close()

		return
	elseif #self._taskCfg ~= 1 then
		printError(string.format("任务配置数量不正确,但本界面只能读取一个,请务必修正( d巅峰赛.xlsx | export_预选赛任务 | activityId = %s | pageIdx = %s )", self._activityId, self._pageIdx))
		self:close()

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentQualifierTaskInfoRes, self._onUpdate, self)
	self:_onUpdate()
end

function TabPTDayRewardView:onExit()
	TabPTDayRewardView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentQualifierTaskInfoRes, self._onUpdate, self)
	self._itemScrollList:dispose()
end

function TabPTDayRewardView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function TabPTDayRewardView:_onUpdateData()
	self:_onUpdateTaskData()
end

function TabPTDayRewardView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateItemColUI()
end

function TabPTDayRewardView:_onUpdateTaskData()
	local taskData = self._taskCfg[1]

	self._taskInfo = {
		data = taskData,
		state = self:_calcTaskState(taskData.quaTaskId)
	}
end

function TabPTDayRewardView:_calcTaskState(quaTaskId)
	local isHasGain = PeakTournamentController.instance:isHasGainPrizeTaskAsQua(quaTaskId)

	if isHasGain then
		return GameEnum.PrizeState.IsHasGain
	end

	local isEnough = PeakTournamentController.instance:isEnoughGetPrizeTaskAsQua(self._activityId, quaTaskId)

	if not isEnough then
		return GameEnum.PrizeState.IsNotEnough
	end

	return GameEnum.PrizeState.IsCanGet
end

function TabPTDayRewardView:_onUpdatePlaneUI()
	GameUtil.SetActive(self._btnGet, self._taskInfo.state == GameEnum.PrizeState.IsCanGet or self._taskInfo.state == GameEnum.PrizeState.IsNotEnough)
	GameUtil.SetActive(self._imgHasGain, self._taskInfo.state == GameEnum.PrizeState.IsHasGain)
	GameUtil.SetGray(self._btnGet, self._taskInfo.state == GameEnum.PrizeState.IsNotEnough)
end

function TabPTDayRewardView:_onUpdateItemColUI()
	local prizeStrArray = string.split(self._taskInfo.data.prize, "#")

	self._itemScrollList:reloadData(prizeStrArray)
end

function TabPTDayRewardView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo, urlOrGo, luaCls, isOne)
end

function TabPTDayRewardView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function TabPTDayRewardView:_onClickBtnGet()
	if self._taskInfo == nil then
		return
	end

	local tipsStr = ""

	if self._taskInfo.state == GameEnum.PrizeState.IsHasGain then
		tipsStr = "您已领取奖励"
	elseif self._taskInfo.state == GameEnum.PrizeState.IsNotEnough then
		tipsStr = "您未达到领取条件"
	end

	if not string.nilorempty(tipsStr) then
		FloatWordMgr.instance:show(tipsStr)

		return
	end

	PeakTournamentController.instance:sendPM_PeakTournamentGainQualifierTaskPrizeReq(self._activityId, {
		self._taskInfo.data.quaTaskId
	})
end

return TabPTDayRewardView
