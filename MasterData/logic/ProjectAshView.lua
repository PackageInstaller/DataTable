-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/projectash/view/ProjectAshView.lua

module("logic.extensions.projectash.view.ProjectAshView", package.seeall)

local ProjectAshView = class("ProjectAshView", ViewComponent)
local EnumStage = {
	Stage1 = 1,
	Stage2 = 2
}

function ProjectAshView:ctor()
	ProjectAshView.super.ctor(self)
end

function ProjectAshView:buildUI()
	ProjectAshView.super.buildUI(self)

	self._btnClose = self:getBtn("topLeft/btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._goldBarCon = self:getGo("goldBarCon")
	self._btnStage1 = self:getBtn("btnStage1")
	self._btnStage2 = self:getBtn("btnStage2")

	goutil.setActive(self._btnStage1.gameObject, true)
	goutil.setActive(self._btnStage2.gameObject, true)

	self._changeStage1 = self._btnStage1.gameObject:GetComponent(ComponentType.UIChangeGroup)
	self._changeStage2 = self._btnStage2.gameObject:GetComponent(ComponentType.UIChangeGroup)
	self._subStage1 = self:getGo("subStage1")
	self._subStage2 = self:getGo("subStage2")

	local playerRoot = self:getGo("subStage1/rewardRoot")

	self._playerSliderMo = PlayerSliderMo.New(playerRoot)
	self._txtScore = self:getTxt("subStage1/score/txtScore")
	self._btnTask = self:getBtn("subStage1/btnTask")
	self._shineEffect = self:getGo("subStage1/shineEffect")
	self._taskRed = self:getGo("subStage1/btnTask/redPoint")
	self._lotteryCostItems = {}

	for i = 1, 3 do
		local item = {}

		item.btn = self:getBtn("subStage1/prizes/item" .. i)
		item.icon = self:getGo("subStage1/prizes/item" .. i .. "/icon")
		item.txt = self:getTxt("subStage1/prizes/item" .. i .. "/txt")
		item.effect = self:getGo("subStage1/prizes/item" .. i .. "/effect")

		table.insert(self._lotteryCostItems, item)
	end

	self._lotteryGetItems = {}

	for i = 1, 5 do
		local item = {}

		item.goRect = self:getGo("subStage1/prizes/cell" .. i):GetComponent(goutil.Type_RectTransform)
		item.startPos = item.goRect.anchoredPosition
		item.btn = self:getBtn("subStage1/prizes/cell" .. i .. "/icon")
		item.icon = self:getGo("subStage1/prizes/cell" .. i .. "/icon")
		item.txtName = self:getTxt("subStage1/prizes/cell" .. i .. "/name/txt")
		item.txtNum = self:getTxt("subStage1/prizes/cell" .. i .. "/txt")

		table.insert(self._lotteryGetItems, item)
	end

	local worldRoot = self:getGo("subStage2/worldRoot")

	self._worldSliderMo = WorldSliderMo.New(worldRoot)
	self._btnSelect = self:getBtn("subStage2/btnSelect")
	self._btnRank = self:getBtn("subStage2/damageRank")
	self._rankList = {}

	for i = 1, 3 do
		self._rankList[i] = self:getTxt("subStage2/damageRank/rank" .. i .. "/txt")
	end

	self._personItem = self:getGo("subStage2/personReward/item")
	self._txtPersonDamageNum = self:getTxt("subStage2/personReward/txtNum")
	self._btnMore = self:getBtn("subStage2/personReward/btnMore")
	self._txtLeftNum = self:getTxt("subStage2/remain/txtNum")
	self._stage2Role = self:getGo("subStage2/role")
end

function ProjectAshView:bindEvents()
	ProjectAshView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnStage1:AddClickListener(self._onClickStage1, self)
	self._btnStage2:AddClickListener(self._onClickStage2, self)
	self._btnTask:AddClickListener(self._onClickTask, self)
	self._btnSelect:AddClickListener(self._onClickSelect, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnMore:AddClickListener(self._onClickMore, self)
	self._worldSliderMo:bindEvents()

	for i, v in ipairs(self._lotteryCostItems) do
		v.btn:AddClickListener(function()
			self:_onClickCostItem(i)
		end)
	end

	for i, v in ipairs(self._lotteryGetItems) do
		v.btn:AddClickListener(function()
			self:_onClickGetItem(i)
		end)
	end
end

function ProjectAshView:unbindEvents()
	ProjectAshView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnStage1:RemoveClickListener()
	self._btnStage2:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	self._btnSelect:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnMore:RemoveClickListener()
	self._worldSliderMo:unbindEvents()

	for i, v in ipairs(self._lotteryCostItems) do
		v.btn:RemoveClickListener()
	end

	for i, v in ipairs(self._lotteryGetItems) do
		v.btn:RemoveClickListener()
	end
end

function ProjectAshView:onEnter()
	ProjectAshView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.ProjectAshInfoRes, self._onProjectAshInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.ProjectAshGainPrizeRes, self._onProjectAshGainPrizeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.ProjectAshStage1LotteryRes, self._onProjectAshStage1LotteryRes, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self._onMaterialChange, self)
	GlobalDispatcher:addListener(GlobalNotify.EndStory, self._onStoryPlayFinished, self)
	self:_loadBgEffect()

	self._activityType = ProjectAshModel.instance:getActivityType()
	self._activityId = ProjectAshModel.instance:getActivityId()

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(self._activityType, self._activityId)

	if not isInTime then
		self:_showPopupView()

		return
	end

	self._cfgActivity = ProjectAshConfig.instance:getActivityCfg(self._activityId)
	self._stage1PrizePlanId = self._cfgActivity.stage1PrizePlanId
	self._stage1CostPlanId = self._cfgActivity.stage1CostPlanId
	self._stage2WorldPrizePlanId = self._cfgActivity.stage2WorldPrizePlanId
	self._stage2DamagePrizePlanId = self._cfgActivity.stage2DamagePrizePlanId
	self._showGolds = self._cfgActivity.showCoin
	self._dailyChallengeLimit = self._cfgActivity.dailyChallengeLimit
	self._cfgCostPlanList = ProjectAshConfig.instance:getCostPanCfgList(self._stage1CostPlanId)
	self._cfgLotteryList = ProjectAshConfig.instance:getShowLotteryCfgList(self._activityId)

	local stage = self:getFirstParam() or EnumStage.Stage1

	RedPointController.instance:regRedPoint(self._taskRed, self._cfgActivity.taskRedPointId)
	self:_changeTab(stage)
	self:_initRewardParams()
	self:_setPlayerScore()
	self:_setGoldBarCon()
	self:_initCostItems()
	self:_initGetItems()
	self:_initWorldParams()
	self:_updatePersonReward()
	self:_startTweenCells()
	self:_updateTodayLeftTimes()
	self:_showRoleModel()
	self:_updateShineEffectActive(false)
	self:_loadShineEffect()
	ProjectAshAgent.instance:sendPM_ProjectAshInfoReq(self._activityId)
end

function ProjectAshView:onExit()
	ProjectAshView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ProjectAshInfoRes, self._onProjectAshInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.ProjectAshGainPrizeRes, self._onProjectAshGainPrizeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.ProjectAshStage1LotteryRes, self._onProjectAshStage1LotteryRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self._onMaterialChange, self)
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._onStoryPlayFinished, self)
	RedPointController.instance:unregRedPoint(self._taskRed)
	self._playerSliderMo:onExit()
	self._worldSliderMo:onExit()
	self:_clearCostItems()
	self:_clearGetItems()
	self:_clearPersonReward()
	self:_clearTweenCells()
	self:_resetRoleModel()
	self:_clearBgEffect()
	self:_clearShineEffect()
	self:_updateShineEffectActive(false)
end

function ProjectAshView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "projectashview_rule")
end

function ProjectAshView:_onClickStage1()
	self:_changeTab(EnumStage.Stage1)
end

function ProjectAshView:_onClickStage2()
	self:_changeTab(EnumStage.Stage2)
end

function ProjectAshView:_onClickTask()
	UIStateManager.instance:push(ViewName.ProjectAshTaskView, self._activityId)
end

function ProjectAshView:_onClickSelect()
	UIStateManager.instance:updateParms(ViewName.ProjectAshView, {
		EnumStage.Stage2
	})
	UIStateManager.instance:push(ViewName.ProjectAshBuffView, self._activityId)
end

function ProjectAshView:_onClickRank()
	UIStateManager.instance:updateParms(ViewName.ProjectAshView, {
		EnumStage.Stage2
	})
	UIStateManager.instance:push(ViewName.ProjectAshRankView, self._activityId)
end

function ProjectAshView:_onClickMore()
	UIStateManager.instance:updateParms(ViewName.ProjectAshView, {
		EnumStage.Stage2
	})
	UIStateManager.instance:push(ViewName.ProjectAshRewardView, self._activityId)
end

function ProjectAshView:_onClickCostItem(index)
	local cfg = self._cfgCostPlanList[index]
	local item = self._lotteryCostItems[index]

	if cfg and item then
		local matType, matId, matNum = MaterialMgr.getMatParams(cfg.cost)

		if matNum <= MaterialModel.instance:getMaterialsNumber(matType, matId) and matNum > 0 then
			if ProjectAshController.instance:isLeftLotteryPrizeCount(self._activityId) then
				ProjectAshAgent.instance:sendPM_ProjectAshStage1LotteryReq(self._activityId, cfg.id)
				self:_updateShineEffectActive(false)
				self:_updateShineEffectActive(true)
			else
				FloatWordMgr.instance:show("奖池已空")
			end
		else
			FloatWordMgr.instance:show("当前道具不足")
		end
	end
end

function ProjectAshView:_onClickGetItem(index)
	local cfg = self._cfgLotteryList[index]
	local item = self._lotteryGetItems[index]

	if cfg and item then
		local matType, matId, matNum = MaterialMgr.getMatParams(cfg.prize)

		CommonTipsMgr.instance:openMaterialTips(item.icon, matType, matId, 0)
	end
end

function ProjectAshView:_onProjectAshInfoRes()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
	self._worldSliderMo:updateWorldReward()
	self._worldSliderMo:relocation()
	self:_setPlayerScore()
	self:_updateCostItems()
	self:_updateGetItems()
	self:_updateRankNames()
	self:_updatePersonReward()
	self:_updateTodayLeftTimes()
end

function ProjectAshView:_onProjectAshGainPrizeRes(prizeType)
	if prizeType == ProjectAshModel.PrizeType.stage1Prize then
		printInfo("test _onProjectAshGainPrizeRes", prizeType)
		self._playerSliderMo:updatePlayerReward()
		self:_setPlayerScore()
	elseif prizeType == ProjectAshModel.PrizeType.stage2DamagePrize then
		self:_updatePersonReward()
	elseif prizeType == ProjectAshModel.PrizeType.stage2WorldPrize then
		self._worldSliderMo:updateWorldReward()
	end
end

function ProjectAshView:_onProjectAshStage1LotteryRes(changeSetId)
	self:_updateGetItems()
	TweenUtil.DoDelay(1.2, function()
		self:_updateShineEffectActive(false)
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end)
end

function ProjectAshView:_onMaterialChange()
	printInfo("test ProjectAshView:_onMaterialChange")
	self:_updateCostItems()
end

function ProjectAshView:_onStoryPlayFinished(storyId)
	return
end

function ProjectAshView:_changeTab(index)
	local stage = index

	if stage == EnumStage.Stage2 and not string.nilorempty(self._cfgActivity.stage2OpenTime) then
		local startTime = GameUtil.string2time(self._cfgActivity.stage2OpenTime)

		if startTime > ServerTime.now() then
			stage = EnumStage.Stage1

			local startDate = GameUtil.time2date(startTime)

			FloatWordMgr.instance:show(string.format("第二阶段 开启时间：%d%s%d%s 5:00", startDate.month, lang("mail_mon"), startDate.day, lang("mail_day")))
		end
	end

	if stage == EnumStage.Stage1 then
		self._changeStage1:SetState(1)
		self._changeStage2:SetState(0)
		goutil.setActive(self._subStage1, true)
		goutil.setActive(self._subStage2, false)
	else
		self._changeStage1:SetState(0)
		self._changeStage2:SetState(1)
		goutil.setActive(self._subStage1, false)
		goutil.setActive(self._subStage2, true)
	end
end

function ProjectAshView:_initRewardParams()
	local prizeType = ProjectAshModel.PrizeType.stage1Prize
	local playerParam = {}

	playerParam.view = self
	playerParam.prizeCfgs = ProjectAshConfig.instance:getProgressPrizeCfgList(self._stage1PrizePlanId)

	function playerParam.getPlayerProgress()
		return ProjectAshModel.instance:getRewardProgress()
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return checknumber(rewardCfg.progress)
	end

	function playerParam.getPrizeByRewardCfg(rewardCfg)
		local prizes = string.split(rewardCfg.prize, "#")

		return prizes[1]
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		return ProjectAshModel.instance:isPlayerRewardCanGet(prizeType, rewardCfg.id, rewardCfg.progress)
	end

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return ProjectAshModel.instance:isPlayerRewardGeted(prizeType, rewardCfg.id)
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		if rewardCfg.storyId > 0 then
			GlobalDispatcher:dispatch(GlobalNotify.StartStory, rewardCfg.storyId)
		end

		ProjectAshAgent.instance:sendPM_ProjectAshGainPrizeReq(self._activityId, prizeType, rewardCfg.id)
	end

	local isSkipAnimation = true

	self._playerSliderMo:initParam(playerParam, isSkipAnimation)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function ProjectAshView:_showPopupView()
	local title = lang("tip")
	local text = lang("outtime")

	local function func()
		self:close()
	end

	TipsFacade.instance:openTipWindowNoX(title, text, func, btnText)
end

function ProjectAshView:_setPlayerScore()
	self._txtScore.text = ProjectAshModel.instance:getRewardProgress()
end

function ProjectAshView:_setGoldBarCon()
	if string.nilorempty(self._showGolds) then
		return
	end

	local list = string.split(self._showGolds, "#")
	local objList = {}

	for i, v in ipairs(list) do
		local element = {}

		element.id = v
		element.showAdd = true

		table.insert(objList, element)
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
end

function ProjectAshView:_initCostItems()
	for i, v in ipairs(self._cfgCostPlanList) do
		local item = self._lotteryCostItems[i]

		if item then
			local matType, matId, matNum = MaterialMgr.getMatParams(v.cost)

			MaterialMgr.setIcon(item.icon, matType, matId)

			local num = MaterialModel.instance:getMaterialsNumber(matType, matId)

			item.txt.text = num

			if num > 0 then
				self:_loadCircleEffect(item.effect)
			else
				self:_clearCircleEffect(item.effect)
			end
		end
	end
end

function ProjectAshView:_updateCostItems()
	for i, v in ipairs(self._cfgCostPlanList) do
		local item = self._lotteryCostItems[i]

		if item then
			local matType, matId, matNum = MaterialMgr.getMatParams(v.cost)
			local num = MaterialModel.instance:getMaterialsNumber(matType, matId)

			item.txt.text = num

			if num > 0 then
				self:_loadCircleEffect(item.effect)
			else
				self:_clearCircleEffect(item.effect)
			end
		end
	end
end

function ProjectAshView:_clearCostItems()
	for i, v in ipairs(self._lotteryCostItems) do
		MaterialMgr.clearIcon(v.icon)
		self:_clearCircleEffect(v.effect)
	end
end

function ProjectAshView:_initGetItems()
	if self._cfgLotteryList then
		for i, v in ipairs(self._cfgLotteryList) do
			local item = self._lotteryGetItems[i]

			if item then
				local matType, matId, matNum = MaterialMgr.getMatParams(v.prize)

				MaterialMgr.setIcon(item.icon, matType, matId)

				item.txtName.text = MaterialMgr.getMaterialsName(matType, matId) .. "*" .. matNum

				local leftNum = v.limitTimes - ProjectAshModel.instance:getLotteryTimes(v.id)

				leftNum = Mathf.Max(leftNum, 0)
				item.txtNum.text = string.format("剩余：%d", leftNum)
			end
		end
	end
end

function ProjectAshView:_updateGetItems()
	if self._cfgLotteryList then
		for i, v in ipairs(self._cfgLotteryList) do
			local item = self._lotteryGetItems[i]

			if item then
				local matType, matId, matNum = MaterialMgr.getMatParams(v.prize)
				local leftNum = v.limitTimes - ProjectAshModel.instance:getLotteryTimes(v.id)

				leftNum = Mathf.Max(leftNum, 0)
				item.txtNum.text = string.format("剩余：%d", leftNum)
			end
		end
	end
end

function ProjectAshView:_clearGetItems()
	for i, v in ipairs(self._lotteryGetItems) do
		MaterialMgr.clearIcon(v.icon)
	end
end

function ProjectAshView:_initWorldParams()
	local prizeType = ProjectAshModel.PrizeType.stage2WorldPrize
	local worldParam = {}

	worldParam.view = self
	worldParam.isShowDefaultPos = true
	worldParam.prizeCfgs = ProjectAshConfig.instance:getProgressPrizeCfgList(self._stage2WorldPrizePlanId)

	local maxScore = checknumber(worldParam.prizeCfgs[#worldParam.prizeCfgs].progress)
	local reverseList = {}

	for i, v in ipairs(worldParam.prizeCfgs) do
		table.insert(reverseList, 1, v)
	end

	worldParam.prizeCfgs = reverseList

	function worldParam.getWorldProgress()
		return maxScore - ProjectAshModel.instance:getWorldProgress()
	end

	function worldParam.getNeedScoreByRewardCfg(rewardCfg)
		return maxScore - checknumber(rewardCfg.progress)
	end

	function worldParam.getScoreTxtByCfg(rewardCfg)
		return (maxScore - checknumber(rewardCfg.progress)) / 100000000 .. "亿"
	end

	function worldParam.isWorldRewardCanGet(rewardCfg)
		return ProjectAshModel.instance:isPlayerRewardCanGet(prizeType, rewardCfg.id, rewardCfg.progress)
	end

	function worldParam.isWorldRewardGeted(rewardCfg)
		return ProjectAshModel.instance:isPlayerRewardGeted(prizeType, rewardCfg.id)
	end

	function worldParam.isAnyWorldRewardCanGet()
		return false
	end

	function worldParam.sendGainWorldPrizeReq(rewardCfg)
		local myDamage = ProjectAshModel.instance:getMyDamage()

		if myDamage > 0 then
			ProjectAshAgent.instance:sendPM_ProjectAshGainPrizeReq(self._activityId, prizeType, rewardCfg.id)
		else
			FloatWordMgr.instance:show("需攻打1次BOSS才能领取奖励")
		end
	end

	function worldParam.getPrizeText(rewardCfg)
		local num = maxScore - ProjectAshModel.instance:getWorldProgress()
		local str = num >= 100000000 and Mathf.Round(num / 100000000) .. "亿" or num

		return string.format("剩余血量:\n<color=#F8D200FF>%s</color>", str)
	end

	self._worldSliderMo:initParam(worldParam)
	self._worldSliderMo:onEnter()
	self._worldSliderMo:updateWorldReward()
	self._worldSliderMo:relocation()
end

function ProjectAshView:_updateRankNames()
	for i, v in ipairs(self._rankList) do
		local name = ProjectAshModel.instance:getTopNName(i)

		v.text = string.nilorempty(name) and i .. "、" or string.format("%d、%s", i, name)
	end
end

function ProjectAshView:_updatePersonReward()
	local myDamage = ProjectAshModel.instance:getMyDamage()
	local cfgProgressPrize = ProjectAshController.instance:getNextCfg(self._stage2DamagePrizePlanId, myDamage)

	if cfgProgressPrize then
		MaterialMgr.setCellByCfg(cfgProgressPrize.prize, self._personItem)

		self._txtPersonDamageNum.text = string.format("%d/%d", myDamage, cfgProgressPrize.progress)
	else
		self._txtPersonDamageNum.text = "0/0"
	end
end

function ProjectAshView:_clearPersonReward()
	MaterialMgr.resetAll(self._personItem)
end

function ProjectAshView:_startTweenCells()
	self:_clearTweenCells()

	self._tweenList = self._tweenList or {}

	for i, v in ipairs(self._lotteryGetItems) do
		Framework.TransformUtil.SetAnchoredPos(v.goRect, v.startPos.x, v.startPos.y)

		local delay = i * 0.2
		local relativeEndY = 10
		local infinite = -1
		local tween = v.goRect:DOAnchorPosY(relativeEndY, 2):SetDelay(delay):SetEase(DG.Tweening.Ease.InOutQuad):SetLoops(infinite, DG.Tweening.LoopType.Yoyo):SetRelative()

		table.insert(self._tweenList, tween)
	end
end

function ProjectAshView:_clearTweenCells()
	if self._tweenList then
		for i, tween in ipairs(self._tweenList) do
			tween:Kill()
		end
	end

	table.clear(self._tweenList)
end

function ProjectAshView:_updateTodayLeftTimes()
	local totalNum = self._dailyChallengeLimit
	local curUsedTimes = ProjectAshModel.instance:getTodayChallengeTimes()
	local leftNum = totalNum - curUsedTimes

	leftNum = Mathf.Max(leftNum, 0)

	if leftNum > 0 then
		if not ColorConst.White then
			local colorStr = ColorConst.Red

			self._txtLeftNum.text = string.format("今日次数：<color=#%s>%d</color>/%d", colorStr, leftNum, totalNum)
		end
	end
end

function ProjectAshView:_showRoleModel()
	local curFaceId = 12012
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._stage2Role, scale, nil, true, x, y)
end

function ProjectAshView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function ProjectAshView:_loadBgEffect()
	self:_clearBgEffect()

	local uiEffect = UIEffectManager.instance:playEffect(self, ProjectAshViewPresentor.EffectBg, self.mainGO.transform, 0, 0, true, false)

	uiEffect:setScale(1)
	uiEffect:setParent(self.mainGO.transform)
	uiEffect:setLocalPos(0, 0, 0)

	self._bgUIEffect = uiEffect
end

function ProjectAshView:_clearBgEffect()
	if self._bgUIEffect then
		UIEffectManager.instance:stopEffect(self._bgUIEffect)

		self._bgUIEffect = nil
	end
end

function ProjectAshView:_loadCircleEffect(go)
	self:_clearCircleEffect(go)

	self._circleUIEffects = self._circleUIEffects or {}

	local uiEffect = UIEffectManager.instance:playEffect(self, ProjectAshViewPresentor.EffectCircle, go.transform, 0, 0, true, false)

	uiEffect:setScale(1)
	uiEffect:setParent(go.transform)
	uiEffect:setLocalPos(0, 0, 0)

	self._circleUIEffects[go] = uiEffect
end

function ProjectAshView:_clearCircleEffect(go)
	if self._circleUIEffects and self._circleUIEffects[go] then
		UIEffectManager.instance:stopEffect(self._circleUIEffects[go])

		self._circleUIEffects[go] = nil
	end
end

function ProjectAshView:_loadShineEffect()
	self:_clearShineEffect()

	local uiEffect = UIEffectManager.instance:playEffect(self, ProjectAshViewPresentor.EffectShine, self._shineEffect.transform, 0, 0, true, false)

	uiEffect:setScale(1)
	uiEffect:setParent(self._shineEffect.transform)
	uiEffect:setLocalPos(0, 0, 0)

	self._shineUIEffect = uiEffect
end

function ProjectAshView:_clearShineEffect()
	if self._shineUIEffect then
		UIEffectManager.instance:stopEffect(self._shineUIEffect)

		self._shineUIEffect = nil
	end
end

function ProjectAshView:_updateShineEffectActive(isActive)
	goutil.setActive(self._shineEffect, isActive)
end

return ProjectAshView
