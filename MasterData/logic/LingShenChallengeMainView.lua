-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lingshenchallenge/view/LingShenChallengeMainView.lua

module("logic.extensions.lingshenchallenge.view.LingShenChallengeMainView", package.seeall)

local LingShenChallengeMainView = class("LingShenChallengeMainView", ViewComponent)

function LingShenChallengeMainView:ctor()
	LingShenChallengeMainView.super.ctor(self)
end

function LingShenChallengeMainView:unbindEvents()
	LingShenChallengeMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnFormation)
	GameUtil.rmClickHandler(self._btnFormTeam)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnShop)
end

function LingShenChallengeMainView:bindEvents()
	LingShenChallengeMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnFormation, self._onClickFormation, self)
	GameUtil.addClickHandler(self._btnFormTeam, self._onClickFormTeam, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
end

function LingShenChallengeMainView:buildUI()
	LingShenChallengeMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnRule = self:getGo("btnRule")
	self._btnFormation = self:getGo("info/btnFormation")
	self._btnFormTeam = self:getGo("info/btnFormTeam")
	self._bossTableView = self:getGo("bossTableView")
	self._bossTableCell = self:getGo("bossTableCell")
	self._bossTableList = ScrollerList.create(self._bossTableView, self._bossTableCell, GameUtil.handler(self._updateBossCell, self), GameUtil.handler(self._clearBossCell, self))
	self._slider = self:getSlider("slider")
	self._txtBlood = self:getTxt("slider/txt")
	self._leftTimeGo = self:getGo("leftTime")
	self._txtLeftTime = self:getTxt("leftTime/txt")
	self._txtBubble = self:getTxt("bubble/txt")
	self._txtDesc = self:getTxt("info/txtDesc")
	self._playerRoot = self:getGo("info/playerRoot")
	self._rewardSliderMo = PlayerSliderMo.New(self._playerRoot)
	self._prizeTip = self:getGo("info/prizeTip")
	self._txtPrizeTip = self:getTxt("info/prizeTip/txtPrizeTip")
	self._con = self:getGo("con")
	self._txtTime = self:getTxt("time/txtTime")
	self._btnStart = self:getGo("info/BtnStart")
	self._btnShop = self:getGo("btnShop")
end

function LingShenChallengeMainView:onExit()
	LingShenChallengeMainView.super.onExit(self)
	self._bossTableList:dispose()
	removetimer(self._onClock, self)

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end
end

function LingShenChallengeMainView:onEnter()
	LingShenChallengeMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_LingShenClgGetInfoRes, self.refreshView, self)

	self._activityId = self:getFirstParam() or LingShenChallengeModel.instance:getCurrActId()
	self._activityCfg = LingShenChallengeConfig.instance:getActivityCfg(self._activityId)
	self._bossId = LingShenChallengeController.instance:getCurBoss(self._activityId)

	self:initSlider()
	settimer(1, self._onClock, self, true)
	LingShenChallengeController.instance:sendPM_LingShenClgGetInfoReq(self._activityId)

	self._txtTime.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.LingShenChallenge, self._activityId)
end

function LingShenChallengeMainView:refreshView()
	self._bossCfg = LingShenChallengeConfig.instance:getBossCfg(self._activityId, self._bossId)

	local startTime, endTime = LingShenChallengeConfig.instance:getBossOpenTime(self._activityId, self._bossId)

	self._isOpen = GameUtil.checkIsInTimePeriod(startTime, endTime)
	self._targetTime = self._isOpen == true and GameUtil.string2time(endTime) or nil

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end

	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(self._bossCfg.raceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._bossCfg.raceId, self._con, scale, nil, nil, x, y)

	GameUtil.SetActive(self._leftTimeGo, self._targetTime and self._targetTime > 0 or false)

	local bossCfg = LingShenChallengeConfig.instance:getBossCfg(self._activityId, self._bossId)

	self._txtDesc.text = bossCfg.desc or "未填写"

	if ServerTime.now() < GameUtil.string2time(bossCfg.weakStartTime) then
		self._txtBubble.text = bossCfg.bubble or "未填写"
	elseif not bossCfg.buffBubble then
		self._txtBubble.text = "未填写"
	end

	local bossInfo = LingShenChallengeModel.instance:getBossInfo(self._activityId, self._bossId)
	local leftValue = math.max(bossInfo.bossTotalHp - bossInfo.historyMaxDamge, 0)

	self._slider:SetValue(bossInfo.historyMaxDamge / bossInfo.bossTotalHp)

	self._txtBlood.text = langPara("历史最高伤害：<color=#FFE89BFF>%d</color>/%d", bossInfo.historyMaxDamge, bossInfo.bossTotalHp)

	GameUtil.SetActive(self._playerRoot, ServerTime.now() <= GameUtil.string2time(endTime))
	GameUtil.SetActive(self._prizeTip, ServerTime.now() > GameUtil.string2time(endTime))
	self._bossTableList:reloadData(LingShenChallengeConfig.instance:getBossCfgs(self._activityId))
	self._rewardSliderMo:updatePlayerReward()
end

function LingShenChallengeMainView:initSlider()
	local bossCfg = LingShenChallengeConfig.instance:getBossCfg(self._activityId, self._bossId)
	local sliderParam = {}

	sliderParam.view = self
	sliderParam.prizeCfgs = LingShenChallengeConfig.instance:getPrizeCfgs(bossCfg.prizePlanId)

	function sliderParam.getPlayerProgress()
		if self._isOpen == true then
			return LingShenChallengeModel.instance:getDailyDamage(self._activityId)
		else
			return 0
		end
	end

	function sliderParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.damage
	end

	function sliderParam.getPrizeByRewardCfg(rewardCfg)
		return rewardCfg.prize
	end

	function sliderParam.isPlayerRewardCanGet(rewardCfg)
		if self._isOpen == true then
			return LingShenChallengeModel.instance:isCanGetProgressReward(self._activityId, self._bossId, rewardCfg.prizeId)
		else
			return false
		end
	end

	function sliderParam.isPlayerRewardGeted(rewardCfg)
		if self._isOpen == true then
			return LingShenChallengeModel.instance:isGetedProgressReward(self._activityId, self._bossId, rewardCfg.prizeId)
		else
			return false
		end
	end

	function sliderParam.sendGainPlayerPrizeReq(rewardCfg)
		LingShenChallengeAgent.instance:sendPM_LingShenClgGainDamagePrizeReq(self._activityId, rewardCfg.prizeId)
	end

	local isSkipAnimation = true

	self._rewardSliderMo:initParam(sliderParam, isSkipAnimation)
	self._rewardSliderMo:onEnter()
	self._rewardSliderMo:updatePlayerReward()
	self._rewardSliderMo:relocation()
end

function LingShenChallengeMainView:_updateBossCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "imgMask/con")
	local imgSelect = goutil.findChild(go, "imgSelect")
	local imgLock = goutil.findChild(go, "imgLock")

	MaterialMgr.setIcon(con, MatType.Pet, data.raceId)

	if ServerTime.now() >= GameUtil.string2time(data.startTime) then
		GameUtil.SetGray(con, false)
		GameUtil.SetActive(imgLock, false)
	else
		GameUtil.SetGray(con, true)
		GameUtil.SetActive(imgLock, true)
	end

	GameUtil.SetActive(imgSelect, data.bossId == self._bossId)
	GameUtil.addClickHandler(go, function()
		self:_onClickBoss(data.bossId)
	end)
end

function LingShenChallengeMainView:_clearBossCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "imgMask/con")

	MaterialMgr.resetAll(con)
	GameUtil.rmClickHandler(go)
end

function LingShenChallengeMainView:_onClickBoss(bossId)
	local startTime, endTime = LingShenChallengeConfig.instance:getBossOpenTime(self._activityId, bossId)

	if ServerTime.now() >= GameUtil.string2time(startTime) then
		self._bossId = bossId

		self:initSlider()
		self:refreshView()
	else
		local startDate = GameUtil.string2date(startTime)
		local endDate = GameUtil.string2date(endTime)

		FloatWordMgr.instance:show(langPara("%d.%d-%d.%d开启挑战", startDate.month, startDate.day, endDate.month, endDate.day))
	end
end

function LingShenChallengeMainView:_onClickFormation()
	local fmtMo = LingShenChallengeModel.instance:getFormTeamFmtMo()

	fmtMo:initParams(self._activityId)
	CustomFmtController.instance:showMissionFormationView(fmtMo)
end

function LingShenChallengeMainView:_onClickFormTeam()
	if LingShenChallengeController.instance:checkFormation(self._activityId) == false then
		FloatWordMgr.instance:show(lang("请先设置预设阵容"))

		return
	end

	if self._isOpen then
		FormTeamController.instance:enterFormTeamView(self._bossCfg.groupId)
	else
		FloatWordMgr.instance:show(lang("不在开放时间内"))
	end
end

function LingShenChallengeMainView:_onClickRule()
	TipsFacade.instance:openRulesView("ling_shen_challenge_rule")
end

function LingShenChallengeMainView:_onClickStart()
	if LingShenChallengeController.instance:checkFormation(self._activityId) == false then
		FloatWordMgr.instance:show(lang("请先设置预设阵容"))

		return
	end

	if self._isOpen then
		FormTeamController.instance:enterFormTeamView(self._bossCfg.groupId)
	else
		FloatWordMgr.instance:show(lang("不在开放时间内"))
	end
end

function LingShenChallengeMainView:_onClickShop()
	GotoMgr.gotoByString(self._activityCfg.jumpTo)
end

function LingShenChallengeMainView:_onClock()
	if self._targetTime and self._targetTime > 0 then
		if ServerTime.now() < self._targetTime then
			local leftTime = self._targetTime - ServerTime.now()

			self._txtLeftTime.text = langPara("剩余时间：%s", GameUtil.FormatTimeWords(leftTime))
		else
			self._targetTime = nil

			self:refreshView()
		end
	end
end

return LingShenChallengeMainView
