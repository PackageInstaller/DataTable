-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/ScuffleMainView.lua

module("logic.extensions.scuffle.view.ScuffleMainView", package.seeall)

local ScuffleMainView = class("ScuffleMainView", ViewComponent)

function ScuffleMainView:ctor()
	ScuffleMainView.super.ctor(self)
end

function ScuffleMainView:buildUI()
	ScuffleMainView.super.buildUI(self)

	self._closeButton = self:getBtn("topLeft/btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._txtSeasonNum = self:getTxt("title/txtSeasonNum")
	self._txtCountDown = self:getTxt("title/txtCountDown")
	self._headIcon = self:getGo("playerInfo/headIcon")
	self._txtPlayerName = self:getTxt("playerInfo/txtPlayerName")
	self._txtArea = self:getTxt("playerInfo/txtArea")
	self._txtRank = self:getTxt("playerInfo/txtRank")
	self._imgLevelIcon = self:getGo("level/imgLevelIcon")
	self._levelChange = self:getGo("level/imgLevelName"):GetComponent(typeof(UIImageSpriteChange))
	self._txtCurScore = self:getTxt("score/txtCurScore")
	self._txtNextScore = self:getTxt("score/txtNextScore")
	self._goScoreUp = self:getGo("score/txtCurScore/scoreChange")
	self._txtDeltaNum = self:getTxt("score/txtCurScore/scoreChange/txtDeltaNum")
	self._btnNormal = self:getBtn("btnNormal")
	self._btnRelax = self:getBtn("btnRelax")
	self._goTimeBg = self:getGo("timeBg")
	self._txtOpenTime = self:getTxt("timeBg/txtOpenTime")
	self._txtCoin = self:getTxt("txtCoin")
	self._coinIcon = self:getGo("txtCoin/icon")
	self._goTimeRelaxBg = self:getGo("timeRelaxBg")
	self._txtRelaxOpenTime = self:getTxt("timeRelaxBg/txtOpenTime")
	self._btnInfo = self:getBtn("bottom/btnInfo")
	self._btnReport = self:getBtn("bottom/btnReport")
	self._btnRank = self:getBtn("bottom/btnRank")
	self._btnReward = self:getBtn("bottom/btnReward")
	self._btnExchange = self:getBtn("bottom/btnExchange")
	self._btnNewGame = self:getBtn("bottom/btnNewGame")
	self._redPoint = self:getGo("bottom/btnReward/redPoint")
	self._rtEffect1 = self:getGo("rtEffect1"):GetComponent(goutil.Type_RectTransform)
	self._rtEffect2 = self:getGo("playerInfo/rtEffect2"):GetComponent(goutil.Type_RectTransform)
	self._scoreEffect = self:getGo("score/effect")
	self._scoreChange = self:getGo("score/txtCurScore/scoreChange"):GetComponent(typeof(UIChangeGroup))
	self._txtTipDesc = self:getTxt("bottom/tip/txtTipDesc")
	self._imgTip = self:getGo("bottom/tip/imgTip")
	self._txtBlessDesc = self:getTxt("blessBubble/bless/txtDesc")
	self._txtTitle = self:getTxt("topLeft/txtTitle")
	self._txtActivityName = self:getTxt("title/txtActivityName")
end

function ScuffleMainView:destroyUI()
	ScuffleMainView.super.destroyUI(self)
	self:_resetExchangeTip()
end

function ScuffleMainView:bindEvents()
	ScuffleMainView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnNormal:AddClickListener(self._onClickNormal, self)
	self._btnRelax:AddClickListener(self._onClickRelax, self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)
	self._btnReport:AddClickListener(self._onClickReport, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnReward:AddClickListener(self._onClickReward, self)
	self._btnExchange:AddClickListener(self._onClickExchange, self)
	self._btnNewGame:AddClickListener(self._onClickNewGame, self)
end

function ScuffleMainView:unbindEvents()
	ScuffleMainView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnNormal:RemoveClickListener()
	self._btnRelax:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnReport:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnReward:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnNewGame:RemoveClickListener()
end

function ScuffleMainView:onEnter()
	ScuffleMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.SF_ScuffleInfoRes, self._onScuffleInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._updateRedPoint, self)
	GlobalDispatcher:addListener(GlobalNotify.ScuffleUpdateDailyGainedScore, self._onUpdateDailyGainedScore, self)
	settimer(1, self._onSecond, self)
	ScuffleModel.instance:onTempReset()
	self:_resetGameObject()
	self:_initView()
	self:_refreshView()
	self:_showScoreUp()
	self:_updateRedPoint()
	self:_loadEffect()
	self:_initGoTimeBg()
	self:_showExchangeTip()
	self:_updateBlessBubbleDesc()
end

function ScuffleMainView:onExit()
	ScuffleMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SF_ScuffleInfoRes, self._onScuffleInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.RedPointUpdate, self._updateRedPoint, self)
	removetimer(self._onSecond, self)
	MaterialMgr.clearIcon(self._coinIcon)
	self:_removeHeadIcon()
	self:_removeTween()
	self:_removeLevelIcon()
	self:_removeEffect()
end

function ScuffleMainView:_onClickClose()
	self:close()
end

function ScuffleMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.ScuffleRuleView)
end

function ScuffleMainView:_onClickNormal()
	if ScuffleController.instance:isInOpenTimeInStandardMode() then
		if ScuffleController.instance:isCoinMaxLimit() then
			local isShowToday = GameUtil.getUserDayData("Scuffle_ShowToday")

			if not isShowToday then
				GameUtil.saveUserDayData("Scuffle_ShowToday", true)

				local title = lang("tip")
				local text = lang("scuffle_tip2")

				local function func()
					if ScuffleController.instance:isInOpenTimeInStandardMode() then
						UIStateManager.instance:push(ViewName.ScuffleMatchView, false)
					else
						FloatWordMgr.instance:show("未在开放时间哦！")
					end
				end

				local btnText = "知道了"

				TipsFacade.instance:openTipWindow(title, text, func, btnText, UnityEngine.TextAnchor.MiddleCenter)
			else
				UIStateManager.instance:push(ViewName.ScuffleMatchView, false)
			end
		else
			UIStateManager.instance:push(ViewName.ScuffleMatchView, false)
		end
	else
		local content = ScuffleConfig.instance:getCommonValueByKey("OPEN_TIME_TIPS")

		FloatWordMgr.instance:show(content)
	end
end

function ScuffleMainView:_onClickRelax()
	if ScuffleController.instance:isInOpenTimeInRelaxMode() then
		UIStateManager.instance:push(ViewName.ScuffleMatchView, true)
	else
		local content = ScuffleConfig.instance:getCommonValueByKey("FUN_OPEN_TIME_TIPS")

		FloatWordMgr.instance:show(content)
	end
end

function ScuffleMainView:_onClickInfo()
	UIStateManager.instance:push(ViewName.ScuffleLevelView)
end

function ScuffleMainView:_onClickReport()
	UIStateManager.instance:push(ViewName.ScuffleReportView)
end

function ScuffleMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.ScuffleRankView)
end

function ScuffleMainView:_onClickReward()
	UIStateManager.instance:push(ViewName.ScuffleRewardView)
end

function ScuffleMainView:_onClickExchange()
	ScuffleController.instance:openExchangeView()
end

function ScuffleMainView:_onClickNewGame()
	UIStateManager.instance:push(ViewName.ScuffleSpecialRuleView)
end

function ScuffleMainView:_onScuffleInfoRes(isSuccess)
	if isSuccess then
		self:_refreshView()
	else
		self:_popupCloseTip("精灵大乱斗未在活动时间内哦")
	end
end

function ScuffleMainView:_onUpdateDailyGainedScore()
	self:_setCoin()
end

function ScuffleMainView:_onSecond()
	self:_updateSeasonCountDown()
	self:_updateOpenTimes()
end

function ScuffleMainView:_initView()
	local cfg = ScuffleController.instance:isExistCfgInActivityTime()

	self:_initTitleTxt(cfg)

	if cfg then
		self._cfgActivity = cfg

		ScuffleAgent.instance:sendSF_ScuffleInfoReq()
	else
		self:_popupCloseTip("精灵大乱斗未在活动时间内哦")
	end
end

function ScuffleMainView:_popupCloseTip(txt)
	UIStateManager.instance:closeAllModalViews()
	TipsFacade.instance:openTipWindowNoX("提示", txt, function()
		self:_onClickClose()
	end, "确定")
end

function ScuffleMainView:_setSeasonNumber()
	local cfg = ScuffleController.instance:isExistCfgInActivityTime()

	if cfg then
		local cfgSeason = ScuffleConfig.instance:getSeasonCfg(cfg.activityId)

		if cfgSeason then
			self._txtSeasonNum.text = "S" .. cfgSeason.seasonId

			return
		end
	end

	self._txtSeasonNum.text = ""
end

function ScuffleMainView:_updateSeasonCountDown()
	self._txtCountDown.text = "赛季剩余：" .. ScuffleController.instance:getSeasonCountDownTxt()
end

function ScuffleMainView:_setLevel()
	local cfg = ScuffleController.instance:getCurLevelCfg()

	uGuiUtil.setSpriteToImage(self._imgLevelIcon, uGuiUtil.SpriteType.BigBg, string.format(ScuffleModel.LevelPath, cfg.icon))
	self._levelChange:SetState(cfg.level - 1)
end

function ScuffleMainView:_removeLevelIcon()
	local component = Framework.ImageBigBG.Get(self._imgLevelIcon)

	component:ClearImage()
end

function ScuffleMainView:_setScore()
	self._txtCurScore.text = ScuffleModel.instance:getScore()

	local score = ScuffleController.instance:getScoreDisctanceOnNextLevel()

	self._txtNextScore.text = score > 0 and score or "已达到最高段位"
end

function ScuffleMainView:_setPlayerInfo()
	self._txtPlayerName.text = RoleModel.instance:getUserName()
	self._txtArea.text = RoleModel.instance:getAreaName()
	self._txtRank.text = "排名 " .. ScuffleModel.instance:getMyRank()

	HeadItemController.instance:setMyHeadCell(self._headIcon)
end

function ScuffleMainView:_removeHeadIcon()
	MaterialMgr.resetAll(self._headIcon)
end

function ScuffleMainView:_setCoin()
	self._txtCoin.text = ScuffleModel.instance:getCoinToday() .. "/" .. checknumber(ScuffleConfig.instance:getCommonValueByKey("CHALLENGE_REWARD_CEILING"))

	local goodsInfo = ScuffleConfig.instance:getCommonValueByKey("WIN_REWARD")
	local temp = string.split(goodsInfo, ":")
	local matType = checknumber(temp[1])
	local itemId = checknumber(temp[2])

	MaterialMgr.setIcon(self._coinIcon, matType, itemId)
end

function ScuffleMainView:_initGoTimeBg()
	self._goTimeBg:SetActive(true)
	self._goTimeRelaxBg:SetActive(true)
end

function ScuffleMainView:_updateOpenTimes()
	self:_setOpenTime("OPEN_TIME", self._goTimeBg, self._txtOpenTime)
	self:_setOpenTime("FUN_OPEN_TIME", self._goTimeRelaxBg, self._txtRelaxOpenTime)
end

function ScuffleMainView:_setOpenTime(key, node, txt)
	local times = self:_getOpenTimeValue(key)

	if times and times[1] and times[2] then
		local startList = string.split(times[1], ":")
		local endList = string.split(times[2], ":")

		txt.text = string.format("开放中：%s:%s - %s:%s", startList[1], startList[2], endList[1], endList[2])
	else
		txt.text = "未在活动时间"
	end
end

function ScuffleMainView:_getOpenTimeValue(key)
	if self._timesValue and self._timesValue[key] then
		for i, v in ipairs(self._timesValue[key]) do
			if GameUtil.checkIsInTimePeriod(v[1], v[2], true) then
				return v
			end
		end

		return nil
	end

	local value = ScuffleConfig.instance:getCommonValueByKey(key)
	local array = string.split(value, ",")

	self._timesValue = self._timesValue or {}
	self._timesValue[key] = self._timesValue[key] or {}

	local result

	for i, v in ipairs(array) do
		local times = string.split(v, "#")

		table.insert(self._timesValue[key], times)

		if GameUtil.checkIsInTimePeriod(times[1], times[2], true) then
			result = times
		end
	end

	return result
end

function ScuffleMainView:_refreshView()
	self:_setPlayerInfo()
	self:_setScore()
	self:_setLevel()
	self:_setSeasonNumber()
	self:_updateSeasonCountDown()
	self:_setCoin()
	self:_updateOpenTimes()
end

function ScuffleMainView:_showScoreUp()
	if ScuffleModel.instance:isHaveOldScore() then
		local oldScore = ScuffleModel.instance:getOldScoreAndReset()
		local newScore = ScuffleModel.instance:getScore()

		if newScore == oldScore then
			return
		end

		local isUp = oldScore < newScore
		local isDown = newScore < oldScore
		local state = 0

		if isUp then
			state = 1
			self._txtDeltaNum.text = string.format("+%d", newScore - oldScore)
		elseif isDown then
			state = 0
			self._txtDeltaNum.text = string.format("-%d", oldScore - newScore)
		end

		self._goScoreUp:SetActive(true)
		self._scoreChange:SetState(state)
		self:_showScoreEffect()

		self._scoreUpTween = TweenUtil.DoDelay(5, function()
			if not goutil.isNil(self._goScoreUp) then
				goutil.setActive(self._goScoreUp, false)
			end
		end)
	else
		goutil.setActive(self._goScoreUp, false)
	end
end

function ScuffleMainView:_removeTween()
	if self._scoreUpTween then
		self._scoreUpTween:Kill()

		self._scoreUpTween = nil
	end

	if self._showTween then
		self._showTween:Kill()

		self._showTween = nil
	end
end

function ScuffleMainView:_resetGameObject()
	goutil.setActive(self._goScoreUp, false)
end

function ScuffleMainView:_updateRedPoint()
	self._redPoint:SetActive(ScuffleModel.instance:isHaveRedPoint())
end

function ScuffleMainView:_loadEffect()
	local ratio = UnityEngine.Screen.height / 720

	self._rtEffect1.gameObject:SetActive(true)

	self._photoEffectMainBg = PhotoEffect.Get(self._rtEffect1.gameObject)

	local effectMainBg = UIEffectManager.instance:getEffectPath(ScuffleMainViewPresentor.MainViewBgPath)

	self._photoEffectMainBg:showEffectsFullScreen({
		effectMainBg
	}, self._rtEffect1.rect.width * ratio, self._rtEffect1.rect.height * ratio)
	self._photoEffectMainBg:setCameraPosition(0, 0, -10)
	self._photoEffectMainBg:setCameraSize(360)

	local camera = self._photoEffectMainBg._photo.producer.rtCamera

	camera.orthographic = true

	self._rtEffect2.gameObject:SetActive(true)

	self._photoEffectPlayerBg = PhotoEffect.Get(self._rtEffect2.gameObject)

	local playerBg = UIEffectManager.instance:getEffectPath(ScuffleMainViewPresentor.PlayerBgPath)

	self._photoEffectPlayerBg:showEffectsFullScreen({
		playerBg
	}, self._rtEffect2.rect.width * ratio, self._rtEffect2.rect.height * ratio)
	self._photoEffectPlayerBg:setCameraPosition(0, 36, -10)
	self._photoEffectPlayerBg:setCameraSize(192)

	local camera = self._photoEffectPlayerBg._photo.producer.rtCamera

	camera.orthographic = true

	self._scoreEffect:SetActive(false)

	self._scoreUIEffect = UIEffectManager.instance:playEffect(self, ScuffleMainViewPresentor.ScoreUpPath, self._scoreEffect.transform, 0, 0, true, false)

	self._scoreUIEffect:setParent(self._scoreEffect.transform)
	self._scoreUIEffect:setScale(1)

	self._scoreUIEffect.hideEffWhileNotOnTop = false
end

function ScuffleMainView:_removeEffect()
	if self._photoEffectMainBg then
		self._photoEffectMainBg:clear()

		self._photoEffectMainBg = nil
	end

	if self._photoEffectPlayerBg then
		self._photoEffectPlayerBg:clear()

		self._photoEffectPlayerBg = nil
	end

	if self._scoreUIEffect then
		UIEffectManager.instance:stopEffect(self._scoreUIEffect)

		self._scoreUIEffect = nil
	end
end

function ScuffleMainView:_showScoreEffect()
	goutil.setActive(self._scoreEffect, false)

	self._showTween = TweenUtil.DoDelay(0.5, function()
		goutil.setActive(self._scoreEffect, true)
	end)
end

function ScuffleMainView:_checkIsFirstOpen()
	local key = "ScuffleMainView_specialrule"
	local isFlag = GameUtil.getUserData(key)

	if not isFlag then
		self:_onClickNewGame()
		GameUtil.saveUserData(key, true)
	end
end

function ScuffleMainView:_showExchangeTip()
	local rewardStr = ScuffleConfig.instance:getCommonValueByKey("SHOP_EXPLICIT_ID")
	local matType, id, matNum = MaterialMgr.getMatParams(rewardStr)
	local cfg = MaterialMgr.getMatCfg(matType, id)

	if cfg then
		self._txtTipDesc.text = lang("scuffle_tip1")
	end

	MaterialMgr.setIcon(self._imgTip, matType, id)
end

function ScuffleMainView:_resetExchangeTip()
	local img = Framework.ImageBigBG.Get(self._imgTip)

	if img then
		img:ClearImage()
	end
end

function ScuffleMainView:_updateBlessBubbleDesc()
	self._txtBlessDesc.text = ScuffleController.instance:getBuffDesc(self._cfgActivity)
end

function ScuffleMainView:_initTitleTxt(cfgActivity)
	if cfgActivity then
		local cfgSeason = ScuffleConfig.instance:getSeasonCfg(cfgActivity.activityId)

		if cfgSeason then
			local name = cfgSeason.seasonName

			self._txtTitle.text = name
			self._txtActivityName.text = string.gsub(name, "大乱斗", "\n大乱斗")

			return
		end
	end

	local str = "精灵大乱斗"

	self._txtTitle.text = str
	self._txtActivityName.text = string.gsub(str, "大乱斗", "\n大乱斗")
end

return ScuffleMainView
