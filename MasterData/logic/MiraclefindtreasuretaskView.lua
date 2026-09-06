-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclefindtreasure/view/MiraclefindtreasuretaskView.lua

module("logic.extensions.miraclefindtreasure.view.MiraclefindtreasuretaskView", package.seeall)

local MiraclefindtreasuretaskView = class("MiraclefindtreasuretaskView", TableViewComponent)

MiraclefindtreasuretaskView.SkipAnim = false
MiraclefindtreasuretaskView.TabType = {
	Achievement = 2,
	Daily = 1
}

function MiraclefindtreasuretaskView:ctor()
	MiraclefindtreasuretaskView.super.ctor(self)

	self._maxProgress = 9
end

function MiraclefindtreasuretaskView:unbindEvents()
	MiraclefindtreasuretaskView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._tabBtns[MiraclefindtreasuretaskView.TabType.Daily].btn:RemoveClickListener()
	self._tabBtns[MiraclefindtreasuretaskView.TabType.Achievement].btn:RemoveClickListener()
	self._btnPass:RemoveClickListener()
	self._btnSkipAnim:RemoveClickListener()
	self._btnpreview:RemoveClickListener()
end

function MiraclefindtreasuretaskView:bindEvents()
	MiraclefindtreasuretaskView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._tabBtns[MiraclefindtreasuretaskView.TabType.Daily].btn:AddClickListener(function()
		self:_switchTab(MiraclefindtreasuretaskView.TabType.Daily)
	end)
	self._tabBtns[MiraclefindtreasuretaskView.TabType.Achievement].btn:AddClickListener(function()
		self:_switchTab(MiraclefindtreasuretaskView.TabType.Achievement)
	end)
	self._btnPass:AddClickListener(self._onClickbtnPass, self)
	self._btnSkipAnim:AddClickListener(self._onClickbtnSkipAnim, self)
	self._btnpreview:AddClickListener(self._onClickbtnpreview, self)
end

function MiraclefindtreasuretaskView:buildUI()
	MiraclefindtreasuretaskView.super.buildUI(self)

	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._item2Go = self:getGo("leftcon/item2/icon")
	self._item1Go = self:getGo("leftcon/item1/icon")
	self._btnAchievementTaskGo = self:getGo("rightcon/btns/btnAchievementTask")
	self._btnDailyTaskGo = self:getGo("rightcon/btns/btnDailyTask")
	self._redPointGoAchievement = self:getGo("rightcon/btns/btnAchievementTask/redPoint")
	self._redPointGoDaily = self:getGo("rightcon/btns/btnDailyTask/redPoint")

	self:_buildTabBtns(MiraclefindtreasuretaskView.TabType.Daily, self._btnDailyTaskGo)
	self:_buildTabBtns(MiraclefindtreasuretaskView.TabType.Achievement, self._btnAchievementTaskGo)

	self._txtProgress = self:getTxt("middlecon/fragments/txtProgress")
	self._fragments = self:getBtn("middlecon/fragments")

	self:_buildFragments(self._fragments.gameObject)

	self._txtTime = self:getTxt("openTime/txtTime")
	self._btnPass = self:getBtn("middlecon/fragments/btnPass")
	self._effectGo = self:getGo("effect")
	self._jiesuoeffectGo = self:getGo("jiesuoeffect")
	self._txtTipGo = self:getGo("txtTip")
	self._goldconGo = self:getGo("goldcon")
	self._skipAnimGo = self:getGo("skipAnim")
	self._btnSkipAnim = self:getBtn("btnSkipAnim")
	self._txtGainAll = self:getTxt("middlecon/fragments/txtGainAll")
	self._btnpreview = self:getBtn("btnpreview")
end

function MiraclefindtreasuretaskView:_buildFragments(go)
	self._fragmentGos = {}

	for i = 1, self._maxProgress do
		self._fragmentGos[i] = goutil.findChild(go, "fragment" .. i)
	end
end

function MiraclefindtreasuretaskView:_buildTabBtns(tabType, go)
	self._tabBtns = self._tabBtns or {}
	self._tabBtns[tabType] = {
		onGo = goutil.findChild(go, "on"),
		offGo = goutil.findChild(go, "off"),
		btn = Framework.ButtonAdapter.Get(go)
	}
end

function MiraclefindtreasuretaskView:onExit()
	MiraclefindtreasuretaskView.super.onExit(self)
	uGuiUtil.clearImage(self._item1Go)
	uGuiUtil.clearImage(self._item2Go)
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

function MiraclefindtreasuretaskView:onEnter()
	MiraclefindtreasuretaskView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_IF_GETINFORES, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
	self.addGEvent(self, GlobalNotify.MiracleFindTreasureDirectGainPrizeRes, self._updateUI, self)
	MaterialController.instance:registerLocalNotify("ItemUsed", self._onItemUse, self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.MiracleFindTreasure)

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开放")
		self:close()

		return
	end

	local factivityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.MiracleFindTreasure)
	local findActCfg = MiraclefindtreasureConfig.instance:getActCfg(factivityId)

	self._maxProgress = findActCfg.costItemCount
	self._lotteryItem = findActCfg.lotteryItem
	self._tabType = self._tabType or MiraclefindtreasuretaskView.TabType.Daily

	goutil.setActive(self._txtTipGo, false)
	goutil.setActive(self._skipAnimGo, MiraclefindtreasuretaskView.SkipAnim)
	self:_setStaticItems()
	self:_updateUI()
	self:_setActTime()
	self:_sendInfoReq()
	self:_setEffect()
	self:_chechDataIsLoad()
	self:_setMainTopGoldBar()
end

function MiraclefindtreasuretaskView:_onClickbtnTip()
	local key = "MiraclefindtreasuretaskView"

	TipsFacade.instance:openRulesView(key)
end

function MiraclefindtreasuretaskView:_onClickbtnClose()
	self:close()
end

function MiraclefindtreasuretaskView:_setStaticItems()
	local spriteName = GameUrl.getItemIconUrl("icon_lb_qjlysq")

	uGuiUtil.setSpriteToImage(self._item1Go, nil, spriteName)

	spriteName = GameUrl.getItemIconUrl("icon_cangbaotusuipian")

	uGuiUtil.setSpriteToImage(self._item2Go, nil, spriteName)
end

function MiraclefindtreasuretaskView:_getPath()
	return {
		cellPath = "rightcon/tablecell",
		viewPath = "rightcon/tableview"
	}
end

function MiraclefindtreasuretaskView:_updateCell(view, cell, taskCfg)
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

function MiraclefindtreasuretaskView:_onClickJump(jumpTo)
	GotoMgr.gotoByString(jumpTo)
end

function MiraclefindtreasuretaskView:_onClickbtnPass()
	if MiraclefindtreasureController.instance:isAllPrizeGain(self._activityId) then
		FloatWordMgr.instance:show("奖励已全部挖完！")

		return
	end

	if MiraclefindtreasuretaskView.SkipAnim then
		MiracleFindTreasureAgent.instance:sendPM_MiracleFindTreasureDirectGainPrizeReq(self._activityId, 1)
	else
		MiraclefindtreasureController.instance:useItem()
	end
end

function MiraclefindtreasuretaskView:_setReward(goItem, prize)
	local arr = string.split(prize, "#")

	MaterialMgr.setCellByCfg(arr[1], goItem)
end

function MiraclefindtreasuretaskView:_clearTableview(cell)
	local goItem = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(goItem)
end

function MiraclefindtreasuretaskView:_updateUI()
	self:_reloadTask()
	self:_updateFragment()
	self:_checkRedPoint()
end

function MiraclefindtreasuretaskView:_reloadTask()
	local taskCfgs = EventTaskSummaryConfig.instance:getTaskCfgs(self._activityId)
	local list = {}
	local isGainList = {}

	for i, v in ipairs(taskCfgs) do
		if self._tabType == MiraclefindtreasuretaskView.TabType.Daily and v.periodType == "daily" or self._tabType ~= MiraclefindtreasuretaskView.TabType.Daily and v.periodType ~= "daily" then
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

function MiraclefindtreasuretaskView:_updateFragment()
	local isGainAll = MiraclefindtreasureController.instance:isAllPrizeGain(self._activityId)
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

	goutil.setActive(self._btnPass.gameObject, isMax and not isGainAll)
	goutil.setActive(self._txtTipGo, isMax and not isGainAll)
	goutil.setActive(self._txtGainAll.gameObject, isGainAll)

	local canUnlock = gianCount >= self._maxProgress

	if canUnlock and isGainAll then
		canUnlock = false
	end

	goutil.setActive(self._unlockEffectGo, canUnlock)

	if canUnlock then
		self:_setUnlockEffect()
	end
end

function MiraclefindtreasuretaskView:_getFragmentTaskFinishCount()
	return (MaterialFacade.instance:getMatNumber(MatType.ACTIVITY_ITEM, self._lotteryItem))
end

function MiraclefindtreasuretaskView:_switchTab(tabType)
	if self._tabType == tabType then
		return
	end

	self._tabType = tabType

	self:_reloadTask()
	self:_setTabOnOff()
end

function MiraclefindtreasuretaskView:_setTabOnOff()
	for k, v in pairs(self._tabBtns) do
		goutil.setActive(v.onGo, k == self._tabType)
		goutil.setActive(v.offGo, k ~= self._tabType)
	end
end

function MiraclefindtreasuretaskView:_setActTime()
	self._txtTime.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.MiracleFindTreasure, self._activityId)
end

function MiraclefindtreasuretaskView:_sendInfoReq()
	EventTaskSummaryController.instance:onSendEventTaskSummaryGetInfoReq(self._activityId)
end

function MiraclefindtreasuretaskView:_onItemUse()
	self:_updateFragment()
end

function MiraclefindtreasuretaskView:_setEffect()
	local effName = "20230428/quanminbeizhan/fx_ui_quanminbeizhan_fw.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

function MiraclefindtreasuretaskView:_setUnlockEffect()
	if not self._unlockEffectHandler then
		local effName = "20230428/quanminbeizhan/fx_ui_quanminbeizhan_kejiesuo.prefab"

		self._unlockEffectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

		self._unlockEffectHandler:setParent(self._jiesuoeffectGo.transform)
		self._unlockEffectHandler:setLocalPos(0, 0, 0)
		self._unlockEffectHandler:setScale(1)
	end
end

function MiraclefindtreasuretaskView:_checkRedPoint()
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

function MiraclefindtreasuretaskView:_chechDataIsLoad()
	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.MiracleFindTreasure)

	if activityId > 0 then
		local info = MiraclefindtreasureModel.instance:getInfo(activityId)

		if not info then
			MiracleFindTreasureAgent.instance:sendPM_MiracleFindTreasureGetInfoReq(activityId)
		end
	end
end

function MiraclefindtreasuretaskView:_setMainTopGoldBar()
	local btn_list = {}

	table.insert(btn_list, {
		showAdd = false,
		id = string.format("10:%s", self._lotteryItem)
	})
	MainUIController.instance:showGlodBar(self._goldconGo, self._viewPresentor, btn_list, false)
end

function MiraclefindtreasuretaskView:_onClickbtnSkipAnim()
	MiraclefindtreasuretaskView.SkipAnim = not MiraclefindtreasuretaskView.SkipAnim

	goutil.setActive(self._skipAnimGo, MiraclefindtreasuretaskView.SkipAnim)
end

function MiraclefindtreasuretaskView:_onClickbtnpreview()
	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.MiracleFindTreasure)

	if activityId > 0 then
		UIStateManager.instance:push(ViewName.MiraclefindtreasureView, activityId, true)
	end
end

return MiraclefindtreasuretaskView
