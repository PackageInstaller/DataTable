-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/common/rewarddesc/TabPTSeasonRewardView.lua

module("logic.extensions.peaktournament.view.common.rewarddesc.TabPTSeasonRewardView", package.seeall)

local TabPTSeasonRewardView = class("TabPTSeasonRewardView", ViewComponent)

function TabPTSeasonRewardView:buildUI()
	TabPTSeasonRewardView.super.buildUI(self)

	self._taskCol = goutil.findChild(self.mainGO, "taskCol")
	self._taskScrollerview = goutil.findChild(self.mainGO, "taskCol/taskScrollerview")
	self._taskScrollercell = goutil.findChild(self.mainGO, "taskCol/taskScrollercell")
	self._itemScrollercell = goutil.findChild(self.mainGO, "taskCol/itemScrollercell")
	self._taskScrollList = ScrollerList.create(self._taskScrollerview, self._taskScrollercell, GameUtil.handler(self._updateTaskCell, self), GameUtil.handler(self._clearTaskCell, self))
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)
end

function TabPTSeasonRewardView:bindEvents()
	TabPTSeasonRewardView.super.bindEvents(self)
end

function TabPTSeasonRewardView:unbindEvents()
	TabPTSeasonRewardView.super.unbindEvents(self)
end

function TabPTSeasonRewardView:onEnter()
	TabPTSeasonRewardView.super.onEnter(self)

	self._activityId = PeakTournamentController.instance:getCurActivityId()

	if self._activityId == 0 then
		FloatWordMgr.instance:show("缺失活动id")
		self:close()

		return
	end

	local params = self:getOpenParam() or {}
	local arr = string.split(params[1], ":")

	self._pageIdxList = {}

	for _, v in ipairs(arr) do
		table.insert(self._pageIdxList, checknumber(v))
	end

	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentQualifierTaskInfoRes, self._onUpdate, self)
	self:_onUpdate()
end

function TabPTSeasonRewardView:onExit()
	TabPTSeasonRewardView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentQualifierTaskInfoRes, self._onUpdate, self)
	self._taskScrollList:dispose()
end

function TabPTSeasonRewardView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function TabPTSeasonRewardView:_onUpdateData()
	self:_onUpdateTaskColData()
end

function TabPTSeasonRewardView:_onUpdateUI()
	self:_onUpdateTaskColUI()
end

function TabPTSeasonRewardView:_onUpdateTaskColData()
	self._taskDataQueue = {}

	local queue = {}

	for _, pageIdx in ipairs(self._pageIdxList) do
		local dataList = PeakTournamentConfig.instance:getPtQuaTaskCfgWithPageIdxById(self._activityId, pageIdx)

		table.insert(queue, dataList)
	end

	for _, dataList in ipairs(queue) do
		local list = {}

		for _, data in ipairs(dataList) do
			local tab = {}

			tab.data = data
			tab.state = self:_calcTaskState(data.quaTaskId)

			table.insert(list, tab)
		end

		table.sort(list, function(a, b)
			if a.state == b.state then
				if a.data.quaTaskId < b.data.quaTaskId then
					return true
				end

				return false
			end

			return a.state < b.state
		end)
		table.insert(self._taskDataQueue, list)
	end

	table.sort(self._taskDataQueue, function(listA, listB)
		local a = listA[1]
		local b = listB[1]

		if a.state == b.state then
			if a.data.quaTaskId < b.data.quaTaskId then
				return true
			end

			return false
		end

		return a.state < b.state
	end)
end

function TabPTSeasonRewardView:_calcTaskState(quaTaskId)
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

function TabPTSeasonRewardView:_onUpdateTaskColUI()
	local list = {}

	for _, taskDataList in ipairs(self._taskDataQueue) do
		if taskDataList[1].state == GameEnum.PrizeState.IsHasGain then
			table.insert(list, taskDataList[#taskDataList])
		else
			table.insert(list, taskDataList[1])
		end
	end

	self._taskScrollList:reloadData(list)
end

function TabPTSeasonRewardView:_updateTaskCell(view, cell, info, tag)
	local data = info.data
	local state = info.state
	local mainGo = cell.gameObject
	local txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local imgHasGain = goutil.findChild(mainGo, "imgHasGain")
	local itemScrollerview = goutil.findChild(mainGo, "itemScrollerview")

	if txtTitle then
		txtTitle.text = data.title
	end

	if txtDesc then
		txtDesc.text = data.desc
	end

	if itemScrollerview and self._itemScrollercell then
		local prizeStrArr = string.split(data.prize, "#")

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = self._itemScrollListDic[mainGo]

			self._itemScrollListDic[mainGo]:reloadData(prizeStrArr)
			self._itemScrollListDic[mainGo]:dragNotifyParent()
		end
	end

	GameUtil.SetActive(btnGet, state == GameEnum.PrizeState.IsCanGet or state == GameEnum.PrizeState.IsNotEnough)
	GameUtil.SetGray(btnGet, state == GameEnum.PrizeState.IsNotEnough)
	GameUtil.SetActive(imgHasGain, state == GameEnum.PrizeState.IsHasGain)
	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickBtnGet, self, info))
end

function TabPTSeasonRewardView:_clearTaskCell(cell)
	local mainGo = cell.gameObject
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function TabPTSeasonRewardView:_onClickBtnGet(info)
	if info == nil then
		return
	end

	local tipsStr = ""

	if info.state == GameEnum.PrizeState.IsHasGain then
		tipsStr = "您已领取奖励"
	elseif info.state == GameEnum.PrizeState.IsNotEnough then
		tipsStr = "您未达到领取条件"
	end

	if not string.nilorempty(tipsStr) then
		FloatWordMgr.instance:show(tipsStr)

		return
	end

	local taskIdList = self:_getCanGainTaskIdList(info.data.quaTaskId)

	if #taskIdList <= 0 then
		return
	end

	PeakTournamentController.instance:sendPM_PeakTournamentGainQualifierTaskPrizeReq(self._activityId, taskIdList)
end

function TabPTSeasonRewardView:_getCanGainTaskIdList(quaTaskId)
	local taskIdList = {}

	for _, taskDataList in ipairs(self._taskDataQueue or {}) do
		for _, taskInfo in ipairs(taskDataList) do
			if taskInfo.state == GameEnum.PrizeState.IsCanGet then
				table.insert(taskIdList, taskInfo.data.quaTaskId)
			end
		end
	end

	return taskIdList
end

function TabPTSeasonRewardView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo, urlOrGo, luaCls, isOne)
end

function TabPTSeasonRewardView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return TabPTSeasonRewardView
