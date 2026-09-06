-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/view/dominatechallenge/DominateChallengeBossView.lua

module("logic.extensions.kingdragonchallenge.view.dominatechallenge.DominateChallengeBossView", package.seeall)

local DominateChallengeBossView = class("DominateChallengeBossView", KdChallengeBossView)

function DominateChallengeBossView:ctor()
	DominateChallengeBossView.super.ctor(self)
end

function DominateChallengeBossView:unbindEvents()
	DominateChallengeBossView.super.unbindEvents(self)
end

function DominateChallengeBossView:bindEvents()
	DominateChallengeBossView.super.bindEvents(self)
end

function DominateChallengeBossView:buildUI()
	DominateChallengeBossView.super.buildUI(self)

	self._buffDesc = self:getTxt("buff/txtDesc")
	self._ruleDesc = goutil.findChildTextComponent(self.mainGO, "rule/txtDesc/Viewport/Content")
	self._con = goutil.findChild(self.mainGO, "con")
end

function DominateChallengeBossView:onEnter()
	self._challengeId = KdChallengeConfig.instance:getNuoyaCurChallengeId()

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeBossBuyRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeBossSweepRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeResultConfirmRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeBossGetPrizeRes, self._sendGetInfoReq, self)
	self:_sendGetInfoReq()

	local redId = RedPointModel.ID_NUOYA_LANDINGONCE_RED_BOSS

	KdChallengeController.instance:saveRedAsLandingOnce(redId, true)
	self:_setBuffIcon()

	self._sweepCallBack = nil
end

function DominateChallengeBossView:onExit()
	DominateChallengeBossView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	self._sweepCallBack = nil
end

function DominateChallengeBossView:_setBuffIcon()
	local challengeCfg = KdChallengeConfig.instance:getKdChallengeData(self._challengeId)
	local bossCfg = KdChallengeConfig.instance:getKdBossData(challengeCfg.planId)
	local dailyBuffCfg = KdChallengeConfig.instance:getDailyBuffCfgByPlan(bossCfg.dailyBuffPlanId)
	local timerDValue = ServerTime.now() - GameUtil.string2time(challengeCfg.openTime1)
	local days = GameUtil.getTimeDDHHMMSS(timerDValue) + 1
	local buffIconCfg = KdChallengeConfig.instance:getKdBuffData(dailyBuffCfg[days].buffId)

	self._buffDesc.text = buffIconCfg.des
end

function DominateChallengeBossView:_onClickBtnChallenge()
	if KdChallengeController.instance:isPassNuoyaAllBossAsBoss() then
		FloatWordMgr.instance:show("已通关")

		return
	end

	if not KdChallengeController.instance:isHaveTimesAsNuoyaBoss() then
		if KdChallengeController.instance:isExceedLimitTimesAsNuoyaBoss() then
			FloatWordMgr.instance:show("已达今日挑战上限")
		else
			self:_onClickBtnAddInRemain()
		end

		return
	end

	if KdChallengeController.instance:isEnoughSweepAsNuoyaBoss() then
		local text = "已满足扫荡要求,可以进行扫荡"

		local function func()
			KdChallengeController.instance:sendPM_TQKingDragonBossSweepReq(self._challengeId)

			function self._sweepCallBack()
				FloatWordMgr.instance:show("恭喜你，扫荡成功")

				self._sweepCallBack = nil
			end
		end

		local btnText = "确认"
		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade.instance:openTipWindow("提示", text, func, btnText, alignment)
	else
		KdChallengeModel.instance:clearViewInfos()
		KdChallengeModel.instance:addViewInfo(ViewName.DominateChallengeMainView)
		KdChallengeModel.instance:addViewInfo(self._viewPresentor.viewName)
		KdChallengeController.instance:enterBattleAsKd(GameEnum.KingDragonType.Boss)
	end
end

function DominateChallengeBossView:_onSetUI()
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

	local itemsStr = KdChallengeConfig.instance:getNuoyaShowResource()

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

	local ruleData = RulesConfig.instance:getRuleCo("zhuzainuoya_rule_1_1")

	if ruleData then
		self._ruleDesc.text = ruleData.rules
	end

	if ruleData then
		self._txtTitle.text = ruleData.title
	end

	local skinId = KdChallengeConfig.instance:getNuoyaCurSkinId()

	self._role = RoleObjectPool.instance:removeRole(self._role)
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, function()
		GameUtil.setLocalRotation(self._role.asset, 0, 0, 0)
	end, true, nil, nil)
end

function DominateChallengeBossView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("zhuzainuoya_rule_1")
end

function DominateChallengeBossView:_onUpdatePlaneUI()
	local bossData = KdChallengeConfig.instance:getKdBossDataByCId(self._challengeId)
	local leftTimes = KdChallengeController.instance:getNuoyaLeftTimesAsBoss()
	local totalTimes = bossData.freeDailyTimes

	self._txtRemain.text = string.format("本日次数：%d/%d", leftTimes, totalTimes)

	local isPassAll = KdChallengeController.instance:isPassNuoyaAllBossAsBoss()
	local isEnoughSweep = KdChallengeController.instance:isEnoughSweepAsNuoyaBoss()

	self._txtBtnChallenge.text = isPassAll and "已通关" or isEnoughSweep and "开始扫荡" or "进入挑战"
end

function DominateChallengeBossView:_onClickBtnAddInRemain()
	if KdChallengeController.instance:isPassNuoyaAllBossAsBoss() then
		FloatWordMgr.instance:show("您已通关,无需购买次数")

		return
	end

	if KdChallengeController.instance:isHaveTimesAsBoss() then
		FloatWordMgr.instance:show(lang("hongliannvhuangview__3"))

		return
	end

	if KdChallengeController.instance:isExceedLimitTimesAsNuoyaBoss() then
		FloatWordMgr.instance:show(lang("hongliannvhuangview__6"))
	else
		self:_popSureBuyTimesWin()
	end
end

function DominateChallengeBossView:_updatePrizeCell(mainGo, data)
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local received = goutil.findChild(mainGo, "received")
	local getNum = goutil.findChildTextComponent(mainGo, "getNum")
	local txtNum = goutil.findChildTextComponent(mainGo, "txtNum")
	local isCanGet = KdChallengeController.instance:isCanGetPrizeAsNuoyaBoss(data.id)
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

function DominateChallengeBossView:_onUpdateData()
	if self._sweepCallBack then
		GameUtil.callBack(self._sweepCallBack)
	end
end

return DominateChallengeBossView
