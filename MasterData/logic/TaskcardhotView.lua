-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cardhot/view/TaskcardhotView.lua

module("logic.extensions.cardhot.view.TaskcardhotView", package.seeall)

local TaskcardhotView = class("TaskcardhotView", ViewComponent)

function TaskcardhotView:ctor()
	TaskcardhotView.super.ctor(self)
end

function TaskcardhotView:buildUI()
	TaskcardhotView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.icon = self:getGo("con")
	self.cellGo = self:getGo("cell")
	self.scrollerGo = self:getGo("tableview")
	self.scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self.btnShare = self:getGo("btnShare")
	self.reward = self:getGo("reward")
	self.rewardCon = self:getGo("reward/con")
	self.rewardCell = self:getGo("reward/cell")

	GameUtil.SetActive(self.rewardCell, false)

	self.slider = self:getSlider("reward/slider")
	self.total = self:getGo("reward/total/item")
	self.txtTotalNum = self:getTxt("reward/total/txtNum")
	self.openTime = self:getTxt("openTime/txt")
end

function TaskcardhotView:bindEvents()
	TaskcardhotView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnShare, self.onShare, self)
end

function TaskcardhotView:unbindEvents()
	TaskcardhotView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnShare)
end

function TaskcardhotView:destroyUI()
	TaskcardhotView.super.destroyUI(self)
end

function TaskcardhotView:onEnter()
	TaskcardhotView.super.onEnter(self)

	self._activityId = 52001
	self.actId = 1

	local actCfg = CardhotConfig.instance:getTaskActivityCfg(self._activityId)
	local type, id, num = MaterialMgr.getMatParams(actCfg.fakeId)

	MaterialMgr.setIcon(self.total, type, id)
	GameUtil.rmClickHandler(self.total)
	GameUtil.addClickHandler(self.total, function()
		CommonTipsMgr.instance:openMaterialTips(self.total, type, id)
	end)

	self.actId = actCfg.taskPlanId
	self.effMap = {}

	goutil.clearChildren(self.rewardCon)

	local taskRewardList = CardhotConfig.instance:getTaskRewardCfg(self._activityId)
	local width = GameUtil.getWidth(self.rewardCon)
	local halfWidth = width * 0.5
	local per = 1 / #taskRewardList
	local perW = per * width

	self.rewardItemList = {}
	self.valueStepArr = {}
	self.progStepArr = {}

	table.insert(self.valueStepArr, 0)
	table.insert(self.progStepArr, 0)

	for i, v in ipairs(taskRewardList) do
		local offX = perW * i - halfWidth
		local cell = self:createRewardCell(v, offX)

		table.insert(self.rewardItemList, cell)
		table.insert(self.valueStepArr, v.needScore)
		table.insert(self.progStepArr, i * per)
	end

	self.openTime.text = self:_getOpenTime()

	local list = {}
	local cfgList = CardhotConfig.instance:getTaskDetailsCfg(self._activityId)

	for k, cfg in pairs(cfgList) do
		table.insert(list, cfg)
	end

	self.scrollList:reloadData(list)

	local prize = ShareController.instance.activeByTimes(3, goutil.findChild(self.btnShare.gameObject, "bubble"))

	MaterialMgr.setCellByCfg(prize, goutil.findChild(self.btnShare.gameObject, "bubble/reward"))
	GlobalDispatcher:addListener(GlobalNotify.PM_DarkDragonPreheatGetInfo, self.onRefreshUI, self)
	CardHotController.instance:sendGetAllTask(self._activityId)
	self:onRefreshUI()
end

function TaskcardhotView:onEnterFinished()
	TaskcardhotView.super.onEnterFinished(self)
end

function TaskcardhotView:onExit()
	TaskcardhotView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_DarkDragonPreheatGetInfo, self.onRefreshUI, self)
	self.scrollList:dispose()
	MaterialMgr.resetAll(goutil.findChild(self.btnShare.gameObject, "bubble/reward"))
end

function TaskcardhotView:onExitFinished()
	TaskcardhotView.super.onExitFinished(self)
end

function TaskcardhotView:onRefreshUI()
	local curValue = checknumber(CardHotModel.instance.totalScore)

	GameUtil.setProgress(self.slider, curValue, self.valueStepArr, self.progStepArr)

	self.txtTotalNum.text = curValue

	for i, v in ipairs(self.rewardItemList) do
		self:updateRewardCell(v, i)
	end

	local list = self.scrollList:getData()

	if list then
		ArraySort.sortOn(list, {
			function(data)
				local obj = CardHotModel.instance:getTaskInfo(data.id)

				if obj and obj.hasGainPrize then
					return 1
				else
					return 0
				end
			end,
			"id"
		})
		self.scrollList:reloadData(list)
	end
end

function TaskcardhotView:_getOpenTime()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.TaskCardHot, self._activityId)
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	return string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
end

function TaskcardhotView:createRewardCell(data, offX)
	local cellGo = goutil.clone(self.rewardCell, "cell_" .. data.id)

	GameUtil.SetActive(cellGo, true)
	goutil.addChildToParent(cellGo, self.rewardCon)
	GameUtil.setAnchoredPos(cellGo, offX, 0)
	GameUtil.addClickHandler(cellGo, GameUtil.handler(self.onClickRewardCell, self, data))

	local item = goutil.findChild(cellGo, "item")
	local recieve = goutil.findChild(cellGo, "recieve")
	local txtNum = goutil.findChildTextComponent(cellGo, "txtNum")

	GameUtil.SetActive(recieve, false)
	MaterialMgr.setCellByCfg(data.prize, item)

	txtNum.text = data.needScore

	return cellGo
end

function TaskcardhotView:updateRewardCell(cellGo, idx)
	local item = goutil.findChild(cellGo, "item")
	local recieve = goutil.findChild(cellGo, "recieve")
	local top = goutil.findChild(cellGo, "top")
	local txtNum = goutil.findChildTextComponent(cellGo, "txtNum")
	local curValue = CardHotModel.instance.totalScore
	local taskRewardList = CardhotConfig.instance:getTaskRewardCfg(self._activityId)

	if not taskRewardList[idx] then
		local data = {}

		if not CardHotModel.instance.hasGainProgessPrize then
			local prize = {}
			local hasGain = table.indexof(prize, data.id)

			GameUtil.SetActive(recieve, hasGain)
			GameUtil.SetActive(top, false)

			local eff = self.effMap[idx]

			UIEffectManager.instance:stopEffect(eff)

			if checknumber(curValue) >= checknumber(data.needScore) and not hasGain then
				GameUtil.SetActive(top, true)

				local effPath = "fx_ui_longchengmibao/fx_ui_longchengmibao.prefab"
				local eff = UIEffectManager.instance:playEffect(self, effPath, item, 0, 0, true, false, nil, function(target, eff)
					eff:setClipping(item:GetComponent(goutil.Type_RectTransform))
				end)

				eff:setParent(item.transform)
				eff:setLocalPos(0, 0, 0)
				eff:setScale(0.95)

				self.effMap[idx] = eff
			end
		end
	end
end

function TaskcardhotView:onClickRewardCell(data)
	print(">>>>>>>>>>>> TaskcardhotView:onClickRewardCell( data )")

	local curValue = CardHotModel.instance.totalScore
	local taskRewardList = CardhotConfig.instance:getTaskRewardCfg(self._activityId)

	if not taskRewardList[data.id] then
		local data = {}

		if not CardHotModel.instance.hasGainProgessPrize then
			local prize = {}
			local hasGain = table.indexof(prize, data.id)

			if checknumber(curValue) >= checknumber(data.needScore) and not hasGain then
				CardHotController.instance:sendGetPrize(self._activityId, data)
			end
		end
	end
end

function TaskcardhotView:_updateCell(view, cell, data, tag)
	local btnRecieve = goutil.findChild(cell, "btnRecieve")
	local btnGo = goutil.findChild(cell, "btnGo")
	local receive = goutil.findChild(cell, "receive")
	local txtTitle = goutil.findChildTextComponent(cell, "txtTitle")
	local txtTask = goutil.findChildTextComponent(cell, "txtTask")
	local txtNumGo = goutil.findChild(cell, "txtNum")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local txtNotOpen = goutil.findChild(cell, "txtNotOpen")
	local item = goutil.findChild(cell, "item")
	local actCfg = CardhotConfig.instance:getTaskActivityCfg(self._activityId)

	MaterialMgr.setCellByCfg(actCfg.fakeId, item)

	local obj = CardHotModel.instance:getTaskInfo(data.id)
	local num = checknumber(obj.curProgress)

	num = math.min(num, checknumber(data.maxProgress))

	local hasGain = obj.hasGainPrize

	txtTitle.text = data.title
	txtTask.text = data.desc
	txtNum.text = string.format("<color=#20B376FF>%s</color>/", num) .. checknumber(data.maxProgress)

	GameUtil.SetActive(receive, hasGain)
	GameUtil.SetActive(btnRecieve, false)
	GameUtil.SetActive(btnGo, false)

	if not hasGain then
		if num >= checknumber(data.maxProgress) then
			GameUtil.SetActive(btnRecieve, true)
		else
			GameUtil.SetActive(btnGo, true)

			if string.nilorempty(data.source) and checknumber(data.maxProgress) > 0 then
				GameUtil.SetActive(btnGo, false)
			end
		end
	end

	GameUtil.addClickHandler(btnGo, GameUtil.handler(self.onClickGo, self, data))
	GameUtil.addClickHandler(btnRecieve, GameUtil.handler(self.onClickRecieve, self, data))
end

function TaskcardhotView:onClickGo(data)
	GotoMgr.gotoByString(data.source)
	self:close()
end

function TaskcardhotView:onClickRecieve(data)
	CardHotController.instance:sendGetTaskPrize(self._activityId, data)
end

function TaskcardhotView:onShare()
	UIStateManager.instance:push(ViewName.TaskcardhotshareView)
end

return TaskcardhotView
