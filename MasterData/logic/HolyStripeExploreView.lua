-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripeexplore/view/HolyStripeExploreView.lua

module("logic.extensions.holystripeexplore.view.HolyStripeExploreView", package.seeall)

local HolyStripeExploreView = class("HolyStripeExploreView", ViewComponent)

function HolyStripeExploreView:buildUI()
	HolyStripeExploreView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnPlay = self:getGo("btnPlay")
	self._txtPlayTime = goutil.findChildTextComponent(self._btnPlay, "txtTime")
	self._goActTime = self:getGo("actTime")
	self._txtActTime = self:getTxt("actTime/txt")
	self._chessboard = self:getGo("chessboard")
	self._chesscell = self:getGo("chesscell")
	self._chessCells = {}
	self._comPlayer = self:getGo("comPlayer")
	self._btnOneKey = self:getGo("btnOneKey")
	self._viptips = self:getGo("btnOneKey/viptips")
	self._txtVip = self:getTxt("btnOneKey/viptips/txtVip")
end

function HolyStripeExploreView:onEnter()
	HolyStripeExploreView.super.onEnter(self)
	self:_initViewState()
	HolyStripeExploreController.instance:getInfo()
	GlobalDispatcher:addListener(GlobalNotify.HolyStripeExploreInfoUpdate, self.refreshViewByInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.HolyStripeExploreMoveChess, self.doMove, self)
	GlobalDispatcher:addListener(GlobalNotify.HolyStripeExploreTimeUpdate, self.refreshTimes, self)
	self.addGEvent(self, GlobalNotify.HolyStripeExploreFinshOneKey, self._PM_LWExploreOneKeyRes, self)

	self._mainEff = UIEffectManager.instance:playEffect(self, "20220729/lingwentanxian/fx_ui_lingwentanxian_jm.prefab", nil, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(self.mainGO.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)

		eff.hideEffWhileNotOnTop = true
	end)
end

function HolyStripeExploreView:onExit()
	HolyStripeExploreView.super.onExit(self)
	self:_resetViewState()
	GlobalDispatcher:removeListener(GlobalNotify.HolyStripeExploreInfoUpdate, self.refreshViewByInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.HolyStripeExploreMoveChess, self.doMove, self)
	GlobalDispatcher:removeListener(GlobalNotify.HolyStripeExploreTimeUpdate, self.refreshTimes, self)
end

function HolyStripeExploreView:bindEvents()
	HolyStripeExploreView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnPlay, self._onClickPlay, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
end

function HolyStripeExploreView:unbindEvents()
	HolyStripeExploreView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnPlay)
	GameUtil.rmClickHandler(self._btnOneKey)
end

function HolyStripeExploreView:_initViewState()
	self._isMoving = false

	goutil.setActive(self._goActTime, false)
	goutil.setActive(self._chesscell, false)

	local path = "20211028/zhiren_aoqi/zhiren_aoqi-ui_p.prefab"

	self._spine = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, nil, nil, function(finishHandlerTarget, eff)
		eff:setParent(self._comPlayer.transform)
		eff:setScale(0.2)
		eff:setLocalPos(0, -20, 0)
		RoleObjectPool.instance:playAnimation(eff.effGo, "idle", true)
	end)

	local vipLv = VipModel.instance:getCurVipLv()

	self._skipVipLv = 0

	for i, v in ipairs(VipConfig.instance:getPrivilegeCfgList()) do
		if v.privilegeType == GameEnum.PrivilegeType.SkipGameLingWenExport and checknumber(v.params) == 1 and (self._skipVipLv == 0 or self._skipVipLv > v.vipLv) then
			self._skipVipLv = v.vipLv
		end
	end

	self._txtVip.text = langPara("VIP%d解锁", self._skipVipLv)

	GameUtil.SetActive(self._viptips, vipLv < self._skipVipLv)
end

function HolyStripeExploreView:_resetViewState()
	if self._spine then
		UIEffectManager.instance:stopEffect(self._spine)

		self._spine = nil
	end

	removetimer(self.onCountDown, self)
	removetimer(self.onMove, self)

	if self._tweenList then
		for i, v in ipairs(self._tweenList) do
			v:Kill()
		end

		self._tweenList = nil
	end

	if self._mainEff then
		UIEffectManager.instance:stopEffect(self._mainEff)

		self._mainEff = nil
	end

	if self._lastPosEff then
		UIEffectManager.instance:stopEffect(self._lastPosEff)

		self._lastPosEff = nil
	end
end

function HolyStripeExploreView:refreshViewByInfo()
	if HolyStripeExploreModel.instance:getCurInfo() then
		self:buildChessBoard()
		self:refreshTimes()
		self:setCountDownTimer()
	else
		local text = langPara("当前探险不存在")

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			UIStateManager.instance:popByName(self._viewPresentor.viewName)
		end)
	end
end

function HolyStripeExploreView:_onClickClose()
	if self._isMoving then
		FloatWordMgr.instance:show(lang("动画播放中"))

		return
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), "确定要退出灵纹探险吗？", function()
		self:close()
	end)
end

function HolyStripeExploreView:_onClickTip()
	if self._isMoving then
		FloatWordMgr.instance:show(lang("动画播放中"))

		return
	end

	UIStateManager.instance:open(ViewName.RulesView, HolyStripeExploreConfig.instance:getCommonValue("RULE"))
end

function HolyStripeExploreView:_onClickPlay()
	if self._isMoving then
		FloatWordMgr.instance:show(lang("动画播放中"))

		return
	end

	if HolyStripeExploreModel.instance:checkHasGetBigPrize() then
		FloatWordMgr.instance:show(lang("本局游戏已完成"))

		return
	end

	if HolyStripeExploreModel.instance:getCurLeftGameTime() > 0 then
		UIStateManager.instance:push(ViewName.HolyStripeExploreGameView)
	else
		local curBuyLeftTime, buyTimeLimit = HolyStripeExploreModel.instance:getCurLeftBuyTimeAndTimeLimit()
		local cost = HolyStripeExploreConfig.instance:getCommonValue("BUY_STEP_PRICE")
		local costType, costId, costNum = MaterialMgr.getMatParams(cost)
		local costName = MaterialMgr.getMaterialsName(costType, costId)

		if curBuyLeftTime > 0 then
			local content = langPara("确定花费%s%s购买挑战次数吗？\n每轮最多可购买%s次，还能购买%s次", costNum, costName, buyTimeLimit, curBuyLeftTime)

			TipsFacade.instance:openPopupCostMatViewNew(costType, costId, costNum, content, function()
				HolyStripeExploreController.instance:buyGameTime()
			end)
		else
			FloatWordMgr.instance:show(lang("本局游戏次数和购买游戏次数已达上限"))
		end
	end
end

function HolyStripeExploreView:buildChessBoard()
	local curGridInfos = HolyStripeExploreModel.instance:getCurMapInfos()

	for k, info in ipairs(curGridInfos) do
		local cell = self._chessCells[k]

		if cell and cell.go then
			-- block empty
		else
			cell = {
				go = goutil.cloneAndSetParent(self._chesscell, self._chessboard.transform, "chesscell" .. k)
			}
		end

		cell.icon = goutil.findChild(cell.go, "icon")
		cell.change = cell.icon:GetComponent("UIImageSpriteChange")
		cell.btnEvent = goutil.findChild(cell.go, "btnEvent")
		cell.goFirst = goutil.findChild(cell.go, "goFirst")
		cell.goEnd = goutil.findChild(cell.go, "goEnd")
		cell.pos = goutil.findChild(cell.go, "pos")
		cell.info = info

		if info.isFirst then
			goutil.setActive(cell.icon, false)
			goutil.setActive(cell.goFirst, true)
			goutil.setActive(cell.goEnd, false)
		else
			goutil.setActive(cell.goFirst, false)
			goutil.setActive(cell.icon, true)

			if info.isEnd then
				cell.change:SetState(1)
				goutil.setActive(cell.goEnd, true)
			else
				cell.change:SetState(0)
				goutil.setActive(cell.goEnd, false)
			end
		end

		GameUtil.setAnchoredPos(cell.go, info.posX, info.posY)

		self._chessCells[k] = cell
	end

	self._curGridId = HolyStripeExploreModel.instance:getCurGridId()

	self._comPlayer.transform:SetParent(self._chessCells[self._curGridId].pos.transform)
	GameUtil.setAnchoredPos(self._comPlayer, 0, 0)
	self._comPlayer.transform:SetParent(self._chessboard.transform)

	for i = 1, self._curGridId do
		goutil.setActive(self._chessCells[i].icon, false)
	end

	for k, cell in ipairs(self._chessCells) do
		if k <= #curGridInfos then
			goutil.setActive(cell.go, true)
		else
			goutil.setActive(cell.go, false)
		end
	end
end

function HolyStripeExploreView:doMove()
	self:refreshTimes()

	local newGridId = HolyStripeExploreModel.instance:getCurGridId()

	self._stepNum = newGridId - self._curGridId

	if self._stepNum > 0 then
		self._isMoving = true

		settimer(0.5, self.onMove, self)

		if self._spine then
			RoleObjectPool.instance:playAnimation(self._spine.effGo, "run", true)
		end
	end
end

function HolyStripeExploreView:onMove()
	if self._stepNum > 0 then
		self._stepNum = self._stepNum - 1
		self._curGridId = self._curGridId + 1

		local pos1 = GameUtil.getPos(self._comPlayer) or Vector3.zero
		local pos2 = GameUtil.getPos(self._chessCells[self._curGridId].pos) or Vector3.zero

		GameUtil.setLocalScale(self._comPlayer, pos1.x - pos2.x > 0 and -1 or 1, 1, 1)

		local tween = self._comPlayer.transform:DOMove(self._chessCells[self._curGridId].pos.transform.position, 0.5)

		self._tweenList = self._tweenList or {}

		table.insert(self._tweenList, tween)
		goutil.setActive(self._chessCells[self._curGridId].icon, false)

		if self._lastPosEff then
			UIEffectManager.instance:stopEffect(self._lastPosEff)

			self._lastPosEff = nil
		end

		self._lastPosEff = UIEffectManager.instance:playEffect(self, "20220729/lingwentanxian/fx_ui_lingwentanxian_jb.prefab", nil, 0, 0, false, false, nil, function(target, eff)
			eff:setParent(self._chessCells[self._curGridId].pos.transform)
			eff:setLocalPos(-24, 270, 0)
			eff:setScale(1)

			eff.hideEffWhileNotOnTop = true
		end)
	elseif self._stepNum == 0 then
		self._stepNum = self._stepNum - 1

		if self._tweenList then
			for i, v in ipairs(self._tweenList) do
				v:Kill()
			end

			self._tweenList = nil
		end

		if self._spine then
			RoleObjectPool.instance:playAnimation(self._spine.effGo, "idle", true)
		end
	else
		removetimer(self.onMove, self)

		self._isMoving = false

		if HolyStripeExploreModel.instance:checkHasGetBigPrize() then
			if self._lastPosEff then
				UIEffectManager.instance:stopEffect(self._lastPosEff)

				self._lastPosEff = nil
			end

			self._lastPosEff = UIEffectManager.instance:playEffect(self, "20220729/lingwentanxian/fx_ui_lingwentanxian_bx.prefab", nil, 0, 0, false, false, function()
				HolyStripeExploreModel.instance:showCI()
			end, function(target, eff)
				eff:setParent(self.mainGO.transform)
				eff:setLocalPos(0, 0, 0)
				eff:setScale(1)

				eff.hideEffWhileNotOnTop = true
			end)
		else
			HolyStripeExploreModel.instance:showCI()
		end
	end
end

function HolyStripeExploreView:checkIsBigPrize()
	return self._curGridId == #HolyStripeExploreModel.instance:getCurMapInfos()
end

function HolyStripeExploreView:setCountDownTimer()
	goutil.setActive(self._goActTime, true)

	self._timeEnd = HolyStripeExploreModel.instance:getCurEndTime()

	settimer(1, self.onCountDown, self)
	self:onCountDown()
end

function HolyStripeExploreView:onCountDown()
	local timeLeft = self._timeEnd - ServerTime.now()

	if timeLeft > 0 then
		self._txtActTime.text = GameUtil.FormatTimeWords(timeLeft)
	else
		removetimer(self.onCountDown, self)

		local text = langPara("倒计时结束，本次探险自动结束")

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			UIStateManager.instance:popByName(self._viewPresentor.viewName)
			UIStateManager.instance:popByName(ViewName.HolyStripeExploreGameView)
		end)
	end
end

function HolyStripeExploreView:refreshTimes()
	self._txtPlayTime.text = langPara("共剩余%s次", HolyStripeExploreModel.instance:getCurLeftGameTime())
end

function HolyStripeExploreView:_onClickOneKey()
	if self._isMoving then
		FloatWordMgr.instance:show(lang("动画播放中"))

		return
	end

	local vipLv = VipModel.instance:getCurVipLv()

	if vipLv < self._skipVipLv then
		FloatWordMgr.instance:show(langPara("VIP%d解锁", self._skipVipLv))
	else
		LingWenExploreAgent.instance:sendPM_LWExploreOneKeyReq()
	end
end

function HolyStripeExploreView:_PM_LWExploreOneKeyRes()
	self:close()
end

return HolyStripeExploreView
