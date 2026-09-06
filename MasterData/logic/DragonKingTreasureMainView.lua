-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonkingtreasure/view/DragonKingTreasureMainView.lua

module("logic.extensions.dragonkingtreasure.view.DragonKingTreasureMainView", package.seeall)

local DragonKingTreasureMainView = class("DragonKingTreasureMainView", TableViewComponent)

DragonKingTreasureMainView.TabType = {
	Achievement = 2,
	Daily = 1
}

function DragonKingTreasureMainView:ctor()
	DragonKingTreasureMainView.super.ctor(self)

	self._maxProgress = 9
end

function DragonKingTreasureMainView:unbindEvents()
	DragonKingTreasureMainView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._tabBtns[DragonKingTreasureMainView.TabType.Daily].btn:RemoveClickListener()
	self._tabBtns[DragonKingTreasureMainView.TabType.Achievement].btn:RemoveClickListener()
	self._btnPass:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnShow)
end

function DragonKingTreasureMainView:bindEvents()
	DragonKingTreasureMainView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._tabBtns[DragonKingTreasureMainView.TabType.Daily].btn:AddClickListener(function()
		self:_switchTab(DragonKingTreasureMainView.TabType.Daily)
	end)
	self._tabBtns[DragonKingTreasureMainView.TabType.Achievement].btn:AddClickListener(function()
		self:_switchTab(DragonKingTreasureMainView.TabType.Achievement)
	end)
	self._btnPass:AddClickListener(self._onClickbtnPass, self)
	GameUtil.addClickHandler(self._btnShow, self._onClickbtnShow, self)
end

function DragonKingTreasureMainView:buildUI()
	DragonKingTreasureMainView.super.buildUI(self)

	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnAchievementTaskGo = self:getGo("rightcon/btns/btnAchievementTask")
	self._btnDailyTaskGo = self:getGo("rightcon/btns/btnDailyTask")
	self._redPointGoAchievement = self:getGo("rightcon/btns/btnAchievementTask/redPoint")
	self._redPointGoDaily = self:getGo("rightcon/btns/btnDailyTask/redPoint")

	self:_buildTabBtns(DragonKingTreasureMainView.TabType.Daily, self._btnDailyTaskGo)
	self:_buildTabBtns(DragonKingTreasureMainView.TabType.Achievement, self._btnAchievementTaskGo)

	self._txtProgress = self:getTxt("middlecon/fragments/txtProgress")
	self._fragments = self:getBtn("middlecon/fragments")

	self:_buildFragments(self._fragments.gameObject)

	self._txtTime = self:getTxt("openTime/txtTime")
	self._btnPass = self:getBtn("middlecon/fragments/btnPass")
	self._effectGo = self:getGo("effect")
	self._jiesuoeffectGo = self:getGo("jiesuoeffect")
	self._btnShow = self:getGo("btnShow")
end

function DragonKingTreasureMainView:_buildFragments(go)
	self._fragmentGos = {}

	for i = 1, self._maxProgress do
		self._fragmentGos[i] = goutil.findChild(go, "fragment" .. i)
	end
end

function DragonKingTreasureMainView:_buildTabBtns(tabType, go)
	self._tabBtns = self._tabBtns or {}
	self._tabBtns[tabType] = {
		onGo = goutil.findChild(go, "on"),
		offGo = goutil.findChild(go, "off"),
		btn = Framework.ButtonAdapter.Get(go)
	}
end

function DragonKingTreasureMainView:onExit()
	DragonKingTreasureMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self._updateUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
	MaterialController.instance:unregisterLocalNotify("ItemUsed", self._onItemUse, self)

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end

	if self._unlockEffectHandler then
		UIEffectManager.instance:stopEffect(self._unlockEffectHandler)

		self._unlockEffectHandler = nil
	end
end

function DragonKingTreasureMainView:onEnter()
	DragonKingTreasureMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self._updateUI, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
	self.addGEvent(self, GlobalNotify.OnMaterialGet, self._onItemUse, self)
	MaterialController.instance:registerLocalNotify("ItemUsed", self._onItemUse, self)

	self._activityType = GameEnum.ActivityType.Spec
	self._activityId = ActivityDefineController.instance:getActivityIdByType(self._activityType)

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开放")
		self:close()

		return
	end

	self._jackpotActId = JackpotModel.instance:getCurrActId()
	self._selectPage = self._selectPage or DragonKingTreasureMainView.TabType.Daily

	self:_updateUI()
	self:_setActTime()
	self:_sendInfoReq()
	self:_setEffect()
end

function DragonKingTreasureMainView:_onClickbtnTip()
	local key = "DragonKingTreasureMainView"

	TipsFacade.instance:openRulesView(key)
end

function DragonKingTreasureMainView:_onClickbtnClose()
	self:close()
end

function DragonKingTreasureMainView:_getPath()
	return {
		cellPath = "rightcon/tablecell",
		viewPath = "rightcon/tableview"
	}
end

function DragonKingTreasureMainView:_updateCell(view, cell, taskCfg)
	local btnJump = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnJump")
	local btnRecieve = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnRecieve")
	local goItem = goutil.findChild(cell.gameObject, "item")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtProgress = goutil.findChildTextComponent(cell.gameObject, "txtProgress")
	local goReceive = goutil.findChild(cell.gameObject, "receive")
	local progress = EventTaskSummaryModel.instance:getTaskCurProgress(taskCfg.taskId)
	local isGain = EventTaskSummaryModel.instance:isTaskHasGainPrize(taskCfg.taskId)
	local isCanGain = not isGain and progress >= taskCfg.maxProgress

	goutil.setActive(goReceive, isGain)
	goutil.setActive(btnJump.gameObject, not isGain and not isCanGain and not string.nilorempty(taskCfg.jumpTo))
	goutil.setActive(btnRecieve.gameObject, isCanGain)

	txtName.text = taskCfg.title
	txtProgress.text = string.format("%s/%s", progress, taskCfg.maxProgress)
	txtDesc.text = taskCfg.desc

	self:_setReward(goItem, taskCfg.prize)
	btnJump:AddClickListener(function()
		if isGain then
			FloatWordMgr.instance:show("奖励已领取")

			return
		end

		if not string.nilorempty(taskCfg.jumpTo) then
			self:_onClickJump(taskCfg.jumpTo)
		end
	end)
	btnRecieve:AddClickListener(function()
		if isGain then
			FloatWordMgr.instance:show("奖励已领取")

			return
		end

		if isCanGain then
			EventTaskSummaryController.instance:onSendEventTaskSummaryGainTaskPrizeReq(self._activityId, taskCfg.taskId)
		end
	end)
end

function DragonKingTreasureMainView:_onClickJump(jumpTo)
	GotoMgr.gotoByString(jumpTo)
end

function DragonKingTreasureMainView:_onClickbtnPass()
	UIStateManager.instance:push(ViewName.DragonKingTreasureLotteryView, false)
end

function DragonKingTreasureMainView:_onClickbtnShow()
	UIStateManager.instance:push(ViewName.DragonKingTreasureLotteryView, true)
end

function DragonKingTreasureMainView:_setReward(goItem, prize)
	local arr = string.split(prize, "#")

	MaterialMgr.setCellByCfg(arr[1], goItem)
end

function DragonKingTreasureMainView:_clearTableview(cell)
	local goItem = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(goItem)
end

function DragonKingTreasureMainView:_updateUI()
	self:_reloadTask()
	self:_updateFragment()
	self:_checkRedPoint()
end

function DragonKingTreasureMainView:_reloadTask()
	self:_onUpdateTaskData()
	self:_updateTaskScrollerList()
	self:_updateFragment()
end

function DragonKingTreasureMainView:_updateTaskScrollerList()
	local list = {}

	for _, taskDataList in ipairs(self._taskDataQueue[self._selectPage]) do
		if taskDataList[1].state == GameEnum.PrizeState.IsHasGain then
			table.insert(list, taskDataList[#taskDataList].data)
		else
			table.insert(list, taskDataList[1].data)
		end
	end

	self._curViewDatas = list

	self:reloadData()
end

function DragonKingTreasureMainView:_onUpdateTaskData()
	self._taskDataQueue = {}

	local queue = EventTaskSummaryConfig.instance:getTaskQueue(self._activityId)

	for pageId, taskList in ipairs(queue) do
		local list = {}

		self._taskDataQueue[pageId] = {}

		for idx, data in ipairs(taskList) do
			list[data.typeId] = list[data.typeId] or {}

			local tab = {}

			tab.data = data
			tab.state = self:_calcTaskState(data.taskId)

			table.insert(list[data.typeId], tab)
		end

		for typeId, typeList in pairs(list) do
			table.sort(list[typeId], function(a, b)
				if a.state == b.state then
					if a.data.taskId < b.data.taskId then
						return true
					end

					return false
				end

				return a.state < b.state
			end)
			table.insert(self._taskDataQueue[pageId], list[typeId])
		end

		table.sort(self._taskDataQueue[pageId], function(listA, listB)
			local a = listA[1]
			local b = listB[1]

			if a.state == b.state then
				if a.data.taskId < b.data.taskId then
					return true
				end

				return false
			end

			return a.state < b.state
		end)
	end
end

function DragonKingTreasureMainView:_calcTaskState(taskId)
	local taskData = EventTaskSummaryConfig.instance:getTaskData(self._activityId, taskId)
	local taskInfo = EventTaskSummaryModel.instance:getTaskInfo(taskId)

	return (taskInfo or nil) and (taskInfo.hasGainPrize == true and 3 or checknumber(taskInfo.curProgress) >= taskData.maxProgress and 1 or 2)
end

function DragonKingTreasureMainView:_updateFragment()
	local gianCount = self:_getFragmentTaskFinishCount()

	self._txtProgress.text = string.format("藏宝图进度：%s/%s", gianCount, self._maxProgress)

	local seed = RoleModel.instance:getUserId() .. "0000000"
	local arr = GameUtil.getFakeRandomNumberArrayBySeed(seed, 1, 9)

	for i, posId in ipairs(arr) do
		local go = self._fragmentGos[posId]

		goutil.setActive(go, i <= gianCount)
	end

	local isMax = gianCount >= self._maxProgress

	goutil.setActive(self._btnPass.gameObject, isMax)

	local canUnlock = gianCount >= self._maxProgress

	goutil.setActive(self._unlockEffectGo, canUnlock)

	if canUnlock then
		self:_setUnlockEffect()
	elseif self._unlockEffectHandler then
		UIEffectManager.instance:stopEffect(self._unlockEffectHandler)

		self._unlockEffectHandler = nil
	end
end

function DragonKingTreasureMainView:_getFragmentTaskFinishCount()
	local jackpotCfg = JackpotConfig.instance:getActCfgById(self._jackpotActId)
	local matType, matId, matNum = MaterialMgr.getMatParams(jackpotCfg.activityItem)

	return (MaterialFacade.instance:getMatNumber(matType, matId))
end

function DragonKingTreasureMainView:_switchTab(tabType)
	if self._selectPage == tabType then
		return
	end

	self._selectPage = tabType

	self:_reloadTask()
	self:_setTabOnOff()
end

function DragonKingTreasureMainView:_setTabOnOff()
	for k, v in pairs(self._tabBtns) do
		goutil.setActive(v.onGo, k == self._selectPage)
		goutil.setActive(v.offGo, k ~= self._selectPage)
	end
end

function DragonKingTreasureMainView:_setActTime()
	self._txtTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
end

function DragonKingTreasureMainView:_sendInfoReq()
	EventTaskSummaryController.instance:onSendEventTaskSummaryGetInfoReq(self._activityId)
end

function DragonKingTreasureMainView:_onItemUse()
	self:_updateFragment()
end

function DragonKingTreasureMainView:_setEffect()
	local effName = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

function DragonKingTreasureMainView:_setUnlockEffect()
	if not self._unlockEffectHandler then
		local effName = "20230428/quanminbeizhan/fx_ui_quanminbeizhan_kejiesuo.prefab"

		self._unlockEffectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

		self._unlockEffectHandler:setParent(self._jiesuoeffectGo.transform)
		self._unlockEffectHandler:setLocalPos(0, 0, 0)
		self._unlockEffectHandler:setScale(1)
	end
end

function DragonKingTreasureMainView:_checkRedPoint()
	local taskCfgs = EventTaskSummaryConfig.instance:getTaskCfgs(self._activityId)
	local dailyRed = false
	local achievementRed = false

	for i, v in ipairs(taskCfgs) do
		if not dailyRed and v.periodType == "daily" then
			local progress = EventTaskSummaryModel.instance:getTaskCurProgress(v.taskId)
			local isGain = EventTaskSummaryModel.instance:isTaskHasGainPrize(v.taskId)

			dailyRed = not isGain and progress >= v.maxProgress
		elseif not achievementRed and v.periodType ~= "daily" then
			local progress = EventTaskSummaryModel.instance:getTaskCurProgress(v.taskId)
			local isGain = EventTaskSummaryModel.instance:isTaskHasGainPrize(v.taskId)

			achievementRed = not isGain and progress >= v.maxProgress
		end

		if dailyRed and achievementRed then
			break
		end
	end

	goutil.setActive(self._redPointGoAchievement, achievementRed)
	goutil.setActive(self._redPointGoDaily, dailyRed)
end

return DragonKingTreasureMainView
