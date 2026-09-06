-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/view/TripleMacthesStartView.lua

module("logic.extensions.triplemacthesgame.view.TripleMacthesStartView", package.seeall)

local TripleMacthesStartView = class("TripleMacthesStartView", ViewComponent)

function TripleMacthesStartView:ctor()
	TripleMacthesStartView.super.ctor(self)
end

function TripleMacthesStartView:unbindEvents()
	TripleMacthesStartView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnPrize)
end

function TripleMacthesStartView:bindEvents()
	TripleMacthesStartView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
end

function TripleMacthesStartView:buildUI()
	TripleMacthesStartView.super.buildUI(self)

	self._btnStart = self:getGo("Btn_Start")
	self._btnClose = self:getGo("Btn_Close")
	self._btnRank = self:getGo("btnRank")
	self._btnPrize = self:getGo("btnPrize")
	self._txtGameTime = self:getTxt("Txt_Cnt")
	self._redPointStart = self:getGo("Btn_Start/redPoint")
	self._playercellGo = self:getGo("reward/playerReward/playercell")
	self._tableviewGo = self:getGo("reward/playerReward/tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._playercellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._playerScrollRectTrans = self:getGo("reward/playerReward/tableview"):GetComponent(goutil.Type_RectTransform)
	self._txtPlayerScore = self:getTxt("reward/playerReward/txtPlayerScore")
	self._slider = self:getSlider("reward/playerReward/tableview/viewport/content/progressSlider")
	self._tipsRoot = self:getGo("tipsRoot")
end

function TripleMacthesStartView:onExit()
	TripleMacthesStartView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redPointStart)
	self._scrollerList:dispose()
end

function TripleMacthesStartView:onEnter()
	TripleMacthesStartView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handlePM_TripleMatchesGameGetInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.TripleMatchesGameGainPrizeRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.TripleMatchesGameSweepRes, self._refreshView, self)

	local params = self:getOpenParam()

	self._activityId = params and params[1] and params[1] or TripleMacthesModel.instance:getCurrActId()
	self._activityType = GameEnum.ActivityType.TripleMacthesGame
	self._isBelongSweep = AnnuityPrivilegeController.instance:isBelongSweep(self._activityId)
	self._actCfg = TripleMachesGameConfig.instance:getActivityCfgById(self._activityId)

	RedPointController.instance:regRedPoint(self._redPointStart, self._actCfg.redPointId)
	AnnuityPrivilegeController.instance:addAnnuityPrivilegeSweepTipsView(self._tipsRoot, self._viewPresentor, self._activityId)
	TripleMatchesGameAgent.instance:sendPM_TripleMatchesGameGetInfoReq(self._activityId)
end

function TripleMacthesStartView:_refreshView()
	self._txtGameTime.text = langPara("今日还剩下：<size=28><color=#78ff27>%d次</color></size>", self._actCfg.dailyGameLimit - TripleMacthesModel.instance:getDailyGameTimes())

	self:_updateReward()
end

function TripleMacthesStartView:_onClickRank()
	UIStateManager.instance:push(ViewName.TripleMacthesRankView, self._activityId)
end

function TripleMacthesStartView:_onClickPrize()
	UIStateManager.instance:push(ViewName.TripleMacthesPrizeView, self._activityId)
end

function TripleMacthesStartView:_updateReward()
	local gameCfg = TripleMachesGameConfig.instance:getActivityCfgById(self._activityId)
	local hasNum = MaterialMgr.getMatCount(gameCfg.itemId)

	self._txtPlayerScore.text = string.format("%s", hasNum)

	local cfgs = TripleMachesGameConfig.instance:getProgressPrizeCfgs(self._activityId)
	local scoreList = {}

	for i, v in ipairs(cfgs) do
		table.insert(scoreList, v.progress)
	end

	self._scrollerList:reloadData(cfgs)
	self._scrollerList:updateUnderSlider(self._slider, hasNum, scoreList)
end

function TripleMacthesStartView:_updateCell(view, cell, cfg, tag)
	local goEffect = goutil.findChild(cell.gameObject, "effect")
	local goGeted = goutil.findChild(cell.gameObject, "geted")
	local goItem = goutil.findChild(cell.gameObject, "item")
	local txtScore = goutil.findChildTextComponent(cell.gameObject, "txtScore")
	local isGain = TripleMacthesModel.instance:isGainProgressPrize(self._activityId, cfg.prizeId)
	local isCanGain = not isGain and TripleMacthesModel.instance:isCanGainProgressPrize(self._activityId, cfg.prizeId)
	local matType, id, matNum = MaterialMgr.getMatParams(cfg.prize)

	MaterialMgr.resetAll(goItem)

	local proxy = MaterialMgr.setCellByCfg(cfg.prize, goItem)

	proxy.binder:setAutoTips(false)
	proxy:setCallBack(function()
		if isCanGain then
			TripleMatchesGameAgent.instance:sendPM_TripleMatchesGameGainPrizeReq(self._activityId, cfg.prizeId)
		else
			CommonTipsMgr.instance:openMaterialTips(goItem, matType, id, 0)
		end
	end)
	goutil.setActive(goEffect, isCanGain)
	goutil.setActive(goGeted, isGain)

	txtScore.text = cfg.progress

	if isCanGain then
		self:_playEffect(goEffect)
	else
		self:_clearEffect(goEffect)
	end
end

function TripleMacthesStartView:_clearCell(cell)
	local goEffect = goutil.findChild(cell.gameObject, "effect")
	local goItem = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(goItem)
end

function TripleMacthesStartView:_playEffect(goEffect)
	self:_clearEffect()

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	self._effectHandlers = self._effectHandlers or {}

	local uiEffect = self._effectHandlers[goEffect]

	uiEffect = uiEffect or UIEffectManager.instance:playEffect(self, effPath, goEffect.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self._playerScrollRectTrans)
	end)

	uiEffect:setParent(goEffect.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._effectHandlers[goEffect] = uiEffect
end

function TripleMacthesStartView:_clearEffect(goEffect)
	if self._effectHandlers and self._effectHandlers[goEffect] then
		UIEffectManager.instance:stopEffect(self._effectHandlers[goEffect])

		self._effectHandlers[goEffect] = nil
	end
end

function TripleMacthesStartView:_onClickStart()
	local maxScore = TripleMacthesModel.instance:getMaxScore()
	local isHasPassFirst = maxScore > 0

	if self._isBelongSweep and isHasPassFirst then
		local isInitInfo = YearCardModel.instance:isInitInfo()

		if not isInitInfo then
			FloatWordMgr.instance:show("正在读取年费特权信息，请稍后再试")

			return
		end

		local sweepResult = self:getTrySweepGameResultAndTips(false, self._activityId, 1)

		if sweepResult == GameEnum.ResultCode.Success then
			local descTxt

			local function sureCallBack(view)
				self:_sweepGame(self._activityId, view:getCurTimes())
			end

			local function cancelCallBack(view)
				self:_enterGame(self._activityId)
			end

			local otherCallBack
			local maxCoinNum = self._actCfg.dailyGameLimit

			local function updateCoinTxtCallBack(view)
				view:getTxtCoin().text = string.format("游戏次数：%s/%s", view:getCurCoinNum(), maxCoinNum)
			end

			local function updateDescTxtCallBack(view)
				local curTimes = view:getCurTimes()
				local score = maxScore * curTimes
				local str = ""
				local cfg = TripleMachesGameConfig.instance:getPrizeCfgByScore(self._activityId, maxScore) or {}

				if not string.nilorempty(cfg.prize) then
					local arr = string.split(cfg.prize, "#")
					local tem = {}

					for i, v in ipairs(arr) do
						local matType, matId, matNum = MaterialMgr.getMatParams(v)
						local progress = matNum * curTimes
						local matName = MaterialMgr.getMaterialsName(matType, matId)

						table.insert(tem, matName .. "x" .. progress)
					end

					str = table.concat(tem, "、")
					str = string.format("\n可获得：<color=#0068b7>%s</color>", str)
				end

				view:getTxtDesc().text = string.format("您已首通完毕，是否扫荡获得进度？\n当前可获得积分：<color=#0068b7>%s</color>%s", score, str)
			end

			local left = self:_getLeftTimes()

			TipsFacade.instance:openPopupCommonCostPopView(left, 1, "开始游戏", "扫荡", "直接开始", descTxt, sureCallBack, cancelCallBack, otherCallBack, updateCoinTxtCallBack, updateDescTxtCallBack)
		else
			self:_enterGame(self._activityId)
		end
	else
		self:_enterGame(self._activityId)
	end
end

function TripleMacthesStartView:_enterGame(activityId)
	if self:_getLeftTimes() <= 0 then
		FloatWordMgr.instance:show(lang("今日已无挑战次数"))

		return
	end

	UIStateManager.instance:push(ViewName.TripleMacthesGameView, activityId)
end

function TripleMacthesStartView:_sweepGame(activityId, times)
	local result = self:getTrySweepGameResultAndTips(true, activityId, times)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	TripleMachesGameController.instance:sendPM_TripleMatchesGameSweepReq(activityId, times)
end

function TripleMacthesStartView:getTrySweepGameResultAndTips(isNeedTips, activityId, times)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success then
		local isCanSweep = AnnuityPrivilegeController.instance:isCanSweep(activityId)

		if not isCanSweep then
			result = GameEnum.ResultCode.Error
		end
	end

	if result == GameEnum.ResultCode.Success then
		local leftTimes = self:_getLeftTimes()

		if leftTimes <= 0 or leftTimes < times then
			result = GameEnum.ResultCode.Error
			tips = "次数不足"
		end
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function TripleMacthesStartView:_getLeftTimes()
	return self._actCfg.dailyGameLimit - TripleMacthesModel.instance:getDailyGameTimes()
end

return TripleMacthesStartView
