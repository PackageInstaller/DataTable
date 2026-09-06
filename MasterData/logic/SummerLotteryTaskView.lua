-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summerlottery/view/SummerLotteryTaskView.lua

module("logic.extensions.summerlottery.view.SummerLotteryTaskView", package.seeall)

local SummerLotteryTaskView = class("SummerLotteryTaskView", TableViewComponent)

function SummerLotteryTaskView:_getPath()
	return {
		cellPath = "middle/itemGo",
		viewPath = "middle/itemListSR"
	}
end

function SummerLotteryTaskView:ctor()
	SummerLotteryTaskView.super.ctor(self)

	self._tabId = GameEnum.PeriodRefreshType.Daily
end

function SummerLotteryTaskView:unbindEvents()
	SummerLotteryTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function SummerLotteryTaskView:bindEvents()
	SummerLotteryTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function SummerLotteryTaskView:buildUI()
	SummerLotteryTaskView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtPlayerScore = self:getTxt("bottom/txtPlayerScore")

	local playerRoot = self:getGo("bottom/playerRoot")

	self._playerSliderMo = PlayerSliderMo.New(playerRoot)
	self._tableviewTab = self:getGo("middle/tableviewTab")
	self._tablecellTab = self:getGo("middle/tableviewTab/tablecellTab")
	self._scrollListTab = ScrollerList.create(self._tableviewTab, self._tablecellTab, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function SummerLotteryTaskView:onExit()
	SummerLotteryTaskView.super.onExit(self)

	local controller = SummerLotteryController.instance

	controller:unregisterLocalNotify(SummerLotteryController.E_GainTaskInfoRes, self._updateAll, self)
	controller:unregisterLocalNotify(SummerLotteryController.E_GainTaskPrizeRes, self._updateAll, self)
	controller:unregisterLocalNotify(SummerLotteryController.E_GainTaskProgressPrize, self._updateProgress, self)
	self._playerSliderMo:onExit()
	self._scrollListTab:dispose()
end

function SummerLotteryTaskView:onEnter()
	SummerLotteryTaskView.super.onEnter(self)

	self._canRewardMap = {}

	local controller = SummerLotteryController.instance

	controller:registerLocalNotify(SummerLotteryController.E_GainTaskInfoRes, self._updateAll, self)
	controller:registerLocalNotify(SummerLotteryController.E_GainTaskPrizeRes, self._updateAll, self)
	controller:registerLocalNotify(SummerLotteryController.E_GainTaskProgressPrize, self._updateProgress, self)

	self._activityId = SummerLotteryModel.instance:getActivityId()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show(lang("FirePowerContestMainView__2"))
		self:close()

		return
	end

	self._taskTabList = SummerLotteryController.instance:getTagIdList(self._activityId)

	local hasCurrentTab = false

	for _, tabId in ipairs(self._taskTabList) do
		if tabId == self._tabId then
			hasCurrentTab = true

			break
		end
	end

	if not hasCurrentTab then
		self._tabId = self._taskTabList[1] or GameEnum.PeriodRefreshType.Daily
	end

	self:_initRewardSlider()
	self:_onClickTab(self._tabId)
	controller:reqGainTaskInfo()
end

function SummerLotteryTaskView:_initRewardSlider()
	local playerParam = {}

	playerParam.view = self
	playerParam.playerSliderCellClass = PlayerSliderCell
	playerParam.effPath = "fx_ui_yongzhezhita/fx_ui_yongzhezhita_xuanzhuan.prefab"
	playerParam.prizeCfgs = SummerLotteryConfig.instance:getTaskProgressConfs(SummerLotteryModel.instance.poolConfig.progressPlanId)

	function playerParam.getPlayerProgress()
		return SummerLotteryModel.instance.curScore
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.needScore
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		return SummerLotteryModel.instance:isProgressPrizeCanGain(rewardCfg.id, rewardCfg.needScore)
	end

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return SummerLotteryModel.instance:isProgressPrizeGain(rewardCfg.id)
	end

	function playerParam.sendGainPlayerPrizeReq()
		SummerLotteryController.instance:reqGainTaskProgressPrize()
	end

	function playerParam.parseGetProgress(rewardCfg)
		return rewardCfg.needScore
	end

	playerParam.bHideCellBg = true

	local isSkipAnimation = false

	self._playerSliderMo:initParam(playerParam, isSkipAnimation)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function SummerLotteryTaskView:_updateTaskList()
	local model = SummerLotteryModel.instance
	local taskInfoList = {}
	local taskInfoListByTaskType = {}

	self._canRewardMap[self._tabId] = {}

	local canRewardList = self._canRewardMap[self._tabId]
	local periodTaskInfoList = model:getTaskInfoListByType(self._tabId)

	if periodTaskInfoList then
		for _, taskInfo in ipairs(periodTaskInfoList) do
			local canGetReward = self:_taskCellCanGet(taskInfo)

			if canGetReward then
				table.insert(canRewardList, taskInfo.taskId)
			end

			local conf = SummerLotteryConfig.instance:getTaskConf(model.poolConfig.taskPlanId, taskInfo.taskId)
			local taskType = conf.taskType

			taskInfoListByTaskType[taskType] = taskInfoListByTaskType[taskType] or {}

			table.insert(taskInfoListByTaskType[taskType], taskInfo)
		end
	end

	local function sortTask(a, b)
		if a.gainedPrize ~= b.gainedPrize then
			return b.gainedPrize
		else
			if not a.gainedPrize then
				local bCanGainA = model:isTaskInfoRed(a)
				local bCanGainB = model:isTaskInfoRed(b)

				if bCanGainA ~= bCanGainB then
					return bCanGainA
				end
			end

			return a.taskId < b.taskId
		end
	end

	for _, sameTypeTaskInfoList in pairs(taskInfoListByTaskType) do
		table.sort(sameTypeTaskInfoList, sortTask)

		local taskInfo = sameTypeTaskInfoList[1]

		if taskInfo.gainedPrize then
			taskInfo = sameTypeTaskInfoList[#sameTypeTaskInfoList]
		end

		table.insert(taskInfoList, taskInfo)
	end

	table.sort(taskInfoList, sortTask)
	self:updateListData(taskInfoList)
end

function SummerLotteryTaskView:_updateAll()
	self:_updateTaskList()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()

	self._txtPlayerScore.text = checknumber(SummerLotteryModel.instance.curScore)
end

function SummerLotteryTaskView:_updateProgress()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function SummerLotteryTaskView:initCell(cell)
	return
end

function SummerLotteryTaskView:_taskCellCanGet(data)
	local model = SummerLotteryModel.instance
	local conf = SummerLotteryConfig.instance:getTaskConf(model.poolConfig.taskPlanId, data.taskId)
	local bGainPrize = data.gainedPrize == true

	return not bGainPrize and data.curProgress >= conf.maxProgress
end

function SummerLotteryTaskView:_updateCell(view, cell, data)
	local txtTitle = goutil.findChildTextComponent(cell, "titleTxt")
	local txtDesc = goutil.findChildTextComponent(cell, "descTxt")
	local txtProgress = goutil.findChildTextComponent(cell, "progressTxt")
	local recieveGo = goutil.findChild(cell, "recieveGo")
	local btnGain = goutil.findChild(cell, "recieveBtn")
	local btnGainChange = btnGain:GetComponent("UIImageSpriteChange")
	local txtBtnGain = goutil.findChildTextComponent(cell, "recieveBtn/recieveTxt")
	local goodsItems = {
		goutil.findChild(cell, "goodsGo_1"),
		goutil.findChild(cell, "goodsGo_2"),
		goutil.findChild(cell, "goodsGo_3")
	}
	local model = SummerLotteryModel.instance
	local conf = SummerLotteryConfig.instance:getTaskConf(model.poolConfig.taskPlanId, data.taskId)
	local prizes = string.split(conf.prize, "#")
	local bGainPrize = data.gainedPrize == true
	local bCanGainPrize = not bGainPrize and data.curProgress >= conf.maxProgress

	if data.curProgress >= conf.maxProgress then
		btnGainChange:SetState(1)
	else
		btnGainChange:SetState(0)
	end

	table.insert(prizes, 1, string.format("1004:1389:%s", conf.score))

	for i, go in pairs(goodsItems or {}) do
		if go then
			local itemCell = goutil.findChild(go, "itemCell")
			local canGet = goutil.findChild(go, "canGet")

			MaterialMgr.resetAll(itemCell)

			local prize = prizes[i]

			if not string.nilorempty(prize) then
				goutil.setActive(go, true)
				goutil.setActive(canGet, bCanGainPrize)
				MaterialMgr.setCellByCfg(prize, itemCell)
			else
				goutil.setActive(go, false)
				goutil.setActive(canGet, false)
			end
		end
	end

	goutil.setActive(recieveGo, bGainPrize)
	goutil.setActive(btnGain, not bGainPrize)
	goutil.setActive(txtProgress.gameObject, not bGainPrize)

	txtBtnGain.text = data.curProgress >= conf.maxProgress and lang("领取") or lang("前往")
	txtTitle.text = conf.taskTitle
	txtDesc.text = conf.taskDesc
	txtProgress.text = string.format("%s/%s", data.curProgress, conf.maxProgress)

	GameUtil.addClickHandler(GameUtil.asBtn(btnGain), function()
		if not bGainPrize then
			if bCanGainPrize then
				local taskIds = self._canRewardMap[self._tabId]

				if TableUtil.isTableEmpty(taskIds) then
					taskIds = {
						data.taskId
					}
				end

				SummerLotteryController.instance:reqGainTaskPrize(taskIds)
			else
				local viewId = checknumber(conf.viewId)

				if viewId > 0 then
					SummerLotteryAgent.instance:sendPM_SummerLotteryViewReq(model:getActivityId(), viewId)
				end

				GotoMgr.gotoByString(conf.jumpTo)
				self:close()
			end
		end
	end)
end

function SummerLotteryTaskView:_clearTableview(cell)
	local goodsItems = {
		goutil.findChild(cell, "goodsGo_1"),
		goutil.findChild(cell, "goodsGo_2"),
		goutil.findChild(cell, "goodsGo_3")
	}

	for _, go in pairs(goodsItems or {}) do
		if go then
			local itemCell = goutil.findChild(go, "itemCell")
			local canGet = goutil.findChild(go, "canGet")

			MaterialMgr.resetAll(itemCell)
		end
	end

	local btnGain = goutil.findChild(cell, "recieveBtn")

	GameUtil.rmClickHandler(GameUtil.asBtn(btnGain))
end

function SummerLotteryTaskView:_updateTabCell(view, cell, data)
	local task = goutil.findChild(cell, "task")
	local redGo = goutil.findChild(cell, "task/redGo")
	local txtName = goutil.findChildTextComponent(cell, "task/nameTxt")
	local taskChangeGroup = task:GetComponent(ComponentType.UIChangeGroup)
	local taskTypeStr = SummerLotteryModel.PeriodRefreshTypeById[data]

	txtName.text = ConstString.TaskPeriodRefreshText[data]

	GameUtil.addClickHandler(task, GameUtil.handler(self._onClickTab, self, data), self)
	GameUtil.SetActive(redGo, SummerLotteryModel.instance:isTaskTypeRed(taskTypeStr))

	if self._tabId == data then
		taskChangeGroup:SetState(1)
	else
		taskChangeGroup:SetState(0)
	end
end

function SummerLotteryTaskView:_clearTabCell(cell)
	local task = goutil.findChild(cell, "task")

	GameUtil.rmClickHandler(task)
end

function SummerLotteryTaskView:_onClickTab(index)
	self._tabId = index

	self._scrollListTab:reloadData(self._taskTabList)
	self:_updateTaskList()
end

return SummerLotteryTaskView
