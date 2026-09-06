-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/readyforwar/view/ReadyforwarmainView.lua

module("logic.extensions.readyforwar.view.ReadyforwarmainView", package.seeall)

local ReadyforwarmainView = class("ReadyforwarmainView", TableViewComponent)

ReadyforwarmainView.TabType = {
	Achievement = 2,
	Daily = 1
}

function ReadyforwarmainView:ctor()
	ReadyforwarmainView.super.ctor(self)

	self._maxProgress = 9
end

function ReadyforwarmainView:unbindEvents()
	ReadyforwarmainView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._tabBtns[ReadyforwarmainView.TabType.Daily].btn:RemoveClickListener()
	self._tabBtns[ReadyforwarmainView.TabType.Achievement].btn:RemoveClickListener()
	self._btnPass:RemoveClickListener()
end

function ReadyforwarmainView:bindEvents()
	ReadyforwarmainView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._tabBtns[ReadyforwarmainView.TabType.Daily].btn:AddClickListener(function()
		self:_switchTab(ReadyforwarmainView.TabType.Daily)
	end)
	self._tabBtns[ReadyforwarmainView.TabType.Achievement].btn:AddClickListener(function()
		self:_switchTab(ReadyforwarmainView.TabType.Achievement)
	end)
	self._btnPass:AddClickListener(self._onClickbtnPass, self)
end

function ReadyforwarmainView:buildUI()
	ReadyforwarmainView.super.buildUI(self)

	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._item2Go = self:getGo("leftcon/item2/icon")
	self._item1Go = self:getGo("leftcon/item1/icon")
	self._btnAchievementTaskGo = self:getGo("rightcon/btns/btnAchievementTask")
	self._btnDailyTaskGo = self:getGo("rightcon/btns/btnDailyTask")
	self._redPointGoAchievement = self:getGo("rightcon/btns/btnAchievementTask/redPoint")
	self._redPointGoDaily = self:getGo("rightcon/btns/btnDailyTask/redPoint")

	self:_buildTabBtns(ReadyforwarmainView.TabType.Daily, self._btnDailyTaskGo)
	self:_buildTabBtns(ReadyforwarmainView.TabType.Achievement, self._btnAchievementTaskGo)

	self._txtProgress = self:getTxt("middlecon/fragments/txtProgress")
	self._fragments = self:getBtn("middlecon/fragments")

	self:_buildFragments(self._fragments.gameObject)

	self._txtTime = self:getTxt("openTime/txtTime")
	self._btnPass = self:getBtn("middlecon/fragments/btnPass")
	self._effectGo = self:getGo("effect")
	self._jiesuoeffectGo = self:getGo("jiesuoeffect")
end

function ReadyforwarmainView:_buildFragments(go)
	self._fragmentGos = {}

	for i = 1, self._maxProgress do
		self._fragmentGos[i] = goutil.findChild(go, "fragment" .. i)
	end
end

function ReadyforwarmainView:_buildTabBtns(tabType, go)
	self._tabBtns = self._tabBtns or {}
	self._tabBtns[tabType] = {
		onGo = goutil.findChild(go, "on"),
		offGo = goutil.findChild(go, "off"),
		btn = Framework.ButtonAdapter.Get(go)
	}
end

function ReadyforwarmainView:onExit()
	ReadyforwarmainView.super.onExit(self)
	uGuiUtil.clearImage(self._item1Go)
	uGuiUtil.clearImage(self._item2Go)
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

function ReadyforwarmainView:onEnter()
	ReadyforwarmainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self._updateUI, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
	MaterialController.instance:registerLocalNotify("ItemUsed", self._onItemUse, self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.SweepBattleField)

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开放")
		self:close()

		return
	end

	self._tabType = self._tabType or ReadyforwarmainView.TabType.Daily

	self:_setStaticItems()
	self:_updateUI()
	self:_setActTime()
	self:_sendInfoReq()
	self:_setEffect()
end

function ReadyforwarmainView:_onClickbtnTip()
	local key = "readyforwarmainview"

	TipsFacade.instance:openRulesView(key)
end

function ReadyforwarmainView:_onClickbtnClose()
	self:close()
end

function ReadyforwarmainView:_setStaticItems()
	local spriteName = GameUrl.getItemIconUrl("icon_moyan01")

	uGuiUtil.setSpriteToImage(self._item1Go, nil, spriteName)

	spriteName = GameUrl.getItemIconUrl("icon_cangbaotusuipian")

	uGuiUtil.setSpriteToImage(self._item2Go, nil, spriteName)
end

function ReadyforwarmainView:_getPath()
	return {
		cellPath = "rightcon/tablecell",
		viewPath = "rightcon/tableview"
	}
end

function ReadyforwarmainView:_updateCell(view, cell, taskCfg)
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
	goutil.setActive(btnJump.gameObject, not isGain and not isCanGain)
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

		self:_onClickJump(taskCfg.jumpTo)
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

function ReadyforwarmainView:_onClickJump(jumpTo)
	GotoMgr.gotoByString(jumpTo)
end

function ReadyforwarmainView:_onClickbtnPass()
	EventTaskSummaryController.instance:useItemInReadyforwarView(606, self._maxProgress)
end

function ReadyforwarmainView:_setReward(goItem, prize)
	local arr = string.split(prize, "#")

	MaterialMgr.setCellByCfg(arr[1], goItem)
end

function ReadyforwarmainView:_clearTableview(cell)
	local goItem = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(goItem)
end

function ReadyforwarmainView:_updateUI()
	self:_reloadTask()
	self:_updateFragment()
	self:_checkRedPoint()
end

function ReadyforwarmainView:_reloadTask()
	local taskCfgs = EventTaskSummaryConfig.instance:getTaskCfgs(self._activityId)
	local list = {}
	local isGainList = {}

	for i, v in ipairs(taskCfgs) do
		if self._tabType == ReadyforwarmainView.TabType.Daily and v.periodType == "daily" or self._tabType ~= ReadyforwarmainView.TabType.Daily and v.periodType ~= "daily" then
			local progress = EventTaskSummaryModel.instance:getTaskCurProgress(v.taskId)
			local isGain = EventTaskSummaryModel.instance:isTaskHasGainPrize(v.taskId)
			local isCanGain = not isGain and progress >= v.maxProgress

			if isGain then
				table.insert(isGainList, v)
			elseif isCanGain then
				table.insert(list, 1, v)
			else
				table.insert(list, v)
			end
		end
	end

	table.insertto(list, isGainList)

	self._curViewDatas = list

	self:reloadData()
	self:_updateFragment()
end

function ReadyforwarmainView:_updateFragment()
	local gianCount = self:_getFragmentTaskFinishCount()

	gianCount = math.min(gianCount, self._maxProgress)
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
	end
end

function ReadyforwarmainView:_getFragmentTaskFinishCount()
	return (MaterialFacade.instance:getMatNumber(MatType.Item, 606))
end

function ReadyforwarmainView:_switchTab(tabType)
	if self._tabType == tabType then
		return
	end

	self._tabType = tabType

	self:_reloadTask()
	self:_setTabOnOff()
end

function ReadyforwarmainView:_setTabOnOff()
	for k, v in pairs(self._tabBtns) do
		goutil.setActive(v.onGo, k == self._tabType)
		goutil.setActive(v.offGo, k ~= self._tabType)
	end
end

function ReadyforwarmainView:_setActTime()
	self._txtTime.text = GameUtil.getActTimeDesc(267, self._activityId)
end

function ReadyforwarmainView:_sendInfoReq()
	EventTaskSummaryController.instance:onSendEventTaskSummaryGetInfoReq(self._activityId)
end

function ReadyforwarmainView:_onItemUse()
	self:_updateFragment()
end

function ReadyforwarmainView:_setEffect()
	local effName = "20230428/quanminbeizhan/fx_ui_quanminbeizhan_fw.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

function ReadyforwarmainView:_setUnlockEffect()
	if not self._unlockEffectHandler then
		local effName = "20230428/quanminbeizhan/fx_ui_quanminbeizhan_kejiesuo.prefab"

		self._unlockEffectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

		self._unlockEffectHandler:setParent(self._jiesuoeffectGo.transform)
		self._unlockEffectHandler:setLocalPos(0, 0, 0)
		self._unlockEffectHandler:setScale(1)
	end
end

function ReadyforwarmainView:_checkRedPoint()
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

return ReadyforwarmainView
