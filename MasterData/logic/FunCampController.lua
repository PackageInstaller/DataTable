-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/controller/FunCampController.lua

module("logic.extensions.funcamp.controller.FunCampController", package.seeall)

local FunCampController = class("FunCampController", BaseController)

FunCampController.Default = 0
FunCampController.Select = 1
FunCampController.SelectFinish = 2
FunCampController.Inspire = 3
FunCampController.Compete = 4
FunCampController.Reward = 5

function FunCampController:ctor()
	return
end

function FunCampController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self._onStartEnterGame, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._TickDailyRefreshData, self)
	GlobalDispatcher:addListener(GlobalNotify.RoleLogined, self._regRedPoint, self)
	self:_regRedPoint()
end

function FunCampController:onReset()
	return
end

function FunCampController:_TickDailyRefreshData()
	self:_regRedPoint()
	self:_initActivityId()
end

function FunCampController:_regRedPoint()
	RedPointController.instance:regUserDayRedPoint(RedPointModel.ID_FUN_CAMP_RANK)
	RedPointController.instance:regUserDayRedPoint(RedPointModel.ID_FUN_CAMP_DAILY)
end

function FunCampController:markDailyRedPoint()
	RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_FUN_CAMP_DAILY)
end

function FunCampController:_onStartEnterGame()
	self:_initActivityId()
end

function FunCampController:sendPM_CB_GetRankInfoReq(activityId, campId)
	FunCampAgent.instance:sendPM_CB_GetRankInfoReq(activityId, campId)
end

function FunCampController:handlePM_CB_GetRankInfoRes(msg)
	FunCampModel.instance:setRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FunCampRankTop5Res)
end

function FunCampController:sendPM_CB_FindReq(activityId)
	FunCampAgent.instance:sendPM_CB_FindReq(activityId)
end

function FunCampController:handlePM_CB_FindRes(msg)
	FunCampModel.instance:setCurNpcAndSceneId(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FunCampFindNpc)
end

function FunCampController:startFind()
	ViewAutoShowController.instance:clearAllSaveModal()
	UIStateManager.instance:popByName(ViewName.FunCampMainView)
	UIStateManager.instance:popByName(ViewName.FunCampCompeteView)
	UIStateManager.instance:popByName(ViewName.FuncampInvadersView)

	if SceneMgr.instance:getCurSceneId() == FunCampModel.instance:getCurSceneId() then
		UIStateManager.instance:open(ViewName.FuncampFindingView)
	else
		self:gotoFindNPC()
	end
end

function FunCampController:gotoFindNPC()
	if EscortModel.instance:IsPickupEscort() then
		FloatWordMgr.instance:show("当前正在护送")

		return
	end

	local targetSceneId = FunCampModel.instance:getCurSceneId()

	if targetSceneId > 0 then
		local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

		if mainPlayer and mainPlayer.spine then
			mainPlayer:gotoScene(targetSceneId, function()
				if not ViewMgr.instance:isOpen(ViewName.FuncampFindingView) then
					UIStateManager.instance:open(ViewName.FuncampFindingView)
				end
			end)
		end
	end
end

function FunCampController:getNpcPosXAndY()
	local x, y
	local curNpcId = FunCampModel.instance:getCurNpcId()
	local scene = SceneMgr.instance:getCurScene()
	local unitNpc = scene.unitFactory:getUnit(UnitTag.Npc, curNpcId)

	if unitNpc then
		x, y = unitNpc.transform:getPos()
	else
		SceneNpcsMgr.instance:createNpc(curNpcId)

		unitNpc = scene.unitFactory:getUnit(UnitTag.Npc, curNpcId)

		if unitNpc then
			x, y = unitNpc.transform:getPos()
		end
	end

	return x, y
end

function FunCampController:overRemoveNpc()
	local curNpcId = FunCampModel.instance:getCurNpcId()
	local scene = SceneMgr.instance:getCurScene()
	local unitNpc = scene.unitFactory:getUnit(UnitTag.Npc, curNpcId)
	local isCanRemove = FunCampModel.instance:getLastPetState()

	if unitNpc and isCanRemove then
		SceneNpcsMgr.instance:removeNpc(curNpcId)
		FunCampModel.instance:setLastPetState(false)
	end
end

function FunCampController:sendPM_CB_FightReq(actId, curForm)
	BattleFacade.instance:registerResultHandler(self._handleBattleEnd, self)

	local simpleForm = curForm:createFormPb()

	FunCampAgent.instance:sendPM_CB_FightReq(actId, simpleForm)
end

function FunCampController:_handleBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)

	local function succHandler()
		UIJumper.instance:pushOneStack(ViewName.FunCampMainView)
		UIJumper.instance:pushOneStack(ViewName.FuncampInvadersView)
		ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
		self:overRemoveNpc()
	end

	local function failHandler()
		ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
	end

	if BattleModel.instance.battleResult == GameEnum.BattleResult.ExpSuccess then
		succHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Success then
		succHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.DogFall then
		failHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Failed then
		failHandler()
	end

	return true
end

function FunCampController:isInActTime()
	local isInTime = CampGameConfig.instance:getOpenActivityId()

	if isInTime <= 0 then
		return false
	end

	return true
end

function FunCampController:playAnimEveryDay(path, storyId, openFunc)
	local key = FunCampModel.KeyAnim1 .. path
	local value = GameUtil.getUserDayData(key, function(value)
		if checknumber(value) == 0 then
			ViewBlockMgr.instance:blockClick(true, self)
			AnimationPlayer.play(path, function()
				ViewBlockMgr.instance:blockClick(false, self)
				self:playStoryOnce(storyId, openFunc)
			end)
			GameUtil.saveUserDayData(key, 1)
		end
	end)
end

function FunCampController:playStoryOnce(storyId, openFunc)
	local key = FunCampModel.KeyStory1 .. storyId

	GameUtil.getUserData(key, function(value)
		if checknumber(value) == 0 then
			if storyId > 0 then
				if openFunc then
					openFunc()
				end

				GlobalDispatcher:dispatch(GlobalNotify.StartStory, storyId)
			end

			GameUtil.saveUserData(key, 1)
		end
	end)
end

function FunCampController:_initActivityId()
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.FUN_CAMP_BATTLE)

	if cfg then
		printInfo("test FunCampController初始化活动 activityId = ", cfg.activityId)

		local oldActivityId = FunCampModel.instance:getActivityId()

		FunCampModel.instance:setActivityId(cfg.activityId)

		if oldActivityId > 0 and oldActivityId ~= cfg.activityId then
			GlobalDispatcher:dispatch(GlobalNotify.FunCampChangeActivityId)
		end
	else
		FunCampModel.instance:setActivityId(187001)
	end
end

function FunCampController:getCurStage()
	local cfg = FunCampConfig.instance:getActivityCfg(FunCampModel.instance:getActivityId())

	if not cfg then
		return FunCampController.Default
	end

	if GameUtil.checkIsInTimePeriod(cfg.selectStartTime, cfg.selectEndTime) then
		if not FunCampModel.instance:isSelectCamp() then
			return FunCampController.Select
		else
			return FunCampController.SelectFinish
		end
	elseif GameUtil.checkIsInTimePeriod(cfg.inspireStartTime, cfg.inspireEndTime) then
		return FunCampController.Inspire
	elseif GameUtil.checkIsInTimePeriod(cfg.battleStartTime, cfg.battleEndTime) then
		return FunCampController.Compete
	elseif GameUtil.checkIsInTimePeriod(cfg.prizeStartTime, cfg.prizeEndTime) then
		return FunCampController.Reward
	else
		return FunCampController.Default
	end
end

function FunCampController:getBtnMainTxt(curStage)
	if curStage == FunCampController.Select then
		return "阵营选择", 1
	elseif curStage == FunCampController.SelectFinish then
		return "选择完成", 2
	elseif curStage == FunCampController.Inspire then
		return "阵营鼓舞", 3
	elseif curStage == FunCampController.Compete then
		return "阵营比拼", 4
	elseif curStage == FunCampController.Reward then
		return "瓜分大奖", 5
	else
		return "瓜分大奖", 5
	end
end

function FunCampController:isShowBtnMain(curStage)
	if curStage == FunCampController.Select then
		return true
	elseif curStage == FunCampController.SelectFinish then
		return true
	elseif curStage == FunCampController.Inspire then
		return true
	elseif curStage == FunCampController.Compete then
		return true
	elseif curStage == FunCampController.Reward then
		return false
	else
		return false
	end
end

function FunCampController:isShowBox(curStage)
	if curStage == FunCampController.Reward then
		return true
	else
		return false
	end
end

function FunCampController:getStageEndTimestamp(curStage)
	local cfg = FunCampConfig.instance:getActivityCfg(FunCampModel.instance:getActivityId())

	if not cfg then
		return ServerTime.now()
	end

	if curStage == FunCampController.Select then
		return GameUtil.string2time(cfg.selectEndTime)
	elseif curStage == FunCampController.SelectFinish then
		return GameUtil.string2time(cfg.inspireStartTime)
	elseif curStage == FunCampController.Inspire then
		return GameUtil.string2time(cfg.inspireEndTime)
	elseif curStage == FunCampController.Compete then
		return GameUtil.string2time(cfg.battleEndTime)
	elseif curStage == FunCampController.Reward then
		return GameUtil.string2time(cfg.prizeEndTime)
	else
		return ServerTime.now()
	end
end

function FunCampController:onClickAddBuyGameTimes(activityId, gameBuyPlanId, maxGameTimes)
	local curGameTime = FunCampModel.instance:getCurFlipGameTimes()
	local maxGameTime = FunCampModel.instance:getTotalMaxGameTimes(maxGameTimes)
	local isLeftTime = curGameTime < maxGameTime

	if isLeftTime then
		FloatWordMgr.instance:show("次数用完才可购买哦")

		return
	end

	local buyTimes = FunCampModel.instance:getGameBuyTimes()
	local cfg = FunCampConfig.instance:getGameBuyCost(gameBuyPlanId, buyTimes)

	if cfg then
		local type, id, count = MaterialMgr.getMatParams(cfg.cost)
		local content = langPara("是否花费%s%s增加1次次数", count, MaterialMgr.getMaterialsName(type, id))

		TipsFacade.instance:openPopupCostMatViewNew(type, id, count, content, function()
			FunCampAgent.instance:sendPM_CB_BuyTimeReq(activityId, FunCampModel.BuyType1)
		end)
	end
end

function FunCampController:onClickAddBuyDonateTimes(activityId, donateBuyPlanId, maxDonateTimes, type)
	local curTime = FunCampModel.instance:getDonateTimes()
	local maxTime = FunCampModel.instance:getTotalMaxDonateTimes(maxDonateTimes)
	local isLeftTime = curTime < maxTime

	if isLeftTime then
		FloatWordMgr.instance:show("次数用完才可购买哦")

		return
	end

	local buyTimes = FunCampModel.instance:getDonateBuyTimes()
	local cfg = FunCampConfig.instance:getDonateBuyCost(donateBuyPlanId, type, buyTimes)

	if cfg then
		local matType, id, count = MaterialMgr.getMatParams(cfg.cost)
		local content = langPara("是否花费%s%s增加1次次数", count, MaterialMgr.getMaterialsName(matType, id))

		TipsFacade.instance:openPopupCostMatViewNew(matType, id, count, content, function()
			FunCampAgent.instance:sendPM_CB_BuyDonateTimesReq()
		end)
	end
end

function FunCampController:onClickAddBuyIntrusionTimes()
	local activityId = FunCampModel.instance:getActivityId()
	local cfgActivityNpc = FunCampNpcConfig.instance:getCfgById(activityId)
	local maxIntrusionTimes = cfgActivityNpc.dailyTimes
	local curGameTime = FunCampModel.instance:getIntrusionTimes()
	local maxGameTime = FunCampModel.instance:getMaxIntrusionBuyTimes(maxIntrusionTimes)
	local maxBuyTime = FunCampNpcConfig.instance:getGameBuyMax()
	local isLeftTime = curGameTime < maxGameTime

	if isLeftTime then
		FloatWordMgr.instance:show("次数用完才可购买哦")

		return
	elseif maxGameTime >= maxBuyTime + checknumber(maxIntrusionTimes) then
		FloatWordMgr.instance:show("已经没有购买次数了")

		return
	end

	local buyTimes = FunCampModel.instance:getIntrusionBuyTimes()
	local cfg = FunCampNpcConfig.instance:getGameBuyCost(buyTimes + 1)
	local type, id, count = MaterialMgr.getMatParams(cfg.cost)
	local content = langPara("是否花费%s*%s购买入侵次数？", MaterialMgr.getMaterialsName(type, id), count)

	TipsFacade.instance:openPopupCostMatViewNew(type, id, count, content, function()
		FunCampAgent.instance:sendPM_CB_BuyTimeReq(activityId, FunCampModel.BuyType2)
	end)
end

function FunCampController:onClickDonate(donateType, donateId, maxCoinDonateTimes)
	local activityId = FunCampModel.instance:getActivityId()
	local curTime = FunCampModel.instance:getDonateTimes()
	local maxTime = FunCampModel.instance:getTotalMaxDonateTimes(maxCoinDonateTimes)
	local isLeftTime = curTime < maxTime

	if not isLeftTime then
		FloatWordMgr.instance:show("捐献次数已经用完了")

		return
	end

	local cfg = FunCampConfig.instance:getCoinModeCfg(activityId, donateType, donateId)

	if cfg then
		local matType, id, count = MaterialMgr.getMatParams(cfg.cost)
		local content = langPara("是否消耗%s%s进行鼓舞，鼓舞成功后将获得对应的鼓舞奖励", count, MaterialMgr.getMaterialsName(matType, id))

		TipsFacade.instance:openPopupCostMatViewNew(matType, id, count, content, function()
			FunCampAgent.instance:sendPM_CB_DonateCoinsReq(activityId, donateType, donateId)
		end)
	end
end

FunCampController.instance = FunCampController.New()

return FunCampController
