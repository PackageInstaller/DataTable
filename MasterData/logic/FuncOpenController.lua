-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcopen/controller/FuncOpenController.lua

module("logic.extensions.funcopen.controller.FuncOpenController", package.seeall)

local FuncOpenController = class("FuncOpenController", BaseController)

function FuncOpenController:ctor()
	return
end

function FuncOpenController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.TaskDataReady, self._onTaskDataReady, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialInited, self._onMofangDataReady, self)
	GlobalDispatcher:addListener(GlobalNotify.CopyDataReady, self._onCopyDataReady, self)
	GlobalDispatcher:addListener(GlobalNotify.TaskDataUpdate, self._checkFuncOpen, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMofangDoLvUp, self._onMofangLvUp, self)
	GlobalDispatcher:addListener(GlobalNotify.ReceiveQilin, self._onReceiveQilin, self)
	GlobalDispatcher:addListener(GlobalNotify.HeroChallengeStatusChange, self._onHeroChallengeStatusChange, self)
	GlobalDispatcher:addListener(GlobalNotify.RoleInfoPushed, self._checkFuncOpen, self)
	GlobalDispatcher:addListener(GlobalNotify.CopyInfoChange, self._checkFuncOpen, self)
	GlobalDispatcher:addListener(GlobalNotify.WTowerDataReady, self._onWTowerDataReady, self)
	self:onReset()
end

function FuncOpenController:onReset()
	self._isInit = false
	self._splitMap = {}
end

function FuncOpenController:splitToArr(input, delimiter)
	input = tostring(input)
	delimiter = tostring(delimiter)

	local map = self._splitMap

	if map[delimiter] and map[delimiter][input] then
		return map[delimiter][input]
	else
		map[delimiter] = map[delimiter] or {}

		local arr = string.split(input, delimiter)

		map[delimiter][input] = arr

		return arr
	end
end

function FuncOpenController:_onTaskDataReady()
	FuncOpenModel.instance:_onTaskDataReady()
	self:_tryInit()
end

function FuncOpenController:_onMofangDataReady()
	FuncOpenModel.instance:_onMofangDataReady()
	self:_tryInit()
end

function FuncOpenController:_onCopyDataReady()
	FuncOpenModel.instance:_onCopyDataReady()
	self:_tryInit()
end

function FuncOpenController:_onMofangLvUp(newLv)
	FuncOpenModel.instance:_onMofangLvUp(newLv)
end

function FuncOpenController:_onWTowerDataReady()
	FuncOpenModel.instance:_onWTowerDataReady()
	self:_tryInit()
end

function FuncOpenController:_onHeroChallengeStatusChange(challengeId, isAllReceived)
	FuncOpenModel.instance:_onHeroChallengeStatusChange(challengeId, isAllReceived)
end

function FuncOpenController:_tryInit()
	if not self._isInit and FuncOpenModel.instance:isAllDataReady() then
		self._isInit = true

		local value = checknumber(MofangModel.instance:getCurLv())

		FuncOpenModel.instance:setCacheMofangLv(value)

		local funcs = FuncOpenConfig.instance:getFunctionOpens()

		funcs = self:_filterOverTime(funcs)

		FuncOpenModel.instance:_onChallengeInit(funcs)
	end
end

function FuncOpenController:_onReceiveQilin()
	FuncOpenModel.instance:_onReceiveQilin()
end

function FuncOpenController:_checkFuncOpen(isForce)
	FuncOpenModel.instance:_checkFuncOpen(isForce)
end

function FuncOpenController:openFuncByViewName(viewName, ...)
	if string.nilorempty(viewName) then
		return
	end

	local list = FuncOpenConfig.instance:getFuncIdByViewNameList(viewName)

	if list and #list == 1 then
		local funcId = list[1]

		printInfo("click funcId = " .. funcId)

		if FuncOpenModel.instance:getFuncIsOpen(funcId) then
			self:reportBehavior(funcId)
			UIStateManager.instance:push(viewName, ...)
		else
			self:checkFuncIdOrShowLockTips(funcId)
		end
	else
		UIStateManager.instance:push(viewName, ...)
	end
end

function FuncOpenController:reportBehavior(funcId)
	local cfg = FuncOpenConfig.instance:getFunctionOpenById(checknumber(funcId))

	if cfg ~= nil then
		SurveyController.instance:reportBehavior(cfg.reportBehavior)
	end
end

function FuncOpenController:reportClickBehavior(funcId)
	local cfg = FuncOpenConfig.instance:getFunctionOpenById(checknumber(funcId))

	if cfg ~= nil then
		SurveyController.instance:reportBehavior(cfg.clickBehavior)
	end
end

function FuncOpenController:openFunc(funcId, ...)
	if checknumber(funcId) > 0 then
		local cfg = FuncOpenConfig.instance:getFunctionOpenById(checknumber(funcId))

		if cfg ~= nil then
			self:onClickFunc(cfg, ...)
		end
	end
end

function FuncOpenController:onClickFunc(cfg, ...)
	if cfg ~= nil then
		if FuncOpenModel.instance:getFuncIsOpen(cfg.funcId) then
			if cfg.funcId == 19 then
				ArenaController.instance:openArenaSafe()
			elseif cfg.funcId == 15 then
				WTowerController.instance:openWarrior()
			elseif cfg.funcId == 27 then
				UIStateManager.instance:open(ViewName.FuncOpenTips)
			elseif cfg.funcId == 171 and not SeniorArenaController.instance:getIsOpen() then
				-- block empty
			elseif cfg.funcId == 35 then
				UIStateManager.instance:push(ViewName.guideQilin)
			elseif cfg.funcId == 36 then
				ChallengeFacade.instance:startChallange(20)
			elseif cfg.funcId == 37 then
				TaskController.instance:gotoChallenge(37)
			elseif cfg.funcId == 38 then
				TaskController.instance:gotoChallenge(35)
			elseif cfg.funcId == 25 then
				RoleController.instance:openMyInfoCard(function()
					return
				end, ...)
			elseif cfg.funcId == 18 then
				BreakFormationController.instance:checkAndOpenView()
			elseif cfg.funcId == 50 then
				UIStateManager.instance:push(ViewName.PetShowView, ViewName.PetEquip)
			elseif cfg.funcId == 232 then
				BonusController.instance:openBonusView(ViewName.SolicitWealthView)
			elseif cfg.funcId == 52 then
				ExpeditionController.instance:enterView()
			elseif cfg.funcId == 58 then
				StrongerFacade.instance:openStrongerView(1)
			elseif cfg.funcId == 60 then
				FamilySceneController.instance:enterScene(...)
			elseif cfg.funcId == 62 then
				PowerCrystalController.instance:OpenView()
			elseif cfg.funcId == 63 then
				UIStateManager.instance:push(ViewName.SevenDays)
			elseif cfg.funcId == 65 then
				UIStateManager.instance:push(ViewName.TimeWheelView, ...)
			elseif cfg.funcId == 66 then
				PowerCrystalController.instance:OpenView()
			elseif cfg.funcId == 69 then
				RankRaceController.instance:checkLastSeasonPrizeReq()
			elseif cfg.funcId == 75 then
				if RankRaceController.instance:IsRankRaceOpenTime("EXTREME_OPEN_TIME") then
					RankRaceController.instance:setCurViewType(RankRaceController.MatchTypeLimit)
					UIStateManager.instance:push(ViewName.RankRaceClassicsView, RankRaceController.MatchTypeLimit)
				else
					FloatWordMgr.instance:show("未到开放时间")
				end
			elseif cfg.funcId == 46 then
				PayShopController.instance:openExchangeView(...)
			elseif cfg.funcId == 93 then
				WorldBossController.instance:goToWorldBoss()
			elseif cfg.funcId == 74 then
				UIStateManager.instance:push(ViewName.AssignmentView)
			elseif cfg.funcId == 55 then
				if not NewChatModel.instance:isMaskChatOpen() then
					return
				end

				local t = NewChatModel.instance:GetMainUIShowMsg()
				local lastMsg = t[#t]

				if lastMsg then
					if lastMsg._channel == GameEnum.ChatChannel.Private then
						if lastMsg._isRead ~= true then
							FriendController.instance:OpenFriendView(lastMsg:getFriendId())
						else
							UIStateManager.instance:push(ViewName.chat)
						end
					elseif lastMsg._channel == GameEnum.ChatChannel.Nearby then
						local showChannel = NewChatController.instance:getShowChannel()

						if showChannel ~= GameEnum.ChatChannel.Nearby then
							UIStateManager.instance:push(ViewName.chat)
						else
							UIStateManager.instance:push(ViewName.chat, lastMsg._channel)
						end
					else
						UIStateManager.instance:push(ViewName.chat, lastMsg._channel)
					end
				end
			elseif cfg.funcId == 105 then
				local itemSourceCfg = ItemConfig.instance:getSourceCfg(2001)

				if self:getConditionReached(itemSourceCfg.openCondition) then
					local params = {
						...
					}

					GameUtil.callBack(params[1])
					GotoMgr.gotoByString(itemSourceCfg.jumpTo)
				end
			elseif cfg.funcId == 91 then
				if FamilyController.instance:getFamilyLv() <= 0 then
					FloatWordMgr.instance:show("请加入一个家族")

					return
				end

				if not EscortModel.instance:IsOpenEscortView() then
					FloatWordMgr.instance:show("未到开放时间！")

					return
				end

				local params = {
					...
				}

				GameUtil.callBack(params[1])
				UIStateManager.instance:pop()
				EscortModel.instance:StartFindGotoNPC()
			elseif cfg.funcId == 2 then
				CollectionModel.instance:setOffset(0)
				UIStateManager.instance:push(cfg.view, ...)
			elseif cfg.funcId == 9 then
				BagPetsController.instance:setPetViewNeedClearOffset(true)
				UIStateManager.instance:push(cfg.view, ...)
			elseif cfg.funcId == 95 then
				PayShopController.instance:openView(...)
			elseif cfg.funcId == 107 then
				BonusController.instance:openBonusView(ViewName.StarteamView)
			elseif cfg.funcId == 108 then
				BonusController.instance:openBonusView(ViewName.ExcellentClass)
			elseif cfg.funcId == 110 then
				-- block empty
			elseif cfg.funcId == 297 then
				AnswerSceneController.instance:gotoAnswerSceneNpc()
			elseif cfg.funcId == 132 then
				FlyNuoController.instance:openView()
			elseif cfg.funcId == 142 then
				NewHandCardController.instance:openView(...)
			elseif cfg.funcId == 149 then
				PetCollegeController.instance:openView(...)
			elseif cfg.funcId == 158 then
				local params = {
					...
				}

				if HerotrialController.instance:checkIfOpen() then
					UIStateManager.instance:push(ViewName.HerotrialView)
				elseif params[1] and TimelimitrankController.instance:isHaveRank() then
					UIStateManager.instance:push(ViewName.TimelimitrankView)
				else
					FloatWordMgr.instance:show("不在活动时间内")
				end
			elseif cfg.funcId == 175 then
				local startTime = GameUtil.string2time(TimeCapsuleConfig.instance:getCommonValue("ACT_START_TIME"))
				local endTime = GameUtil.string2time(TimeCapsuleConfig.instance:getCommonValue("ACT_END_TIME"))

				if startTime > ServerTime.now() or endTime < ServerTime.now() then
					local startTable, endTable = GameUtil.time2date(startTime), GameUtil.time2date(endTime)

					FloatWordMgr.instance:show(string.format("活动开启时间为：%d月%d日%d:%02d-%d月%d日%d:%02d，当前不在开启时间内", startTable.month, startTable.day, startTable.hour, startTable.min, endTable.month, endTable.day, endTable.hour, endTable.min))

					return
				else
					UIStateManager.instance:push(cfg.view)
				end
			elseif cfg.funcId == 176 then
				ScenariocopyController.instance:openScmainView()
			elseif cfg.funcId == 183 then
				BigOrangeController.instance:goToNPC()
			elseif cfg.funcId == 191 then
				ActivityshopController.instance:openExchangeView(...)
			elseif cfg.funcId == 202 then
				JigsawcollectController.instance:openView()
			elseif cfg.funcId == 113 then
				UIStateManager.instance:push(ViewName.PassportwpView)
			elseif cfg.funcId == 213 then
				ZeropayController.instance:openView()
			elseif cfg.funcId == 216 then
				ConsumelotteryController.instance:openView()
			elseif cfg.funcId == 220 then
				ActivityshopController.instance:openExchangeView(17, 17004)
			elseif cfg.funcId == 219 then
				AixinmmController.instance:openView()
			elseif cfg.funcId == 247 then
				DiscountaccruingpayController.instance:openView()
			elseif cfg.funcId == 248 then
				ConsumediamondgiftController.instance:openView()
			elseif cfg.funcId == 252 then
				FamilyteamplayController.instance:openView()
			elseif cfg.funcId == 172 then
				EndlessBattleModel.instance:setNeedShowOneKey(true)
				UIStateManager.instance:push(cfg.view)
			elseif cfg.funcId == 300 then
				AnlongselfselectController.instance:openView()
			elseif cfg.funcId == 319 then
				CatchPropsController.instance:openActivityView()
			elseif cfg.funcId == 323 then
				DrawEquipmentsController.instance:openDrawEquipmentView(...)
			elseif cfg.funcId == 338 then
				ImagefragmentcollectionController.instance:openView()
			elseif cfg.funcId == 5019 then
				NianNianChallController.instance:openMainView()
			elseif cfg.funcId == 119 then
				YearCardController.instance:onClikcMainUIHud()
			elseif cfg.funcId == 493 then
				PetAwakenVerificationController.instance:funcOpenHandler(...)
			elseif cfg.funcId == 880 then
				LotusbattleController.instance:openView()
			elseif cfg.funcId == 982 then
				ElementSparkSceneController.instance:enterElementSpark()
			else
				if not string.nilorempty(cfg.view) then
					if ViewMgr.instance:isOpen(cfg.view) and ViewSetting.instance:isModal(cfg.view) then
						UIStateManager.instance:popByName(cfg.view)
					end

					UIStateManager.instance:push(cfg.view, ...)
				end

				if not string.nilorempty(cfg.jumpTo) then
					GotoMgr.gotoOnlyFuncCtrl(cfg.jumpTo)
				end

				SurveyController.instance:reportBehavior(cfg.reportBehavior)
			end
		else
			self:showLockTips(cfg)
		end
	end
end

function FuncOpenController:checkFuncIdOrShowLockTips(funcId)
	if FuncOpenModel.instance:getFuncIsOpen(funcId) then
		return true
	else
		local cfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)

		self:showLockTips(cfg)
	end

	return false
end

function FuncOpenController:getLockTips(cfg)
	if cfg then
		local tips = ""

		if not string.nilorempty(cfg.lockedTips) then
			tips = cfg.lockedTips
		elseif not string.nilorempty(cfg.openCondition) then
			tips = self:getConditionLockTips(cfg.openCondition)
		end

		return tips
	end
end

function FuncOpenController:showLockTips(cfg)
	local tips = self:getLockTips(cfg)

	if tips then
		if enableDebug then
			FloatWordMgr.instance:show(tips .. "[" .. cfg.funcId .. "]")
		else
			FloatWordMgr.instance:show(tips)
		end
	end
end

function FuncOpenController:loadOpenFuncInfo()
	return
end

function FuncOpenController:getFuncIsOpenByCfg(cfg)
	local matchPlat = ActivityPopupModel.instance:checkIsMatchPlatform(cfg.platformTypeLimit) and ActivityPopupModel.instance:checkIsMatchCochannel(cfg.cochannelLimit)

	if not matchPlat then
		return false
	end

	local isOpen = self:getConditionReached(cfg.openCondition, cfg.openTime)

	if not isOpen then
		return false
	end

	local isIndependentShow = self:_getIndependentCondition(cfg)

	if isIndependentShow ~= nil then
		return isIndependentShow
	end

	return self:getTimeReached(cfg.activityType, cfg.activityIds) and self:getOtherReachedById(cfg.funcId)
end

function FuncOpenController:_getIndependentCondition(cfg)
	if not cfg then
		return nil
	end

	if cfg.funcId == 119 and cfg.activityIds and cfg.activityIds[1] then
		return YearCardController.instance:isFuncOpen(cfg.activityIds[1])
	end

	return nil
end

function FuncOpenController:getConditionReached(openCondition, openTime)
	if not self:checkOpenTime(openTime) then
		return false
	elseif not FuncOpenModel.instance:isDataInited() then
		return false
	elseif type(openCondition) == "string" then
		return self:parseCondition(openCondition)
	elseif type(openCondition) == "table" then
		return self:checkCondition(openCondition)
	else
		return true
	end
end

function FuncOpenController:getTimeReached(activityType, activityIds)
	if not activityType or activityType <= 0 then
		return true
	end

	local isReached = false

	if activityIds then
		for i, id in ipairs(activityIds) do
			local isInTime = ActivityDefineController.instance:isInActivityTimeById(activityType, id)

			if isInTime then
				return true
			end
		end
	else
		local cfg = ActivityDefineController.instance:getActivityCfgByType(activityType)

		isReached = not not cfg
	end

	return isReached
end

function FuncOpenController:getOtherReachedById(funcId)
	local boo = true

	funcId = checknumber(funcId)

	if funcId == 93 then
		boo = WorldBossController.instance:isInBossFightTime()
	elseif funcId == 91 then
		boo = FamilyController.instance:getFamilyLv() > 0 and EscortModel.instance:IsOpenEscortView()
	elseif funcId == 297 then
		boo = AnswerSceneController.instance:checkAnswerSceneOpen()
	end

	return boo
end

function FuncOpenController:getConditionLockTips(openCondition)
	return "暂未开启"
end

function FuncOpenController._scriptCallback(str)
	local _self = FuncOpenController.instance

	return FuncOpenController.checkCondition(_self, _self:splitToArr(str, ","))
end

function FuncOpenController:parseCondition(input)
	if string.nilorempty(input) then
		return true
	end

	return GameUtil.expScript(input, FuncOpenController._scriptCallback)
end

function FuncOpenController:_filterOverTime(funcs)
	local list = {}
	local now = ServerTime.now()

	for _, func in ipairs(funcs) do
		local cfg = FuncOpenConfig.instance:getFunctionOpenById(func.funcId)
		local isNotOverActTime = self:getNotOverActTime(cfg.activityType, cfg.activityIds)

		if self:checkNotOverTime(cfg.openTime, now) and isNotOverActTime then
			table.insert(list, func)
		end
	end

	return list
end

function FuncOpenController:getNotOverActTime(activityType, activityIds)
	if not activityType or activityType <= 0 then
		return true
	end

	local isReached = false

	if activityIds then
		for i, id in ipairs(activityIds) do
			local isInTime = ActivityDefineController.instance:isInActivityNotOverTimeById(activityType, id)

			if isInTime then
				return true
			end
		end
	else
		local cfg = ActivityDefineController.instance:getActivityCfgByType(activityType)

		isReached = not not cfg
	end

	return isReached
end

function FuncOpenController:checkNotOverTime(openTime, now)
	if string.nilorempty(openTime) then
		return true
	else
		local conditionOR = self:splitToArr(openTime, "|")
		local res = true

		for _, t in ipairs(conditionOR) do
			local conditions = self:splitToArr(t, "&")

			for _, v in ipairs(conditions) do
				if not string.nilorempty(v) then
					local times = self:splitToArr(v, "#")

					if #times == 2 then
						res = false

						local timeEnd = GameUtil.string2time(times[2])

						if now <= timeEnd then
							return true
						end
					else
						return true
					end
				end
			end
		end

		return res
	end
end

function FuncOpenController:checkCondition(openCondition)
	local passCondition = false

	if not openCondition then
		passCondition = true
	else
		local type = checknumber(openCondition[1])

		if type == 1 then
			passCondition = TaskFacade.instance:isTaskStepFinished(checknumber(openCondition[2]), checknumber(openCondition[3]))
		elseif type == 2 then
			passCondition = checknumber(MofangModel.instance:getCurLv()) >= checknumber(openCondition[2])
		elseif type == 3 then
			passCondition = RoleModel.instance:getMaxPower() >= checknumber(openCondition[2])
		elseif type == 4 then
			passCondition = PlotCopyModel.instance:isStagePassed(checknumber(openCondition[2]), checknumber(openCondition[3]))
		elseif type == 5 then
			passCondition = MaterialChallengeModel.instance:isStagePassed(checknumber(openCondition[2]), checknumber(openCondition[3]))
		elseif type == 6 then
			local start = checknumber(openCondition[2])
			local duration = checknumber(openCondition[3])

			passCondition = GameUtil.isInOpenDaysByCreateRole(start, duration)
		elseif type == 7 then
			passCondition = HandbookModel.instance:isHasPet(checknumber(openCondition[2]))
		elseif type == 8 then
			local start = checknumber(openCondition[2])
			local duration = checknumber(openCondition[3])

			passCondition = GameUtil.isInOpenDaysByOpenDay(start, duration)
		elseif type == 101 then
			passCondition = SevenDaysModel.instance:IsOpenSevenDaysView(true)
		elseif type == 102 then
			passCondition = SevenDaysModel.instance:IsOpenExcellentClassView(0)
		elseif type == 103 then
			local cost = checknumber(RoleModel.instance:GetRole().consumeMoney)
			local cond = checknumber(openCondition[2])

			passCondition = cond == 0 and cond < cost or cond <= cost
		elseif type == 104 then
			local days = GameUtil.getOpenAreaDaysForFive()
			local cfg = ActivityDefineConfig.instance:getCfgById(13, 13001)
			local startDay = checknumber(cfg.startDay)
			local durationDay = checknumber(cfg.durationDay)

			passCondition = startDay <= days and days < startDay + durationDay
		elseif type == 105 then
			for i = 2, #openCondition do
				local v = checknumber(openCondition[i])

				passCondition = openCondition or RedPointModel.instance:isActive(v)
			end
		elseif type == 106 then
			local activityType = checknumber(openCondition[2])
			local activityId = checknumber(openCondition[3])

			passCondition = ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
		elseif type == 107 then
			local needCost = checknumber(openCondition[2])

			passCondition = needCost <= RoleModel.instance:getMyConsumeMoney()
		elseif type == 108 then
			local bossInfo = ShareTaskModel.instance:GetMyShareBossInfo()

			passCondition = bossInfo and bossInfo.isHaveBoss
		elseif type == 109 then
			local data = MaterialModel.instance:getMaterialsByTypeAndSub(MatType.Item_ConsumeLottery, MatType.Item)

			passCondition = data and data[1] and data[1]:GetCount() > 0
		elseif type == 9 then
			local curLv = WTowerController.instance:getMainProgress()

			passCondition = curLv >= checknumber(openCondition[2])
		elseif type == 10 then
			local needFamilyLv = checknumber(openCondition[2])

			passCondition = needFamilyLv <= FamilyModel.instance:getFamilyLv()
		elseif type == 110 then
			passCondition = RecallTaskModel.instance:isGetActivityOpen(false)
		elseif type == 111 then
			passCondition = RecallTaskModel.instance:isGetActivityOpen(true)
		elseif type == 112 then
			passCondition = NewhandwelfareModel.instance:isNewHandPlayer()
		elseif type == 113 then
			local time = GameUtil.string2time(tostring(openCondition[2]))
			local type = checknumber(openCondition[3])
			local playerTime = RoleModel.instance:getActiveTimeSec()

			if type == 0 then
				passCondition = playerTime < time
			elseif type == 1 then
				passCondition = time < playerTime
			end
		elseif type == 114 then
			return YearCardController.instance:isInYearCardpreorderTime()
		end
	end

	return passCondition
end

function FuncOpenController:checkOpenTime(openTime)
	if string.nilorempty(openTime) then
		return true
	else
		local conditionOR = self:splitToArr(openTime, "|")
		local resultOR = false

		for _, t in ipairs(conditionOR) do
			local conditions = self:splitToArr(t, "&")
			local resultAND = true

			for _, v in ipairs(conditions) do
				if not string.nilorempty(v) then
					local times = self:splitToArr(v, "#")

					if #times == 2 and not GameUtil.checkIsInTimePeriod(times[1], times[2]) then
						resultAND = false

						break
					end
				end
			end

			if resultAND == true then
				resultOR = resultAND

				break
			end
		end

		return resultOR
	end
end

FuncOpenController.instance = FuncOpenController.New()

return FuncOpenController
