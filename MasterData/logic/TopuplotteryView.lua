-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/topuplottery/view/TopuplotteryView.lua

module("logic.extensions.topuplottery.view.TopuplotteryView", package.seeall)

local TopuplotteryView = class("TopuplotteryView", ViewComponent)
local BigPrizeEffectPath = "20230120/leichongxuyuan/fx_ui_lcxy_an.prefab"

function TopuplotteryView:ctor()
	TopuplotteryView.super.ctor(self)
end

function TopuplotteryView:unbindEvents()
	TopuplotteryView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnCharge)
	GameUtil.rmClickHandler(self._btnPray)
	GameUtil.rmClickHandler(self._btnChoose)
end

function TopuplotteryView:bindEvents()
	TopuplotteryView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnCharge, self._onClickCharge, self)
	GameUtil.addClickHandler(self._btnPray, self._onClickLottery, self)
	GameUtil.addClickHandler(self._btnChoose, self._onClickChooseBigPrize, self)
end

function TopuplotteryView:buildUI()
	TopuplotteryView.super.buildUI(self)

	self._btnRule = self:getGo("btnRule")
	self._btnCharge = self:getGo("btnCharge")
	self._btnPray = self:getGo("btnPray")
	self._txtTime = self:getTxt("time/txtTime")
	self._txtValue = self:getTxt("txtValue")
	self._txtCharge = self:getTxt("txtCharge")
	self._redPray = self:getGo("btnPray/redpoint")
	self._btnChoose = self:getGo("cell_1/btnChoose")
	self._txtBigPrize = self:getTxt("cell_1/txt")
	self._cells = {}

	for i = 1, 9 do
		table.insert(self._cells, self:getGo("cell_" .. i))
	end
end

function TopuplotteryView:onExit()
	TopuplotteryView.super.onExit(self)
	TopUpLotteryController.instance:unregisterLocalNotify(TopUpLotteryController.E_GetInfoRes, self._invalidateAll, self)
	TopUpLotteryController.instance:unregisterLocalNotify(TopUpLotteryController.E_RandRes, self._playLotteryAnim, self)

	for i, v in ipairs(self._cells) do
		local itemGo = goutil.findChild(v, "item")

		MaterialMgr.resetAll(itemGo)
	end

	self:_disposeAnim()

	self._isPlaying = false

	self:_removeBigPrizeEffect()
end

function TopuplotteryView:_disposeAnim()
	if self._sequence then
		self._sequence:Kill(false)

		self._sequence = nil
	end
end

function TopuplotteryView:onEnter()
	TopuplotteryView.super.onEnter(self)
	TopUpLotteryController.instance:registerLocalNotify(TopUpLotteryController.E_GetInfoRes, self._invalidateAll, self)
	TopUpLotteryController.instance:registerLocalNotify(TopUpLotteryController.E_RandRes, self._playLotteryAnim, self)

	local activityId = checknumber(self:getFirstParam())

	if activityId <= 0 then
		self:close()

		return
	end

	self._activityId = activityId
	self._activityConfig = TopUpLotteryConfig.instance:getActivityConfig(activityId)
	self._prizeConfig = TopUpLotteryConfig.instance:getPrizeConfigs(self._activityConfig.prizePlanId)

	self:_invalidateAllAsNone()
	TopUpLotteryAgent.instance:sendPM_TopUpLotteryGetInfoReq(self._activityId)
	self:_updateActTime()
end

function TopuplotteryView:_removeBigPrizeEffect()
	if self._bigPrizeEffect then
		UIEffectManager.instance:stopEffect(self._bigPrizeEffect)

		self._bigPrizeEffect = nil
	end
end

function TopuplotteryView:_addBigPrizeEffect()
	self:_removeBigPrizeEffect()

	local eff = UIEffectManager.instance:playEffect(self, BigPrizeEffectPath, self._btnChoose.transform, 0, 0, true)

	eff:setParent(self._btnChoose.transform)
	eff:setScale(1)
	eff:setLocalPos(0, 0, 0)

	self._bigPrizeEffect = eff
end

function TopuplotteryView:_invalidateAll()
	local actMo = TopUpLotteryModel.instance:getMoOrCreateNew(self._activityId)
	local nextBigPrize = self._activityConfig.bigPrizeTime - actMo.randTime % self._activityConfig.bigPrizeTime

	self._txtValue.text = langPara("再抽%d次必定获得大奖", nextBigPrize)

	if actMo.bigPrizeId > 0 then
		local config

		for i, v in ipairs(self._bigPrizeConfigs) do
			if v.prizeId == actMo.bigPrizeId then
				config = v

				break
			end
		end

		self:_updateOnePrize(self._cells[1], config)
	else
		self:_updateOnePrize(self._cells[1], nil)
	end

	GameUtil.SetActive(self._btnChoose, actMo.bigPrizeId <= 0)

	if actMo.bigPrizeId <= 0 then
		self._txtBigPrize.text = lang("选择\n大奖")

		self:_addBigPrizeEffect()
	else
		self._txtBigPrize.text = lang("大奖")

		self:_removeBigPrizeEffect()
	end

	GameUtil.SetActive(self._redPray, actMo.lotteryNum > 0 and actMo.todayRandTime < self._activityConfig.dailyLimit)
end

function TopuplotteryView:_invalidateAllAsNone()
	self._txtValue.text = ""
	self._txtCharge.text = ""

	GameUtil.SetActive(self._redPray, false)

	self._showingCells = {}
	self._normalPrizeConfigs = {}
	self._bigPrizeConfigs = {}

	for _, config in ipairs(self._prizeConfig) do
		if config.bigPrize ~= 1 then
			table.insert(self._normalPrizeConfigs, config)
		else
			table.insert(self._bigPrizeConfigs, config)
		end
	end

	ArraySort.sortOn(self._normalPrizeConfigs, "prizeId")
	ArraySort.sortOn(self._bigPrizeConfigs, "prizeId")
	table.insert(self._showingCells, {
		cell = self._cells[1],
		selectedGo = goutil.findChild(self._cells[1], "selected")
	})

	for i = 2, #self._cells do
		local cell = self._cells[i]
		local prizeId = i - 1
		local config = self._normalPrizeConfigs[prizeId]

		if not config then
			GameUtil.SetActive(cell, false)
		else
			GameUtil.SetActive(cell, true)

			local selectedGo = goutil.findChild(cell, "selected")

			GameUtil.SetActive(selectedGo, false)
			table.insert(self._showingCells, {
				cell = cell,
				config = config,
				selectedGo = selectedGo
			})
			self:_updateOnePrize(cell, config)
		end
	end
end

function TopuplotteryView:_updateOnePrize(cell, config, bBigPrizeCell)
	local itemGo = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(itemGo)

	if config and not string.nilorempty(config.prize) then
		MaterialMgr.setCellByCfg(config.prize, itemGo)
	end
end

function TopuplotteryView:_playLotteryAnim(prizeId)
	self._isPlaying = true

	local loopMax = 3
	local cellIndex = 0
	local loopIndex = 1
	local targetCellIndex = 0
	local config = self._prizeConfig[prizeId]
	local CellMax = #self._showingCells

	if config.bigPrize == 1 then
		targetCellIndex = 1
	else
		for i = 2, #self._showingCells do
			if self._showingCells[i].config.prizeId == prizeId then
				targetCellIndex = i

				break
			end
		end
	end

	local speed = 0.2
	local loopRoundFunc, stepFunc

	function stepFunc()
		for _, v in ipairs(self._showingCells) do
			GameUtil.SetActive(v.selectedGo, false)
		end

		printInfo("2.....................", loopIndex, cellIndex)

		local group = self._showingCells[cellIndex]

		GameUtil.SetActive(group.selectedGo, true)
		self:_disposeAnim()

		local sequence = DG.Tweening.DOTween.Sequence()

		self._sequence = sequence

		sequence:SetDelay(speed)
		sequence:OnComplete(function()
			self:_disposeAnim()
			loopRoundFunc()
		end)
	end

	function loopRoundFunc()
		printInfo(".....................", loopIndex, cellIndex)

		if loopIndex >= loopMax and cellIndex >= targetCellIndex then
			self:_invalidateAll()

			self._isPlaying = false

			local actMo = TopUpLotteryModel.instance:getMoOrCreateNew(self._activityId)

			actMo:popAndShowChangeSet()
			printInfo("...............done")
		else
			cellIndex = cellIndex + 1

			if cellIndex > CellMax then
				cellIndex = 1
				loopIndex = loopIndex + 1
			end

			stepFunc()
		end
	end

	loopRoundFunc()
end

function TopuplotteryView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "topuplotteryview_rule")
end

function TopuplotteryView:_updateActTime()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.TOP_UP_LOTTERY, self._activityId)
	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)

	self._txtTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
end

function TopuplotteryView:_onClickLottery()
	if self._isPlaying then
		return
	end

	local actMo = TopUpLotteryModel.instance:getMoOrCreateNew(self._activityId)

	if actMo.todayRandTime >= self._activityConfig.dailyLimit then
		FloatWordMgr.instance:show(lang("今日已达到抽奖上限，请明日再来"))

		return
	end

	if actMo.bigPrizeId <= 0 then
		FloatWordMgr.instance:show(lang("请先选择大奖"))

		return
	end

	if actMo.lotteryNum <= 0 then
		local nextCharge = self._activityConfig.money - actMo.totalMoney % self._activityConfig.money
		local strContent = langPara("当前还差<color=#FF0000>%s元</color>即可进行抽奖，清先前往充值哦", math.ceil(nextCharge / 100))

		TipsFacade.instance:openTipWindow(lang("tip"), strContent, function()
			self:_onClickCharge()
		end, lang("前往充值"))

		return
	end

	TopUpLotteryAgent.instance:sendPM_TopUpLotteryRandReq(self._activityId)
end

function TopuplotteryView:_onClickCharge()
	if self._isPlaying then
		return
	end

	if not string.nilorempty(self._activityConfig.gotoCharge) then
		GotoMgr.gotoByString(self._activityConfig.gotoCharge)
	end
end

function TopuplotteryView:_onClickChooseBigPrize()
	if self._isPlaying then
		return
	end

	TopUpLotteryController.instance:reqChooseBigPrize(self._activityId, self._bigPrizeConfigs)
end

return TopuplotteryView
