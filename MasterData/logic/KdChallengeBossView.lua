-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/view/KdChallengeBossView.lua

module("logic.extensions.kingdragonchallenge.view.KdChallengeBossView", package.seeall)

local KdChallengeBossView = class("KdChallengeBossView", ViewComponent)

function KdChallengeBossView:buildUI()
	KdChallengeBossView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._btnChallenge = goutil.findChild(self.mainGO, "btnChallenge")
	self._txtBtnChallenge = goutil.findChildTextComponent(self.mainGO, "btnChallenge/txt")
	self._txtRemain = goutil.findChildTextComponent(self.mainGO, "remain/txt")
	self._btnAddInRemain = goutil.findChild(self.mainGO, "remain/btnAdd")
	self._phaseView = goutil.findChild(self.mainGO, "getSlider/phaseView")
	self._txtNum = goutil.findChildTextComponent(self.mainGO, "getSlider/txtNum")
	self._sliderComp = self:getSlider("getSlider")
	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
	self._con = goutil.findChild(self.mainGO, "con")
	self._effRoot = goutil.findChild(self.mainGO, "effRoot")
	self._ruleDesc = goutil.findChildTextComponent(self.mainGO, "rule/txtDesc")
	self._bgEff = nil
	self._prizeEff = {}
end

function KdChallengeBossView:bindEvents()
	KdChallengeBossView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
	GameUtil.addClickHandler(self._btnAddInRemain, self._onClickBtnAddInRemain, self)
end

function KdChallengeBossView:unbindEvents()
	KdChallengeBossView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnAddInRemain)
end

function KdChallengeBossView:onEnter()
	KdChallengeBossView.super.onEnter(self)

	self._challengeId = KdChallengeConfig.instance:getKdCurChallengeId()

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeBossBuyRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeBossSweepRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeResultConfirmRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeBossGetPrizeRes, self._sendGetInfoReq, self)
	self:_sendGetInfoReq()

	local redId = RedPointModel.ID_KINGDRAGON_LANDINGONCE_RED_BOSS

	KdChallengeController.instance:saveRedAsLandingOnce(redId, true)
end

function KdChallengeBossView:onExit()
	KdChallengeBossView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.KDChallengeGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.KDChallengeBossBuyRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.KDChallengeBossSweepRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.KDChallengeResultConfirmRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.KDChallengeBossGetPrizeRes, self._sendGetInfoReq, self)

	if self._bgEff then
		UIEffectManager.instance:stopEffect(self._bgEff)

		self._bgEff = nil
	end

	self:_clearSlider()
end

function KdChallengeBossView:_sendGetInfoReq()
	KdChallengeController.instance:sendPM_TQKingDragonGetInfoReq(self._challengeId)
end

function KdChallengeBossView:_onSetUI()
	local effParent = self._effRoot
	local pathName = "20220902/wzsltiaozhan/fx_ui_wzsl_guang"

	UIEffectManager.instance:stopEffect(self._bgEff)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._bgEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end

	local itemsStr = KdChallengeConfig.instance:getKdShowResource()

	if not string.nilorempty(itemsStr) then
		local itemsStrArray = string.split(itemsStr, "#")
		local list = {}

		for _, itemStr in ipairs(itemsStrArray) do
			t = {
				showAdd = true,
				id = itemStr
			}

			table.insert(list, t)
		end

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	end

	local ruleData = RulesConfig.instance:getRuleCo("KingofTheDragon_rule_1_1")

	if ruleData then
		self._ruleDesc.text = ruleData.rules
	end

	if ruleData then
		self._txtTitle.text = ruleData.title
	end
end

function KdChallengeBossView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function KdChallengeBossView:_onUpdateData()
	return
end

function KdChallengeBossView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateSlider()
end

function KdChallengeBossView:_onUpdatePlaneUI()
	local bossData = KdChallengeConfig.instance:getKdBossDataByCId(self._challengeId)
	local leftTimes = KdChallengeController.instance:getLeftTimesAsBoss()
	local totalTimes = bossData.freeDailyTimes

	self._txtRemain.text = string.format("本日次数：%d/%d", leftTimes, totalTimes)

	local isPassAll = KdChallengeController.instance:isPassAllBossAsBoss()
	local isEnoughSweep = KdChallengeController.instance:isEnoughSweepAsBoss()

	self._txtBtnChallenge.text = isPassAll and "已通关" or isEnoughSweep and "开始扫荡" or "进入挑战"
end

function KdChallengeBossView:_onUpdateSlider()
	local totalDmg = KdChallengeModel.instance:getTotalDmgAsBoss()
	local prizeCfg = KdChallengeConfig.instance:getKdBossDamageCfgByCId(self._challengeId)

	self._txtNum.text = string.format("累计伤害：%s", totalDmg)

	for idx, data in ipairs(prizeCfg) do
		local mainGo = self._phaseView.transform:GetChild(idx - 1)

		if mainGo == nil then
			printError(string.format("缺失预制( id=%d )", data.id))
		else
			self:_updatePrizeCell(mainGo, data)
		end
	end

	local valueStepArr = {
		0
	}
	local progStepArr = {
		0
	}

	for idx, data in ipairs(prizeCfg) do
		table.insert(valueStepArr, data.dmgProgress)
		table.insert(progStepArr, data.id / #prizeCfg)
	end

	GameUtil.setProgress(self._sliderComp, totalDmg, valueStepArr, progStepArr)
end

function KdChallengeBossView:_clearSlider()
	local prizeCfg = KdChallengeConfig.instance:getKdBossDamageCfgByCId(self._challengeId)

	for idx, data in ipairs(prizeCfg) do
		local mainGo = self._phaseView.transform:GetChild(idx - 1)
		local btnGet = goutil.findChild(mainGo, "btnGet")

		MaterialMgr.resetAll(mainGo)
		UIEffectManager.instance:stopEffect(self._prizeEff[mainGo])

		self._prizeEff[mainGo] = nil

		GameUtil.rmClickHandler(btnGet)
	end
end

function KdChallengeBossView:_updatePrizeCell(mainGo, data)
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local received = goutil.findChild(mainGo, "received")
	local getNum = goutil.findChildTextComponent(mainGo, "getNum")
	local txtNum = goutil.findChildTextComponent(mainGo, "txtNum")
	local isCanGet = KdChallengeController.instance:isCanGetPrizeAsBoss(data.id)
	local isHasGain = KdChallengeController.instance:isHasGainPrizeAsBoss(data.id)

	txtNum.text = langPara("hongliannvhuangview__2", math.ceil(data.dmgProgress / 10000))

	MaterialMgr.setCellByCfg(data.gain, item)
	GameUtil.SetActive(received, isHasGain)
	UIEffectManager.instance:stopEffect(self._prizeEff[mainGo])

	self._prizeEff[mainGo] = nil

	if isCanGet then
		local effParent = item
		local pathName = "fx_ui_juqingfuben/fx_ui_juqingfuben02"

		if effParent and not string.nilorempty(pathName) then
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

			self._prizeEff[mainGo] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, nil)
		end
	end

	GameUtil.SetActive(btnGet, isCanGet)
	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickPrizeCellGet, self, data))
end

function KdChallengeBossView:_onClickPrizeCellGet(data)
	KdChallengeController.instance:sendPM_TQKingDragonBossGetPrizeReq(self._challengeId, data.id)
end

function KdChallengeBossView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("KingofTheDragon_rule_1")
end

function KdChallengeBossView:_onClickBtnChallenge()
	if KdChallengeController.instance:isPassAllBossAsBoss() then
		FloatWordMgr.instance:show("已通关")

		return
	end

	if not KdChallengeController.instance:isHaveTimesAsBoss() then
		if KdChallengeController.instance:isExceedLimitTimesAsBoss() then
			FloatWordMgr.instance:show("已达今日挑战上限")
		else
			self:_onClickBtnAddInRemain()
		end

		return
	end

	if KdChallengeController.instance:isEnoughSweepAsBoss() then
		local text = "已满足扫荡要求,可以进行扫荡"

		local function func()
			KdChallengeController.instance:sendPM_TQKingDragonBossSweepReq(self._challengeId)
		end

		local btnText = "确认"
		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade.instance:openTipWindow("提示", text, func, btnText, alignment)
	else
		KdChallengeModel.instance:clearViewInfos()
		KdChallengeModel.instance:addViewInfo(ViewName.KdChallengeMainView)
		KdChallengeModel.instance:addViewInfo(self._viewPresentor.viewName)
		KdChallengeController.instance:enterBattleAsKd(GameEnum.KingDragonType.Boss)
	end
end

function KdChallengeBossView:_onClickBtnAddInRemain()
	if KdChallengeController.instance:isPassAllBossAsBoss() then
		FloatWordMgr.instance:show("您已通关,无需购买次数")

		return
	end

	if KdChallengeController.instance:isHaveTimesAsBoss() then
		FloatWordMgr.instance:show(lang("hongliannvhuangview__3"))

		return
	end

	if KdChallengeController.instance:isExceedLimitTimesAsBoss() then
		FloatWordMgr.instance:show(lang("hongliannvhuangview__6"))
	else
		self:_popSureBuyTimesWin()
	end
end

function KdChallengeBossView:_popSureBuyTimesWin()
	local buyCfg = KdChallengeConfig.instance:getKdBossBuyCfgByCId(self._challengeId)
	local limitBuyTimes = #buyCfg
	local challengeBuyTimes = KdChallengeModel.instance:getChallengeBuyTimesAsBoss()
	local challengeTimes = KdChallengeModel.instance:getChallengeTimesAsBoss()
	local leftTimes = limitBuyTimes - challengeBuyTimes
	local buyData = KdChallengeConfig.instance:getKdBossBuyDataByCId(self._challengeId, challengeBuyTimes + 1)

	if buyData then
		local matType, matId, matNum = MaterialMgr.getMatParams(buyData.cost)
		local iconContent = MaterialMgr.getContentMatCfg(matType, matId, 30, -5, MaterialMgr.ICON_TYPE_ICON)
		local content = langPara("hongliannvhuangview__5", matNum, iconContent, limitBuyTimes, leftTimes)

		local function handler()
			KdChallengeController.instance:sendPM_TQKingDragonBossBuyReq(self._challengeId)
		end

		TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, handler)
	end
end

return KdChallengeBossView
