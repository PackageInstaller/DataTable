-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recalltask/view/RecallTaskView.lua

module("logic.extensions.recalltask.view.RecallTaskView", package.seeall)

local RecallTaskView = class("RecallTaskView", ViewComponent)

function RecallTaskView:ctor()
	RecallTaskView.super.ctor(self)

	self._curTaskDatas = nil
	self._curPrizeDatas = nil
	self._isHaveTask = nil
	self._prizeEffList = nil
end

function RecallTaskView:bindEvents()
	RecallTaskView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "recalltask")
	end, self)
	self._xiaohaoBtn:AddClickListener(function()
		CommonTipsMgr.instance:openMaterialTips(self._xiaohaoBtn, MatType.ACTIVITY_ITEM, RecallTaskModel.instance.openActivityId, 0)
	end, self)
	self._shopBtn:AddClickListener(function()
		if checknumber(self._endTime) <= 0 then
			FloatWordMgr.instance:show("活动已结束")

			return
		end

		UIStateManager.instance:push(ViewName.RecallShop, 2)
		self._redpointGo:SetActive(false)
	end, self)
	self._otherBtn:AddClickListener(function()
		if checknumber(self._endTime) <= 0 then
			FloatWordMgr.instance:show("活动已结束")

			return
		end

		UIStateManager.instance:push(ViewName.chat, GameEnum.ChatChannel.Share)
	end, self)
	self._callBtn:AddClickListener(function()
		if checknumber(self._endTime) <= 0 then
			FloatWordMgr.instance:show("活动已结束")

			return
		end

		UIStateManager.instance:push(ViewName.chat, GameEnum.ChatChannel.Share)
	end, self)
	self._recallBtn:AddClickListener(function()
		if checknumber(self._endTime) <= 0 then
			FloatWordMgr.instance:show("活动已结束")

			return
		end

		UIStateManager.instance:push(ViewName.RecallShare)
	end, self)
end

function RecallTaskView:unbindEvents()
	RecallTaskView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._xiaohaoBtn:RemoveClickListener()
	self._shopBtn:RemoveClickListener()
	self._otherBtn:RemoveClickListener()
	self._callBtn:RemoveClickListener()
	self._recallBtn:RemoveClickListener()
end

function RecallTaskView:onExit()
	RecallTaskView.super.onExit(self)

	for _, eff in pairs(self._prizeEffList) do
		if eff then
			UIEffectManager.instance:stopEffect(eff)
		end
	end

	self._prizeEffList = nil

	GlobalDispatcher:removeListener(GlobalNotify.UpdataRecallRecallInfo, self._updataRecallTaskView, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataRecallReceiveTask, self._updataTaskListShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataRecallReceivePrize, self._updataPrizeListShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateActiveShopInfo, self._updataShopRedpoint, self)
	removetimer(self._calculationSurplusTime, self)

	self._curTaskDatas = nil
	self._curPrizeDatas = nil
	self._isHaveTask = nil
end

function RecallTaskView:destroyUI()
	RecallTaskView.super.destroyUI(self)

	local xhBig = self._xiaohaoIma.gameObject:GetComponent("ImageBigBG")

	if xhBig then
		xhBig:ClearImage()
	end
end

function RecallTaskView:buildUI()
	RecallTaskView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._scoreTxt = self:getGo("scoreTxt"):GetComponent("UIImgNumeralText")

	local xiaohaoGo = self:getGo("xiaohaoItem")

	self._xiaohaoIma = goutil.findChild(xiaohaoGo, "xiaohaoIma"):GetComponent("Image")
	self._xiaohaoTxt = goutil.findChildTextComponent(xiaohaoGo, "xiaohaoTxt")
	self._xiaohaoBtn = Framework.ButtonAdapter.GetFrom(xiaohaoGo, "xiaohaoBtn")
	self._shopBtn = self:getBtn("shopBtn")
	self._redpointGo = self:getGo("shopBtn/redpointGo")

	local taskInfoGo = self:getGo("taskInfoGo")

	self._taskDescTxt = goutil.findChildTextComponent(taskInfoGo, "taskDescTxt")
	self._otherBtn = Framework.ButtonAdapter.GetFrom(taskInfoGo, "otherBtn")
	self._taskRuleGo = goutil.findChild(taskInfoGo, "taskRuleGo")
	self._taskRuleTxt = goutil.findChildTextComponent(self._taskRuleGo, "taskRuleTxt")
	self._callBtn = Framework.ButtonAdapter.GetFrom(self._taskRuleGo, "callBtn")

	local recallPrizeGo = goutil.findChild(taskInfoGo, "recallPrizeGo")

	self._recallBtn = Framework.ButtonAdapter.GetFrom(recallPrizeGo, "recallBtn")
	self._recallTxtGo = goutil.findChild(recallPrizeGo, "recallBtn/recallTxt")
	self._taskListSR = goutil.findChild(taskInfoGo, "taskListSR"):GetComponent("UITableview")
	self._taskItem = goutil.findChild(taskInfoGo, "taskItem")

	self._taskItem:SetActive(false)

	self._prizeListSR = goutil.findChild(recallPrizeGo, "prizeListSR"):GetComponent("UITableview")
	self._prizeItem = goutil.findChild(recallPrizeGo, "prizeItem")

	self._prizeItem:SetActive(false)

	self._srContent = goutil.findChild(recallPrizeGo, "prizeListSR/Viewport"):GetComponent(goutil.Type_RectTransform)
	self._progBarGo = goutil.findChild(recallPrizeGo, "prizeListSR/Viewport/progBarGo/progBarSli")
	self._progBarSli = self._progBarGo:GetComponent("Slider")
	self._progBarSli.value = 0
	self._timerTxt = goutil.findChildTextComponent(self.mainGO, "timerGo/timerTxt")
	self._taskDescTxt.text = ""
	self._taskRuleTxt.text = ""

	GameUtil.SetActive(self._redpointGo, false)
	GameUtil.SetActive(self._taskRuleGo, false)

	self._timerTxt.text = ""

	self:registCallbacks()
end

function RecallTaskView:registCallbacks()
	self._taskListSR:RegisterCallback(self._taskInView, function()
		return 940, 88
	end, self._taskAtIndex, self)
	self._taskListSR:RegisterUpdateCellCallback(self._OnTaskCellUpdate)
	self._prizeListSR:RegisterCallback(self._prizeInView, function()
		return 70, 70
	end, self._prizeAtIndex, self)
	self._prizeListSR:RegisterUpdateCellCallback(self._OnPrizeCellUpdate)
	self._prizeListSR:AddOnScrollValueChanged(self._onCellUpdatePosition, self)
end

function RecallTaskView:_taskInView()
	if not self._curTaskDatas then
		return 0
	end

	return #self._curTaskDatas
end

function RecallTaskView:_taskAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._taskItem)

	local data = self._curTaskDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_updateTaskCell(view, cell, data)

	return cell
end

function RecallTaskView:_OnTaskCellUpdate(view, cell)
	local index = cell.index
	local data = self._curTaskDatas[index + 1]

	cell.data = index + 1

	self:_updateTaskCell(view, cell, data)
end

function RecallTaskView:_prizeInView()
	if not self._curPrizeDatas then
		return 0
	end

	return #self._curPrizeDatas
end

function RecallTaskView:_prizeAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._prizeItem)

	local data = self._curPrizeDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_updatePrizeCell(view, cell, data)

	return cell
end

function RecallTaskView:_OnPrizeCellUpdate(view, cell)
	local index = cell.index
	local data = self._curPrizeDatas[index + 1]

	cell.data = index + 1

	self:_updatePrizeCell(view, cell, data)
end

function RecallTaskView:_onReloadFinish()
	self:_onCellUpdatePosition()
end

function RecallTaskView:onEnter()
	RecallTaskView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataRecallRecallInfo, self._updataRecallTaskView, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataRecallReceiveTask, self._updataTaskListShow, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataRecallReceivePrize, self._updataPrizeListShow, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdateActiveShopInfo, self._updataShopRedpoint, self)

	self._prizeEffList = {}

	MaterialMgr.setIcon(self._xiaohaoIma, MatType.ACTIVITY_ITEM, RecallTaskModel.instance.openActivityId)

	self.actCfg = RecallTaskConfig.instance:getRecallActivityCfg(RecallTaskModel.instance.openActivityId)

	self:_updataRecallTaskView()

	self._endTime = -1

	self:_showActivityTimer()
	RecallTaskController.instance:csGetInviteUserInfoReq()
end

function RecallTaskView:_updataRecallTaskView()
	self:_updataTaskListShow()
	self:_updataPrizeListShow()
end

function RecallTaskView:_updataTaskListShow()
	self:_updataShopRedpoint()

	local recallInfo = RecallTaskModel.instance:getRecallInfo()

	self._curTaskDatas = {}

	if recallInfo == nil or recallInfo.taskInfoList == nil or #recallInfo.taskInfoList == 0 then
		self._taskDescTxt.text = lang("text_recall_desc_7")
		self._isHaveTask = false

		GameUtil.SetActive(self._taskListSR, false)
		GameUtil.SetActive(self._otherBtn, false)
		GameUtil.SetActive(self._taskRuleGo, true)

		self._taskRuleTxt.text = self.actCfg.ruleDesc
	else
		self._isHaveTask = true
		self._taskRuleTxt.text = ""

		GameUtil.SetActive(self._taskRuleGo, false)
		GameUtil.SetActive(self._otherBtn, true)
		GameUtil.SetActive(self._taskListSR, true)

		if recallInfo and recallInfo.taskInfoList then
			self._curTaskDatas = recallInfo.taskInfoList
		end

		local supCount = math.max(self.actCfg.dailyTaskCount - #self._curTaskDatas, 0)

		self._taskDescTxt.text = langPara("text_recall_desc_8", supCount, self.actCfg.dailyTaskCount)

		self._taskListSR:ReloadData()
	end
end

function RecallTaskView:_updataShopRedpoint()
	local count = MaterialModel.instance:getMaterialsNumber(MatType.ACTIVITY_ITEM, RecallTaskModel.instance.openActivityId)

	self._scoreTxt:SetNum(count)

	self._xiaohaoTxt.text = tostring(count)

	self._redpointGo:SetActive(RecallTaskModel.instance:getShopRedpoint(true))
end

function RecallTaskView:_updataPrizeListShow()
	self:_updataShopRedpoint()

	local recallInfo = RecallTaskModel.instance:getRecallInfo()
	local prizeCfgs = RecallTaskConfig.instance:getRecallPrizeCfgs(self.actCfg.invitePrizePlan)

	self._curPrizeDatas = {}

	local isAllFull = true
	local prizeIds = {}

	if recallInfo and recallInfo.prizeIds then
		prizeIds = recallInfo.prizeIds
	end

	local count = 0

	if recallInfo and checknumber(recallInfo.recallCount) > 0 then
		count = checknumber(recallInfo.recallCount)
	end

	for _, cfg in pairs(prizeCfgs or {}) do
		if cfg and checknumber(cfg.prizeId) > 0 then
			local isReceive = not not (#prizeIds > 0 and table.indexof(prizeIds, cfg.prizeId))

			if count < cfg.needCount then
				isAllFull = false
			end

			table.insert(self._curPrizeDatas, {
				prizeId = cfg.prizeId,
				needCount = cfg.needCount,
				prize = cfg.prize,
				isFull = count >= cfg.needCount,
				isReceive = isReceive
			})
		end
	end

	if self._curPrizeDatas then
		if not #self._curPrizeDatas then
			local dataNum = 0

			if dataNum > 1 then
				table.sort(self._curPrizeDatas, function(a, b)
					return a.prizeId < b.prizeId
				end)
			end

			local width = dataNum * 120

			GameUtil.setWidth(self._progBarGo, width)
			uGuiUtil.setImageGrayState(self._recallBtn.gameObject, isAllFull)
			uGuiUtil.setTextGrayState(self._recallTxtGo, isAllFull)

			self._recallBtn.btn.interactable = not isAllFull

			self._prizeListSR:ReloadData()

			if isAllFull then
				self._progBarSli.value = 1

				return
			end

			if dataNum <= 0 or count == 0 then
				self._progBarSli.value = 0

				return
			end

			local once = 1 / dataNum
			local value = 0

			for i = 1, dataNum do
				if self._curPrizeDatas[i].isFull then
					value = value + once
				else
					local syc = 0

					if self._curPrizeDatas[i - 1] and self._curPrizeDatas[i - 1].needCount > 0 then
						syc = self._curPrizeDatas[i - 1].needCount
					end

					local temp = (count - syc) * once / (self._curPrizeDatas[i].needCount - syc)

					value = value + temp

					break
				end
			end

			self._progBarSli.value = value
		end
	end
end

function RecallTaskView:_onCellUpdatePosition(pos)
	local contentGo = self._prizeListSR:GetContent()

	if self._curPrizeDatas then
		if not #self._curPrizeDatas then
			local count = 0
			local width = count * 120 + 35

			GameUtil.setWidth(contentGo, width)
			Framework.TransformUtil.SetLocalPos(self._progBarGo.transform, contentGo.transform.localPosition.x, -35, 0)
		end
	end
end

function RecallTaskView:_showActivityTimer()
	removetimer(self._calculationSurplusTime, self)

	local stime, etime = ActivityDefineController.instance:getStartTimeAndEndTime(RecallTaskModel.instance.openActivityType, RecallTaskModel.instance.openActivityId)
	local nowTime = ServerTime.nowServerLook()

	if etime <= nowTime then
		self._timerTxt.text = "活动结束"
		self._endTime = -1

		return
	end

	self._endTime = etime

	if nowTime < self._endTime then
		self:_calculationSurplusTime()
		settimer(1, self._calculationSurplusTime, self, true)
	end
end

function RecallTaskView:_calculationSurplusTime()
	local supTime = self._endTime - ServerTime.nowServerLook()

	if supTime <= 0 then
		removetimer(self._calculationSurplusTime, self)

		self._timerTxt.text = "活动结束"
		self._endTime = -1

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(supTime)

	self._timerTxt.text = day > 0 and string.format("剩余时间: %s天%s时%s分", day, hour, min) or string.format("剩余时间： %s时%s分%s秒", hour, min, sec)
end

function RecallTaskView:_updateTaskCell(view, cell, data)
	local taskNameTxt = goutil.findChildTextComponent(cell, "taskNameTxt")
	local taskDescTxt = goutil.findChildTextComponent(cell, "taskDescTxt")
	local headGo = goutil.findChild(cell, "headGo")
	local roleNameTxt = goutil.findChildTextComponent(cell, "roleNameTxt")
	local powerTxt = goutil.findChildTextComponent(cell, "powerTxt")
	local goodsGo = goutil.findChild(cell, "goodsGo")
	local progTxt = goutil.findChildTextComponent(cell, "progTxt")
	local gotoBtnGo = goutil.findChild(cell, "gotoBtn")
	local gotoIma = gotoBtnGo:GetComponent("UIImageSpriteChange")
	local gotoTxt = goutil.findChildTextComponent(gotoBtnGo, "gotoTxt")
	local achieveGo = goutil.findChild(cell, "achieveGo")
	local redpointGo = goutil.findChild(cell, "redpointGo")

	MaterialMgr.resetAll(headGo)
	MaterialMgr.resetAll(goodsGo)
	GameUtil.asBtn(gotoBtnGo):RemoveClickListener()

	local taskCfg = RecallTaskConfig.instance:getRecallTaskCfgs(self.actCfg.taskPlan, data.taskId)

	if taskCfg == nil then
		return
	end

	taskNameTxt.text = taskCfg.title
	taskDescTxt.text = taskCfg.desc

	HeadItemController.instance:setHeadCellByInfo(headGo, data.partner)

	roleNameTxt.text = data.partner.userName
	powerTxt.text = tostring(data.partnerCurZdl)

	MaterialMgr.setCellByCfg(taskCfg.prize, goodsGo)

	if data.prizeGained then
		progTxt.text = ""

		GameUtil.SetActive(gotoBtnGo, false)
		GameUtil.SetActive(achieveGo, true)
		GameUtil.SetActive(redpointGo, false)

		return
	end

	progTxt.text = data.selfProgress .. "/" .. taskCfg.maxProgress

	GameUtil.SetActive(achieveGo, false)
	GameUtil.SetActive(gotoBtnGo, true)

	if data.selfProgress >= taskCfg.maxProgress then
		gotoTxt.text = lang("mail_get")

		GameUtil.SetActive(redpointGo, data.partnerDone)
		gotoIma:SetState(1)
	else
		gotoTxt.text = lang("goto")

		GameUtil.SetActive(redpointGo, false)
		gotoIma:SetState(0)
	end

	GameUtil.asBtn(gotoBtnGo):AddClickListener(function()
		if checknumber(self._endTime) <= 0 then
			FloatWordMgr.instance:show("活动已结束")

			return
		end

		if data.selfProgress >= taskCfg.maxProgress then
			if data.partnerDone then
				RecallTaskController.instance:csGetGainTaskPrizeReq(data.taskId, data.partner.userId)
			else
				FloatWordMgr.instance:show(lang("text_recall_desc_9"))
			end
		elseif string.nilorempty(taskCfg.jumpTo) then
			FloatWordMgr.instance:show(lang("text_recall_desc_10"))
		else
			GotoMgr.gotoByString(taskCfg.jumpTo)
		end
	end, self)
end

function RecallTaskView:_updatePrizeCell(view, cell, data)
	local goodsGo = goutil.findChild(cell, "goodsGo")
	local receivedGo = goutil.findChild(cell, "receivedGo")
	local numTxt = goutil.findChildTextComponent(cell, "numTxt")
	local clickBtnGo = goutil.findChild(cell, "clickBtn")

	MaterialMgr.resetAll(goodsGo)
	GameUtil.asBtn(clickBtnGo):RemoveClickListener()

	if self._prizeEffList[cell] then
		UIEffectManager.instance:stopEffect(self._prizeEffList[cell])

		self._prizeEffList[cell] = nil
	end

	MaterialMgr.setCellByCfg(data.prize, goodsGo)
	receivedGo:SetActive(data.isReceive)

	numTxt.text = langPara("text_recall_desc_11", data.needCount)

	if not data.isFull then
		GameUtil.SetActive(clickBtnGo, false)

		return
	end

	if not data.isReceive then
		self._prizeEffList[cell] = UIEffectManager.instance:playEffect(self, "fx_ui_qirirenwu/fx_qirirenwu_kelingqu.prefab", cell, 0, 0, true, nil, nil, function(_, eff)
			eff:setParent(cell.transform)
			eff:setScale(1)
			eff:setLocalPos(0, 1, 0)
			eff:setClipping(self._srContent)
		end)
	end

	GameUtil.SetActive(clickBtnGo, true)
	GameUtil.asBtn(clickBtnGo):AddClickListener(function()
		if checknumber(self._endTime) <= 0 then
			FloatWordMgr.instance:show("活动已结束")

			return
		end

		if data.isReceive then
			FloatWordMgr.instance:show(lang("text_recall_desc_12"))

			return
		end

		RecallTaskController.instance:csGetGainInvitePrizeReq(data.prizeId)
	end, self)
end

return RecallTaskView
