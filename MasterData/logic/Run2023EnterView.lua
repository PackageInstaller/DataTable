-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/run2023/view/Run2023EnterView.lua

module("logic.extensions.run2023.view.Run2023EnterView", package.seeall)

local Run2023EnterView = class("Run2023EnterView", ViewComponent)

function Run2023EnterView:ctor()
	Run2023EnterView.super.ctor(self)
end

function Run2023EnterView:unbindEvents()
	Run2023EnterView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnWishTree)
	GameUtil.rmClickHandler(self._btnDemo)
	GameUtil.rmClickHandler(self._btnTips)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnJump)
end

function Run2023EnterView:bindEvents()
	Run2023EnterView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStartGame, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnWishTree, self._onClickWishTree, self)
	GameUtil.addClickHandler(self._btnDemo, self._onClickDemo, self)
	GameUtil.addClickHandler(self._btnTips, self._onClickTips, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnJump, self._onClickJump, self)
end

function Run2023EnterView:buildUI()
	Run2023EnterView.super.buildUI(self)

	self._btnStart = self:getBtn("btnStart")
	self._btnClose = self:getBtn("btnClose")
	self._btnWishTree = self:getBtn("btnWishTree")
	self._btnDemo = self:getBtn("btnDemo")
	self._btnJump = self:getBtn("btnJump")
	self._btnTips = self:getBtn("txtRewardTip/btnTip")
	self._txtTime = self:getTxt("time/txt")
	self._txtUseTimes = self:getTxt("useTimes/txt")
	self._txtTodayBest = self:getTxt("buffPet/txtDayRecord")
	self._txtHistoryBest = self:getTxt("buffPet/txtOptimalRecord")
	self._goRole = self:getGo("bg/role")
	self._btnRule = self:getBtn("btnRule")
	self._bg = self:getGo("bg")
	self._headIcon = self:getGo("bg/downbg/item")
	self._cell1 = self:getGo("cell1")

	GameUtil.SetActive(self._cell1, false)

	self._container = self:getGo("container")
	self._redPointGame = self:getGo("btnStart/redpoint")
	self._redPointWishTree = self:getGo("btnWishTree/redpoint")
	self._txtItemCost = self:getTxt("itemCost/txt")
	self._itemCost = self:getGo("itemCost/redpoint")
	self._tipsRoot = self:getGo("tipsRoot")
end

function Run2023EnterView:onExit()
	Run2023EnterView.super.onExit(self)
	self:_clearRole()
	self:_removeCellEff(self._bg)
	self:_removeAllCellEff()
	GlobalDispatcher:removeListener(GlobalNotify.RunGameGetInfoRes, self._refreshView, self)
	RedPointController.instance:unregRedPoint(self._redPointWishTree)
end

function Run2023EnterView:onEnter()
	Run2023EnterView.super.onEnter(self)
	self:_initView()
	self:_loadRole()
	Run2023Controller.instance:sendGameInfoReq(self._activityId)
	self.addGEvent(self, GlobalNotify.RunGameGetInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.UnLockedLabel, self._handleUnLockedLabel, self)
	self.addGEvent(self, GlobalNotify.RunGameSweepGameRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.RunGameStart, self._onStartGame, self)

	self._isBelongSweep = AnnuityPrivilegeController.instance:isBelongSweep(self._activityId)
	self._gamecfg = Run2023Config.instance:getGameCfgsByActId(self._activityId)

	if self._gamecfg then
		self._labelPlanId = self._gamecfg.labelPlanId or 0
	end

	if self._gamecfg then
		self._prizePlanId = self._gamecfg.prizePlanId or 0
	end

	AnnuityPrivilegeController.instance:addAnnuityPrivilegeSweepTipsView(self._tipsRoot, self._viewPresentor, self._activityId)
end

function Run2023EnterView:_handleUnLockedLabel()
	self:_refreshCell()
	self:_refreshView()
end

function Run2023EnterView:_initView()
	self._activityId = 0

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.INTO_THE_CAR)

	if actCfg then
		self._activityId = actCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.INTO_THE_CAR, self._activityId)
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	if self._txtTime then
		self._txtTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	end
end

function Run2023EnterView:_loadRole()
	local gender = RoleModel.instance:getGender()

	GameUtil.setUIImageSpriteIdx(self._goRole, gender)
	self._goRole:GetComponent("Image"):SetNativeSize()
	uGuiUtil.setSpriteToImage(self._headIcon, uGuiUtil.SpriteType.BigBg, (gender == 1 or nil) and "ui/icon/headicon/com_player_aiqi02.png")
end

function Run2023EnterView:_clearRole()
	if self._xiaonuo then
		UIEffectManager.instance:stopEffect(self._xiaonuo)

		self._xiaonuo = nil
	end

	uGuiUtil.clearImage(self._headIcon)
end

function Run2023EnterView:_refreshView()
	local todayBest = Run2023Model.instance:getTodayBest()
	local historyBest = Run2023Model.instance:getHistoryBest()
	local leftUseTimes = Run2023Model.instance:getLeftUseTimes()
	local dailyGameTimes = Run2023Config.instance:getGameDailyTimesByActId(self._activityId)

	GameUtil.SetGray(self._btnStart, leftUseTimes <= 0)
	GameUtil.SetActive(self._redPointGame, leftUseTimes > 0)

	self._txtUseTimes.text = string.format("剩余次数：<color=#C83B3BFF>%s</color>/%s", Run2023Model.instance:getLeftUseTimes(), dailyGameTimes)
	self._txtTodayBest.text = todayBest > 0 and string.format("今日记录：%.1fs", todayBest) or "今日记录：暂无记录"
	self._txtHistoryBest.text = historyBest > 0 and string.format("最佳记录：%.1fs", historyBest) or "最佳纪录：暂无记录"

	local matArr = {}
	local labelCfg = Run2023Config.instance:getGameLabelCfgsByActId(self._activityId) or {}

	for _, data in ipairs(labelCfg) do
		table.insert(matArr, data.unLockCost)
	end

	matArr = MaterialMgr.mergeMatStrList(matArr)

	local matStr = matArr[1]

	if not string.nilorempty(matStr) then
		local matType, matId, matNum = MaterialMgr.getMatParams(matStr)
		local curNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
		local matName = MaterialMgr.getMaterialsName(matType, matId)

		self._txtItemCost.text = string.format("%s：%s", matName, curNum)

		GameUtil.SetActive(self._itemCost, true)
	else
		GameUtil.SetActive(self._itemCost, false)
	end
end

function Run2023EnterView:_playCellEff(go, path, x, y, isLoop, callback)
	if not go then
		return
	end

	self._effs = self._effs or {}

	self:_removeCellEff(go)

	local function loadCallBack(view, uiEffect)
		uiEffect:setParent(go.transform)
		uiEffect:setScale(1)
		uiEffect:setLocalPos(x, y, 0)

		uiEffect.hideEffWhileNotOnTop = true
	end

	self._effs[go] = UIEffectManager.instance:playEffect(self, path, nil, x, y, isLoop, nil, callback, loadCallBack)
end

function Run2023EnterView:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

function Run2023EnterView:_initLabel()
	self._effectList = {}
	self._hasRecList = {}
	self._cfg = {}
	self._items = {}
	self._hasRecList = Run2023Model.instance:getUnlockedLabelList()

	local _cfgList = Run2023Config.instance:getGameLabelCfgs(self._labelPlanId) or {}

	for i, v in ipairs(_cfgList) do
		table.insert(self._cfg, v)
	end

	GameUtil.SetActive(self._cell1, false)
	goutil.clearChildren(self._container)

	for k, v in pairs(self._cfg) do
		local cell = self:_createCell()

		self:_updateLabelCell(cell, v)
		table.insert(self._items, cell)
	end
end

function Run2023EnterView:_createCell()
	local cellGo = goutil.cloneAndSetParent(self._cell1, self._container.transform, "cell")

	GameUtil.SetActive(cellGo, true)

	return cellGo
end

function Run2023EnterView:_updateLabelCell(cellGo, data)
	local lockGo = goutil.findChild(cellGo, "lock")
	local imgCanRec = goutil.findChild(cellGo, "imgCanRec")
	local btnRec = goutil.findChild(cellGo, "btnRec")
	local recEffect = goutil.findChild(cellGo, "effect")
	local imgRed = goutil.findChild(cellGo, "imgRed")
	local txtShow = goutil.findChildTextComponent(cellGo, "txtShow")
	local costRewardStr = MaterialMgr.changeItemStrArr(data.unLockCost)
	local matType, matId, matNum = MaterialMgr.getMatParams(costRewardStr[1])

	self:_removeEffect(cellGo)
	GameUtil.SetActive(imgRed, false)
	GameUtil.SetActive(imgCanRec, false)
	GameUtil.SetActive(lockGo, false)

	local isOpen = true
	local isHasRec = self._hasRecList[data.labelId]

	if isHasRec then
		txtShow.text = lang(data.nameUnlock)

		GameUtil.rmClickHandler(btnRec)
	else
		if MaterialModel.instance:IsEnough(matType, matId, matNum) then
			if data.labelId == 1 or data.labelId > 1 and self._hasRecList[data.labelId - 1] == true then
				GameUtil.SetActive(imgCanRec, true)
				GameUtil.SetActive(imgRed, true)
				self:_loadEffect(recEffect.transform, cellGo)
				GameUtil.addClickHandler(btnRec, function()
					if isOpen then
						local tweenLong = UnityTweens.TweenRotate.StartTween(cellGo, Vector3.New(0, 0, 0), Vector3.New(0, 360, 0), 2)

						isOpen = false

						tweenLong:AddListener(function()
							Run2023Controller.instance:sendPM_IntoTheCarUnLockLabelReq(self._activityId)
							self:_removeEffect(cellGo)
						end)
					end
				end)
			else
				GameUtil.SetActive(lockGo, true)
			end
		else
			GameUtil.SetActive(lockGo, true)
		end

		txtShow.text = lang(data.name)
	end

	if not data.pos then
		local pos = {}

		GameUtil.setAnchoredPos(cellGo, pos[1], pos[2])
	end
end

function Run2023EnterView:_refreshCell()
	if self._items == nil then
		return
	end

	self._hasRecList = Run2023Model.instance:getUnlockedLabelList()

	for i, v in ipairs(self._cfg) do
		self:_updateLabelCell(self._items[i], v)
	end
end

function Run2023EnterView:_loadEffect(transFrom, go)
	self:_removeEffect(go)

	local bgEffectPath = "fx_ui_qirirenwu/fx_ui_kelingqu_ceshihuikui.prefab"
	local recUIEffect = UIEffectManager.instance:playEffect(self, bgEffectPath, transFrom, 0, 0, true, false)

	recUIEffect:setParent(transFrom)
	recUIEffect:setScale(1)
	recUIEffect:setLocalPos(0, 0, 0)

	self._effectList[go] = recUIEffect
end

function Run2023EnterView:_removeEffect(go)
	if self._effectList[go] then
		UIEffectManager.instance:stopEffect(self._effectList[go])

		self._effectList[go] = nil
	end
end

function Run2023EnterView:_removeAllCellEff()
	if self._items == nil then
		return
	end

	for i, v in ipairs(self._items) do
		self:_removeEffect(v)
	end
end

function Run2023EnterView:_onClickStartGame()
	local maxScore = Run2023Model.instance:getHistoryBest()
	local isHasPassFirst = maxScore > 0

	if not self._isBelongSweep or not isHasPassFirst then
		self:_enterGame(self._activityId)

		return
	end

	if not YearCardModel.instance:isInitInfo() then
		FloatWordMgr.instance:show("正在读取年费特权信息，请稍后再试")

		return
	end

	local sweepResult = self:_getTrySweepGameResultAndTips(false, self._activityId, 1)

	if sweepResult ~= GameEnum.ResultCode.Success then
		self:_enterGame(self._activityId)

		return
	end

	self:_showSweepChoiceDialog(maxScore)
end

function Run2023EnterView:_showSweepChoiceDialog(maxScore)
	local function sureCallBack(view)
		self:_sweepGame(self._activityId, view:getCurTimes())
	end

	local function cancelCallBack(view)
		self:_enterGame(self._activityId)
	end

	local maxGameTimes = Run2023Model.instance:getMaxUseTimes()

	local function updateCoinTxtCallBack(view)
		view:getTxtCoin().text = string.format("游戏次数：%s/%s", view:getCurCoinNum(), maxGameTimes)
	end

	local function updateDescTxtCallBack(view)
		local matStr = ""
		local prizeStrList = Run2023Config.instance:getGameRewardCfgsById(self._prizePlanId, maxScore)
		local curTimes = view:getCurTimes()

		for i, v in ipairs(prizeStrList) do
			local matType, matId, matNum = MaterialMgr.getMatParams(v)
			local matName = MaterialMgr.getMaterialsName(matType, matId)

			matStr = i == 1 and string.format("%s x <color=#0068b7>%s</color>", matName, matNum * curTimes) or string.format("%s, %s x <color=#0068b7>%s</color>", matStr, matName, matNum * curTimes)
		end

		view:getTxtDesc().text = string.format("您已首通完毕，是否扫荡获得进度？\n当前可获得奖励数量：%s", matStr)
	end

	local left = Run2023Model.instance:getLeftUseTimes()

	TipsFacade.instance:openPopupCommonCostPopView(left, 1, "开始游戏", "扫荡", "直接开始", nil, sureCallBack, cancelCallBack, nil, updateCoinTxtCallBack, updateDescTxtCallBack)
end

function Run2023EnterView:_enterGame(activityId)
	local result = self:_getTryEnterGameResultAndTips(true, activityId, 1)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local clientKey = Run2023Model.instance:beforeStartGame()

	Run2023Controller.instance:sendStartGameReq(self._activityId, clientKey)
end

function Run2023EnterView:_onStartGame()
	UIStateManager.instance:push(ViewName.Run2023MainView, false)
end

function Run2023EnterView:_sweepGame(activityId, times)
	local result = self:_getTrySweepGameResultAndTips(true, activityId, times)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	Run2023Controller.instance:sendPM_IntoTheCarSweepGameReq(activityId, times)
end

function Run2023EnterView:_getTryEnterGameResultAndTips(isNeedTips, activityId, times)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	if result == GameEnum.ResultCode.Success then
		local left = Run2023Model.instance:getLeftUseTimes()

		if left < times then
			result = GameEnum.ResultCode.Error
			tips = "剩余游戏次数不足"
		end
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function Run2023EnterView:_getTrySweepGameResultAndTips(isNeedTips, activityId, times)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success then
		local isCanSweep = AnnuityPrivilegeController.instance:isCanSweep(activityId)

		if not isCanSweep then
			tips = "不可扫荡"
			result = GameEnum.ResultCode.Error
		end
	end

	if result == GameEnum.ResultCode.Success then
		result = self:_getTryEnterGameResultAndTips(isNeedTips, activityId, times)
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function Run2023EnterView:_onClickClose()
	self:close()
end

function Run2023EnterView:_onClickWishTree()
	self:close()
end

function Run2023EnterView:_onClickDemo()
	UIStateManager.instance:push(ViewName.Run2023MainView, true)
end

function Run2023EnterView:_onClickTips()
	UIStateManager.instance:open(ViewName.RulesView, "rungame_tips")
end

function Run2023EnterView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "benpaoyouxi_rule")
end

function Run2023EnterView:_onClickJump()
	if self._gotoStr == nil then
		self._gotoStr = Run2023Config.instance:getGameCommonByKey("Jump_Shop")

		if string.nilorempty(self._gotoStr) then
			printError("未配置跳转指令")

			return
		end
	end

	GotoMgr.gotoByString(self._gotoStr)
end

return Run2023EnterView
