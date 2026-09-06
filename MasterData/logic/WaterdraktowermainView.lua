-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/WaterdraktowermainView.lua

module("logic.extensions.waterdraktower.view.WaterdraktowermainView", package.seeall)

local WaterdraktowermainView = class("WaterdraktowermainView", ViewComponent)

WaterdraktowermainView.LastTowerType = "WaterdraktowermainView.LastTowerType"

local TowerType = {
	Water = 1,
	Drak = 2
}

function WaterdraktowermainView:ctor()
	WaterdraktowermainView.super.ctor(self)
end

function WaterdraktowermainView:buildUI()
	WaterdraktowermainView.super.buildUI(self)

	self._btnRule = self:getBtn("btnRule")
	self._btnStart = self:getBtn("btnStart")
	self._btnRank = self:getBtn("btnRank")
	self._btnClose = self:getBtn("btnClose")
	self._txtActTime = goutil.findChildTextComponent(self.mainGO, "txtActTime")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "rightRoot/txtName")
	self._txtLeftRewardCont = goutil.findChildTextComponent(self.mainGO, "rightRoot/txtLeftRewardCont")
	self._txtBtnStart = goutil.findChildTextComponent(self.mainGO, "btnStart/txtBtnStart")
	self._baseRewarditemGo = self:getGo("rightRoot/baseReward/item")
	self._baseRewardGo = self:getGo("rightRoot/baseReward")
	self._baseRewardGroup = ItemGroup.New(self._baseRewardGo, self._baseRewarditemGo, nil, nil, true)
	self._extRewardGo = self:getGo("rightRoot/extReward")
	self._extRewarditemGo = self:getGo("rightRoot/extReward/item")
	self._extRewardGroup = ItemGroup.New(self._extRewardGo, self._extRewarditemGo, nil, nil, true)
	self._levelProgressGo = self:getGo("rightRoot/levelProgress")
	self._levelProgressitemGo = self:getGo("rightRoot/levelProgress/item")
	self._levelProgressSizeX = self._levelProgressGo.transform.sizeDelta.x
	self._levelProgressGroup = ItemGroup.New(self._levelProgressGo, nil, nil, nil, true)
	self._rolecon = self:getGo("rightRoot/rolecon")
	self._starGos = {}
	self._btnChangeTower = self:getBtn("leftRoot/btnChangeTower")
	self._btnAddTime = self:getBtn("btnAddTime")
	self._goldBarConGo = self:getGo("goldBarCon")
	self._text_clone3Go = self:getGo("rightRoot/text_clone3")
	self._text_clone2Go = self:getGo("rightRoot/text_clone2")
	self._txtLeftTime = goutil.findChildTextComponent(self.mainGO, "btnAddTime/txtLeftTime")
	self._allPassTipGo = self:getGo("allPassTip")
	self._btnAddTimeGo = self:getGo("btnAddTime")
	self._changegroup = self:getGo("changegroup"):GetComponent(ComponentType.UIChangeGroup)
	self._effectGo = self:getGo("effect")
	self._bg = self:getGo("bg")
end

function WaterdraktowermainView:bindEvents()
	WaterdraktowermainView.super.bindEvents(self)
	self._btnRule:AddClickListener(self._onClickbtnRule, self)
	self._btnStart:AddClickListener(self._onClickbtnStart, self)
	self._btnRank:AddClickListener(self._onClickbtnRank, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnChangeTower:AddClickListener(self._onClickbtnChangeTower, self)
	self._btnAddTime:AddClickListener(self._onClickbtnAddTime, self)
end

function WaterdraktowermainView:unbindEvents()
	WaterdraktowermainView.super.unbindEvents(self)
	self._btnRule:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnChangeTower:RemoveClickListener()
	self._btnAddTime:RemoveClickListener()
end

function WaterdraktowermainView:destroyUI()
	WaterdraktowermainView.super.destroyUI(self)
end

function WaterdraktowermainView:onEnter()
	WaterdraktowermainView.super.onEnter(self)
	GlobalDispatcher:addListener(WaterdraktowerController.PM_WaterDarkTowerGetInfoRes, self._PM_WaterDarkTowerGetInfoRes, self)
	GlobalDispatcher:addListener(WaterdraktowerController.PM_WaterDarkTowerBuyTimesRes, self._PM_WaterDarkTowerBuyTimesRes, self)

	self._actType = GameEnum.ActivityType.WaterDrakTower
	self._actId = self:getFirstParam()
	self._tier = 0

	local lastType = GameUtil.getUserData(WaterdraktowermainView.LastTowerType)

	lastType = checknumber(lastType)

	if lastType > 0 then
		self:_swithchTowerType(lastType, true)
	else
		self:_swithchTowerType(TowerType.Water, true)
	end

	self:_setActTime()

	local btn_list = {
		{
			showAdd = true,
			id = GameEnum.GoldType.Diamond
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarConGo, self._viewPresentor, btn_list, false)
	self:_checkPassRankShow()
end

function WaterdraktowermainView:onEnterFinished()
	WaterdraktowermainView.super.onEnterFinished(self)
end

function WaterdraktowermainView:onExit()
	WaterdraktowermainView.super.onExit(self)
	GlobalDispatcher:removeListener(WaterdraktowerController.PM_WaterDarkTowerGetInfoRes, self._PM_WaterDarkTowerGetInfoRes, self)
	GlobalDispatcher:removeListener(WaterdraktowerController.PM_WaterDarkTowerBuyTimesRes, self._PM_WaterDarkTowerBuyTimesRes, self)
	self._baseRewardGroup:dispose(function(item)
		local con = goutil.findChild(item.mainGO, "con")

		MaterialMgr.resetAll(con)
	end)
	self._extRewardGroup:dispose(function(item)
		local con = goutil.findChild(item.mainGO, "con")

		MaterialMgr.resetAll(con)
	end)
	self:_clearEffect()
	GlobalModel.instance:setUIInteractable(true)
	removetimer(self._finishEffect, self)
	uGuiUtil.clearImage(self._bg)
end

function WaterdraktowermainView:onExitFinished()
	WaterdraktowermainView.super.onExitFinished(self)
end

function WaterdraktowermainView:_onClickbtnClose()
	self:close()
end

function WaterdraktowermainView:_onClickbtnRule()
	TipsFacade.instance:openRulesView("waterdraktower")
end

function WaterdraktowermainView:_onClickbtnStart()
	local leftTime = self:_getLeftChallengeTime()

	if leftTime <= 0 then
		FloatWordMgr.instance:show("挑战次数不足")

		return
	end

	if self._tierCfgs then
		local passStage = WaterdraktowerModel.instance:getPassStage()
		local nextChallengeCfg = self._tierCfgs[passStage + 1]

		if nextChallengeCfg then
			UIStateManager.instance:push(ViewName.WaterdraktowerMission, self._actId, nextChallengeCfg, self._towerType)
		end
	end
end

function WaterdraktowermainView:_onClickbtnRank()
	UIStateManager.instance:push(ViewName.WaterdraktowerrankView, self._actId)
end

function WaterdraktowermainView:_onClickbtnAddTime()
	local dailyBuyTimes = WaterdraktowerModel.instance:getDayliBuyTime()
	local leftTime = self:_getLeftChallengeTime()

	if leftTime > 0 then
		FloatWordMgr.instance:show("还有挑战次数")
	else
		local buyCfg = WaterdraktowerConfig.instance:getBuyTimeCfg(self._actCfg.buyTimesPlanId, dailyBuyTimes + 1)

		if not buyCfg then
			FloatWordMgr.instance:show("购买次数不足")
		else
			local allBuyCfg = WaterdraktowerConfig.instance:getBuyTimeCfgs(self._actCfg.buyTimesPlanId)
			local canbuyTimes = #allBuyCfg
			local arr = string.split(buyCfg.cost, ":")
			local matType = checknumber(arr[1])
			local matId = checknumber(arr[2])
			local matNum = checknumber(arr[#arr])
			local costNum = MaterialFacade.instance:getGoodCost(matType, matId, matNum)
			local content = langPara("今天所有的挑战次数已经用完，可以购买更多次数继续挑战。确定要花费<color=#ebad32>%s%s</color>购买破阵次数吗？\n每天可以购买%s次，当前剩余购买次数：%s", costNum, MaterialMgr.getMaterialsName(matType, matId), canbuyTimes, canbuyTimes - dailyBuyTimes)

			local function sureFunc()
				WaterDarkTowerAgent.instance:sendPM_WaterDarkTowerBuyTimesReq(self._actId)
			end

			if MatType.Diamond_Consume == matType or matType == MatType.Diamond then
				TipsFacade.instance:openPopupCostDiamondView(costNum, content, sureFunc)
			else
				FloatWordMgr.instance:show("不是说好只能用砖石买吗")
			end
		end
	end
end

function WaterdraktowermainView:_getLeftChallengeTime()
	local totalTimes = self._actCfg.dailyTimes
	local buyTimes = WaterdraktowerModel.instance:getBuyTime()
	local clgTimes = WaterdraktowerModel.instance:getClgTimes()

	return totalTimes - clgTimes + buyTimes
end

function WaterdraktowermainView:_onClickbtnChangeTower()
	if self._towerType == TowerType.Water then
		self:_swithchTowerType(TowerType.Drak)
	else
		self:_swithchTowerType(TowerType.Water)
	end
end

function WaterdraktowermainView:_swithchTowerType(t_type, notEffect)
	local function changeTower()
		self._towerType = t_type

		GameUtil.saveUserData(WaterdraktowermainView.LastTowerType, tostring(t_type))
		uGuiUtil.setSpriteToImage(self._bg, nil, GameUrl.getBigbgFolderUrl("waterdarktower", "board_sat_bg" .. t_type))
		self._changegroup:SetState(self._towerType == TowerType.Water and 0 or 1)
		WaterDarkTowerAgent.instance:sendPM_WaterDarkTowerGetInfoReq(self._actId, self._towerType)
	end

	if not notEffect then
		self._next_t_type = t_type

		GlobalModel.instance:setUIInteractable(false)
		settimer(2, self._finishEffect, self, false)
		self:_setEffect(changeTower)
	else
		changeTower()
	end
end

function WaterdraktowermainView:_finishEffect()
	removetimer(self._finishEffect, self)

	if self._next_t_type then
		self:_swithchTowerType(self._next_t_type, true)

		self._next_t_type = nil
	end

	GlobalModel.instance:setUIInteractable(true)
end

function WaterdraktowermainView:_updateUI()
	self._actCfg = WaterdraktowerConfig.instance:getAcfCfg(self._actId)

	local allPlanCfgs = WaterdraktowerConfig.instance:getChallengeCfgs(self._actCfg.challengePlanId)
	local planCfgs = allPlanCfgs[self._towerType]

	self._tier = WaterdraktowerModel.instance:getPassTier()
	self._tierCfgs = planCfgs[self._tier]

	self:_setRightInfo()
	self:_setChallengeLeftTime()
end

function WaterdraktowermainView:_setRightInfo()
	self:_setTowerStageProgress()
	self:_setCurrStageInfo()
end

function WaterdraktowermainView:_setChallengeLeftTime()
	local totalTimes = self._actCfg.dailyTimes

	self._txtLeftTime.text = string.format("挑战次数：%s/%s", self:_getLeftChallengeTime(), totalTimes)
end

function WaterdraktowermainView:_setTowerStageProgress()
	if not self._tierCfgs then
		return
	end

	local tierCfgs = self._tierCfgs
	local passStage = WaterdraktowerModel.instance:getPassStage()

	self._levelProgressGroup:updateWithNoCreate(#tierCfgs, function(item, index)
		item.mainGO:SetActive(true)

		local cfg = tierCfgs[index]
		local txtBattleLevel = goutil.findChildTextComponent(item.mainGO, "battle/txtLevel")
		local goPass = goutil.findChild(item.mainGO, "pass")
		local goBattle = goutil.findChild(item.mainGO, "battle")
		local goLock = goutil.findChild(item.mainGO, "lock")
		local goStar = goutil.findChild(item.mainGO, "stars")
		local txtLockLevel = goutil.findChildTextComponent(item.mainGO, "lock/txtLevel")
		local txtPassLevel = goutil.findChildTextComponent(item.mainGO, "pass/txtLevel")

		goutil.setActive(goPass, cfg.stage <= passStage)
		goutil.setActive(goBattle, cfg.stage == passStage + 1)
		goutil.setActive(goStar, cfg.stage == passStage + 1)
		goutil.setActive(goLock, cfg.stage > passStage + 1)

		txtPassLevel.text = string.format("%s关", cfg.stage)
		txtLockLevel.text = string.format("%s关", cfg.stage)
		txtBattleLevel.text = cfg.name

		if cfg.stage == passStage + 1 then
			self._starGos = {}

			for i = 1, 5 do
				self._starGos[i] = goutil.findChild(goStar, "star" .. i)
			end

			self:_setStageHard(cfg)
		end
	end)
end

function WaterdraktowermainView:_setCurrStageInfo()
	if not self._tierCfgs then
		return
	end

	local passStage = WaterdraktowerModel.instance:getPassStage()
	local tierCfgs = self._tierCfgs

	self._currStageChallengeCfg = tierCfgs[passStage + 1] or tierCfgs[passStage]
	self._isAllPass = passStage > 0 and passStage >= self._currStageChallengeCfg.stage

	goutil.setActive(self._allPassTipGo, self._isAllPass)
	goutil.setActive(self._btnStart.gameObject, not self._isAllPass)
	goutil.setActive(self._btnAddTimeGo, not self._isAllPass)
	self:_setReward()
	self:_setTierName()
	self:_setRole()
end

function WaterdraktowermainView:_setReward()
	local passStage = WaterdraktowerModel.instance:getPassStage()

	if self._currStageChallengeCfg then
		local arr = string.split(self._currStageChallengeCfg.prize, "#")

		self._baseRewardGroup:updateWithMoArray(arr, function(item, cfgStr)
			local con = goutil.findChild(item.mainGO, "con")
			local ylq = goutil.findChild(item.mainGO, "ylq")

			goutil.setActive(ylq, self._currStageChallengeCfg.stage <= passStage)
			MaterialMgr.setCellByCfg(cfgStr, con)
		end)
	end

	local allPlanCfgs = WaterdraktowerConfig.instance:getSpecialPrizeCfgs(self._actCfg.prizePlanId)
	local planCfgs = allPlanCfgs[self._towerType]
	local planCfg = planCfgs[self._tier]

	if planCfg then
		local arr = string.split(planCfg.specialPrize, "#")

		self._extRewardGroup:updateWithMoArray(arr, function(item, cfgStr)
			local con = goutil.findChild(item.mainGO, "con")
			local effect = goutil.findChild(item.mainGO, "effect")
			local ylq = goutil.findChild(item.mainGO, "ylq")
			local txtYlg = goutil.findChildTextComponent(item.mainGO, "ylq/txtYlq")

			txtYlg.text = WaterdraktowerModel.instance:isGetLastExtReward() and "已领取" or "未获得"

			goutil.setActive(ylq, self._currStageChallengeCfg.stage <= passStage)
			MaterialMgr.setCellByCfg(cfgStr, con)
		end)

		self._txtLeftRewardCont.text = planCfg.maxGainNum - WaterdraktowerModel.instance:getSpecialPrizeNum()
	end
end

function WaterdraktowermainView:_setTierName()
	self._txtName.text = string.format("%s%s层·%s关", self._towerType == TowerType.Water and "冰封之塔" or "黑暗之塔", self._tier, self._currStageChallengeCfg.stage)
end

function WaterdraktowermainView:_setRole()
	return
end

function WaterdraktowermainView:_setStageHard(challengeCfg)
	local cfgs = WaterdraktowerConfig.instance:getCutDownPlanCfgs(challengeCfg.cutDownPlanId)
	local passNum = WaterdraktowerModel.instance:getSpecialPrizeNum()
	local stime = ActivityDefineController.instance:getStartTimeAndEndTime(self._actType, self._actId)
	local curHardStar = 5
	local newTime = ServerTime.nowServerLook()

	for i = #cfgs, 1, -1 do
		local cfg = cfgs[i]

		if passNum >= cfg.personNum or newTime >= stime + cfg.cutDownTime * 86400 then
			curHardStar = curHardStar - cfg.stall

			break
		end
	end

	for i, go in ipairs(self._starGos) do
		goutil.setActive(go, i <= curHardStar)
	end
end

function WaterdraktowermainView:_setActTime()
	local stime, etime = ActivityDefineController.instance:getStartTimeAndEndTime(self._actType, self._actId)
	local sdate = GameUtil.time2date(stime)
	local edate = GameUtil.time2date(etime)

	self._txtActTime.text = string.format("%s - %s", self:_formatTime(sdate), self:_formatTime(edate))
end

function WaterdraktowermainView:_formatTime(date)
	return string.format("%s年%s月%s日", date.year, date.month, date.day)
end

function WaterdraktowermainView:_PM_WaterDarkTowerGetInfoRes(status)
	if status == 0 then
		self:_updateUI()
	end
end

function WaterdraktowermainView:_PM_WaterDarkTowerBuyTimesRes(status)
	if status == 0 then
		self:_setChallengeLeftTime()
	end
end

function WaterdraktowermainView:_checkPassRankShow()
	local data = WaterdraktowerController.instance:getPassRankData()

	if data then
		UIStateManager.instance:push(ViewName.WaterdarktowerpasstipView)
	end
end

function WaterdraktowermainView:_setEffect()
	local effName = "fx_ui_longzun/fx_ui_shuianta.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)

	self._effectHandler.hideEffWhileNotOnTop = false
end

function WaterdraktowermainView:_clearEffect()
	UIEffectManager.instance:stopEffect(self._effectHandler)
end

return WaterdraktowermainView
