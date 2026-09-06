-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recalltask/view/ReturnTaskView.lua

module("logic.extensions.recalltask.view.ReturnTaskView", package.seeall)

local ReturnTaskView = class("ReturnTaskView", TableViewComponent)

function ReturnTaskView:ctor()
	ReturnTaskView.super.ctor(self)

	self._isWriteCode = nil
end

function ReturnTaskView:bindEvents()
	ReturnTaskView.super.bindEvents(self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "returntask")
	end, self)
	self._codeBtn:AddClickListener(self._onClickCodeBtn, self)
	self._shopBtn:AddClickListener(function()
		if checknumber(self._endTime) <= 0 then
			FloatWordMgr.instance:show("活动已结束")

			return
		end

		UIStateManager.instance:push(ViewName.RecallShop, 1)
		self:_updataShopRedpoint()
	end, self)
end

function ReturnTaskView:unbindEvents()
	ReturnTaskView.super.unbindEvents(self)
	self._tipsBtn:RemoveClickListener()
	self._codeBtn:RemoveClickListener()
	self._shopBtn:RemoveClickListener()
end

function ReturnTaskView:onExit()
	ReturnTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataRecallReturnInfo, self._updataReturnTaskView, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataRecallReceiveTask, self._updataTaskListShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataRecallWriteCode, self._updataCodeShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateActiveShopInfo, self._updataShopRedpoint, self)
	removetimer(self._calculationSurplusTime, self)
end

function ReturnTaskView:destroyUI()
	ReturnTaskView.super.destroyUI(self)

	self._isWriteCode = nil
end

function ReturnTaskView:buildUI()
	ReturnTaskView.super.buildUI(self)

	self._tipsBtn = self:getBtn("tipsBtn")
	self._dayTxt = goutil.findChildTextComponent(self.mainGO, "dayTxt")
	self._scoreTxt = self:getGo("scoreTxt"):GetComponent("UIImgNumeralText")

	local roleInfoGo = self:getGo("roleInfoGo")

	self._codeBtn = Framework.ButtonAdapter.GetFrom(roleInfoGo, "codeBtn")
	self._shopBtn = self:getBtn("shopBtn")
	self._redpointGo = self:getGo("shopBtn/redpointGo")
	self._timerTxt = goutil.findChildTextComponent(self.mainGO, "timerGo/timerTxt")
	self._dayTxt.text = ""

	self._redpointGo:SetActive(false)

	self._timerTxt.text = ""
end

function ReturnTaskView:onEnter()
	ReturnTaskView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataRecallReturnInfo, self._updataReturnTaskView, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataRecallReceiveTask, self._updataTaskListShow, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataRecallWriteCode, self._updataCodeShow, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdateActiveShopInfo, self._updataShopRedpoint, self)

	local value = GameUtil.getUserDayData("ReturnViewRedpoint")

	if value ~= 1 then
		GameUtil.saveUserDayData("ReturnViewRedpoint", 1)
		GlobalDispatcher:dispatch(GlobalNotify.PR_UpdataPlayerReturnRed, 5)
	end

	self._endTime = -1

	self:_showActivityTimer()
	self:_updataReturnTaskView()
	RecallTaskController.instance:csGetRegressUserInfoReq()
end

function ReturnTaskView:_updataReturnTaskView()
	self:_updataCodeShow()
	self:_updataTaskListShow()
end

function ReturnTaskView:_updataCodeShow()
	self._isWriteCode = false

	local returnInfo = RecallTaskModel.instance:getReturnInfo()

	if returnInfo and checknumber(returnInfo.useCodeTime) < ServerTime.now() then
		self._isWriteCode = true
	end

	GameUtil.SetActive(self._codeBtn, self._isWriteCode)
end

function ReturnTaskView:_updataTaskListShow()
	self:_updataShopRedpoint()

	local returnInfo = RecallTaskModel.instance:getReturnInfo()
	local actCfg = RecallTaskConfig.instance:getRecallActivityCfg(RecallTaskModel.instance.openActivityId)

	self._curViewDatas = {}

	if returnInfo and returnInfo.taskInfoList then
		self._curViewDatas = returnInfo.taskInfoList
	end

	self._taskPlan = actCfg.taskPlan

	self._tableview:ReloadData()
end

function ReturnTaskView:_updataShopRedpoint()
	local count = MaterialModel.instance:getMaterialsNumber(MatType.ACTIVITY_ITEM, RecallTaskModel.instance.openActivityId)

	self._scoreTxt:SetNum(count)

	local isShow = RecallTaskModel.instance:getShopRedpoint(false)

	if isShow ~= self._redpointGo.activeSelf then
		GlobalDispatcher:dispatch(GlobalNotify.PR_UpdataPlayerReturnRed, 5)
	end

	self._redpointGo:SetActive(isShow)
end

function ReturnTaskView:_onClickCodeBtn()
	if checknumber(self._endTime) <= 0 then
		FloatWordMgr.instance:show("活动已结束")

		return
	end

	if not self._isWriteCode then
		FloatWordMgr.instance:show(lang("text_recall_desc_13"))

		return
	end

	UIStateManager.instance:push(ViewName.RecallCode)
end

function ReturnTaskView:_showActivityTimer()
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

function ReturnTaskView:_calculationSurplusTime()
	local supTime = self._endTime - ServerTime.nowServerLook()

	if supTime <= 0 then
		removetimer(self._calculationSurplusTime, self)

		self._timerTxt.text = "活动结束"
		self._endTime = -1

		FloatWordMgr.instance:show("该活动已下架")
		UIStateManager.instance:popByName(ViewName.PlayerReturn)

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(supTime)

	self._timerTxt.text = day > 0 and string.format("剩余时间: %s天%s时%s分", day, hour, min) or string.format("剩余时间： %s时%s分%s秒", hour, min, sec)
end

function ReturnTaskView:_getPath()
	return {
		cellPath = "taskInfoGo/taskItem",
		viewPath = "taskInfoGo/taskListSR"
	}
end

function ReturnTaskView:_cellSize()
	return 216, 356
end

function ReturnTaskView:_updateCell(view, cell, data)
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local desTxt = goutil.findChildTextComponent(cell, "desTxt")
	local scoreTxt = goutil.findChildTextComponent(cell, "scoreTxt")
	local goodsGo = goutil.findChild(cell, "goodsGo")
	local leftRoleGo = goutil.findChild(cell, "leftRoleGo")
	local lHeadGo = goutil.findChild(leftRoleGo, "headGo")
	local lFinishGo = goutil.findChild(leftRoleGo, "finishGo")
	local lDescTxt = goutil.findChildTextComponent(leftRoleGo, "descTxt")
	local gotoBtnGo = goutil.findChild(leftRoleGo, "gotoBtn")
	local rightRoleGo = goutil.findChild(cell, "rightRoleGo")
	local addGo = goutil.findChild(rightRoleGo, "addGo")
	local rHeadGo = goutil.findChild(rightRoleGo, "headGo")
	local rFinishGo = goutil.findChild(rightRoleGo, "finishGo")
	local rDescTxt = goutil.findChildTextComponent(rightRoleGo, "descTxt")
	local rightBtnGo = goutil.findChild(rightRoleGo, "rightBtnGo")
	local receiveBtnGo = goutil.findChild(cell, "receiveBtn")
	local receiveTxt = goutil.findChildTextComponent(receiveBtnGo, "receiveTxt")
	local achieveGo = goutil.findChild(cell, "achieveGo")

	MaterialMgr.resetAll(goodsGo)
	MaterialMgr.resetAll(lHeadGo)
	MaterialMgr.resetAll(rHeadGo)
	GameUtil.asBtn(gotoBtnGo):RemoveClickListener()
	GameUtil.asBtn(rightBtnGo):RemoveClickListener()
	GameUtil.asBtn(receiveBtnGo):RemoveClickListener()

	local taskCfg = RecallTaskConfig.instance:getRecallTaskCfgs(self._taskPlan, data.taskId)

	if taskCfg == nil then
		return
	end

	nameTxt.text = taskCfg.title
	desTxt.text = taskCfg.desc

	local goodsList = string.split(taskCfg.prize, ":")

	scoreTxt.text = "+ " .. goodsList[3]

	if data.prizeGained then
		leftRoleGo:SetActive(false)
		rightRoleGo:SetActive(false)
		receiveBtnGo:SetActive(true)
		achieveGo:SetActive(true)

		receiveTxt.text = lang("mail_got")

		MaterialMgr.setCellByCfg(taskCfg.prize, goodsGo)

		return
	end

	achieveGo:SetActive(false)

	local isFull = data.selfProgress >= taskCfg.maxProgress

	if isFull and data.partnerDone then
		leftRoleGo:SetActive(false)
		rightRoleGo:SetActive(false)
		receiveBtnGo:SetActive(true)

		receiveTxt.text = lang("mail_get")

		MaterialMgr.setCellByCfg(taskCfg.prize, goodsGo)
		GameUtil.asBtn(receiveBtnGo):AddClickListener(function()
			RecallTaskController.instance:csGetGainTaskPrizeReq(data.taskId, data.partner.userId)
		end, self)

		return
	end

	receiveTxt.text = ""

	receiveBtnGo:SetActive(false)
	leftRoleGo:SetActive(true)
	rightRoleGo:SetActive(true)
	HeadItemController.instance:setMyHeadCell(lHeadGo)

	if isFull then
		lDescTxt.text = ""

		gotoBtnGo:SetActive(false)
		lFinishGo:SetActive(true)
	else
		lFinishGo:SetActive(false)

		lDescTxt.text = langPara("text_recall_desc_16", data.selfProgress, taskCfg.maxProgress)

		gotoBtnGo:SetActive(true)
		GameUtil.asBtn(gotoBtnGo):AddClickListener(function()
			if string.nilorempty(taskCfg.jumpTo) then
				FloatWordMgr.instance:show(lang("text_recall_desc_17"))
			else
				GotoMgr.gotoByString(taskCfg.jumpTo)
			end
		end, self)
	end

	if data.partner == nil or checknumber(data.partner.userId) <= 0 then
		rFinishGo:SetActive(false)
		addGo:SetActive(true)

		rDescTxt.text = lang("text_recall_desc_14")
	else
		addGo:SetActive(false)
		HeadItemController.instance:setHeadCellByInfo(rHeadGo, data.partner)
		rFinishGo:SetActive(data.partnerDone)

		rDescTxt.text = data.partnerDone and "" or lang("text_recall_desc_15")
	end

	GameUtil.asBtn(rightBtnGo):AddClickListener(function()
		if checknumber(self._endTime) <= 0 then
			FloatWordMgr.instance:show("活动已结束")

			return
		end

		if data.partner == nil or checknumber(data.partner.userId) <= 0 then
			UIStateManager.instance:push(ViewName.Share, GameEnum.ShareType.ShareRecall, data.taskId)
		else
			FriendController.instance:showInfoView(data.partner.userId, rHeadGo)
		end
	end, self)
end

return ReturnTaskView
