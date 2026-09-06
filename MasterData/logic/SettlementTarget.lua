-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/SettlementTarget.lua

module("logic.extensions.battlesettlement.view.SettlementTarget", package.seeall)

local SettlementTarget = class("SettlementTarget", BSAnimPlay)
local json = require("cjson")

SettlementTarget.Colors = {
	Common = "FFFFFF",
	Sucess = "99FFB0",
	Fail = "EC6941"
}

function SettlementTarget:buildUI(parent)
	SettlementTarget.super.buildUI(self, parent)

	self._imgBgTarget = goutil.findChild(parent, "imgBgTarget"):GetComponent(goutil.Type_RectTransform)
	self._element = goutil.findChild(parent, "element")

	self._element:SetActive(false)

	self._txtDesc = goutil.findChildTextComponent(parent, "element/txtDesc")
	self._scrollRectAdapter = Framework.ScrollRectAdapter.GetFrom(parent, "scrollList")
	self._scrollRect = goutil.findChild(parent, "scrollList"):GetComponent(goutil.Type_RectTransform)
	self._contentRect = goutil.findChild(parent, "scrollList/Viewport/Content"):GetComponent(goutil.Type_RectTransform)
	self._btnStatics = Framework.ButtonAdapter.GetFrom(parent, "imgBgTarget/btnStatics")
	self._titleHeight = 50
	self._preHeight = 5
	self._lastHeight = self._preHeight
	self._postHeight = 10
	self._unitHeight = 40
	self._extraPreHeight = 5
	self._rowLimitLen = 43
end

function SettlementTarget:destroyUI()
	self._parent = nil
	self._parentRectTrans = nil
end

function SettlementTarget:bindEvents()
	self._btnStatics:AddClickListener(self._onClickStatics, self)
end

function SettlementTarget:unbindEvents()
	self._btnStatics:RemoveClickListener()
end

function SettlementTarget:onEnter(totalHeight, curPosY, delayTime, isSuccess)
	SettlementTarget.super.onEnter(self, totalHeight, curPosY, delayTime)

	if self._isEntered then
		return self:_getDefault()
	end

	self._isEntered = true
	self._isSuccess = isSuccess
	self._lastHeight = self._preHeight

	self:_setStaticsActive(not isSuccess)
	goutil.setActive(self._parent, true)

	self._curViewDatas = {}
	self._targetConditionItems = {}

	local list = BattleSettlementController.instance:getElements()

	if list and #list > 0 then
		self:_customizeCondition(list)
		BattleSettlementController.instance:clearElements()
	else
		self:_setConditions()
		self:_loadList()
	end

	return self:getNextData()
end

function SettlementTarget:_customizeCondition(list)
	self._curTime = self._time1
	self._curDelay = self._delayTime1 + self:_getCurTimePoint()

	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 1500, 0)
	self._imgBgTarget:DOAnchorPosX(0, self._curTime):SetDelay(self._curDelay)

	for i, v in ipairs(list) do
		table.insert(self._curViewDatas, v)
	end

	for i, v in ipairs(self._curViewDatas) do
		v.posY = self:_getPosY(i)
		v.curTime = self._curTime

		self:_updateCurDelay()

		v.curDelay = self._curDelay

		local go = goutil.cloneAndSetParent(self._element, self._contentRect.transform, "item" .. tostring(i))

		go:SetActive(true)

		local conditionItem = GameUtil.AddLuaOnce(go, TargetConditionItem)

		conditionItem:init(go, v)
		table.insert(self._targetConditionItems, conditionItem)
	end

	self:_setContentHeight()
	self:_resetContentPos()
end

function SettlementTarget:onExit()
	self._isEntered = false

	self:doKillTween()
	self:_clearList()
	goutil.setActive(self._parent, false)
end

function SettlementTarget:_updateCurDelay()
	self._curDelay = self._curDelay + self._delayTime1
end

function SettlementTarget:_getPosY(index)
	local count = index >= 1 and index or 1

	if index > 1 then
		local preData = self._curViewDatas[index - 1]

		if preData then
			self._txtDesc.text = preData.txtDesc

			local h = self._txtDesc.preferredHeight
			local posY = -1 * (self._lastHeight + math.max(30, h) + 3)

			self._lastHeight = -posY

			return posY
		end
	end

	local posY = -1 * (self._preHeight + (count - 1) * self._unitHeight)

	self._lastHeight = -posY

	return posY
end

function SettlementTarget:_getColorStr(bValue)
	return (bValue or nil) and (SettlementTarget.Colors.Sucess or SettlementTarget.Colors.Fail)
end

function SettlementTarget:_setConditions()
	self._curTime = self._time1
	self._curDelay = self._delayTime1 + self:_getCurTimePoint()

	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 1500, 0)
	self._imgBgTarget:DOAnchorPosX(0, self._curTime):SetDelay(self._curDelay)

	local settlementType = BattleSettlementModel.instance:getType()
	local param = BattleSettlementModel.instance:getParams()

	print("lbc-------------------------------           撒情况 = ", settlementType, BattleSettlementModel.Enum.LailisiChanllenge)

	if settlementType == BattleSettlementModel.Enum.ResCopy then
		self:_setResCopyConditions()
	elseif settlementType == BattleSettlementModel.Enum.Endless then
		self:_setEndlessConditions()
	elseif settlementType == BattleSettlementModel.Enum.HolyChall then
		self:_setHolyChallConditions()
	elseif settlementType == BattleSettlementModel.Enum.FamilyTeamplay then
		self:_setFamilyTeamplayConditions()
	elseif settlementType == BattleSettlementModel.Enum.Fengbaobao then
		self:_setFengbaobaoConditions()
	elseif settlementType == BattleSettlementModel.Enum.NianNianChall then
		self:_setNianNianConditions()
	elseif settlementType == BattleSettlementModel.Enum.HalloweenBoss then
		self:_setHalloweenBossConditions()
	elseif settlementType == BattleSettlementModel.Enum.WroldBoss then
		self:_setWorldConditions()
	elseif settlementType == BattleSettlementModel.Enum.FamilyWar then
		self:_setFamilyWarConditions()
	elseif settlementType == BattleSettlementModel.Enum.ViretaActivity then
		self:_setViretaActivityConditions()
	elseif settlementType == BattleSettlementModel.Enum.LailisiChanllenge then
		self:_setLailisiActivityCoditions()
	elseif settlementType == BattleSettlementModel.Enum.GodDiShiTian then
		if param and param.isShowBossHp then
			self:_setGodDishitianConditions()
		else
			self:_setDefaultConditions()
		end
	elseif settlementType == BattleSettlementModel.Enum.GodARuiShi then
		self:_setGodARuiShiCoditions()
	elseif settlementType == BattleSettlementModel.Enum.KingDragonChallenge then
		self:_setKingDragonChallengeCoditions()
	elseif settlementType == BattleSettlementModel.Enum.CORBossChallenge then
		self:_setCORBossChallengeCoditions()
	elseif settlementType == BattleSettlementModel.Enum.PeakTournamentFight then
		self:_setPeakTournamentFightCoditions()
	elseif settlementType == BattleSettlementModel.Enum.KingCiYuanChallenge then
		self:_setKCYBossChallengeCondition()
	elseif settlementType == BattleSettlementModel.Enum.DoDragonBossChallenge then
		self:_setDoDragonBossChallengeCondition()
	elseif settlementType == BattleSettlementModel.Enum.NeverLandAttackChallenge then
		if param then
			self:_setNeverLandAttackChallengeCondition(param)
		else
			self:_setDefaultConditions()
		end
	elseif settlementType == BattleSettlementModel.Enum.NeverLandDefendChallenge then
		if param then
			self:_setNeverLandDefendChallengeCondition(param)
		else
			self:_setDefaultConditions()
		end
	elseif settlementType == BattleSettlementModel.Enum.EternalChallenge then
		self:_setEternalChallengeCondition()
	elseif settlementType == BattleSettlementModel.Enum.FanRuiChallenge then
		self:_setFanRuiChallengeCondition()
	elseif settlementType == BattleSettlementModel.Enum.DivineCiYuanNationChallenge then
		self:_setDivineCiYuanChallengeCondition(param)
	elseif settlementType == BattleSettlementModel.Enum.KunLunChallengeNormal then
		self:_setKunLunChallengeNormalCoditions()
	elseif settlementType == BattleSettlementModel.Enum.NightFeastBoss then
		self:_setNightFeastBossCondition(param)
	elseif settlementType == BattleSettlementModel.Enum.GodStatuesWar then
		local fightType = BattleModel.instance.StartGodStatuesWarFightType

		if fightType == GswEnum.FightType_Normal then
			self:_setGodStatuesWarCondition()
		elseif fightType == GswEnum.FightType_Vieo then
			self:_setDefaultConditions()
		end
	elseif settlementType == BattleSettlementModel.Enum.DragonKingARuiShiClg then
		self:_setDragonKingARuiShiCondition(param)
	elseif settlementType == BattleSettlementModel.Enum.DivineGasiri then
		self:_setDivineGasiriCondition(param)
	elseif settlementType == BattleSettlementModel.Enum.AngelPower then
		self:_setAngelPowerCondition(param)
	elseif settlementType == BattleSettlementModel.Enum.YoungChampionKingQualifier then
		self:_setYoungChampionKingQualifierCondition(param)
	elseif settlementType == BattleSettlementModel.Enum.DivineDakinosClg then
		self:_setDivineDakinosClgCondition(param)
	else
		self:_setDefaultConditions()
	end
end

function SettlementTarget:_setResCopyConditions()
	local conditionType = BattleModel.instance:getConditionType()
	local conditionParams = BattleModel.instance:getConditionParams()

	if conditionType == GameEnum.Evaluate.Combination then
		local index = 1
		local jConditionParams = GameUtil.jsonToTable(conditionParams)

		for id, singleConditionParam in pairs(jConditionParams) do
			local cfgWinnerOp = BattleSettlementConfig.instance:getBattleWinnerOpCfgById(checknumber(id))

			if cfgWinnerOp then
				index = self:_addSpecialCondition(index, cfgWinnerOp.type, singleConditionParam, cfgWinnerOp.params, cfgWinnerOp.desc)
			end
		end
	else
		local params = BattleSettlementModel.instance:getParams()
		local oldStageEvaluate = checknumber(params.oldStageEvaluate)
		local newStageEvaluate = 0
		local winId = params.winId
		local cfg = BattleSettlementConfig.instance:getBattleWinnerOpTypeCfgById(winId)

		if cfg and cfg.type == conditionType then
			local jConditionParams = GameUtil.jsonToTable(conditionParams)

			newStageEvaluate = jConditionParams[cfg.paramNames[1]]

			local isExistNew = oldStageEvaluate < jConditionParams[cfg.paramNames[1]]

			if isExistNew then
				local element1 = {}

				element1.txtDesc = string.format(cfg.desc, newStageEvaluate)
				element1.isReach = nil
				element1.isNewRecord = true
				element1.posY = self:_getPosY(1)
				element1.curTime = self._curTime

				self:_updateCurDelay()

				element1.curDelay = self._curDelay

				local element2 = {}

				element2.txtDesc = string.format(cfg.desc, oldStageEvaluate)
				element2.isReach = nil
				element2.isNewRecord = false
				element2.posY = self:_getPosY(2)
				element2.curTime = self._curTime

				self:_updateCurDelay()

				element2.curDelay = self._curDelay

				table.insert(self._curViewDatas, element1)
				table.insert(self._curViewDatas, element2)
			else
				local element1 = {}

				element1.txtDesc = string.format(cfg.desc, newStageEvaluate)
				element1.isReach = true
				element1.posY = self:_getPosY(1)
				element1.curTime = self._curTime

				self:_updateCurDelay()

				element1.curDelay = self._curDelay

				table.insert(self._curViewDatas, element1)
			end
		end
	end
end

function SettlementTarget:_setDefaultConditions()
	printInfo("test SettlementTarget:_setDefaultConditions")

	local conditionType = BattleModel.instance:getConditionType()
	local index = 1

	index = not string.nilorempty(conditionType) and conditionType ~= GameEnum.Evaluate.BuffNum and conditionType ~= GameEnum.Evaluate.EnemyBuffNum and self:_setSpecialCondition(index, conditionType) or self:_setCommonCondition(index)

	self:_setPerfectCondition(index)
end

function SettlementTarget:_setWorldConditions()
	self:_setDefaultConditions()

	local info = WorldBossController.instance._infoAfterChallenge

	if info then
		local value = checknumber(info.processorSection)

		self:addConditionEle(langPara("火力值达到<color=#eb4642>%s</color>", value), value > 0)
	end
end

function SettlementTarget:addConditionEle(desc, isReach)
	local element1 = {}

	element1.txtDesc = desc
	element1.isReach = isReach
	element1.posY = self:_getPosY(#self._curViewDatas + 1)
	element1.curTime = self._curTime

	self:_updateCurDelay()

	element1.curDelay = self._curDelay

	table.insert(self._curViewDatas, element1)
end

function SettlementTarget:_setHalloweenBossConditions()
	local element1 = {}
	local value = HalloweenGuestModel.instance._bossBattleDamage

	element1.txtDesc = langPara("text_halloween_desc_1", value)
	element1.isReach = nil
	element1.posY = self:_getPosY(1)
	element1.curTime = self._curTime

	self:_updateCurDelay()

	element1.curDelay = self._curDelay

	table.insert(self._curViewDatas, element1)
end

function SettlementTarget:_setEndlessConditions()
	local element1 = {}
	local defendCount = EndlessBattleController.instance:getDefendCount()

	element1.txtDesc = string.format("累计防守<color=#%s>%s</color>波", SettlementTarget.Colors.Sucess, defendCount)
	element1.isReach = nil
	element1.posY = self:_getPosY(1)
	element1.curTime = self._curTime

	self:_updateCurDelay()

	element1.curDelay = self._curDelay

	table.insert(self._curViewDatas, element1)
end

function SettlementTarget:_setHolyChallConditions()
	local element1 = {}
	local params = BattleSettlementModel.instance:getParams()

	element1.txtDesc = string.format("今日对圣光飞龙BOSS造成伤害 <color=#%s>(%s/%s)</color>", SettlementTarget.Colors.Sucess, params.haveStr, params.allStr)
	element1.isReach = nil
	element1.posY = self:_getPosY(1)
	element1.curTime = self._curTime

	self:_updateCurDelay()

	element1.curDelay = self._curDelay

	table.insert(self._curViewDatas, element1)
end

function SettlementTarget:_setFamilyTeamplayConditions()
	if BattleModel.instance.isFamilyTeamPlayPractice then
		self:_setDefaultConditions()

		return
	else
		local element1 = {}
		local info = FamilyteamplayModel.instance:getEndBattleInfo()
		local damage = checknumber(info.battleBossDamage)

		element1.txtDesc = string.format("对敌方精灵造成总伤害<color=#%s>%s</color>", SettlementTarget.Colors.Fail, damage)
		element1.isReach = nil
		element1.posY = self:_getPosY(1)
		element1.curTime = self._curTime

		self:_updateCurDelay()

		element1.curDelay = self._curDelay

		table.insert(self._curViewDatas, element1)
	end
end

function SettlementTarget:_setFengbaobaoConditions()
	local element1 = {}
	local ratio = FamilyteamplayModel.instance:getEndBattleHpRatio()
	local ratio2 = math.ceil(ratio)

	if ratio < ratio2 and ratio2 >= 100 then
		ratio2 = 99
	end

	element1.txtDesc = string.format("Boss剩余血量%s", ratio2 .. "%")
	element1.isReach = nil
	element1.posY = self:_getPosY(1)
	element1.curTime = self._curTime

	self:_updateCurDelay()

	element1.curDelay = self._curDelay

	table.insert(self._curViewDatas, element1)
end

function SettlementTarget:_setNianNianConditions()
	local element1 = {}

	element1.txtDesc = "击败敌阵精灵"
	element1.isReach = self._isSuccess
	element1.posY = self:_getPosY(1)
	element1.curTime = self._curTime

	self:_updateCurDelay()

	element1.curDelay = self._curDelay

	local element2 = {}

	element2.txtDesc = "念念必须存活"

	local enemys = BattleModel.instance:getEnemyUnits()
	local alive = false
	local supportCfg = NianNianChallModel.instance:getSupportPetCfg()
	local raceId = supportCfg and checknumber(supportCfg.raceId) or -1

	for k, v in pairs(enemys) do
		if v.attrs:getOriginRaceId() == raceId then
			alive = not v:isDead()
		end
	end

	element2.isReach = alive
	element2.posY = self:_getPosY(2)
	element2.curTime = self._curTime

	self:_updateCurDelay()

	element2.curDelay = self._curDelay

	table.insert(self._curViewDatas, element2)
end

function SettlementTarget:_setFamilyWarConditions()
	local endInfo = FamilyWarModel.instance:getNestBattleInfo()

	if endInfo == nil or #endInfo == 0 then
		self:_setDefaultConditions()

		return
	end

	for i = 1, #endInfo do
		local element = {}

		element.txtDesc = endInfo[i].desc
		element.isReach = endInfo[i].isFinish
		element.posY = self:_getPosY(i)
		element.curTime = self._curTime

		self:_updateCurDelay()

		element.curDelay = self._curDelay

		table.insert(self._curViewDatas, element)
	end
end

function SettlementTarget:_setViretaActivityConditions()
	local endKillScore, isWin = InfinitefutureModel.instance:getVretaKillScore()

	if isWin then
		if not (InfinitefutureModel.instance.curStageId - 1) then
			local curStageId = InfinitefutureModel.instance.curStageId
			local winCondition = InfinitefutureConfig.instance:getStagePassCount(InfinitefutureModel.instance.viretaActIds[3], curStageId)

			if isWin then
				if not SettlementTarget.Colors.Sucess then
					local color = SettlementTarget.Colors.Fail
					local element = {}

					element.txtDesc = string.format("击败全部精灵且维蕾塔击杀数 <color=#%s>(%s%s)</color>", color, endKillScore, winCondition)
					element.isReach = isWin
					element.posY = self:_getPosY(1)
					element.curTime = self._curTime

					self:_updateCurDelay()

					element.curDelay = self._curDelay

					table.insert(self._curViewDatas, element)
				end
			end
		end
	end
end

function SettlementTarget:_setGodDishitianConditions()
	local enemyId = BattleModel.instance:getRightTeamId()
	local enemyTotalDefDamage = BattleStatisticsDataModel.instance:getTotalDefDamage(enemyId)
	local element = {}

	element.txtDesc = string.format("Boss获得总伤害：%d", enemyTotalDefDamage)
	element.isReach = true
	element.posY = self:_getPosY(1)
	element.curTime = self._curTime

	self:_updateCurDelay()

	element.curDelay = self._curDelay

	table.insert(self._curViewDatas, element)
end

function SettlementTarget:_setLailisiActivityCoditions()
	local taskShow = BattleSettlementModel.instance:getParams()
	local actInfo = LailisiModel.instance:getFinalActivity()
	local taskInfo = LailisiModel.instance:getTaskInfo(actInfo.activityId)
	local taskCfgs = LailisiConfig.instance:getTaskInfo(taskInfo.taskId)
	local damage = LailisiModel.instance:getDamage()

	if taskShow == nil or #taskShow == 0 then
		self:_setDefaultConditions()

		return
	end

	local element1 = {}

	element1.txtDesc = string.format("本次造成的伤害：%s", damage)
	element1.isReach = true
	element1.posY = self:_getPosY(1)
	element1.curTime = self._curTime

	self:_updateCurDelay()

	element1.curDelay = self._curDelay

	table.insert(self._curViewDatas, element1)

	for i, v in ipairs(taskShow) do
		if v.taskNum then
			local element = {}
			local cfg = taskCfgs[v.taskNum]

			element.txtDesc = string.format("%s(%s/%s)", cfg.resultDesc, v.progress, cfg.detectorParam)
			element.isReach = tonumber(v.progress) >= cfg.detectorParam
			element.posY = self:_getPosY(i + 1)
			element.curTime = self._curTime

			self:_updateCurDelay()

			element.curDelay = self._curDelay

			table.insert(self._curViewDatas, element)
		end
	end
end

function SettlementTarget:_setGodARuiShiCoditions()
	local taskShow = BattleSettlementModel.instance:getParams()

	if taskShow == nil then
		self:_setDefaultConditions()

		return
	end

	local damage = taskShow.damage
	local addScore = taskShow.addScore
	local element1 = {}

	if damage ~= nil then
		element1.txtDesc = string.format("本次造成的伤害：%s", checknumber(damage))
		element1.isReach = true
		element1.posY = self:_getPosY(1)
		element1.curTime = self._curTime

		self:_updateCurDelay()

		element1.curDelay = self._curDelay

		table.insert(self._curViewDatas, element1)
	else
		self:_setCommonCondition(1)
	end

	if addScore ~= nil then
		local element2 = {}

		element2.txtDesc = string.format("获得的生命精华：%s", checknumber(addScore))
		element2.isReach = true
		element2.posY = self:_getPosY(2)
		element2.curTime = self._curTime

		self:_updateCurDelay()

		element2.curDelay = self._curDelay

		table.insert(self._curViewDatas, element2)
	end
end

function SettlementTarget:_setKingDragonChallengeCoditions()
	local dmg = KdChallengeModel.instance:getBossDamageInFlg()
	local element = {}

	element.txtDesc = string.format("Boss获得总伤害：<color=#EC6941>%d</color>", dmg)
	element.isReach = true
	element.posY = self:_getPosY(1)
	element.curTime = self._curTime

	self:_updateCurDelay()

	element.curDelay = self._curDelay

	table.insert(self._curViewDatas, element)
end

function SettlementTarget:_setCORBossChallengeCoditions()
	local dmg = CantonOperaRoadModel.instance:getDmageAsCORBossChallenge()
	local element = {}

	element.txtDesc = string.format("Boss获得总伤害：<color=#EC6941>%d</color>", dmg)
	element.isReach = true
	element.posY = self:_getPosY(1)
	element.curTime = self._curTime

	self:_updateCurDelay()

	element.curDelay = self._curDelay

	table.insert(self._curViewDatas, element)
end

function SettlementTarget:_setPeakTournamentFightCoditions()
	local fightType = BattleModel.instance.PeakTournamentFightType

	if fightType == PeakTournamentController.FightType.QuaFight then
		local oldScore = PeakTournamentModel.instance:getRankScoreAsQua()
		local newScore = PeakTournamentModel.instance:getNewRankScoreAsQua()
		local element = {}

		element.txtDesc = string.format("积分变化：<color=#eb4624>%s</color>-><color=#20b376>%s</color>", oldScore, newScore)
		element.isReach = true
		element.posY = self:_getPosY(1)
		element.curTime = self._curTime

		self:_updateCurDelay()

		element.curDelay = self._curDelay

		table.insert(self._curViewDatas, element)
	elseif fightType == PeakTournamentController.FightType.EliFight then
		self:_setDefaultConditions()
	elseif fightType == PeakTournamentController.FightType.FightVieo then
		self:_setDefaultConditions()
	else
		self:_setDefaultConditions()
	end
end

function SettlementTarget:_setKCYBossChallengeCondition()
	local dmg = BattleSettlementModel.instance:getParams().damage or 0
	local element = {}

	element.txtDesc = langPara("造成伤害量：：<color=#EC6941>%s</color>", dmg)
	element.isReach = true
	element.posY = self:_getPosY(1)
	element.curTime = self._curTime

	self:_updateCurDelay()

	element.curDelay = self._curDelay

	table.insert(self._curViewDatas, element)
end

function SettlementTarget:_setDoDragonBossChallengeCondition()
	local dmg = DoDragonChallengeModel.instance:getDecHpAsBoss()
	local element = {}

	element.txtDesc = langPara("造成伤害量：：<color=#EC6941>%s</color>", dmg)
	element.isReach = true
	element.posY = self:_getPosY(1)
	element.curTime = self._curTime

	self:_updateCurDelay()

	element.curDelay = self._curDelay

	table.insert(self._curViewDatas, element)
end

function SettlementTarget:_setNeverLandAttackChallengeCondition(dmg)
	local element = {}

	element.txtDesc = langPara("伤害：<color=#EC6941>%s</color>", dmg)
	element.isReach = true
	element.posY = self:_getPosY(1)
	element.curTime = self._curTime

	self:_updateCurDelay()

	element.curDelay = self._curDelay

	table.insert(self._curViewDatas, element)
end

function SettlementTarget:_setNeverLandDefendChallengeCondition(score)
	local element = {}

	element.txtDesc = langPara("坚持回合数：<color=#EC6941>%s</color>", score)
	element.isReach = true
	element.posY = self:_getPosY(1)
	element.curTime = self._curTime

	self:_updateCurDelay()

	element.curDelay = self._curDelay

	table.insert(self._curViewDatas, element)
end

function SettlementTarget:_setEternalChallengeCondition()
	local activityId = EternalChallengeController.instance:getActivityId()

	if activityId <= 0 then
		return
	end

	local skinId = EternalChallengeController.instance:getSkinId(activityId)
	local petName = PetSkinConfig.instance:getPetSkinName(skinId)
	local element = {}
	local maxDmg = EternalChallengeConfig.instance:getEcClientCommonValue(activityId, "ETERNALCHALLENGE_BOSS_HP", true)
	local msg = EternalChallengeModel.instance:getFightEndResMsg()
	local curDmg = checknumber(msg and msg.damage)
	local isReach = maxDmg <= curDmg

	element.txtDesc = not isReach and string.format("击杀boss，造成<color=#%s>%d</color>/<color=#%s>%d</color>伤害", self:_getColorStr(false), curDmg, self:_getColorStr(true), maxDmg) or string.format("击杀boss，造成<color=#%s>%d</color>/<color=#%s>%d</color>伤害", self:_getColorStr(true), curDmg, self:_getColorStr(true), maxDmg)
	element.isReach = isReach
	element.posY = self:_getPosY(1)
	element.curTime = self._curTime

	self:_updateCurDelay()

	element.curDelay = self._curDelay

	table.insert(self._curViewDatas, element)

	local element = {}
	local isDead = true
	local units = BattleModel.instance:getUnits()

	for _, unit in ipairs(units) do
		if unit.modelId == skinId then
			isDead = unit:isDead()
		end
	end

	element.txtDesc = string.format("%s存活", petName)
	element.isReach = not isDead
	element.posY = self:_getPosY(2)
	element.curTime = self._curTime

	self:_updateCurDelay()

	element.curDelay = self._curDelay

	table.insert(self._curViewDatas, element)
end

function SettlementTarget:_setFanRuiChallengeCondition()
	self:_setCommonCondition(1)

	local params = BattleSettlementModel.instance:getParams()

	for i, v in ipairs(params) do
		local element = {}

		element.txtDesc = v.txtDesc
		element.isReach = v.isReach
		element.posY = self:_getPosY(i + 1)
		element.curTime = self._curTime

		self:_updateCurDelay()

		element.curDelay = self._curDelay

		table.insert(self._curViewDatas, element)
	end
end

function SettlementTarget:_setDivineCiYuanChallengeCondition(lefthp)
	local element = {}

	element.txtDesc = langPara("剩余血量：<color=#EC6941>%s</color>", lefthp)
	element.isReach = true
	element.posY = self:_getPosY(1)
	element.curTime = self._curTime

	self:_updateCurDelay()

	element.curDelay = self._curDelay

	table.insert(self._curViewDatas, element)
end

function SettlementTarget:_setKunLunChallengeNormalCoditions()
	local dmg = KunLunChallengeModel.instance:getDamageOfNorClg()
	local element = {}

	element.txtDesc = string.format("Boss获得总伤害：<color=#%s>%d</color>", SettlementTarget.Colors.Sucess, dmg)
	element.isReach = true
	element.posY = self:_getPosY(1)
	element.curTime = self._curTime

	self:_updateCurDelay()

	element.curDelay = self._curDelay

	table.insert(self._curViewDatas, element)

	local leftHp = KunLunChallengeModel.instance:getBossLeftHpOfNorClg()
	local element = {}

	element.txtDesc = string.format("Boss剩余血量：<color=#%s>%d%%</color>", SettlementTarget.Colors.Sucess, leftHp / 100)
	element.isReach = true
	element.posY = self:_getPosY(2)
	element.curTime = self._curTime

	self:_updateCurDelay()

	element.curDelay = self._curDelay

	table.insert(self._curViewDatas, element)
end

function SettlementTarget:_setNightFeastBossCondition(param)
	local element = {}
	local damageNum = param.curFightDamage

	element.txtDesc = string.format("对敌方精灵造成的总伤害 <color=#%s>%d</color>", SettlementTarget.Colors.Fail, damageNum)
	element.isReach = nil
	element.posY = self:_getPosY(1)
	element.curTime = self._curTime

	self:_updateCurDelay()

	element.curDelay = self._curDelay

	table.insert(self._curViewDatas, element)
end

function SettlementTarget:_setGodStatuesWarCondition()
	local beatFormCount = 0
	local seasonId = checknumber(BattleModel.instance.StartGodStatuesWarSeasonId)

	if seasonId > 0 then
		local msg = GodStatuesWarController.instance:getFightDivinePillarResMsg(seasonId)

		beatFormCount = checknumber(msg and msg.beatFormCount)
	end

	local element = {}

	element.txtDesc = string.format("本次破阵数量 <color=#20b376>%d</color>", beatFormCount)
	element.isReach = nil
	element.posY = self:_getPosY(1)
	element.curTime = self._curTime

	self:_updateCurDelay()

	element.curDelay = self._curDelay

	table.insert(self._curViewDatas, element)
end

function SettlementTarget:_setDragonKingARuiShiCondition(params)
	local element = {}
	local damageNum = BattleModel.instance:getTotalHurt(GameEnum.TargetType.Friend)
	local needDamageNum = params.needDamageNum
	local isReach = needDamageNum <= damageNum

	element.txtDesc = isReach and string.format("造成<color=#%s>%d</color>/<color=#%s>%d</color>伤害", self:_getColorStr(true), damageNum, self:_getColorStr(true), needDamageNum) or string.format("造成<color=#%s>%d</color>/<color=#%s>%d</color>伤害", self:_getColorStr(false), damageNum, self:_getColorStr(true), needDamageNum)
	element.isReach = isReach
	element.posY = self:_getPosY(1)
	element.curTime = self._curTime

	self:_updateCurDelay()

	element.curDelay = self._curDelay

	table.insert(self._curViewDatas, element)
end

function SettlementTarget:_setDivineGasiriCondition(params)
	local element1 = {}
	local enemys = BattleModel.instance:getEnemyUnits()
	local totalNum = 0
	local curNum = 0

	for k, v in pairs(enemys) do
		if not v.attrs:IsOraclePet() then
			totalNum = totalNum + 1

			if v.attrs:getCurHp() <= 0 then
				curNum = curNum + 1
			end
		end
	end

	if totalNum <= curNum then
		curNum = totalNum
		element1.txtDesc = string.format("击败敌阵全部精灵  <color=#%s>(%d/%d)</color>", SettlementTarget.Colors.Sucess, totalNum, totalNum)
		element1.isReach = true
	else
		element1.txtDesc = string.format("未击败敌阵全部精灵  <color=#%s>(%d/%d)</color>", SettlementTarget.Colors.Fail, curNum, totalNum)
		element1.isReach = false
	end

	element1.isReach = isReach
	element1.posY = self:_getPosY(1)
	element1.curTime = self._curTime

	self:_updateCurDelay()

	element1.curDelay = self._curDelay

	table.insert(self._curViewDatas, element1)

	local index = #self._curViewDatas
	local actId = params.activityId
	local stageId = params.stageId
	local stageCfg = DivineGasiriConfig.instance:getStageCfg(actId, stageId)
	local targets = stageCfg.winScoreRequirements
	local scores = params.typeAndScores

	for i, v in ipairs(scores) do
		local element = {}
		local target = targets[i]
		local score = v.right
		local cfg = DivineGasiriConfig.instance:getScoreCfg(actId, v.left)
		local isReach = target <= score
		local showTest = string.format("<color=#%s>%s</color>", self:_getColorStr(isReach), cfg.passDesc)

		element.txtDesc = string.format(showTest, score, target)
		element.isReach = isReach
		element.posY = self:_getPosY(index + i)
		element.curTime = self._curTime

		self:_updateCurDelay()

		element.curDelay = self._curDelay

		table.insert(self._curViewDatas, element)
	end
end

function SettlementTarget:_setAngelPowerCondition(params)
	local index = 1
	local element1 = {}
	local enemys = BattleModel.instance:getEnemyUnits()
	local totalNum = #enemys
	local curNum = 0
	local isWin

	for k, v in pairs(enemys) do
		if v.attrs:getCurHp() <= 0 then
			curNum = curNum + 1
		end
	end

	if curNum >= #enemys then
		curNum = #enemys
		element1.txtDesc = string.format("击败敌阵全部精灵  <color=#%s>(%d/%d)</color>", SettlementTarget.Colors.Sucess, #enemys, totalNum)
		element1.isReach = true
	else
		element1.txtDesc = string.format("未击败敌阵全部精灵  <color=#%s>(%d/%d)</color>", SettlementTarget.Colors.Fail, curNum, totalNum)
		element1.isReach = false
	end

	element1.posY = self:_getPosY(index)
	element1.curTime = self._curTime

	self:_updateCurDelay()

	element1.curDelay = self._curDelay

	table.insert(self._curViewDatas, element1)

	index = index + 1

	if checknumber(params.winId) > 0 then
		local winId = params.winId
		local cfg = BattleSettlementConfig.instance:getBattleWinnerOpCfgById(winId)
		local conditionParams = BattleModel.instance:getConditionParams()

		if cfg.type == GameEnum.Evaluate.Combination then
			local jConditionParams = GameUtil.jsonToTable(conditionParams)
			local newIndex = index

			for id, singleConditionParam in pairs(jConditionParams) do
				local cfgWinnerOp = BattleSettlementConfig.instance:getBattleWinnerOpCfgById(checknumber(id))

				if cfgWinnerOp and cfgWinnerOp.type == GameEnum.Evaluate.ActiveCount then
					local typeCfg = BattleSettlementConfig.instance:getBattleWinnerOpTypeCfgByType(cfgWinnerOp.type)
					local element = {}

					element.txtDesc = ""

					local jConditionParams = GameUtil.jsonToTable(singleConditionParam)
					local num = 0

					if typeCfg.paramNames and typeCfg.paramNames[1] and jConditionParams and jConditionParams[typeCfg.paramNames[1]] then
						num = jConditionParams[typeCfg.paramNames[1]]
					end

					local cfgStr = cfgWinnerOp.params
					local isTypeReach = num >= checknumber(cfgStr)
					local color = self:_getColorStr(isTypeReach)

					element.txtDesc = string.format(typeCfg.desc, checknumber(cfgStr)) .. string.format("  <color=#%s>(%s/%s)</color>", color, tostring(num), cfgStr)
					element.isReach = isTypeReach
					element.posY = self:_getPosY(newIndex)
					element.curTime = self._curTime

					self:_updateCurDelay()

					element.curDelay = self._curDelay

					table.insert(self._curViewDatas, element)

					newIndex = newIndex + 1
				end
			end

			index = newIndex
		elseif cfg.type == GameEnum.Evaluate.ActiveCount then
			local conditionTypeParams = BattleModel.instance:getConditionTypeParams()
			local typeCfg = BattleSettlementConfig.instance:getBattleWinnerOpTypeCfgByType(cfg.type)
			local element = {}

			element.txtDesc = ""

			local jConditionParams = GameUtil.jsonToTable(conditionParams)
			local num = 0

			if typeCfg.paramNames and typeCfg.paramNames[1] and jConditionParams and jConditionParams[typeCfg.paramNames[1]] then
				num = jConditionParams[typeCfg.paramNames[1]]
			end

			local cfgStr = conditionTypeParams
			local isTypeReach = num >= checknumber(cfgStr)
			local color = self:_getColorStr(isTypeReach)

			element.txtDesc = string.format(typeCfg.desc, checknumber(cfgStr)) .. string.format("  <color=#%s>(%s/%s)</color>", color, tostring(num), cfgStr)
			element.isReach = isTypeReach
			element.posY = self:_getPosY(index)
			element.curTime = self._curTime

			self:_updateCurDelay()

			element.curDelay = self._curDelay

			table.insert(self._curViewDatas, element)

			index = index + 1
		end
	end

	local requireList = params.requireList

	for i, v in ipairs(requireList) do
		local element = {}
		local isReach = v.curNum >= v.needNum

		element.txtDesc = string.format("%s面具 <color=#%s>（%d/%d）</color>", v.maskName, self:_getColorStr(isReach), v.curNum, v.needNum)
		element.isReach = isReach
		element.posY = self:_getPosY(index)
		element.curTime = self._curTime

		self:_updateCurDelay()

		element.curDelay = self._curDelay

		table.insert(self._curViewDatas, element)

		index = index + 1
	end
end

function SettlementTarget:_setYoungChampionKingQualifierCondition(params)
	local element1 = {}
	local enemys = BattleModel.instance:getEnemyUnits()
	local totalNum = 0
	local curNum = 0

	for k, v in pairs(enemys) do
		if not v.attrs:IsOraclePet() then
			totalNum = totalNum + 1

			if v.attrs:getCurHp() <= 0 then
				curNum = curNum + 1
			end
		end
	end

	if totalNum <= curNum then
		curNum = totalNum
		element1.txtDesc = string.format("击败敌阵全部精灵  <color=#%s>(%d/%d)</color>", SettlementTarget.Colors.Sucess, totalNum, totalNum)
		element1.isReach = true
	else
		element1.txtDesc = string.format("未击败敌阵全部精灵  <color=#%s>(%d/%d)</color>", SettlementTarget.Colors.Fail, curNum, totalNum)
		element1.isReach = false
	end

	element1.posY = self:_getPosY(1)
	element1.curTime = self._curTime

	self:_updateCurDelay()

	element1.curDelay = self._curDelay

	table.insert(self._curViewDatas, element1)

	local oldScore = checknumber(params.oldScore)
	local newScore = checknumber(params.newScore)
	local stepId = checknumber(params.stepId)

	if stepId == YoungChampionKingEnum.Qualify_Step_Id or stepId == YoungChampionKingEnum.Score_Match_Step_Id then
		local element2 = {}

		element2.txtDesc = string.format("积分变化：<color=#eb4624>%s</color>-><color=#20b376>%s</color>", oldScore, newScore)
		element2.isReach = true
		element2.posY = self:_getPosY(2)
		element2.curTime = self._curTime

		self:_updateCurDelay()

		element2.curDelay = self._curDelay

		table.insert(self._curViewDatas, element2)
	end
end

function SettlementTarget:_setDivineDakinosClgCondition(params)
	local element1 = {}
	local enemys = BattleModel.instance:getEnemyUnits()
	local totalNum = 0
	local curNum = 0

	for k, v in pairs(enemys) do
		if not v.attrs:IsOraclePet() then
			totalNum = totalNum + 1

			if v.attrs:getCurHp() <= 0 then
				curNum = curNum + 1
			end
		end
	end

	if totalNum <= curNum then
		curNum = totalNum
		element1.txtDesc = string.format("击败敌阵全部精灵  <color=#%s>(%d/%d)</color>", SettlementTarget.Colors.Sucess, totalNum, totalNum)
		element1.isReach = true
	else
		element1.txtDesc = string.format("未击败敌阵全部精灵  <color=#%s>(%d/%d)</color>", SettlementTarget.Colors.Fail, curNum, totalNum)
		element1.isReach = false
	end

	element1.posY = self:_getPosY(1)
	element1.curTime = self._curTime

	self:_updateCurDelay()

	element1.curDelay = self._curDelay

	table.insert(self._curViewDatas, element1)

	local needSaveCount = checknumber(params.needSaveCount)
	local saveCount = checknumber(params.saveCount)
	local element2 = {}

	if needSaveCount <= saveCount then
		element2.txtDesc = string.format("至少拯救%d名信徒  <color=#%s>(%d/%d)</color>", needSaveCount, SettlementTarget.Colors.Sucess, saveCount, needSaveCount)
		element2.isReach = true
	else
		element2.txtDesc = string.format("至少拯救%d名信徒  <color=#%s>(%d/%d)</color>", needSaveCount, SettlementTarget.Colors.Fail, saveCount, needSaveCount)
		element2.isReach = false
	end

	element2.posY = self:_getPosY(2)
	element2.curTime = self._curTime

	self:_updateCurDelay()

	element2.curDelay = self._curDelay

	table.insert(self._curViewDatas, element2)
end

function SettlementTarget:_setCommonCondition(index)
	local element1 = {}
	local enemys = BattleModel.instance:getEnemyUnits()
	local totalNum = #enemys
	local curNum = 0

	if self._isSuccess then
		curNum = #enemys
		element1.txtDesc = string.format("击败敌阵全部精灵  <color=#%s>(%d/%d)</color>", SettlementTarget.Colors.Sucess, #enemys, totalNum)
		element1.isReach = true
	else
		for k, v in pairs(enemys) do
			if v.attrs:getCurHp() <= 0 then
				curNum = curNum + 1
			end
		end

		element1.txtDesc = string.format("未击败敌阵全部精灵  <color=#%s>(%d/%d)</color>", SettlementTarget.Colors.Fail, curNum, totalNum)
		element1.isReach = false
	end

	element1.posY = self:_getPosY(index)
	element1.curTime = self._curTime

	self:_updateCurDelay()

	element1.curDelay = self._curDelay

	table.insert(self._curViewDatas, element1)

	index = index + 1

	return index
end

function SettlementTarget:_addSpecialCondition(index, conditionType, conditionParams, conditionTypeParams, desc)
	local cfg = BattleSettlementConfig.instance:getBattleWinnerOpTypeCfgByType(conditionType)

	if cfg then
		local element1 = {}

		element1.txtDesc = ""

		local jConditionParams = GameUtil.jsonToTable(conditionParams)
		local num = 0

		if cfg.paramNames and cfg.paramNames[1] and jConditionParams and jConditionParams[cfg.paramNames[1]] then
			num = jConditionParams[cfg.paramNames[1]]
		end

		local cfgStr = conditionTypeParams
		local color = self:_getColorStr(self._isSuccess)
		local isSingleReach = self._isSuccess

		if cfg.type == GameEnum.Evaluate.DamageTotal then
			element1.txtDesc = string.format(cfg.desc, tostring(num))
		elseif cfg.type == GameEnum.Evaluate.MyActivePetContainsAttrs then
			local paramList = string.split(cfgStr, ",")

			if paramList and #paramList == 2 then
				element1.txtDesc = string.format(cfg.desc, paramList[2], paramList[1])
			elseif paramList and #paramList > 2 then
				local strJoint = paramList[2]

				for i = 3, #paramList do
					strJoint = strJoint .. paramList[i]
				end

				element1.txtDesc = string.format(cfg.desc, strJoint, paramList[1])
			else
				element1.txtDesc = cfg.desc
			end
		elseif cfg.type == GameEnum.Evaluate.MyPosIdMustActive then
			local paramList = string.split(cfgStr, ",")
			local str = ""

			if paramList and #paramList > 0 then
				for i, v in ipairs(paramList) do
					str = str .. checknumber(v) + 1

					if i ~= #paramList then
						str = str .. ","
					end
				end
			end

			element1.txtDesc = string.format(cfg.desc, str)
		elseif cfg.type == GameEnum.Evaluate.PosHpRate then
			local paramList = string.split(cfgStr, "_")

			element1.txtDesc = paramList and #paramList == 2 and string.format(cfg.desc, paramList[1] + 1, checknumber(paramList[2]) * 100) or cfg.desc
		elseif cfg.type == GameEnum.Evaluate.DamageTotalRange then
			local paramList = string.split(cfgStr, "_")

			element1.txtDesc = paramList and #paramList == 2 and string.format(cfg.desc, paramList[1], tostring(num), paramList[2]) or cfg.desc
		elseif cfg.type == GameEnum.Evaluate.CircleCount then
			element1.txtDesc = string.format(cfg.desc, cfgStr)
		elseif cfg.type == GameEnum.Evaluate.MyRaceIdMustActive then
			local petcfg = CharacterConfig.instance:getPetCo(checknumber(cfgStr))

			if petcfg then
				if not petcfg.name then
					local name = ""

					element1.txtDesc = string.format(cfg.desc, name)
				end
			end
		elseif cfg.type == GameEnum.Evaluate.EqualCircleCount then
			element1.txtDesc = string.format(cfg.desc, cfgStr)
		elseif cfg.type == GameEnum.Evaluate.CharacterActiveNum then
			element1.txtDesc = string.format(cfg.desc, tostring(num))
		elseif cfg.type == GameEnum.Evaluate.EnemyActiveCount then
			local curActNum = checknumber(num)
			local needActNum = checknumber(cfgStr)
			local isReach = true
			local color = self:_getColorStr(isReach)

			element1.txtDesc = string.format(cfg.desc, needActNum, color, curActNum, needActNum)
		elseif cfg.type == GameEnum.Evaluate.KillNum then
			local curKillNum = checknumber(num)
			local needKillNum = checknumber(cfgStr)

			element1.txtDesc = string.format(cfg.desc, curKillNum)
		elseif cfg.type == GameEnum.Evaluate.ActiveCountLessThan then
			local lessThanActNum = checknumber(num)
			local curActNum = checknumber(cfgStr)

			element1.txtDesc = string.format(cfg.desc, lessThanActNum)
		elseif cfg.type == GameEnum.Evaluate.EnemyActiveLessThanCount then
			local curActNum = checknumber(num)
			local needActNum = checknumber(cfgStr)
			local isReach = curActNum <= needActNum
			local color = self:_getColorStr(isReach)

			element1.txtDesc = string.format(cfg.desc, needActNum, color, curActNum, needActNum)
			isSingleReach = isReach
		else
			element1.txtDesc = string.format(cfg.desc, checknumber(cfgStr)) .. string.format("  <color=#%s>(%s/%s)</color>", color, tostring(num), cfgStr)
		end

		if not string.nilorempty(desc) then
			element1.txtDesc = desc
		end

		element1.isReach = isSingleReach
		element1.posY = self:_getPosY(index)
		element1.curTime = self._curTime

		self:_updateCurDelay()

		element1.curDelay = self._curDelay

		table.insert(self._curViewDatas, element1)

		index = index + 1
	end

	return index
end

function SettlementTarget:_setSpecialCondition(index, conditionType)
	local conditionParams = BattleModel.instance:getConditionParams()

	if conditionType == GameEnum.Evaluate.Combination then
		local jConditionParams = GameUtil.jsonToTable(conditionParams)
		local newIndex = index

		for id, singleConditionParam in pairs(jConditionParams) do
			local cfgWinnerOp = BattleSettlementConfig.instance:getBattleWinnerOpCfgById(checknumber(id))

			if cfgWinnerOp then
				newIndex = self:_addSpecialCondition(newIndex, cfgWinnerOp.type, singleConditionParam, cfgWinnerOp.params, cfgWinnerOp.desc)
			end
		end

		return newIndex
	else
		local conditionTypeParams = BattleModel.instance:getConditionTypeParams()

		return self:_addSpecialCondition(index, conditionType, conditionParams, conditionTypeParams)
	end
end

function SettlementTarget:_setPerfectCondition(index)
	if not self._isSuccess then
		return
	end

	if self:_isHavePerfectPass() then
		local selfUnits = BattleModel.instance:getUnits()
		local num = #selfUnits
		local curNum = 0

		for k, v in pairs(selfUnits) do
			if v.attrs:getCurHp() > 0 then
				curNum = curNum + 1
			end
		end

		local element2 = {}
		local params = BattleSettlementModel.instance:getParams()
		local isPerfect = self:_isPerfectPass()
		local color = self:_getColorStr(isPerfect)
		local cfgNum = BattleSettlementModel.instance:getPerfectPassConditionPetNum(params.chapterId, params.stageId)

		element2.txtDesc = string.format("%s  <color=#%s>(%d/%d)</color>", BattleSettlementModel.instance:getPlotCopyPerfectText(params.chapterId, params.stageId), color, num - curNum, cfgNum)
		element2.isReach = isPerfect
		element2.posY = self:_getPosY(index)
		element2.curTime = self._curTime

		self:_updateCurDelay()

		element2.curDelay = self._curDelay

		table.insert(self._curViewDatas, element2)

		index = index + 1
	else
		local conditionType = BattleModel.instance:getPerfectWinType()

		if not string.nilorempty(conditionType) then
			local isPerfectWin = BattleModel.instance:isPerfectWin()
			local cfg = BattleSettlementConfig.instance:getBattleWinnerOpTypeCfgByType(conditionType)

			if cfg then
				local element = {}
				local conditionParams = BattleModel.instance:getPerfectWinParams()
				local jConditionParams = json.decode(conditionParams)
				local num = jConditionParams[cfg.paramNames[1]]
				local cfgStr = BattleModel.instance:getPerfectWinTypeParams()

				if isPerfectWin then
					if not SettlementTarget.Colors.Sucess then
						local color = SettlementTarget.Colors.Fail

						element.txtDesc = "完美通关  " .. string.format(cfg.desc, checknumber(cfgStr)) .. string.format("  <color=#%s>(%s/%s)</color>", color, tostring(num), cfgStr)
						element.isReach = isPerfectWin
						element.posY = self:_getPosY(index)
						element.curTime = self._curTime

						self:_updateCurDelay()

						element.curDelay = self._curDelay

						table.insert(self._curViewDatas, element)

						index = index + 1
					end
				end
			end
		end
	end
end

function SettlementTarget:_setContentHeight()
	local count = self:_getItemCount()
	local sizeDelta = self._contentRect.sizeDelta
	local height = self._preHeight + self._postHeight

	for i, v in ipairs(self._curViewDatas) do
		self._txtDesc.text = v.txtDesc

		local h = self._txtDesc.preferredHeight

		height = height + h
	end

	self._contentRect.sizeDelta = Vector2.New(sizeDelta.x, height)

	local scrollCount = count < 4 and count or 4
	local scrollHeight = self._preHeight + self._postHeight + scrollCount * self._unitHeight

	self._scrollRect.sizeDelta = Vector2.New(sizeDelta.x, scrollHeight)
end

function SettlementTarget:_resetContentPos()
	self._scrollRectAdapter.scrollRect.verticalNormalizedPosition = 1
end

function SettlementTarget:_getItemCount()
	if self._curViewDatas then
		return #self._curViewDatas
	end

	return 0
end

function SettlementTarget:_setHeight()
	local count = self:_getItemCount()
	local height = self._titleHeight + self._preHeight + self._postHeight + count * self._unitHeight

	self.height = height

	Framework.TransformUtil.SetAnchoredPos(self._parentRectTrans, 0, self:_getCurPosY())

	local sizeDelta = self._parentRectTrans.sizeDelta

	self._parentRectTrans.sizeDelta = Vector2.New(sizeDelta.x, height)
end

function SettlementTarget:getMaxHeight()
	local maxCount = 4

	return self._titleHeight + self._preHeight + self._postHeight + maxCount * self._unitHeight
end

function SettlementTarget:_setAnimCostTime()
	local titleCount = 1
	local count = self:_getItemCount() + titleCount

	self.animCostTime = self._delayTime1 * count
end

function SettlementTarget:_isHavePerfectPass()
	local enumType = BattleSettlementModel.instance:getType()

	return enumType == BattleSettlementModel.Enum.PlotCopy
end

function SettlementTarget:_isPerfectPass()
	local enumType = BattleSettlementModel.instance:getType()

	return PlotCopyModel.instance:isPerfectPass(enumType)
end

function SettlementTarget:_loadList()
	print("real _loadList")
	self:_setContentHeight()
	self:_resetContentPos()
	print("len = " .. #self._curViewDatas)

	for i, v in ipairs(self._curViewDatas) do
		local go = goutil.cloneAndSetParent(self._element, self._contentRect.transform, "item" .. tostring(i))

		go:SetActive(true)

		local conditionItem = GameUtil.AddLuaOnce(go, TargetConditionItem)

		conditionItem:init(go, v)
		table.insert(self._targetConditionItems, conditionItem)
	end
end

function SettlementTarget:_clearList()
	if self._targetConditionItems then
		for i, v in ipairs(self._targetConditionItems) do
			v:reset()
		end

		self._targetConditionItems = nil
	end

	self._curViewDatas = nil

	goutil.clearChildren(self._contentRect.gameObject)
end

function SettlementTarget:doTween()
	if self._targetConditionItems then
		for i, v in ipairs(self._targetConditionItems) do
			v:doTween()
		end
	end
end

function SettlementTarget:doKillTween()
	SettlementTarget.super.doKillTween(self)
	self._imgBgTarget:DOKill(true)

	if self._targetConditionItems then
		for i, v in ipairs(self._targetConditionItems) do
			v:doKillTween()
		end
	end
end

function SettlementTarget:doCompleteTween()
	self:doKillTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 0, 0)
end

function SettlementTarget:_onClickStatics()
	ViewMgr.instance:open(ViewName.BattleStatics)
end

function SettlementTarget:_setStaticsActive(isShow)
	self._btnStatics.gameObject:SetActive(isShow)
end

return SettlementTarget
