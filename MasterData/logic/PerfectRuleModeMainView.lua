-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/perfectrulemode/PerfectRuleModeMainView.lua

module("logic.extensions.timelimitedchallenge.view.perfectrulemode.PerfectRuleModeMainView", package.seeall)

local PerfectRuleModeMainView = class("PerfectRuleModeMainView", TimeLimitedMainView)

function PerfectRuleModeMainView:_setEffectUrls()
	self._effPaths = {}
end

function PerfectRuleModeMainView:buildUI()
	PerfectRuleModeMainView.super.buildUI(self)

	self._btnReceive = self:getBtn("dailyPrize/btnReceive")
	self._imgIcon = self:getGo("dailyPrize/imgIcon")
	self._txtNum = self:getTxt("dailyPrize/txtNum")
	self._imgReceived = self:getGo("dailyPrize/imgReceived")
	self._goAdd = self:getGo("btnAdd")
	self._btnAdd = GameUtil.asBtn(self._goAdd)
	self._dot = self:getGo("dailyPrize/btnReceive/dot")
	self._txtEffectName = self:getTxt("dailyPrize/txtEffectName")
	self._challengeId = 0
end

function PerfectRuleModeMainView:bindEvents()
	PerfectRuleModeMainView.super.bindEvents(self)
	self._btnReceive:AddClickListener(self._onClickReceive, self)
	self._btnAdd:AddClickListener(self._onClickAdd, self)
end

function PerfectRuleModeMainView:unbindEvents()
	PerfectRuleModeMainView.super.unbindEvents(self)
	self._btnReceive:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
end

function PerfectRuleModeMainView:onEnter()
	PerfectRuleModeMainView.super.onEnter(self)

	if self._challengeId > 0 then
		self:_updateCurCfg()
		self:_freshViewFixedPart()
		self:doSpecialThing()
		self:_getInfoDaily()
	else
		printError("请在当前界面buildUI 重写当前挑战ID")
	end

	RedPointController.instance:unregRedPoint(self._redPoint)
	GlobalDispatcher:addListener(GlobalNotify.PerfectRuleModeDailyRresh, self._getInfoDaily, self)
	GlobalDispatcher:addListener(GlobalNotify.PerfectRuleModeInfoUpdate, self._refreshInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.PerfectRuleModeError, self._onError, self)
end

function PerfectRuleModeMainView:onExit()
	PerfectRuleModeMainView.super.onExit(self)
	MaterialMgr.clearIcon(self._imgIcon)
	MaterialMgr.resetAll(self._pointRankItem)
	GlobalDispatcher:removeListener(GlobalNotify.PerfectRuleModeDailyRresh, self._getInfoDaily, self)
	GlobalDispatcher:removeListener(GlobalNotify.PerfectRuleModeInfoUpdate, self._refreshInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.PerfectRuleModeError, self._onError, self)
end

function PerfectRuleModeMainView:doSpecialThing()
	return
end

function PerfectRuleModeMainView:_updateCurCfg()
	self._commonCfg = PerfectRuleModeConfig.instance:getCommonCfg(self._challengeId)
	self._totalTimes = self._commonCfg.dailyTimes
	self._ableToBuyTimes = PerfectRuleModeConfig.instance:getMaxBuyTimes(self._challengeId)

	local petRankThreshold = checknumber(self._commonCfg.rankLimit)
	local petRankPrize = self._commonCfg.rankPrize

	self._txtTipRank.text = string.format("前%s名\n可获得", petRankThreshold)

	MaterialMgr.setCellByCfg(petRankPrize, self._pointRankItem)
end

function PerfectRuleModeMainView:_freshViewFixedPart()
	local matstr = self._commonCfg.dailyPrize

	if not string.nilorempty(matstr) then
		local matType, matId, matNum = MaterialMgr.getMatParams(matstr)

		MaterialMgr.clearIcon(self._imgIcon)
		MaterialMgr.updateItemByStr(self._imgIcon, matstr)

		self._txtEffectName.text = MaterialMgr.getMaterialsName(matType, matId)
		self._txtNum.text = "x" .. matNum
	end

	self._txtTipRank.text = langPara("前%s名\n可获得", self._commonCfg.rankLimit)
end

function PerfectRuleModeMainView:_updateCurInfo()
	self._curInfo = PerfectRuleModeModel.instance:getInfo(self._challengeId)
	self._leftTimes = self._totalTimes + self._curInfo.hasBuyTimes - self._curInfo.hasUseTimes

	GameUtil.SetActive(self._tipExchange, not self._curInfo.isHasGainPet)
end

function PerfectRuleModeMainView:_getInfoDaily()
	PerfectRuleFightAgent.instance:sendPM_PerfectRuleFightGetInfoReq(self._challengeId)
end

function PerfectRuleModeMainView:_refreshInfo()
	self:_updateCurInfo()
	self:_updateLeftTimes()
	self:_updateRankTip()
	self:_updateDailyPrize()
end

function PerfectRuleModeMainView:_updateLeftTimes()
	self._txtLeftChallengeCount.text = langPara("今天剩余次数：<color=#FFFFFFFF>%d/%d</color>", self._leftTimes, self._totalTimes)

	goutil.setActive(self._goAdd, self._leftTimes == 0)
	goutil.setActive(self._redPoint, self._leftTimes ~= 0)
end

function PerfectRuleModeMainView:_updateRankTip()
	self:_activeTipRank(self._commonCfg.rankLimit >= self._curInfo.rankSize and not self._curInfo.isHasGainPet)
end

function PerfectRuleModeMainView:_updateDailyPrize()
	goutil.setActive(self._imgReceived, self._curInfo.isHasGain)
	goutil.setActive(self._dot, not self._curInfo.isHasGain)
	GameUtil.SetGray(self._btnReceive.gameObject, self._curInfo.isHasGain)
end

function PerfectRuleModeMainView:_onError(status)
	self:close()
end

function PerfectRuleModeMainView:_onClickReceive()
	if self._curInfo.isHasGain then
		FloatWordMgr.instance:show(lang("今天已领取，明天再来吧"))
	else
		PerfectRuleFightAgent.instance:sendPM_PerfectRuleFightGainDailyPrizeReq(self._challengeId)
	end
end

function PerfectRuleModeMainView:_onClickAdd()
	if self._curInfo.hasBuyTimes >= self._ableToBuyTimes then
		FloatWordMgr.instance:show(lang("今日购买已达上限，次日5点刷新购买次数"))
	else
		local curcost = PerfectRuleModeConfig.instance:getCostByIdAndTimes(self._challengeId, self._curInfo.hasBuyTimes + 1)
		local curCostType, curCostId, curCostNum = MaterialMgr.getMatParams(curcost)
		local curIcon = MaterialMgr.getContentMatCfg(curCostType, curCostId, 30, -5, MaterialMgr.ICON_TYPE_ICON)
		local content = langPara("确定花费<color=#ebad32>%s</color>%s购买挑战次数吗？\n每天最多可购买：<color=#ebad32>%s次</color>，还能购买<color=#ebad32>%s次</color>", curCostNum, curIcon, self._ableToBuyTimes, self._ableToBuyTimes - self._curInfo.hasBuyTimes)

		TipsFacade.instance:openPopupCostMatViewNew(curCostType, curCostId, curCostNum, content, function()
			PerfectRuleFightAgent.instance:sendPM_PerfectRuleFightBuyTimesReq(self._challengeId)
		end)
	end
end

function PerfectRuleModeMainView:_onClickStart()
	if self._leftTimes == 0 then
		if self._curInfo.hasBuyTimes >= self._ableToBuyTimes then
			FloatWordMgr.instance:show(lang("今日挑战次数已耗尽！"))
		else
			FloatWordMgr.instance:show(lang("今日挑战次数已耗尽，可购买次数继续挑战！"))
			self:_onClickAdd()
		end
	else
		local curRuleId = self._curInfo.curRuleId

		if curRuleId and curRuleId > 0 then
			UIStateManager.instance:push(self._commonCfg.ruleview, self._challengeId)
		else
			UIStateManager.instance:push(self._commonCfg.difficultyview, self._challengeId)
		end
	end
end

function PerfectRuleModeMainView:_onClickRank()
	if string.nilorempty(self._commonCfg.gotoRank) then
		printInfo("test PerfectRuleModeMainView:_onClickRank 配置为空")
		PerfectRuleModeMainView.super._onClickRank(self)
	else
		printInfo("test PerfectRuleModeMainView:_onClickRank 配置为", self._commonCfg.gotoRank)
		GotoMgr.gotoByString(self._commonCfg.gotoRank)
	end
end

function PerfectRuleModeMainView:_onClickTry()
	if string.nilorempty(self._commonCfg.gotoShop) then
		printInfo("test PerfectRuleModeMainView:_onClickTry 配置为空")
		PerfectRuleModeMainView.super._onClickTry(self)
	else
		printInfo("test PerfectRuleModeMainView:_onClickTry 配置为", self._commonCfg.gotoShop)
		GotoMgr.gotoByString(self._commonCfg.gotoShop)
	end
end

return PerfectRuleModeMainView
