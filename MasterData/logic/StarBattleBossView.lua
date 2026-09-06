-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/view/StarBattleBossView.lua

module("logic.extensions.starbattle.view.StarBattleBossView", package.seeall)

local StarBattleBossView = class("StarBattleBossView", ViewComponent)

function StarBattleBossView:ctor()
	StarBattleBossView.super.ctor(self)
end

function StarBattleBossView:unbindEvents()
	StarBattleBossView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnFight1)
	GameUtil.rmClickHandler(self._btnFight2)
	GameUtil.rmClickHandler(self._btnFight)
end

function StarBattleBossView:bindEvents()
	StarBattleBossView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnFight1, GameUtil.handler(self._onClickFight, self, 1))
	GameUtil.addClickHandler(self._btnFight2, GameUtil.handler(self._onClickFight, self, 2))
	GameUtil.addClickHandler(self._btnFight, GameUtil.handler(self._onClickFight, self, 1))
end

function StarBattleBossView:buildUI()
	StarBattleBossView.super.buildUI(self)

	self._doubleboss = self:getGo("doubleboss")
	self._roleCon = self:getGo("oneBoss/roleCon")
	self._oneBoss = self:getGo("oneBoss")
	self._btnFight1 = self:getGo("doubleboss/btnFight1")
	self._btnFight2 = self:getGo("doubleboss/btnFight2")
	self._btnFight = self:getGo("oneBoss/btnFight")
	self._verRaceCellList = {}

	for i = 1, 2 do
		local cell = {}

		cell.go = self:getGo("verRaces/items/item_" .. i)
		cell.icon = goutil.findChild(cell.go, "icon")
		cell.txtTag = goutil.findChildTextComponent(cell.go, "tag/txt")
		cell.proxy = nil

		table.insert(self._verRaceCellList, cell)
	end

	local cellProgress = self:getGo("prize/cell")
	local tabProgress = self:getGo("prize/tableview")

	self._tableviewProgress = ScrollerList.create(tabProgress, cellProgress, GameUtil.handler(self._updateProgressCell, self), GameUtil.handler(self._clearProgressCell, self))
	self._progressBar = self:getSlider("prize/tableview/viewport/content/progressBar")
	self._txtNumDamage = self:getTxt("prize/damageNum/txtNum")
	self._txtRule = self:getTxt("rule/txt")
	self._txtScoreOne = self:getTxt("oneBoss/score/txt")
	self._txtTimesOne = self:getTxt("oneBoss/times/txt")
	self._txtScoreDouble = self:getTxt("doubleboss/score/txt")
	self._txtTimesDouble = self:getTxt("doubleboss/times/txt")
	self._txtDamage1 = self:getTxt("doubleboss/damage1/txt")
	self._txtDamage2 = self:getTxt("doubleboss/damage2/txt")
end

function StarBattleBossView:onExit()
	StarBattleBossView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	for _, cell in ipairs(self._verRaceCellList) do
		MaterialMgr.instance:resetAll(cell.icon)

		cell.proxy = nil
	end

	self._tableviewProgress:dispose()
end

function StarBattleBossView:onEnter()
	StarBattleBossView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_StarBattleGetInfo, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_StarBattleVerifyRace, self._handleVerifyRace, self)
	self.addGEvent(self, GlobalNotify.PM_StarBattleGainProgressPrize, self._updatePrizes, self)

	self._activityId = 510001
	self._periodId = 1

	local params = self:getOpenParam()

	if params then
		if params[1] then
			self._activityId = checknumber(params[1])
		end

		self._periodId = StarBattleController.instance:getCurrentPeriodId(self._activityId)
	end

	StarBattleController.instance:getInfo(self._activityId, self._periodId)
	self:_updateUIByCfg()
	self:_updateUIByInfo()

	self._isNeedCheckVerRaceIds = true

	StarBattleController.instance:recordLastTab(self._activityId, self._periodId, 3)
end

function StarBattleBossView:_updateUIByCfg()
	self._curActCfg = StarBattleConfig.instance:getActCfg(self._activityId)
	self._periodCfg = StarBattleConfig.instance:getPeriodCfg(self._activityId, self._periodId)
	self._bossPrizeCfgs = StarBattleConfig.instance:getBossProgressPrizeCfgs(self._periodCfg.progressPlanId)
	self._verRaceCfgs = StarBattleConfig.instance:getFormationRaceCfgs(self._periodCfg.formationRacePlanId) or {}
	self._stageCfgs = StarBattleConfig.instance:getStageCfgs(self._periodCfg.stagePlanId) or {}
	self._bossCfgs = StarBattleConfig.instance:getBossCfgs(self._periodCfg.bossPlanId) or {}
	self._firstBossCfg = self._bossCfgs and self._bossCfgs[1]

	local skinId = checknumber(self._firstBossCfg.bossLihui)

	if skinId > 0 then
		local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("drawing", skinId)

		self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._roleCon, displayBagOffset[3], nil, true, displayBagOffset[1], displayBagOffset[2])
	end

	goutil.setActive(self._doubleboss, #self._bossCfgs > 1)
	goutil.setActive(self._roleCon, #self._bossCfgs == 1)
	goutil.setActive(self._oneBoss, #self._bossCfgs == 1)

	for i, cell in ipairs(self._verRaceCellList) do
		local cfg = self._verRaceCfgs[i]

		if cfg then
			goutil.setActive(cell.go, true)

			cell.proxy = MaterialMgr.setCell(MatType.Pet, cfg.raceId, cell.icon)
			cell.txtTag.text = string.format("+%s%%", cfg.scorePercent)
		else
			goutil.setActive(cell.go, false)
			MaterialMgr.instance:resetAll(cell.icon)

			cell.txtTag.text = ""
			cell.proxy = nil
		end
	end

	self._txtRule.text = self._periodCfg.bossRuleDesc or ""
	self._timeLimit = self._curActCfg.dailyChallengeBossTimes or 1
end

function StarBattleBossView:_updateUIByInfo()
	self:_updateVerRaceIds()
	self:_updatePrizes()
	self:_updateClgInfo()
end

function StarBattleBossView:_updateVerRaceIds()
	self._verRaceIdMap = {}

	local info = StarBattleModel.instance:getBaseInfo(self._activityId, self._periodId)

	if info then
		if not info.verifiedRaceId then
			for _, raceId in ipairs(info.verifiedRaceId) do
				self._verRaceIdMap[raceId] = true
			end

			if self._isNeedCheckVerRaceIds then
				self:_checkVerRaceIds()
			end
		end
	end

	for i, cell in ipairs(self._verRaceCellList) do
		local cfg = self._verRaceCfgs[i]

		if cfg then
			if not self._verRaceIdMap[cfg.raceId] then
				if cell.proxy then
					if self._verRaceIdMap[cfg.raceId] then
						cell.proxy:setGray(false)
						cell.proxy.binder:setAutoTips(true)
						cell.proxy.binder:setCallBack(nil)
					else
						local para = string.format("%s:%s", MatType.Pet, cfg.raceId)

						cell.proxy.binder:setAutoTips(false)
						cell.proxy:setCallBack(function()
							MaterialMgr.openGetSourceByStr(para)
						end)
						cell.proxy:setGray(true)
					end
				end
			end
		end
	end
end

function StarBattleBossView:_handleVerifyRace()
	self._isNeedCheckVerRaceIds = true

	self:_updateVerRaceIds()
	self:_updateClgInfo()
end

function StarBattleBossView:_updateClgInfo()
	self._totalScore = 0
	self._todayChallengeBossTimes = 0
	self._firstDoubleBossDamage = -1
	self._secondDoubleBossDamage = -1
	self._isAllPassStage = false

	local info = StarBattleModel.instance:getBaseInfo(self._activityId, self._periodId)

	if info then
		self._totalScore = checknumber(info.maxBossScore) or 0
		self._todayChallengeBossTimes = info.todayChallengeBossTimes or 0
		self._firstDoubleBossDamage = checknumber(info.firstDoubleBossDamage) or -1
		self._secondDoubleBossDamage = checknumber(info.secondDoubleBossDamage) or -1

		if not info.maxPassStageId then
			local maxPassStageId = 0

			self._isAllPassStage = maxPassStageId >= #self._stageCfgs
		end
	end

	self._curLeftTime = self._timeLimit - self._todayChallengeBossTimes
	self._txtTimesOne.text = string.format("今日次数：%s/%s", self._curLeftTime, self._timeLimit)
	self._txtTimesDouble.text = string.format("今日次数：%s/%s", self._todayChallengeBossTimes, self._timeLimit)
	self._txtScoreOne.text = self._totalScore
	self._txtScoreDouble.text = self._totalScore
	self._txtDamage1.text = self:_formatNum(self._firstDoubleBossDamage)
	self._txtDamage2.text = self:_formatNum(self._secondDoubleBossDamage)
end

function StarBattleBossView:_checkVerRaceIds()
	self._isNeedCheckVerRaceIds = false

	if not self._verRaceCfgs or #self._verRaceCfgs <= 0 then
		return
	end

	for i, cfg in ipairs(self._verRaceCfgs) do
		if not self._verRaceIdMap[cfg.raceId] and BagPetsController.instance:getPetNumByRaceId(cfg.raceId) > 0 then
			StarBattleController.instance:verifyRace(self._activityId, cfg.raceId, self._periodId)

			return
		end
	end
end

function StarBattleBossView:_checkCanFight(bossId)
	if self._curLeftTime <= 0 then
		TipsFacade.instance:openCommonTips("今日挑战次数已用完，请明天再来挑战！")

		return false
	end

	if not self._isAllPassStage then
		TipsFacade.instance:openCommonTips("请先通关反击精英所有关卡，再来挑战BOSS！")

		return false
	end

	if #self._bossCfgs > 1 then
		if bossId == 1 and self._firstDoubleBossDamage > -1 then
			TipsFacade.instance:openCommonTips("请继续挑战第二个双生BOSS,完成此次挑战！")

			return false
		elseif bossId == 2 and self._secondDoubleBossDamage > -1 then
			TipsFacade.instance:openCommonTips("请继续挑战第一个双生BOSS,完成此次挑战！")

			return false
		end
	end

	return true
end

function StarBattleBossView:_onClickFight(bossId)
	if self:_checkCanFight(bossId) then
		StarBattleController.instance:showBossMissionView(self._activityId, self._periodId, bossId)
	end
end

function StarBattleBossView:_updatePrizes()
	self._totalBossDamage = 0
	self._todayChallengeBossTimes = 0
	self._hasGainBossProgressMap = {}

	local info = StarBattleModel.instance:getBaseInfo(self._activityId, self._periodId)

	if info then
		self._totalBossDamage = checknumber(info.totalBossDamage) or 0
		self._todayChallengeBossTimes = info.todayChallengeBossTimes or 0

		if not info.hasGainBossProgressIds then
			do
				local hasGainBossProgressIds = {}

				for _, prizeId in ipairs(hasGainBossProgressIds) do
					self._hasGainBossProgressMap[prizeId] = true
				end
			end

			local showIndex = -1
			local lastIndex = -1
			local scoreList = {}

			for i, v in ipairs(self._bossPrizeCfgs) do
				if checknumber(v.totalDamage) <= self._totalBossDamage then
					if not self._hasGainBossProgressMap[i] then
						if showIndex <= 0 then
							showIndex = i
						end
					else
						lastIndex = i
					end
				end

				table.insert(scoreList, checknumber(v.totalDamage))
			end

			if lastIndex <= 0 then
				lastIndex = 1
			end

			if showIndex <= 0 then
				showIndex = lastIndex
			end

			self._tableviewProgress:updateUnderSlider(self._progressBar, self._totalBossDamage, scoreList)
			self._tableviewProgress:reloadData(self._bossPrizeCfgs)
			self._tableviewProgress:MoveCellToBegin(showIndex - 1)

			self._txtNumDamage.text = self:_formatNum(self._totalBossDamage)
		end
	end
end

function StarBattleBossView:_formatNum(num)
	local num = checknumber(num)

	num = Mathf.Max(num, 0)

	if num >= 100000000 then
		if num % 100000000 == 0 then
			return string.format("%.0f亿", num / 100000000)
		end

		return string.format("%.2f亿", num / 100000000)
	elseif num >= 10000 then
		if num % 10000 == 0 then
			return string.format("%.0f万", num / 10000)
		end

		return string.format("%.2f万", num / 10000)
	else
		return tostring(num)
	end
end

function StarBattleBossView:_updateProgressCell(view, cell, data)
	local item = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.setCellByCfg(data.prize, item)

	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")

	txtNum.text = self:_formatNum(data.totalDamage)

	if not self._hasGainBossProgressMap[data.progressId] then
		local isGain = false
		local isMatchGain = not isGain and self._totalBossDamage >= checknumber(data.totalDamage)
		local btnGet = goutil.findChild(cell.gameObject, "btnGet")

		goutil.setActive(btnGet, isMatchGain)

		local effect = goutil.findChild(cell.gameObject, "effect")

		if isMatchGain then
			self:_playCellEffect(effect)
			GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGainPrize, self, data.progressId))
		else
			self:_clearCellEffect(effect)
		end

		local geted = goutil.findChild(cell.gameObject, "geted")

		goutil.setActive(geted, isGain)
	end
end

function StarBattleBossView:_clearProgressCell(cell)
	local item = goutil.findChild(cell.gameObject, "item")

	if item then
		MaterialMgr.resetAll(item)
	end

	local btnGet = goutil.findChild(cell.gameObject, "btnGet")

	if btnGet then
		GameUtil.rmClickHandler(btnGet)
	end

	local effect = goutil.findChild(cell.gameObject, "effect")

	if effect then
		self:_clearCellEffect(effect)
	end
end

function StarBattleBossView:_onClickGainPrize(progressId)
	StarBattleController.instance:gainProgressPrize(self._activityId, progressId, self._periodId)
end

function StarBattleBossView:_playCellEffect(effGo)
	self:_clearCellEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("prize/tableview/viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScaleXYZ(0.96, 1, 0.87)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function StarBattleBossView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

return StarBattleBossView
