-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/view/FbbchallengemainView.lua

module("logic.extensions.fbbchallenge.view.FbbchallengemainView", package.seeall)

local FbbchallengemainView = class("FbbchallengemainView", TableViewComponent)

function FbbchallengemainView:ctor()
	FbbchallengemainView.super.ctor(self)

	self._challengeId = FbbchallengeConfig.instance:getDefineValue("CHALLENGE_ID", true)
end

function FbbchallengemainView:buildUI()
	FbbchallengemainView.super.buildUI(self)

	self._leftTimeFmt = "距离活动结束：%s"
	self._closeButton = self:getBtn("topleft/btnClose")
	self._txtLeftTime = goutil.findChildTextComponent(self.mainGO, "txtLeftTime")
	self._txtLeftChallengeCount = goutil.findChildTextComponent(self.mainGO, "txtLeftCount")
	self._btnStart = self:getBtn("btnStart")
	self._redPoint = goutil.findChild(self._btnStart.gameObject, "dot")
	self._con = self:getGo("con")
	self._btnRank = self:getBtn("btnRank")
	self._btnRule = self:getBtn("btnRule")
	self._scoreBarSli = self:getSlider("scoreScroll/viewport/content/scoreBarSli")
	self._scoreBarSliTr = self._scoreBarSli.transform
	self._scrollContentTr = self:getGo("scoreScroll/viewport/content").transform
	self._progressRewardEffectHandler = {}
	self._btnBuyTime = self:getBtn("btnBuyTime")
	self._txtTotalDamage = goutil.findChildTextComponent(self.mainGO, "img/txtTotalDamage")
	self._txtBossLeftHP = goutil.findChildTextComponent(self.mainGO, "txtBossLeftHP")
end

function FbbchallengemainView:bindEvents()
	FbbchallengemainView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnRule:AddClickListener(self._onClickRule, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnBuyTime:AddClickListener(self._onClickbtnBuyTime, self)
end

function FbbchallengemainView:unbindEvents()
	FbbchallengemainView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnBuyTime:RemoveClickListener()
end

function FbbchallengemainView:_setEffectUrls()
	self._effPaths = {
		{
			goPath = "point_fx_1",
			path = "fx_ui_yirenzhixia/fx_ui_yirenzhixia_baobaoui.prefab"
		}
	}
end

function FbbchallengemainView:onEnter()
	FbbchallengemainView.super.onEnter(self)
	RedPointController.instance:regRedPoint(self._redPoint, 125)
	GlobalDispatcher:addListener(FbbchallengeController.PM_FengBaoBaoClgGetInfoRes, self._onFightInfoRes, self)
	GlobalDispatcher:addListener(FbbchallengeController.PM_FengBaoBaoClgBuyTimesRes, self._onBuyTimeRes, self)

	self._isFirstLoadData = true
	self._challengeCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	self:_updateInfo(self._challengeCfg.raceId)
	settimer(1, self._onTick, self, true)
	self:_onTick()
	self:_setEffectUrls()
	self:_createEffs()
	FengBaoBaoChallengeAgent.instance:sendPM_FengBaoBaoClgGetInfoReq()
end

function FbbchallengemainView:onExit()
	FbbchallengemainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redPoint)
	GlobalDispatcher:removeListener(FbbchallengeController.PM_FengBaoBaoClgGetInfoRes, self._onFightInfoRes, self)
	GlobalDispatcher:removeListener(FbbchallengeController.PM_FengBaoBaoClgBuyTimesRes, self._onBuyTimeRes, self)
	removetimer(self._onTick, self)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	for _, eff in ipairs(self._effs) do
		UIEffectManager.instance:stopEffect(eff)
	end

	self._effs = {}

	for k, v in pairs(self._progressRewardEffectHandler) do
		UIEffectManager.instance:stopEffect(v)
	end
end

function FbbchallengemainView:_onFightInfoRes(status, msg)
	if status == 0 then
		self:_checkIsBattleSceneRetrun()
		self:_updateUI()
	end
end

function FbbchallengemainView:_onBuyTimeRes(status)
	if status == 0 then
		self:_updateUI()
	end
end

function FbbchallengemainView:_updateUI()
	self._info = FbbchallengeModel.instance:getClgInfo()

	if not self._info then
		return
	end

	local maxDailyTimes = FbbchallengeConfig.instance:getDefineValue("DAILY_TIMES", true)

	self._leftChallengeCount = maxDailyTimes + self._info.buyTimes - self._info.clgTimes
	self._leftChallengeCount = math.max(0, self._leftChallengeCount)
	self._txtLeftChallengeCount.text = string.format("今天剩余次数：  <color=#4FEA91FF>%s</color>/%s", self._leftChallengeCount, maxDailyTimes)

	self:_updateReward()

	local bossHp = self._info.curHp

	self._isSuccess = bossHp <= 0

	local damageNum = self._info.bossHp - self._info.curHp

	self._txtTotalDamage.text = damageNum > 10000 and math.floor(damageNum / 10000) .. "万" or damageNum

	local ratio = self._info.curHp / self._info.bossHp * 100

	self._txtBossLeftHP.text = string.format("王也剩余血量<color=#4FEA91FF>%s</color>", ratio > math.floor(ratio) and math.floor(ratio * 10) / 10 .. "%" or ratio .. "%")
end

function FbbchallengemainView:_onClickRule()
	TipsFacade.instance:openRulesView("fbbchallengemain")
end

function FbbchallengemainView:_onStartBuff()
	self:_onClickStart()
end

function FbbchallengemainView:_onClickStart()
	if self._isSuccess then
		FloatWordMgr.instance:show("王也已被击败，无需再进行挑战")

		return
	end

	if self._leftChallengeCount < 1 then
		FloatWordMgr.instance:show("今天的挑战次数已经用完了")

		return
	end

	UIStateManager.instance:push(ViewName.FbbchooseView)
end

function FbbchallengemainView:_onClickRank()
	UIStateManager.instance:push(ViewName.FbbrankView)
end

function FbbchallengemainView:_onClickClose()
	self:close()
end

function FbbchallengemainView:_onClickbtnBuyTime()
	if self._info then
		if self._info.curHp <= 0 then
			FloatWordMgr.instance:show("王也已被击败，无需再进行挑战")

			return
		end

		local hasBuyTime = self._info.buyTimes
		local dayTimes = FbbchallengeConfig.instance:getDefineValue("DAILY_TIMES", true)

		if dayTimes + hasBuyTime - self._info.clgTimes > 0 then
			FloatWordMgr.instance:show("还有挑战次数，无需购买")

			return
		end

		local planId = FbbchallengeConfig.instance:getDefineValue("BUY_TIMES_PLAN_ID", true)
		local cfgs = FbbchallengeConfig.instance:getBuyTimeCfgs(planId)
		local canBuyTimes = #cfgs

		if canBuyTimes <= hasBuyTime then
			FloatWordMgr.instance:show("购买次数不足")

			return
		end

		local arr = string.split(cfgs[hasBuyTime + 1].consume, ":")
		local matType, matId, matNum = checknumber(arr[1]), checknumber(arr[2]), checknumber(arr[3])
		local costNum = MaterialFacade.instance:getGoodCost(matType, matId, matNum)
		local hasNum = MaterialFacade.instance:getMatNumber(matType, matId)

		if hasNum < costNum then
			FloatWordMgr.instance:show("钻石余额不足")

			return
		end

		local content = string.format("确认花费%s钻石购买一次挑战次数？\n今日还可购买%s次", costNum, canBuyTimes - hasBuyTime)

		local function sureFunc()
			FengBaoBaoChallengeAgent.instance:sendPM_FengBaoBaoClgBuyTimesReq()
		end

		TipsFacade.instance:openPopupCostDiamondView(costNum, content, sureFunc)
	end
end

function FbbchallengemainView:_onTick()
	if self._challengeId == nil or not TLChallengeController.instance:isInOpenTime(self._challengeId) then
		self._txtLeftTime.text = ""

		local text = "活动已经结束"

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			UIStateManager.instance:popByName(self._viewPresentor.viewName)
		end)
		removetimer(self._onTick, self)
	else
		local leftTimeFormat = TLChallengeController.instance:getLeftTimeFormat(self._challengeId)

		self._txtLeftTime.text = string.format(self._leftTimeFmt, leftTimeFormat)
	end
end

function FbbchallengemainView:_createEffs()
	self._effs = {}

	for _, v in ipairs(self._effPaths) do
		local parent = self.mainGO

		if not string.nilorempty(v.goPath) then
			parent = self:getGo(v.goPath)
		end

		local eff = UIEffectManager.instance:playEffect(self, v.path, parent, 0, 0, true)

		eff:setParent(parent.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)
		eff:setLocalEulerAngle(0, 0, 0)
		table.insert(self._effs, eff)
	end
end

function FbbchallengemainView:_updateInfo(raceId)
	local skinId = raceId
	local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("fbbchallengemain", skinId)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	self._role = RoleObjectPool.instance:removeRole(self._role)
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, scale, nil, true, x, y)
end

function FbbchallengemainView:_updateReward()
	if self._info then
		self._maxAccHarmPrizeProcess = self._info.maxAccHarmPrizeProcess
		self._hasGainProgessPrize = {}
		self._currDamage = self._info.bossHp - self._info.curHp
		self._moveId = 1

		for i, v in ipairs(self._info.accHarmPrizeIndex) do
			self._hasGainProgessPrize[v] = true
			self._moveId = math.max(self._moveId, v)
		end

		local planId = FbbchallengeConfig.instance:getDefineValue("ACC_HARM_PRIZE_PLAN_ID", true)
		local prizeCfgs = FbbchallengeConfig.instance:getRewardPlanCfgs(planId)

		self._prizeCfgs = prizeCfgs
		self._scoreCellSpace = 95

		local len = self._scoreCellSpace * #prizeCfgs

		self._scoreCellSpace = len / #prizeCfgs
		self._tableview.gridWidth = self._scoreCellSpace
		self._tableview.cellOffset = Vector2.New(self._scoreCellSpace, 82)

		self:_updateScore()

		self._curViewDatas = prizeCfgs

		self:reloadData()
	end
end

function FbbchallengemainView:_updateScore()
	local curRatio = self._currDamage / self._maxAccHarmPrizeProcess

	curRatio = curRatio * 10000

	local fill = 0

	if self._prizeCfgs then
		local len = #self._prizeCfgs
		local step = 1 / len

		if curRatio >= self._prizeCfgs[#self._prizeCfgs].accHarm then
			fill = 1
		else
			local nextScore = 0
			local lastScore = 0

			for i, v in ipairs(self._prizeCfgs) do
				if curRatio >= v.accHarm then
					fill = fill + step
					lastScore = v.accHarm
				else
					nextScore = v.accHarm

					break
				end
			end

			fill = fill + (curRatio - lastScore) / (nextScore - lastScore) * step
		end
	end

	self._scoreBarSli:SetValue(fill)
end

function FbbchallengemainView:_checkIsBattleSceneRetrun()
	if FbbchallengeModel.instance:getBattleEndShowParams() then
		UIStateManager.instance:push(ViewName.FbbbattleresultView)
	end
end

function FbbchallengemainView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "scoreScroll"
	}
end

function FbbchallengemainView:_cellSize(view, index)
	return self._scoreCellSpace, 100
end

function FbbchallengemainView:_updateCell(view, cell, cfg)
	local goReceiveShowGo = goutil.findChild(cell.gameObject, "receiveShowGo")
	local goItemcell = goutil.findChild(cell.gameObject, "itemcell")
	local goEffect = goutil.findChild(cell.gameObject, "effect")
	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")
	local isGet = self._hasGainProgessPrize[cfg.prizeId]
	local needDamage = cfg.accHarm / 10000 * self._maxAccHarmPrizeProcess
	local isCanGet = false

	if not isGet then
		isCanGet = needDamage <= self._currDamage
	end

	goutil.setActive(goReceiveShowGo, isGet)

	local proxy = MaterialMgr.setCellByCfg(cfg.prize, goItemcell)
	local num = math.floor(needDamage)

	txtNum.text = num >= 10000 and math.floor(num / 10000) .. "万" or num
end

function FbbchallengemainView:_clearTableview(cell)
	local goItemcell = goutil.findChild(cell.gameObject, "itemcell")

	MaterialMgr.resetAll(goItemcell)
end

function FbbchallengemainView:_checkMoveToCenterOffset()
	if self._isFirstLoadData then
		self._isFirstLoadData = nil

		local numCells = self:_numInView()

		if self._moveId and self._moveId >= 1 and numCells >= self._moveId then
			local cellWidth = self._tableview.gridWidth
			local offset = (self._moveId - 1) * cellWidth
			local viewSize = self._tableview:GetViewSize()
			local offsetTo = offset - viewSize * 0.5 + cellWidth * 0.5
			local minOfs = 0
			local maxOfs = (numCells - 1) * cellWidth
			local ofs = math.max(minOfs, math.min(offsetTo, maxOfs))

			self._tableview:SetOffsetWithoutRefresh(ofs)
		end
	end
end

function FbbchallengemainView:_onReloadFinish()
	if self._isFirstLoadData then
		self:_checkMoveToCenterOffset()
		self._tableview:ReloadData()
	end
end

return FbbchallengemainView
