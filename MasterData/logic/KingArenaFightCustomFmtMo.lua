-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/model/KingArenaFightCustomFmtMo.lua

module("logic.extensions.kingarena.model.KingArenaFightCustomFmtMo", package.seeall)

local KingArenaFightCustomFmtMo = class("KingArenaFightCustomFmtMo", BaseCustomFmtMo)

function KingArenaFightCustomFmtMo:onInit()
	KingArenaFightCustomFmtMo.super.onInit(self)
end

function KingArenaFightCustomFmtMo:initFormationMo()
	KingArenaFightCustomFmtMo.super.initFormationMo(self)

	self._petMapAsRight = {}
	self._formationMoOfEnemy = FormationMO.New(GameUtil.handler(self.getPetMoByIdOfEnemy, self))
end

function KingArenaFightCustomFmtMo:updateCfg(seasonId, periodId, userId, rank, isUseMaxZdl)
	self._seasonId = seasonId
	self._periodId = periodId
	self._userId = userId
	self._rank = rank
	self._kingArenaMo = KingArenaController.instance:getKingArenaMo(self._seasonId)

	local oldZdlRatio = self._zdlRatio

	self._zdlRatio = 0
	self.useMaxFightPower = false

	if isUseMaxZdl then
		local zdlRatio = self._kingArenaMo:getZdlRatio()

		if zdlRatio > 0 then
			self._zdlRatio = checknumber(zdlRatio)
			self.useMaxFightPower = true
		end
	end

	if oldZdlRatio ~= self._zdlRatio then
		self:initPetList()
	end

	self._fightRate = 0

	self._formationMoOfEnemy:ResetPosition(true)
	GlobalDispatcher:addListener(GlobalNotify.HandlePM_KingArenaViewFormRes, self._handlePM_KingArenaViewFormRes, self)
	KingArenaController.instance:sendPM_KingArenaViewFormReq(self._userId)
end

function KingArenaFightCustomFmtMo:_handlePM_KingArenaViewFormRes(status, msg)
	if status ~= 0 then
		return
	end

	local petSimpleView = msg.playerView.petSimpleView
	local tempList = {}

	self._petMapAsRight = self._petMapAsRight or {}

	for k, v in pairs(self._petMapAsRight) do
		table.insert(tempList, v)

		self._petMapAsRight[k] = nil
	end

	for _, v in ipairs(petSimpleView) do
		local petMo = #tempList > 0 and BagPetMo.New() or BagPetMo.New()

		petMo:initBaseView(v)

		petMo.isMyPackPet = false
		self._petMapAsRight[v.petId] = petMo
	end

	local simpleForm = msg.playerView.curForm

	self._formationMoOfEnemy:SetData(simpleForm)
	GlobalDispatcher:dispatch(GlobalNotify.RefreshEnemyFmt)
end

function KingArenaFightCustomFmtMo:onExitView()
	KingArenaFightCustomFmtMo.super.onExitView(self)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_KingArenaViewFormRes, self._handlePM_KingArenaViewFormRes, self)
end

function KingArenaFightCustomFmtMo:updateData()
	self.isShowBtnCutePet = true
end

function KingArenaFightCustomFmtMo:_changePetMo(petMo)
	if self.useMaxFightPower then
		local maxPetMo = FightingPowerPetMo.getMaxPetMoByData(petMo)

		for k, v in pairs(GameEnum.AttrModelType) do
			maxPetMo.attrMo.extModelBaseAttrRate[v] = self._zdlRatio
		end

		maxPetMo.isMyPackPet = false

		maxPetMo:calcAllAttr()

		maxPetMo.isMyPackPet = petMo.isMyPackPet

		return maxPetMo
	else
		local petMoForm = petMo:GetClone()

		petMoForm.attrMo:resetPublicAttr()
		petMoForm.attrMo:calcTotalAttrs()
		petMoForm:refreshAllAttr()

		return petMoForm
	end
end

function KingArenaFightCustomFmtMo:initFightHandler()
	local function handler()
		local result, tips = self:getTryStartFightResultAndTips(self._seasonId, self._periodId)

		FloatWordMgr.instance:show(tips)

		if result ~= GameEnum.ResultCode.Success then
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

			return
		end

		local resetCd = KingArenaConfig.instance:getCommonValue("FIGHT_CD", true)
		local last = self._kingArenaMo:getLastFightTime()

		last = Mathf.Ceil(checknumber(last) / 1000)

		local now = ServerTime.now()

		if resetCd > now - last - 1 then
			local left = Mathf.Ceil(Mathf.Max(resetCd - (now - last), 0))

			FloatWordMgr.instance:show(string.format("冷却中，剩余%s秒", left))
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

			return
		end

		local curTimes = self._kingArenaMo:getDailyFightTimes()
		local freeTimes = self._kingArenaMo:getFreeDailyFightTimes()
		local buyTimes = Mathf.Max(curTimes - freeTimes, 0)
		local dailyBuyFightTimes = self._kingArenaMo:getDailyBuyFightTimes()
		local leftCanClgTimes = Mathf.Max(dailyBuyFightTimes - (curTimes - freeTimes), 0)

		if leftCanClgTimes > 0 then
			UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

			local simpleForm = self:getCurSimpleForm()

			KingArenaController.instance:sendPM_KingArenaFightReq(self._seasonId, self._rank, simpleForm, self.useMaxFightPower)
		else
			local maxBuyTimes = self._kingArenaMo:getMaxBuyFightTimes()
			local leftBuyTimes = self._kingArenaMo:getLeftDailyBuyFightTimes()

			if leftBuyTimes > 0 then
				local isEnough = KingArenaController.instance:checkMatEnough(self._seasonId, dailyBuyFightTimes + 1, dailyBuyFightTimes + 1, true)

				if isEnough then
					local descTxt

					local function sureCallBack(view)
						local times = view:getCurTimes()

						if KingArenaController.instance:checkMatEnough(self._seasonId, dailyBuyFightTimes + 1, dailyBuyFightTimes + times, true) then
							GlobalDispatcher:addListener(GlobalNotify.HandlePM_KingArenaBuyFightTimesRes, self._tryStartFight, self)
							KingArenaController.instance:sendPM_KingArenaBuyFightTimesReq(self._seasonId, times)
						else
							GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
						end
					end

					local function cancelCallBack(view)
						GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
					end

					local otherCallBack

					local function updateCoinTxtCallBack(view)
						view:getTxtCoin().text = ""
					end

					local function updateDescTxtCallBack(view)
						local times = view:getCurTimes()
						local cosMats = KingArenaConfig.instance:getCostMatsWithBuyTimes(self._seasonId, dailyBuyFightTimes + 1, dailyBuyFightTimes + times)
						local names = ""
						local index = 1

						for matKey, matNum in pairs(cosMats) do
							local matName = MaterialMgr.getMaterialsNameByCfg(matKey)

							names = index > 1 and names .. string.format(", <color=#eb4624>%s%s</color>", matNum, matName) or string.format("<color=#eb4624>%s%s</color>", matNum, matName)
							index = index + 1
						end

						view:getTxtDesc().text = string.format("确定花费%s购买挑战次数吗？\n<size=24>每天最多可购买%s次，还能购买%s次</size>", names, maxBuyTimes, leftBuyTimes)
					end

					TipsFacade.instance:openPopupCommonCostPopView(leftBuyTimes, 1, "提示", "确定", "取消", descTxt, sureCallBack, cancelCallBack, otherCallBack, updateCoinTxtCallBack, updateDescTxtCallBack)
				end
			else
				FloatWordMgr.instance:show("今日购买次数已用完")
			end

			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
		end
	end

	self:setFightHandler(handler, nil)
end

function KingArenaFightCustomFmtMo:getTryStartFightResultAndTips(seasonId, periodId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local kingArenaMo = KingArenaController.instance:getKingArenaMo(seasonId)

	if result == GameEnum.ResultCode.Success and not KingArenaController.instance:isInTimeOfSeasonPeriod(seasonId, periodId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "竞技未开始"
	end

	if result == GameEnum.ResultCode.Success then
		local zoneId = kingArenaMo:getZoneId()

		if zoneId <= 0 then
			result = GameEnum.ResultCode.HasSure
			tips = "未加入战区"
		end
	end

	if result == GameEnum.ResultCode.Success then
		local curTimes = kingArenaMo:getDailyFightTimes()
		local freeTimes = kingArenaMo:getFreeDailyFightTimes()
		local maxBuyTimes = kingArenaMo:getMaxBuyFightTimes()

		if curTimes >= freeTimes + maxBuyTimes then
			result = GameEnum.ResultCode.IsMaxLimitOfTimes
			tips = "已达今日挑战次数上限"
		end
	end

	return result, tips
end

function KingArenaFightCustomFmtMo:_tryStartFight(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_KingArenaBuyFightTimesRes, self._tryStartFight, self)

	if status ~= 0 then
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

		return
	end

	local seasonId = msg.seasonId

	if self._seasonId ~= seasonId then
		return
	end

	UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

	local simpleForm = self:getCurSimpleForm()

	KingArenaController.instance:sendPM_KingArenaFightReq(self._seasonId, self._rank, simpleForm, self.useMaxFightPower)
end

function KingArenaFightCustomFmtMo:getMonsterConfigList()
	return {}
end

function KingArenaFightCustomFmtMo:getFmtInfoConfig()
	local simpleForm = CustomFmtController.instance:createFormPb(self._formationMoOfEnemy)

	return simpleForm.extParams
end

function KingArenaFightCustomFmtMo:getTeamAndFormation(creepCfg)
	local fmtMo = self._formationMoOfEnemy
	local teams, formations, speed = fmtMo:getTeamAndFormation()

	ArraySort.sortOn(teams, "position")

	local resultFormations = {}

	for posId, bagPetMo in pairs(formations) do
		local fightingPowerMo = bagPetMo:toFightingPowerPetMo()

		fightingPowerMo.petId = bagPetMo:getPetId()
		resultFormations[posId] = fightingPowerMo
	end

	return teams, resultFormations
end

function KingArenaFightCustomFmtMo:getPetMoByIdOfEnemy(petId)
	return self._petMapAsRight[petId]
end

function KingArenaFightCustomFmtMo:getExtParams()
	return self:getFmtInfoConfig()
end

return KingArenaFightCustomFmtMo
