-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/claw_doll/ClawDollActivityView.lua

module("logic.extensions.welfare.view.claw_doll.ClawDollActivityView", package.seeall)

local M = class("ClawDollActivityView", DynamicFragmentView)

ClawDollActivityView.CONFIGID = 0

function M:buildUI()
	self._timeText = self._registry:getText("activity_prize_claw_panel_1171528197")

	local goitem_1 = self._registry:getGo("0&rewards_detail_item_2141037416")
	local goitem_2 = self._registry:getGo("1&rewards_detail_item_2141037416")
	local goitem_3 = self._registry:getGo("2&rewards_detail_item_2141037416")

	self._item1 = Astral.LuaComponentContainer.Add(goitem_1, ItemCell)

	self._item1:Awake()
	self._item1:setShowSelectedEffect(false)

	self._item2 = Astral.LuaComponentContainer.Add(goitem_2, ItemCell)

	self._item2:Awake()
	self._item2:setShowSelectedEffect(false)

	self._item3 = Astral.LuaComponentContainer.Add(goitem_3, ItemCell)

	self._item3:Awake()
	self._item3:setShowSelectedEffect(false)

	self._btnDetail = self._registry:getBtn("3&btn_right_1251431307")
	self._btnExchange = self._registry:getBtn("4&btn_left_-1571983320")
	self._btnTaskList = self._registry:getBtn("5&btn_middle_-31477526")
	self._curCoinNumText = goutil.findChildTextComponent(self._btnTaskList, "startCurrency/txtNum")
	self._taskRedPoint = goutil.findChild(self._btnTaskList, "red_point")

	local info = WelfareConfig.instance:getActivityTabCfg(self.params[1])

	self._cfgId = info.planIds[1]
	ClawDollActivityView.CONFIGID = self._cfgId
end

function M:destroyUI()
	self._timeText = nil
	self._item_1 = nil
	self._item_2 = nil
	self._item_3 = nil
	self._btnDetail = nil
	self._btnExchange = nil
	self._btnTaskList = nil
	self._curCoinNumText = nil
	self._item1 = nil
	self._item2 = nil
	self._item3 = nil
	self._cfgId = nil
end

function M:bindEvents()
	self._btnTaskList:AddClickListener(self._onClickTask, self)
	self._btnExchange:AddClickListener(self._onClickExchange, self)
	self._btnDetail:AddClickListener(self._onClickDetail, self)
end

function M:unbindEvents()
	self._btnTaskList:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnDetail:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)

	local actId = ClawDollController.instance:getActivityId(self._cfgId)
	local actMo = ActivityModel.instance:getActivityById(actId)

	self._timeText.text = actMo:getTimeString()

	settimer(60, self.setTimeText, self, true)
	self:updateCoinNum()
	ClawDollAgent.instance:sendGetClipDollInfoRequest(self._cfgId)
	TaskAgent.instance:sendListTaskRequest(TaskEnum.TaskLabel.ClipDollDaily)
	self:setPreviewReward()
	self:setTaskRedPoint()
end

function M:onExit()
	self:setEvent(false)
	removetimer(self.setTimeText, self)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.CLAW_DOLL_REDPOINT, self.setTaskRedPoint, self)
		GlobalDispatcher:addEventListener(EventType.CLAW_DOLL_COINNUMBER, self.updateCoinNum, self)
	else
		GlobalDispatcher:removeEventListener(EventType.CLAW_DOLL_REDPOINT, self.setTaskRedPoint, self)
		GlobalDispatcher:removeEventListener(EventType.CLAW_DOLL_COINNUMBER, self.updateCoinNum, self)
	end
end

function M:setTaskRedPoint()
	local actID = ClawDollController.instance:getActivityId(ClawDollActivityView.CONFIGID)
	local isTaskCanRev = false
	local redPointTask = RedDotModel.instance:getRedDotDetailList(GameEnum.RedPointEnum.ActivityTask) or {}

	for k, v in ipairs(redPointTask) do
		if tonumber(v) == actID then
			isTaskCanRev = true
		end
	end

	goutil.setActive(self._taskRedPoint.gameObject, isTaskCanRev)
end

function M:updateCoinNum()
	self._curCoinNumText.text = ClawDollController.instance:getCurCoinNumber(self._cfgId)
end

function M:_onClickTask()
	local txtBtn = goutil.findChildTextComponent(self._btnTaskList.gameObject, "normal/Text1")

	UserUtil.uploadActivityTabBuryPoint(UserUtil.activityFirstTabName, UserUtil.activitySecondTabName, txtBtn and txtBtn.text or "")

	local bool = self:_canEnterActivity()

	if bool then
		ViewMgr.instance:open(ViewName.ClawDollTaskView)
	else
		FloatWordMgr.instance:show(lang("tip_activity_over"))
	end
end

function M:_onClickExchange()
	local txtBtn = goutil.findChildTextComponent(self._btnExchange.gameObject, "normal/Text1")

	UserUtil.uploadActivityTabBuryPoint(UserUtil.activityFirstTabName, UserUtil.activitySecondTabName, txtBtn and txtBtn.text or "")

	local bool = self:_canEnterActivityExchange()

	if bool then
		ViewMgr.instance:open(ViewName.ClawDollExchangeView, self._cfgId)
	else
		FloatWordMgr.instance:show(lang("tip_activity_over"))
	end
end

function M:_onClickDetail()
	local txtBtn = goutil.findChildTextComponent(self._btnDetail.gameObject, "normal/Text1")

	UserUtil.uploadActivityTabBuryPoint(UserUtil.activityFirstTabName, UserUtil.activitySecondTabName, txtBtn and txtBtn.text or "")

	local bool = self:_canEnterActivity()

	if bool then
		ViewMgr.instance:open(ViewName.ClawDollDetailView)
	else
		FloatWordMgr.instance:show(lang("tip_activity_over"))
	end
end

function M:_canEnterActivity()
	local actId = ClawDollController.instance:getActivityId(self._cfgId)
	local actMo = ActivityModel.instance:getActivityById(actId)
	local bool = actMo:getIsActivityOpen()

	return bool
end

function M:_canEnterActivityExchange()
	local actId = ClawDollController.instance:getActivityId(self._cfgId)
	local actMo = ActivityModel.instance:getActivityById(actId)
	local bool = false

	if actMo:isHaveExchangeTime() then
		bool = actMo:getIsActivityExchange()

		if not bool then
			bool = actMo:getIsActivityOpen()
		end
	else
		bool = actMo:getIsActivityOpen()
	end

	return bool
end

function M:setTimeText()
	local actId = ClawDollController.instance:getActivityId(self._cfgId)
	local actMo = ActivityModel.instance:getActivityById(actId)

	if actMo then
		self._timeText.text = actMo:getTimeString()
	else
		self._timeText.text = TextFormatter.formatFullExpireTime(0)
	end
end

function M:setPreviewReward()
	local id_1, id_2, id_3 = ClawDollConfig.instance:getPreviewRewardByCfgId(self._cfgId)

	self:setPreviewRewardData(id_1, self._item1)
	self:setPreviewRewardData(id_2, self._item2)
	self:setPreviewRewardData(id_3, self._item3)
end

function M:setPreviewRewardData(id, item)
	local rewardInfo = RewardConfig.instance:getRewardCfgByCode(id)
	local itemId = rewardInfo.reward[1].code
	local count = rewardInfo.reward[1].num
	local tempData = ItemUtil.createItemData({
		itemId = itemId
	})

	tempData:setCount(count)
	item:updateData(tempData)
end

return M
