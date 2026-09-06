-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/timedpointracemode/TimedPointRaceModeBuffShowView.lua

module("logic.extensions.timelimitedchallenge.view.timedpointracemode.TimedPointRaceModeBuffShowView", package.seeall)

local TimedPointRaceModeBuffShowView = class("TimedPointRaceModeBuffShowView", ViewComponent)

function TimedPointRaceModeBuffShowView:buildUI()
	TimedPointRaceModeBuffShowView.super.buildUI(self)

	self._coms = {}

	for i = 1, 10 do
		local com = {}

		com.go = self:getGo("com" .. i)

		for k = 1, 3 do
			local enterCell = {}

			enterCell.go = goutil.findChild(com.go, "btnChallenge" .. k)
			enterCell.btn = GameUtil.asBtn(enterCell.go)
			enterCell.icon = goutil.findChild(enterCell.go, "icon")
			enterCell.txt = goutil.findChildTextComponent(enterCell.go, "txt")
			enterCell.passmark = goutil.findChild(enterCell.go, "passmark")
			enterCell.lock = goutil.findChild(enterCell.go, "lock")
			enterCell.select = goutil.findChild(enterCell.go, "select")
			enterCell.cfg = nil
			com[k] = enterCell
		end

		self._coms[i] = com
	end

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._txtLeftTime = self:getTxt("txtLeftTime")
	self._btnAddTime = self:getBtn("txtLeftTime/btnAdd")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtTime = self:getTxt("time")
	self.otherMenber = {
		{
			bg = self:getGo("bg"),
			titlelabel = lang("创造秩序")
		},
		{
			bg = self:getGo("bg2"),
			titlelabel = lang("破坏秩序")
		}
	}
	self._tip = self:getGo("tip"):GetComponent("UIImageSpriteChange")
end

function TimedPointRaceModeBuffShowView:unbindEvents()
	TimedPointRaceModeBuffShowView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnAddTime:RemoveClickListener()

	for i = 1, 10 do
		for k = 1, 3 do
			self._coms[i][k].btn:RemoveClickListener()
		end
	end
end

function TimedPointRaceModeBuffShowView:bindEvents()
	TimedPointRaceModeBuffShowView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickBtnTip, self)
	self._btnAddTime:AddClickListener(self.close, self)

	for i = 1, 10 do
		for k = 1, 3 do
			self._coms[i][k].btn:AddClickListener(function()
				self:_onClickBuffBattle(i, k)
			end)
		end
	end
end

function TimedPointRaceModeBuffShowView:onEnter()
	TimedPointRaceModeBuffShowView.super.onEnter(self)

	local params = self:getOpenParam()

	self._challengeId = checkint(params[1])
	self._enterType = checkint(params[2])

	if self._enterType and self._tip then
		self._tip:ChangeStateNow(self._enterType - 1)
	end

	self:_updateViewFixedPart()
	self:_refreshInfo()
	GlobalDispatcher:addListener(GlobalNotify.TimedPointRaceModeDailyFresh, self._getInfoDaily, self)
	GlobalDispatcher:addListener(GlobalNotify.TimedPointRaceModeInfoUpdate, self._refreshInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.TimedPointRaceModeError, self._onError, self)
	self:_onTick()
	settimer(1, self._onTick, self, true)
end

function TimedPointRaceModeBuffShowView:onExit()
	TimedPointRaceModeBuffShowView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.TimedPointRaceModeDailyFresh, self._getInfoDaily, self)
	GlobalDispatcher:removeListener(GlobalNotify.TimedPointRaceModeInfoUpdate, self._refreshInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.TimedPointRaceModeError, self._onError, self)
	removetimer(self._onTick, self)
end

function TimedPointRaceModeBuffShowView:_updateViewFixedPart()
	self._commonCfg = TimedPointRaceModeConfig.instance:getCommonCfg(self._challengeId)

	for i = 1, 10 do
		for k = 1, 3 do
			local cfg = TimedPointRaceModeConfig.instance:getBuffChallengeCfgs(self._challengeId, i, k)

			goutil.setActive(self._coms[i][k].go, cfg)

			if cfg then
				self._coms[i][k].txt.text = langPara("%s%s级", cfg.buffName, cfg.buffLv)
				self._coms[i][k].cfg = cfg

				goutil.setActive(self._coms[i].go, cfg.enterViewType == self._enterType)
			end
		end
	end

	for k, v in ipairs(self.otherMenber) do
		if self._enterType == k then
			goutil.setActive(v.bg, true)

			self._txtTitle.text = v.titlelabel
		else
			goutil.setActive(v.bg, false)
		end
	end
end

function TimedPointRaceModeBuffShowView:_refreshInfo()
	self._curInfo = TimedPointRaceModeModel.instance:getInfo(self._challengeId)

	local withBuff = self._curInfo.withBuffs

	for i = 1, 10 do
		for k = 1, 3 do
			if withBuff[i] + 1 == k then
				goutil.setActive(self._coms[i][k].passmark, false)
				goutil.setActive(self._coms[i][k].select, true)
				goutil.setActive(self._coms[i][k].lock, false)
			elseif k < withBuff[i] + 1 then
				goutil.setActive(self._coms[i][k].passmark, true)
				goutil.setActive(self._coms[i][k].select, false)
				goutil.setActive(self._coms[i][k].lock, false)
			else
				goutil.setActive(self._coms[i][k].passmark, false)
				goutil.setActive(self._coms[i][k].select, false)
				goutil.setActive(self._coms[i][k].lock, true)
			end
		end
	end

	self._curBuyBuffTimes = checkint(self._curInfo.buyBuffTimes)
	self._buffLeftTime = checkint(self._commonCfg.buffFreeTimes) - self._curInfo.useBuffTimes + self._curBuyBuffTimes
	self._txtLeftTime.text = langPara("剩余秩序次数：%s", self._buffLeftTime)

	local isMatchVip = VipModel.instance:getCurVipLv() >= self._commonCfg.buyNeedVipLv
	local isTimeHasLeft = self._buffLeftTime > 0
	local isHasBuyTimeLeft = self._commonCfg.buffBuyTimes > self._curBuyBuffTimes

	goutil.setActive(self._btnAddTime.gameObject, isMatchVip and not isTimeHasLeft and isHasBuyTimeLeft)
end

function TimedPointRaceModeBuffShowView:_onClickBuffBattle(buffType, BuffLv)
	self._curInfo = TimedPointRaceModeModel.instance:getInfo(self._challengeId)

	local withBuff = self._curInfo.withBuffs
	local isAble, isTimeAble, isDateAble = TimedPointRaceModeConfig.instance:isTimeAbleToChallenge(self._challengeId)

	if isAble then
		if withBuff[buffType] then
			if withBuff[buffType] then
				if self._buffLeftTime <= 0 then
					TipsFacade.instance:openCommonTips("当前秩序次数已耗尽")
				elseif withBuff[buffType] == BuffLv then
					UIStateManager.instance:push(self._commonCfg.buffEnterBattleView, self._challengeId, self._coms[buffType][BuffLv].cfg)
				elseif withBuff[buffType] < BuffLv then
					TipsFacade.instance:openCommonTips("尚未通关前置秩序")
				else
					TipsFacade.instance:openCommonTips("今日已通关")
				end
			else
				self:close()
			end
		end
	else
		if isDateAble then
			TipsFacade.instance:openCommonTips(langPara("%s不可挑战", self._commonCfg.closeRange))
		else
			TipsFacade.instance:openCommonTips("当前挑战允许日期已过")
		end

		self:close()
	end
end

function TimedPointRaceModeBuffShowView:_onError(status)
	self:close()
end

function TimedPointRaceModeBuffShowView:_getInfoDaily()
	TipsFacade.instance:openCommonTips("今日挑战已重置")
	self:close()
end

function TimedPointRaceModeBuffShowView:_onClickBtnTip()
	return
end

function TimedPointRaceModeBuffShowView:_onClickAddBuffTime()
	if self._buffLeftTime <= 0 then
		local leftBuyBuffTime = self._commonCfg.buffBuyTimes - self._curBuyBuffTimes

		if leftBuyBuffTime > 0 then
			local curcost = self._commonCfg.buffBuyTimesCost
			local curCostType, curCostId, curCostNum = MaterialMgr.getMatParams(curcost)
			local curIcon = MaterialMgr.getContentMatCfg(curCostType, curCostId, 30, -5, MaterialMgr.ICON_TYPE_ICON)
			local content = langPara("确定花费<color=#ebad32>%s</color>%s购买挑战次数吗？\n每天最多可购买：<color=#ebad32>%s次</color>，还能购买<color=#ebad32>%s次</color>", curCostNum, curIcon, self._commonCfg.buffBuyTimes, leftBuyBuffTime)

			TipsFacade.instance:openPopupCostMatViewNew(curCostType, curCostId, curCostNum, content, function()
				TimedChallengeRankingScoreAgent.instance:sendPM_TimedChallengeRankingScoreBuyBuffTimesReq(self._challengeId)
			end)
		else
			FloatWordMgr.instance:show("今日购买已达上限，次日5点刷新购买次数")
		end
	end
end

function TimedPointRaceModeBuffShowView:_onTick()
	local challengeCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	if challengeCfg and self._commonCfg then
		local endDateTime = GameUtil.string2time(challengeCfg.absoluteEndDay) - self._commonCfg.notFightDays * 86400
		local curTime = ServerTime.now()
		local leftTime = endDateTime - curTime

		if leftTime > 0 then
			self._txtTime.text = langPara("剩余：%s", GameUtil.FormatTimeSymbol(leftTime))

			return
		end
	end

	self._txtTime.text = langPara("剩余:00:00:00")

	local text = "挑战日期已经结束"

	TipsFacade.instance:openTipWindowNoX("提示", text, function()
		UIStateManager.instance:popByName(self._viewPresentor.viewName)
	end)
	removetimer(self._onTick, self)
end

return TimedPointRaceModeBuffShowView
