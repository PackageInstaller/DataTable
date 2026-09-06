-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/gohome/GoHomeBackTaskView.lua

module("logic.extensions.playerreturn.view.gohome.GoHomeBackTaskView", package.seeall)

local GoHomeBackTaskView = class("GoHomeBackTaskView", ViewComponent)

function GoHomeBackTaskView:ctor()
	GoHomeBackTaskView.super.ctor(self)

	self._taskItemList = nil
	self._effPool = {}
end

function GoHomeBackTaskView:buildUI()
	GoHomeBackTaskView.super.buildUI(self)

	self._timerTxt = goutil.findChildTextComponent(self.mainGO, "timerGo/timerTxt")
	self._tipsBtn = self:getGo("tipsBtn")
	self._btnShare = self:getGo("btnShare")
	self._listsBtn = self:getGo("listsBtn")
	self._sldPrizeCol = goutil.findChildComponent(self.mainGO, "prizeCol/sld", ComponentType.Slider)
	self._txtSldPrizeCol = goutil.findChildTextComponent(self.mainGO, "prizeCol/txtSld")
	self._txtScorePrizeCol = goutil.findChildTextComponent(self.mainGO, "prizeCol/txtScore")
	self._scrViewPrizeCol = goutil.findChild(self.mainGO, "prizeCol/scrView")
	self._scrCellPrizeCol = goutil.findChild(self.mainGO, "prizeCol/scrCell")
	self._scrollerListPrizeCol = ScrollerList.create(self._scrViewPrizeCol, self._scrCellPrizeCol, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._scrViewportPrizeCol = goutil.findChild(self.mainGO, "prizeCol/scrView/Viewport")

	local rightInfoGo = self:getGo("rightInfoGo")

	self._taskItemList = {}

	local go

	for i = 1, 4 do
		go = goutil.findChild(rightInfoGo, "taskItem_" .. i)

		if go then
			self._taskItemList[i] = {
				itemGo = go,
				descTxt = goutil.findChildTextComponent(go, "descTxt"),
				shareBtn = Framework.ButtonAdapter.GetFrom(go, "shareBtn"),
				limitTxt = goutil.findChildTextComponent(go, "limitTxt")
			}
		end
	end

	self._prizeBtns = {}

	local prizeOne = goutil.findChild(self.mainGO, "prizeOne")
	local prizeTwo = goutil.findChild(self.mainGO, "prizeTwo")

	for idx, go in ipairs({
		prizeOne,
		prizeTwo
	}) do
		local cell = {}

		cell._mainGo = go
		cell._btn = goutil.findChild(go, "btn")
		cell._icon = goutil.findChild(go, "btn/icon")
		cell._txtNum = goutil.findChildTextComponent(go, "btn/txtNum")
		cell._received = goutil.findChild(go, "btn/received")
		cell._xuanzhuanEff = goutil.findChild(go, "btn/xuanzhuanEff")
		cell._txt = goutil.findChildTextComponent(go, "tips/txt")
		self._prizeBtns[idx] = cell
	end
end

function GoHomeBackTaskView:bindEvents()
	GoHomeBackTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._listsBtn, function()
		UIStateManager.instance:push(ViewName.BackList)
	end, self)
	GameUtil.addClickHandler(self._tipsBtn, function()
		UIStateManager.instance:push(ViewName.RulesView, "backtask")
	end, self)
	GameUtil.addClickHandler(self._btnShare, self._onClickShareURL, self)

	for idx, v in ipairs(self._prizeBtns) do
		GameUtil.addClickHandler(v._btn, GameUtil.handler(self._onClickBtnPrize, self, idx))
	end

	for i = 1, #self._taskItemList do
		if self._taskItemList[i] and self._taskItemList[i].shareBtn then
			self._taskItemList[i].shareBtn:AddClickListener(function()
				self:_onClickShareBtn(i)
			end, self)
		end
	end
end

function GoHomeBackTaskView:unbindEvents()
	GoHomeBackTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._listsBtn)
	GameUtil.rmClickHandler(self._tipsBtn)
	GameUtil.rmClickHandler(self._btnShare)

	for idx, v in ipairs(self._prizeBtns) do
		GameUtil.rmClickHandler(v._btn)
	end

	for i = 1, #self._taskItemList do
		if self._taskItemList[i] and self._taskItemList[i].shareBtn then
			self._taskItemList[i].shareBtn:RemoveClickListener()
		end
	end
end

function GoHomeBackTaskView:onEnter()
	GoHomeBackTaskView.super.onEnter(self)

	self._activityId = PlayerReturnConfig.instance:getOpenActivityId()

	if self._activityId <= 0 then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	if GameUtil.getUserDayData("RP_GoHomeBackTaskView") ~= 1 then
		GameUtil.saveUserDayData("RP_GoHomeBackTaskView", 1)
		RedPointModel.instance:updateAllRedPoint()
	end

	self.addGEvent(self, GlobalNotify.UpdataBackTaskBase, self._updataTaskViewShow, self)
	self.addGEvent(self, GlobalNotify.UpdataBackGainPrize, self._updataTaskViewShow, self)
	self.addGEvent(self, GlobalNotify.PR_handlePM_CIGainTypePrizeRes, self._updataTaskViewShow, self)

	self._actCfg = PlayerReturnConfig.instance:getBackActivityCfg(self._activityId)
	self._allTaskCfgs = PlayerReturnConfig.instance:getBackTaskCfg(self._actCfg.inviteLimitPlan)
	self._prizeCfg = PlayerReturnConfig.instance:getBackPrizeCfg(self._actCfg.prizePlan)

	self:_updataTaskViewShow()
	self:_showActivityTimer()

	local effPath = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

	self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self.pmEff:setParent(self.mainGO.transform)
	self.pmEff:setLocalPos(0, 0, 0)
	self.pmEff:setScale(1)
	PlayerReturnController.instance:csGetCIGetActInfoReq()
end

function GoHomeBackTaskView:onExit()
	GoHomeBackTaskView.super.onExit(self)
	removetimer(self._calculationSurplusTime, self)

	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)

		self.pmEff = nil
	end

	self:_clearPrizeEffPool()
	self:_onClearPrizeColUI()
	self:_onClearPrizeBtn()
end

function GoHomeBackTaskView:destroyUI()
	GoHomeBackTaskView.super.destroyUI(self)

	self._taskItemList = nil
end

function GoHomeBackTaskView:_updataTaskViewShow()
	self:_onUpdatePrizeBtn()
	self:_onUpdatePrizeColUI()
	self:_updataRightInfoShow()
end

function GoHomeBackTaskView:_onUpdatePrizeColUI()
	local backInfo = PlayerReturnModel.instance:getBackTaskInfo()
	local infoList = {}

	for _, data in ipairs(self._prizeCfg) do
		local info = {}
		local state = GameEnum.PrizeState.IsNotEnough

		if table.indexof(backInfo.prizeIds, data.prizeId) then
			state = GameEnum.PrizeState.IsHasGain
		elseif backInfo.score >= data.scoreReq then
			state = GameEnum.PrizeState.IsCanGet
		end

		info.prizeId = data.prizeId
		info.state = state

		table.insert(infoList, info)
	end

	self._scrollerListPrizeCol:reloadData(infoList)

	local index = 0

	for idx, info in ipairs(infoList) do
		if info.state == GameEnum.PrizeState.IsCanGet or info.state == GameEnum.PrizeState.IsNotEnough then
			index = idx - 1

			break
		end
	end

	self._scrollerListPrizeCol:MoveCellInView(index, true)

	local lastPrizeData = self._prizeCfg[#self._prizeCfg]
	local curScore = backInfo.score
	local totalScore = lastPrizeData.scoreReq
	local progrees = curScore / totalScore

	self._txtSldPrizeCol.text = string.format("<color=#20b376>%s</color>/%s", curScore, lastPrizeData.scoreReq)
	self._txtScorePrizeCol.text = curScore
	self._sldPrizeCol.value = progrees
end

function GoHomeBackTaskView:_onClearPrizeColUI()
	self._scrollerListPrizeCol:dispose()
end

function GoHomeBackTaskView:_updatePrizeCell(view, cell, info, tag)
	local prizeId = info.prizeId
	local state = info.state
	local data = self._prizeCfg[prizeId]
	local prizeArr = string.split(data.prize or {}, "#")
	local mainGo = cell.gameObject
	local score_txt = goutil.findChildTextComponent(mainGo, "score/txt")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local item1 = goutil.findChild(mainGo, "item1")
	local item2 = goutil.findChild(mainGo, "item2")
	local imgHasGain = goutil.findChild(mainGo, "imgHasGain")

	score_txt.text = data.scoreReq

	for idx, go in ipairs({
		item1,
		item2
	}) do
		local str = prizeArr[idx]

		if not string.nilorempty(str) then
			MaterialMgr.setCellByCfg(str, go)
		else
			MaterialMgr.resetAll(go)
		end
	end

	GameUtil.SetActive(btnGet, state == GameEnum.PrizeState.IsCanGet)
	GameUtil.SetActive(imgHasGain, state == GameEnum.PrizeState.IsHasGain)

	if state == GameEnum.PrizeState.IsCanGet then
		self:_playPrizeEff(item1)
		self:_playPrizeEff(item2)
	else
		self:_stopPrizeEff(item1)
		self:_stopPrizeEff(item2)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._clickPrizeCell, self, info))
end

function GoHomeBackTaskView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local item1 = goutil.findChild(mainGo, "item1")
	local item2 = goutil.findChild(mainGo, "item2")

	GameUtil.rmClickHandler(btnGet)
	self:_stopPrizeEff(item1)
	self:_stopPrizeEff(item2)

	for idx, go in ipairs({
		item1,
		item2
	}) do
		MaterialMgr.resetAll(go)
	end
end

function GoHomeBackTaskView:_clickPrizeCell(info)
	local prizeId = info.prizeId
	local state = info.state

	if state == GameEnum.PrizeState.IsCanGet then
		PlayerReturnController.instance:csGetCIGainPrizeReq(prizeId)
	elseif state == GameEnum.PrizeState.IsNotEnough then
		FloatWordMgr.instance:show(lang("text_halloween_desc_11"))
	elseif state == GameEnum.PrizeState.IsHasGain then
		FloatWordMgr.instance:show(lang("mail_got"))
	end
end

function GoHomeBackTaskView:_onUpdatePrizeBtn()
	for prizeId, cell in ipairs(self._prizeBtns) do
		local prizeData = PlayerReturnConfig.instance:getTypePrizeData(self._activityId, prizeId)

		GameUtil.SetActive(cell._mainGo, prizeData ~= nil)

		if prizeData ~= nil then
			local matArr = string.split(prizeData.prize or {}, "#")
			local prize = matArr[1]
			local matType, matId, matNum = MaterialMgr.getMatParams(prize)
			local proxy = MaterialMgr.setCellByCfg(prize, cell._icon)

			proxy.binder:setBgActive(false)
			proxy.binder:setAutoTips(false)
			proxy.binder:setEffStatus(false)
			proxy.binder:setNum(0)

			cell._txtNum.text = matNum

			local state = PlayerReturnController.instance:getPrizeStateOfAct(self._activityId, prizeId)

			GameUtil.SetActive(cell._received, state == GameEnum.PrizeState.IsHasGain)

			if state == GameEnum.PrizeState.IsCanGet then
				self:_playXuanzhuanEffect(cell._xuanzhuanEff)
			else
				self:_stopXuanzhuanEffect(cell._xuanzhuanEff)
			end

			local name = PlayerReturnModel.instance:_getTaskGradeName(prizeData.type)

			cell._txt.text = string.format("成功邀请一名%s玩家", name)
		else
			MaterialMgr.resetAll(cell._icon)
			self:_stopXuanzhuanEffect(cell._xuanzhuanEff)

			cell._txt.text = ""
		end
	end
end

function GoHomeBackTaskView:_onClearPrizeBtn()
	for prizeId, cell in ipairs(self._prizeBtns) do
		MaterialMgr.resetAll(cell._icon)
		self:_stopXuanzhuanEffect(cell._xuanzhuanEff)
	end
end

function GoHomeBackTaskView:_playXuanzhuanEffect(effParent)
	local pathName = "fx_ui_yongzhezhita/fx_ui_yongzhezhita_xuanzhuan"

	self:_stopXuanzhuanEffect(effParent)

	if not goutil.isNil(effParent) and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setClipping(effParent:GetComponent(goutil.Type_RectTransform))
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		if self._xuanzhuanEffs == nil then
			self._xuanzhuanEffs = {}
		end

		self._xuanzhuanEffs[effParent] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function GoHomeBackTaskView:_stopAllXuanzhuanEffect()
	if self._xuanzhuanEffs then
		for effParent, eff in pairs(self._xuanzhuanEffs) do
			self:_stopXuanzhuanEffect(effParent)
		end

		table.clear(self._xuanzhuanEffs)
	end
end

function GoHomeBackTaskView:_stopXuanzhuanEffect(effParent)
	if self._xuanzhuanEffs then
		UIEffectManager.instance:stopEffect(self._xuanzhuanEffs[effParent])
	end
end

function GoHomeBackTaskView:_onClickBtnPrize(prizeId)
	local state = PlayerReturnController.instance:getPrizeStateOfAct(self._activityId, prizeId)

	if state == GameEnum.PrizeState.IsCanGet then
		PlayerReturnController.instance:sendPM_CIGainTypePrizeReq(self._activityId, prizeId)
	elseif state == GameEnum.PrizeState.IsNotEnough then
		FloatWordMgr.instance:show(lang("text_halloween_desc_11"))
	elseif state == GameEnum.PrizeState.IsHasGain then
		FloatWordMgr.instance:show(lang("mail_got"))
	end
end

function GoHomeBackTaskView:_updataRightInfoShow()
	self._baseInfo = PlayerReturnModel.instance:getBackTaskInfo()

	for i = 1, #self._allTaskCfgs do
		if self._allTaskCfgs[i] and self._taskItemList[i] then
			self._taskItemList[i].descTxt.text = string.format(self._allTaskCfgs[i].desc, PlayerReturnModel.instance:_getTaskGradeName(i), self._allTaskCfgs[i].scorePrize)

			local sup = math.max(self._allTaskCfgs[i].timesLimit - self:_getTaskGradeLimit(i), 0)

			self._taskItemList[i].limitTxt.text = checknumber(self._allTaskCfgs[i].limitType) == 2 and langPara("text_recall_desc_40", sup, self._allTaskCfgs[i].timesLimit) or langPara("text_recall_desc_39", sup, self._allTaskCfgs[i].timesLimit)

			local isGray = sup <= 0

			uGuiUtil.setImageGrayState(self._taskItemList[i].shareBtn.gameObject, isGray)
			uGuiUtil.setTextGrayState(self._taskItemList[i].limitTxt.gameObject, isGray)
		end
	end
end

function GoHomeBackTaskView:_getTaskGradeLimit(index)
	if self._baseInfo == nil then
		return 0
	end

	if index < 4 then
		for _, info in pairs(self._baseInfo.inviteTimesInfos or {}) do
			if info and info.type == index then
				return info.times
			end
		end

		return 0
	end

	if index == 4 then
		return checknumber(self._baseInfo.accUseCodeTimes)
	end

	return 0
end

function GoHomeBackTaskView:_onClickShareBtn(index)
	if self._allTaskCfgs == nil or self._allTaskCfgs[index] == nil then
		return
	end

	if not ((self._allTaskCfgs[index].timesLimit > 0 and self._allTaskCfgs[index].timesLimit <= self:_getTaskGradeLimit(index) or nil) and false) then
		FloatWordMgr.instance:show(lang("text_recall_desc_35"))

		return
	end

	if index >= 4 then
		UIStateManager.instance:push(ViewName.BackCode)
	else
		UIStateManager.instance:push(ViewName.BackShare, self._baseInfo.myCode)
	end
end

function GoHomeBackTaskView:_onClickShareURL()
	local bgImageName = "share_01"

	UIStateManager.instance:push(ViewName.ShareQRCode, bgImageName, url)
end

function GoHomeBackTaskView:_showActivityTimer()
	removetimer(self._calculationSurplusTime, self)

	local actCfg = ActivityDefineConfig.instance:getCfgById(PlayerReturnModel.instance.backActType, PlayerReturnModel.instance.backActId)

	if actCfg == nil or actCfg.endTime == nil then
		self._timerTxt.text = lang("text_equip_desc_1")

		return
	end

	self._timeEnd = GameUtil.string2time(actCfg.endTime)

	if self._timeEnd <= ServerTime.now() then
		self._timerTxt.text = lang("text_equip_desc_1")
	else
		self:_calculationSurplusTime()
		settimer(1, self._calculationSurplusTime, self, true)
	end
end

function GoHomeBackTaskView:_calculationSurplusTime()
	local supTime = self._timeEnd - ServerTime.now()

	if supTime <= 0 then
		removetimer(self._calculationSurplusTime, self)

		self._timerTxt.text = lang("text_equip_desc_1")

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(supTime)

	self._timerTxt.text = day > 0 and langPara("text_countdown_min", day, hour, min) or langPara("text_countdown_second", hour, min, sec)
end

function GoHomeBackTaskView:_playPrizeEff(mainGo)
	local effParent = mainGo
	local key = mainGo
	local pathName = "fx_ui_juqingfuben/fx_ui_juqingfuben02"

	UIEffectManager.instance:stopEffect(self._effPool[key])

	if not goutil.isNil(effParent) and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setClipping(self._scrViewportPrizeCol:GetComponent(goutil.Type_RectTransform))
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._effPool[key] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function GoHomeBackTaskView:_stopPrizeEff(key)
	UIEffectManager.instance:stopEffect(self._effPool[key])

	self._effPool[key] = nil
end

function GoHomeBackTaskView:_clearPrizeEffPool()
	for key, eff in pairs(self._effPool) do
		self:_stopPrizeEff(key)
	end
end

return GoHomeBackTaskView
