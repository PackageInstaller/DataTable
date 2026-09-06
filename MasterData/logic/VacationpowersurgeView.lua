-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vacationpowersurge/view/VacationpowersurgeView.lua

module("logic.extensions.vacationpowersurge.view.VacationpowersurgeView", package.seeall)

local VacationpowersurgeView = class("VacationpowersurgeView", TableViewComponent)

function VacationpowersurgeView:ctor()
	VacationpowersurgeView.super.ctor(self)
end

function VacationpowersurgeView:buildUI()
	VacationpowersurgeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._txtLeftTime = goutil.findChildTextComponent(self.mainGO, "txtLeftTime")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txtProgress = goutil.findChildTextComponent(self.mainGO, "scoreInfoGo/progress/txtProgress")
	self._tabconGo = self:getGo("tabcon")
	self._tabcellGo = self:getGo("tabcon/tabcell")
	self._tabCellGroup = ItemGroup.New(self._tabconGo, self._tabcellGo, nil, nil, true)
	self._scoreBarSli = self:getSlider("scoreInfoGo/scoreBarSli")
	self._scoreBarSliTr = self._scoreBarSli.transform
	self._rewarditemGo = self:getGo("scoreInfoGo/scoreBarSli/rewardcon/rewarditem")
	self._rewardconGo = self:getGo("scoreInfoGo/scoreBarSli/rewardcon")
	self._progressRewardGroup = ItemGroup.New(self._rewardconGo, self._rewarditemGo, nil, nil, true)
	self._progressItemGo = self:getGo("scoreInfoGo/progress/item")
	self._progressRewardEffectHandler = {}
	self._tabRedPointGos = {}
	self._tabEffectHandlers = {}
	self._roleConGo = self:getGo("roleCon")
end

function VacationpowersurgeView:bindEvents()
	VacationpowersurgeView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
end

function VacationpowersurgeView:unbindEvents()
	VacationpowersurgeView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function VacationpowersurgeView:destroyUI()
	VacationpowersurgeView.super.destroyUI(self)

	self._progressRewardEffectHandler = {}
	self._tabEffectHandlers = {}
end

function VacationpowersurgeView:onEnter()
	VacationpowersurgeView.super.onEnter(self)

	self._actType = GameEnum.ActivityType.Vacationpowersurge

	GlobalDispatcher:addListener(VacationpowersurgeController.PM_VacationPowerSurgeGetInfoRes, self._PM_VacationPowerSurgeGetInfoRes, self)
	GlobalDispatcher:addListener(VacationpowersurgeController.PM_VacationPowerSurgeGainTaskPrizeRes, self._PM_VacationPowerSurgeGainTaskPrizeRes, self)
	GlobalDispatcher:addListener(VacationpowersurgeController.PM_VacationPowerSurgeOnePassRes, self._PM_VacationPowerSurgeOnePassRes, self)
	GlobalDispatcher:addListener(VacationpowersurgeController.PM_VacationPowerSurgeGainProgressPrizeRes, self._PM_VacationPowerSurgeGainProgressPrizeRes, self)
	VacationPowerSurgeAgent.instance:sendPM_VacationPowerSurgeGetInfoReq()

	self._activityId = false

	self:_updateTab()
	self:_setRole()
end

function VacationpowersurgeView:onEnterFinished()
	VacationpowersurgeView.super.onEnterFinished(self)
end

function VacationpowersurgeView:onExit()
	VacationpowersurgeView.super.onExit(self)
	GlobalDispatcher:removeListener(VacationpowersurgeController.PM_VacationPowerSurgeGetInfoRes, self._PM_VacationPowerSurgeGetInfoRes, self)
	GlobalDispatcher:removeListener(VacationpowersurgeController.PM_VacationPowerSurgeGainTaskPrizeRes, self._PM_VacationPowerSurgeGainTaskPrizeRes, self)
	GlobalDispatcher:removeListener(VacationpowersurgeController.PM_VacationPowerSurgeOnePassRes, self._PM_VacationPowerSurgeOnePassRes, self)
	GlobalDispatcher:removeListener(VacationpowersurgeController.PM_VacationPowerSurgeGainProgressPrizeRes, self._PM_VacationPowerSurgeGainProgressPrizeRes, self)
	removetimer(self._updateLeftTime, self)
	self._tabCellGroup:dispose(function(item)
		local goItemcon = goutil.findChild(item.mainGO, "itemcon")

		MaterialMgr.resetAll(goItemcon)
	end)
	self._progressRewardGroup:dispose(function(item)
		local goItemcell = goutil.findChild(item.mainGO, "itemcell")

		MaterialMgr.resetAll(goItemcell)
	end)
	MaterialMgr.resetAll(self._progressItemGo)

	for k, v in pairs(self._progressRewardEffectHandler) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._tabRedPointGos = {}

	for k, v in pairs(self._tabEffectHandlers) do
		UIEffectManager.instance:stopEffect(v)
	end
end

function VacationpowersurgeView:onExitFinished()
	VacationpowersurgeView.super.onExitFinished(self)
end

function VacationpowersurgeView:_onClickbtnClose()
	self:close()
end

function VacationpowersurgeView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("resourcecarnival")
end

function VacationpowersurgeView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function VacationpowersurgeView:_cellSize(view, index)
	return 100, 100
end

function VacationpowersurgeView:_updateCell(view, cell, data)
	local btnGet = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnGet")
	local btnGoto = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btns/btnGoto")
	local btnPayFinish = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btns/btnPayFinish")
	local goCon = goutil.findChild(cell.gameObject, "itemcon/con")
	local goItemcon = goutil.findChild(cell.gameObject, "itemcon")
	local goYlq = goutil.findChild(cell.gameObject, "ylqGo")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtCost = goutil.findChildTextComponent(btnPayFinish.gameObject, "txtCost")
	local txtProgress = goutil.findChildTextComponent(btnGoto.gameObject, "txtProgress")
	local txtOutProgress = goutil.findChildTextComponent(cell.gameObject, "btns/txtGo/txtProgress")
	local txtOutProgressCon = goutil.findChild(cell.gameObject, "btns/txtGo")
	local var_16_0 = self._canOneKeyFinish and (not data.isCanGetPrize and not data.isGetPrize and not string.nilorempty(data.cfg.onePassConsume) or false)
	local showPayFinishBtn = true

	goto label_16_0

	::label_16_0::

	txtName.text = data.cfg.title
	txtDesc.text = data.cfg.desc
	txtProgress.text = data.curProgress .. "/" .. data.cfg.maxProgress

	goutil.setActive(btnGet.gameObject, data.isCanGetPrize)

	local showGoto = not data.isCanGetPrize and not data.isGetPrize and not string.nilorempty(data.cfg.source)

	goutil.setActive(btnGoto.gameObject, showGoto)

	local var_16_1 = data.isGetPrize

	if not data.isGetPrize then
		var_16_1 = data.isCanGetPrize

		if not data.isCanGetPrize then
			local hideOutProgress = showGoto

			goutil.setActive(txtOutProgressCon, not hideOutProgress)

			txtOutProgress.text = hideOutProgress and "" or data.curProgress .. "/" .. data.cfg.maxProgress

			self:_setTaskReward(goItemcon.transform, goCon, data.cfg.prize, data.cfg.score)
			goutil.setActive(btnPayFinish.gameObject, showPayFinishBtn)

			if showPayFinishBtn then
				local arr = string.split(data.cfg.onePassConsume, ":")
				local matType = checknumber(arr[1])
				local matId = checknumber(arr[2])
				local matNum = checknumber(arr[3])
				local costPrice = MaterialFacade.instance:getGoodCost(matType, matId, matNum)

				txtCost.text = costPrice

				btnPayFinish:AddClickListener(function()
					if matType == MatType.Diamond_Consume or matType == MatType.Diamond then
						local goodsName = MaterialMgr.getMaterialsName(matType, matId)
						local content = string.format("确定消耗<color=red>%s%s</color>，快速完成此任务？", costPrice, goodsName)

						local function successCallBack()
							VacationpowersurgeController.instance:sendPM_VacationPowerSurgeOnePassReq(self._activityId, data.cfg.id)
						end

						TipsFacade.instance:openPopupCostDiamondView(costPrice, content, successCallBack)
					else
						printError("不是说好了只能消耗钻石的吗？")
					end
				end)
			end

			goutil.setActive(goYlq, data.isGetPrize)
			btnGet:AddClickListener(function()
				VacationpowersurgeController.instance:sendPM_VacationPowerSurgeGainTaskPrizeReq(self._activityId, data.cfg.id)
			end)
			btnGoto:AddClickListener(function()
				UIStateManager.instance:push(ViewName.ItemSource, data.cfg.source, true)
			end)
		end
	end
end

function VacationpowersurgeView:_setTaskReward(parent, cell, prizeStr, score)
	local list = string.split(prizeStr, "#")
	local childCount = parent.childCount

	for i = 1, childCount do
		goutil.setActive(parent:GetChild(i - 1).gameObject, false)
	end

	local fakeItem = string.format("%s:%s", self._fakeItemPre, score)

	table.insert(list, 1, fakeItem)

	for i, v in ipairs(list) do
		local go = childCount < i and goutil.cloneAndSetParent(cell, parent) or parent:GetChild(i - 1).gameObject

		MaterialMgr.setCellByCfg(v, go)
		goutil.setActive(go, true)
	end
end

function VacationpowersurgeView:_clearTableview(cell)
	local goCon = goutil.findChild(cell.gameObject, "itemcon/con")
	local goItemcon = goutil.findChild(cell.gameObject, "itemcon")
	local parent = goItemcon.transform
	local childCount = parent.childCount

	for i = 1, childCount do
		MaterialMgr.resetAll(parent:GetChild(i - 1).gameObject)
	end
end

function VacationpowersurgeView:_updateTab()
	local actInfos = VacationpowersurgeModel.instance:getActInfos()
	local cfgs = VacationpowersurgeConfig.instance:getActCfgs()

	self._actInfosIdkey = {}

	for i, v in ipairs(actInfos) do
		self._actInfosIdkey[v.activityId] = v
	end

	if not self._activityId then
		for i, cfg in ipairs(cfgs) do
			if ActivityDefineController.instance:isInActivityTimeById(self._actType, cfg.activityId) then
				if VacationpowersurgeModel.instance:checkTaskRewardDotByActId(cfg.activityId) or VacationpowersurgeModel.instance:checkProgressRewardDotByActId(cfg.activityId) then
					self._activityId = cfg.activityId

					break
				end

				self._activityId = cfg.activityId
			end
		end

		if self._activityId then
			self:_setCurrActId(self._activityId)
		end
	end

	if not self._activityId then
		local text = "全部活动已结束，即将退出界面"

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			self:close()
		end)

		return
	end

	for k, v in pairs(self._tabRedPointGos) do
		goutil.setActive(v.redpointGo, false)
	end

	self._tabRedPointGos = {}

	self._tabCellGroup:updateWithMoArray(cfgs, function(item, cfg)
		local bgChang = item.mainGO:GetComponent(ComponentType.UIChangeGroup)
		local goLockGo = goutil.findChild(item.mainGO, "lockGo")
		local goEffect = goutil.findChild(item.mainGO, "effect")
		local goRedpointGo = goutil.findChild(item.mainGO, "redpointGo")
		local txtLock = goutil.findChildTextComponent(item.mainGO, "lockGo/txtLock")
		local txtName = goutil.findChildTextComponent(item.mainGO, "txtName")
		local btn = Framework.ButtonAdapter.Get(item.mainGO)

		bgChang:SetState(self._activityId == cfg.activityId and 1 or 0)

		txtName.text = cfg.desc

		local isLock = not ActivityDefineController.instance:isInActivityTimeById(self._actType, cfg.activityId)

		goutil.setActive(goLockGo, isLock)

		local handler = self._tabEffectHandlers[goEffect]

		if handler then
			UIEffectManager.instance:stopEffect(handler)
		end

		if self._activityId == cfg.activityId and not isLock then
			local effName = "fx_ui_shouchong/fx_ui_leichong_shouchong.prefab"

			handler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

			handler:setParent(goEffect.transform)
			handler:setScale(1.2)
			handler:setLocalPos(0, 0, 0)

			self._tabEffectHandlers[goEffect] = handler
		end

		local lockTip = ""

		if isLock then
			local stime, etime = ActivityDefineController.instance:getStartTimeAndEndTime(self._actType, cfg.activityId)
			local date = GameUtil.time2date(stime)

			lockTip = etime < ServerTime.nowServerLook() and "活动已结束" or string.format("%s月%s日开启", date.month, date.day)
			txtLock.text = lockTip
		end

		btn:AddClickListener(function()
			if isLock then
				FloatWordMgr.instance:show(lockTip)

				return
			else
				self:_setCurrActId(cfg.activityId)
			end
		end)

		self._tabRedPointGos[cfg.activityId] = {
			activityId = cfg.activityId,
			redpointGo = goRedpointGo
		}
	end)
	self:_checkTabRedDot()
	self:_updateView()
end

function VacationpowersurgeView:_setCurrActId(activityId)
	self._activityId = activityId

	self:_updateTab()
end

function VacationpowersurgeView:_updateView()
	self:_setActLeftTime()
	self:_setProgressReward()
	self:_setTask()
end

function VacationpowersurgeView:_setActLeftTime()
	local _, etime = ActivityDefineController.instance:getStartTimeAndEndTime(self._actType, self._activityId)

	self._leftTime = etime - ServerTime.nowServerLook()

	if self._leftTime > 0 then
		settimer(1, self._updateLeftTime, self, true)
		self:_updateLeftTime()
	else
		self._txtLeftTime.text = "活动已结束"
	end
end

function VacationpowersurgeView:_updateLeftTime()
	self._leftTime = self._leftTime - 1

	if self._leftTime > 0 then
		local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(self._leftTime)

		if hour < 10 then
			hour = "0" .. hour
		end

		if min < 10 then
			min = "0" .. min
		end

		if sec < 10 then
			sec = "0" .. sec
		end

		self._txtLeftTime.text = day > 0 and string.format("活动剩余：%s天 %s:%s:%s", day, hour, min, sec) or string.format("活动剩余：%s:%s:%s", hour, min, sec)
	else
		self._txtLeftTime.text = "活动已结束"

		removetimer(self._updateLeftTime, self)
	end
end

function VacationpowersurgeView:_setProgressReward()
	local acfg = VacationpowersurgeConfig.instance:getActCfg(self._activityId)
	local prizeCfgs = VacationpowersurgeConfig.instance:getProgressPlanCfgs(acfg.progressPlanId)
	local info = self._actInfosIdkey[self._activityId]

	self._currScore = 0
	self._hasGainProgessPrize = {}

	if info then
		self._currScore = info.totalScore

		for i, v in ipairs(info.hasGainProgessPrize) do
			self._hasGainProgessPrize[v] = true
		end
	end

	MaterialMgr.setCellByCfg(acfg.item, self._progressItemGo)

	self._prizeCfgs = prizeCfgs
	self._scoreCellSpace = math.ceil(self._scoreBarSliTr.sizeDelta.x) / #prizeCfgs

	self._progressRewardGroup:updateWithMoArray(prizeCfgs, self._updateScoreCell, self)
	self:_updateScore()
end

function VacationpowersurgeView:_updateScoreCell(item, cfg)
	local goReceiveShowGo = goutil.findChild(item.mainGO, "receiveShowGo")
	local goItemcell = goutil.findChild(item.mainGO, "itemcell")
	local goEffect = goutil.findChild(item.mainGO, "effect")
	local txtNum = goutil.findChildTextComponent(item.mainGO, "txtNum")
	local isGet = self._hasGainProgessPrize[cfg.id]
	local isCanGet = false

	if not isGet then
		isCanGet = self._currScore >= cfg.needScore
	end

	goutil.setActive(goReceiveShowGo, isGet)

	local proxy = MaterialMgr.setCellByCfg(cfg.prize, goItemcell)

	txtNum.text = cfg.needScore

	proxy.binder:setAutoTips(isGet or not isCanGet)

	if isCanGet then
		proxy.binder:setCallBack(function()
			VacationpowersurgeController.instance:sendPM_VacationPowerSurgeGainProgressPrizeReq(self._activityId, cfg.id)
		end)
	else
		proxy.binder:setCallBack(nil)
	end

	local handler = self._progressRewardEffectHandler[goEffect]

	UIEffectManager.instance:stopEffect(handler)

	if isCanGet then
		local effName = "fx_ui_tequan/fx_ui_tequan_kuang.prefab"

		handler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)
		self._progressRewardEffectHandler[goEffect] = handler

		handler:setParent(goEffect.transform)
		handler:setScale(1)
		handler:setLocalPos(0, 0, 0)
	end

	GameUtil.setAnchoredPos(item.mainGO, (item.index - 1) * self._scoreCellSpace + self._scoreCellSpace, -60)
end

function VacationpowersurgeView:_updateScore()
	local currScore = self._currScore
	local fill = 0

	if self._prizeCfgs then
		local len = #self._prizeCfgs
		local step = 1 / len

		if currScore >= self._prizeCfgs[#self._prizeCfgs].needScore then
			fill = 1
		else
			local nextScore = 0
			local lastScore = 0

			for i, v in ipairs(self._prizeCfgs) do
				if currScore >= v.needScore then
					fill = fill + step
					lastScore = v.needScore
				else
					nextScore = v.needScore

					break
				end
			end

			fill = fill + (currScore - lastScore) / (nextScore - lastScore) * step
		end
	end

	self._txtProgress.text = currScore

	self._scoreBarSli:SetValue(fill)
end

function VacationpowersurgeView:_setTask()
	local acfg = VacationpowersurgeConfig.instance:getActCfg(self._activityId)
	local tcfgs = VacationpowersurgeConfig.instance:getTaskCfgs(acfg.taskPlanId)
	local _, etime = ActivityDefineController.instance:getStartTimeAndEndTime(self._actType, self._activityId)

	self._canOneKeyFinish = ServerTime.nowServerLook() >= etime - 86400 * acfg.startOnePassDayBeforeEnd
	self._fakeItemPre = acfg.item

	local canGetTasks = {}
	local hasGetPrizeTasks = {}
	local norTasks = {}
	local info = self._actInfosIdkey[self._activityId]
	local serverTaskInfos = {}

	if info and info.taskInfos then
		for i, v in ipairs(info.taskInfos) do
			serverTaskInfos[v.taskId] = v
		end
	end

	local typeList = {}

	for i, v in ipairs(tcfgs) do
		typeList[v.type] = typeList[v.type] or {}

		table.insert(typeList[v.type], v)
	end

	local function sortByMaxProgress(a, b)
		return a.maxProgress < b.maxProgress
	end

	for k, v in pairs(typeList) do
		table.sort(v, sortByMaxProgress)
	end

	local finalCfgs = {}

	for k, list in pairs(typeList) do
		local allHasGain = true

		for i, cfg in ipairs(list) do
			if not serverTaskInfos[cfg.id] or not serverTaskInfos[cfg.id].hasGainPrize then
				allHasGain = false

				table.insert(finalCfgs, cfg)

				break
			end
		end

		if allHasGain then
			table.insert(finalCfgs, list[#list])
		end
	end

	for i, cfg in ipairs(finalCfgs) do
		local vo = serverTaskInfos[cfg.id]
		local data = {
			isCanGetPrize = false,
			curProgress = 0,
			isGetPrize = false,
			cfg = cfg
		}

		if vo then
			data.curProgress = vo.curProgress

			if vo.hasGainPrize then
				data.isGetPrize = true

				table.insert(hasGetPrizeTasks, data)
			elseif vo.curProgress >= cfg.maxProgress then
				data.isCanGetPrize = true

				table.insert(canGetTasks, data)
			else
				table.insert(norTasks, data)
			end
		else
			table.insert(norTasks, data)
		end
	end

	local finalList = {}

	table.insertto(finalList, canGetTasks)
	table.insertto(finalList, norTasks)
	table.insertto(finalList, hasGetPrizeTasks)

	self._curViewDatas = finalList

	self:reloadData()
end

function VacationpowersurgeView:_PM_VacationPowerSurgeGetInfoRes(status)
	if status == 0 then
		self:_updateTab()
	end
end

function VacationpowersurgeView:_PM_VacationPowerSurgeGainTaskPrizeRes()
	self:_updateView()
	self:_checkTabRedDot()
end

function VacationpowersurgeView:_PM_VacationPowerSurgeOnePassRes()
	self:_updateView()
	self:_checkTabRedDot()
end

function VacationpowersurgeView:_PM_VacationPowerSurgeGainProgressPrizeRes()
	self:_setProgressReward()
	self:_checkTabRedDot()
end

function VacationpowersurgeView:_checkTabRedDot()
	for activityId, v in pairs(self._tabRedPointGos) do
		goutil.setActive(v.redpointGo, (ActivityDefineController.instance:isInActivityTimeById(self._actType, activityId) or nil) and (VacationpowersurgeModel.instance:checkTaskRewardDotByActId(activityId) or VacationpowersurgeModel.instance:checkProgressRewardDotByActId(activityId)))
	end
end

function VacationpowersurgeView:_setRole()
	if not self._roleGoInstance then
		local effName = VacationpowersurgeViewPresentor.RolePath
		local go = self:getResInstance(effName)

		if go then
			go.transform:SetParent(self._roleConGo.transform)
			Framework.TransformUtil.SetLocalPos(go.transform, 0, 0, 0)
			Framework.TransformUtil.SetLocalScale(go.transform, 0.26, 0.26, 0.26)
		end

		self._roleGoInstance = go
	end
end

return VacationpowersurgeView
