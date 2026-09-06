-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckydraw/view/LuckyDrawView.lua

module("logic.extensions.luckydraw.view.LuckyDrawView", package.seeall)

local LuckyDrawView = class("LuckyDrawView", ViewComponent)
local DRAW_TIME = 4
local DRAW_ROUND = 4
local MAX_LUCKY_VAL = 100

function LuckyDrawView:ctor()
	LuckyDrawView.super.ctor(self)
end

function LuckyDrawView:buildUI()
	LuckyDrawView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnAnim = Framework.ToggleAdapter.GetFrom(self.mainGO.gameObject, "btnAnim")
	self._btnStart = self:getBtn("btnStart")
	self._redPoint = self:getGo("btnStart/imgRed")
	self._cells = {}

	for i = 1, LuckyDrawModel.NUM_OUT_CELL do
		local cell = {}

		cell.go = goutil.findChild(self.mainGO, "cells/cell_" .. i)
		cell.select = goutil.findChild(cell.go, "select")
		cell.canvasGroup = goutil.findChild(cell.go, "select"):GetComponent("CanvasGroup")
		cell.icon = goutil.findChild(cell.go, "icon")
		cell.tag = goutil.findChild(cell.go, "tag")
		cell.get = goutil.findChild(cell.go, "get")
		cell.canvasGroup = goutil.findChild(cell.go, "select"):GetComponent("CanvasGroup")
		cell.bg = goutil.findChildComponent(cell.go, "bg", "UIImageSpriteChange")
		cell.btnInfo = goutil.findChild(cell.go, "btnInfo")

		table.insert(self._cells, cell)
	end

	self._goldBarCon = self:getGo("goldBarCon")
	self._txtTime = self:getTxt("txtTime")
	self._txtLuckyVal = goutil.findChildComponent(self.mainGO, "luckyValue/imgNum", typeof(UIImgNumeralText))
	self.iconCost = self:getGo("cost/coin")
	self._txtCost = self:getTxt("cost/txtCost")
	self.bigPrizeExist = false
	self._effect = self:getGo("effect")
	self._mask = self:getGo("mask")
end

function LuckyDrawView:bindEvents()
	LuckyDrawView.super.bindEvents(self)
	self._btnStart:AddClickListener(self._sendDraw, self)
	self._btnTip:AddClickListener(self._clickTip, self)
	self._btnClose:AddClickListener(self.close, self)
	GameUtil.asBtn(self._mask):AddClickListener(self._runningTip, self)
end

function LuckyDrawView:unbindEvents()
	LuckyDrawView.super.unbindEvents(self)
	self._btnStart:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	GameUtil.asBtn(self._mask):RemoveClickListener()
end

function LuckyDrawView:destroyUI()
	LuckyDrawView.super.destroyUI(self)
end

function LuckyDrawView:onEnter()
	LuckyDrawView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.LuckyDrawGetInfo, self._refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.LuckyDrawDrawRes, self._drawRes, self)
	GlobalDispatcher:addListener(GlobalNotify.LuckyDrawBuyDraw, self._buyRes, self)
	self:_setRunning(false)

	if LuckyDrawController.instance:refreshActivtyId() then
		if not LuckyDrawController.instance:sendGetInfo() then
			self:_refresh()
		end
	else
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("活动不在时间内"), GameUtil.handler(self.close, self))

		return
	end
end

function LuckyDrawView:onEnterFinished()
	LuckyDrawView.super.onEnterFinished(self)
end

function LuckyDrawView:onExit()
	LuckyDrawView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.LuckyDrawGetInfo, self._refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.LuckyDrawDrawRes, self._drawRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.LuckyDrawBuyDraw, self._buyRes, self)
	self._btnAnim:RemoveOnValueChanged()
	UIEffectManager.instance:stopEffect(self._centerEffect)
	MaterialMgr.resetAll(self.iconCost)
end

function LuckyDrawView:onExitFinished()
	LuckyDrawView.super.onExitFinished(self)
end

function LuckyDrawView:_refresh()
	if not LuckyDrawController.instance:refreshActivtyId() then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("活动不在时间内"), GameUtil.handler(self.close, self))

		return
	end

	local activityId = LuckyDrawModel.instance:getActId()
	local mainCfg = LuckyDrawConfig.instance:getActCfg(activityId)

	self._costItem = mainCfg.cost
	self._diamendCost = mainCfg.goodsId

	local strItem = string.split(self._costItem, ":")
	local list = {
		{
			showAdd = true,
			id = GameEnum.GoldType.Diamond
		},
		{
			showTip = true,
			showAdd = true,
			id = strItem[1] .. ":" .. strItem[2],
			showAddCallBack = function()
				self:_buyLuckyRes()
			end
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	MaterialMgr.setIcon(self.iconCost, checknumber(strItem[1]), checknumber(strItem[2]))

	self._txtCost.text = checknumber(strItem[3])

	self._btnAnim:RemoveOnValueChanged()
	self._btnAnim:AddOnValueChanged(function(go, isOn)
		LuckyDrawModel.instance:setCloseAnim(isOn)

		self._closeAnim = isOn
	end)

	self._closeAnim = LuckyDrawModel.instance:getCloseAnim()
	self._btnAnim.isOn = LuckyDrawModel.instance:getCloseAnim()

	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.LuckyDraw)
	local objStart, objEnd = GameUtil.string2date(cfg.startTime), GameUtil.string2date(cfg.endTime)
	local startDay, startMonth = objStart.day, objStart.month
	local endDay, endMonth = objEnd.day, objEnd.month

	self._txtTime.text = langPara("活动时间：%s.%s-%s.%s", startMonth, startDay, endMonth, endDay)

	local luckyScore = LuckyDrawModel.instance:getCurLuckyScore()

	if luckyScore > MAX_LUCKY_VAL then
		luckyScore = MAX_LUCKY_VAL
	end

	self._txtLuckyVal:SetText(luckyScore)
	self:_setCell()

	local needNum = checknumber(strItem[3])

	goutil.setActive(self._redPoint, needNum <= MaterialMgr.getMatCount(self._costItem) and self.bigPrizeExist)
end

function LuckyDrawView:_setCell()
	local activityId = LuckyDrawModel.instance:getActId()
	local mainCfg = LuckyDrawConfig.instance:getActCfg(activityId)
	local prizeCfg = LuckyDrawConfig.instance:getPrizeCfg(activityId)

	self.bigPrizeExist = false

	for i = 1, LuckyDrawModel.NUM_OUT_CELL do
		local obj = self._cells[i]
		local data = prizeCfg[i]

		if data.prizeType == 1 then
			local arr = string.split(data.prize, ":")
			local raceId = checknumber(arr[2])
			local btn_Info = Framework.ButtonAdapter.Get(obj.btnInfo)

			btn_Info:AddClickListener(function()
				PetbookController.instance:openPetinfoView(raceId)
			end, self)

			local hasGet = LuckyDrawModel.instance:getPrizeDrawNum(i) >= data.limit

			goutil.setActive(obj.get, hasGet)

			if not hasGet then
				self.bigPrizeExist = true
			end
		else
			local proxy = MaterialMgr.setCellByCfg(data.prize, obj.icon)

			if proxy then
				proxy.binder:setBgActive(false)
				proxy.binder:setEffStatus(false)
				proxy.binder:setNumBg(false)
			end

			goutil.setActive(obj.tag, data.prizeType == 2)
			obj.bg:SetState(checknumber(data.colourPic))
		end
	end

	GameUtil.SetGray(self._btnStart, not self.bigPrizeExist)
end

function LuckyDrawView:_clearCell()
	for i = 1, LuckyDrawModel.NUM_OUT_CELL do
		local obj = self._cells[i]
		local data = prizeCfg[i]

		if data.prizeType == 1 then
			local btn_Info = Framework.ButtonAdapter.Get(obj.btnInfo)

			btn_Info:RemoveClickListener()
		else
			MaterialMgr.resetAll(obj.icon)
		end
	end
end

function LuckyDrawView:_sendDraw()
	if not LuckyDrawController.instance:refreshActivtyId() then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("活动不在时间内"), GameUtil.handler(self.close, self))

		return
	end

	if not self.bigPrizeExist then
		FloatWordMgr.instance:show("抽奖轮数达到上限！")

		return
	end

	local arr1 = string.split(self._costItem, ":")
	local costNum = checknumber(arr1[3])
	local have = MaterialMgr.getMatCount(self._costItem)
	local needNum = costNum - have

	if needNum <= 0 then
		LuckyDrawController.instance:sendDraw()
	else
		self:_buyLuckyRes()
	end
end

function LuckyDrawView:_buyLuckyRes()
	local arr1 = string.split(self._costItem, ":")
	local costNum = checknumber(arr1[3])
	local have = MaterialMgr.getMatCount(self._costItem)
	local needNum = costNum - have

	if needNum <= 0 then
		FloatWordMgr.instance:show("请使用剩余积分")

		return
	end

	local priceList = string.split(self._diamendCost, ":")
	local priceType = checknumber(priceList[1])
	local priceId = checknumber(priceList[2])
	local priceCount = checknumber(priceList[3])

	if priceType == MatType.Diamond_Consume then
		priceCount = GoodsConfig.instance:getCfgPrice(priceId) * priceCount

		local sumPrice = needNum * priceCount
		local str = langPara("确定要花费%s钻石，购买%s幸运积分吗？", sumPrice, needNum)

		TipsFacade.instance:openPopupCostDiamondView(sumPrice, str, function()
			LuckyDrawController.instance:buyDraw(needNum)
		end)
	end
end

function LuckyDrawView:_drawRes(res)
	self._curIndex = 1

	local terminal = res

	printInfo("------------------%s", terminal)

	if self._closeAnim then
		self:showCIPrize()
	else
		self:_startDraw(terminal, DRAW_TIME, DRAW_ROUND, DG.Tweening.Ease.OutCubic, function()
			settimer(0.7, self.showCIPrize, self, false)
		end)
	end
end

function LuckyDrawView:_startDraw(terminal, duration, round, TweenEase, finishCallback)
	if self._outTween then
		self._outTween:Kill(false)

		self._outTween = nil
	end

	self:_setRunning(true)
	settimer(0.005, self._fadeOut, self, true)

	local stepLength = round * LuckyDrawModel.NUM_OUT_CELL + self:_outDIff(self._curIndex, terminal)

	self._outTween = TweenUtil.ValueTo(0, stepLength, duration, function(val)
		local centerIndex = math.round(val + self._curIndex) % LuckyDrawModel.NUM_OUT_CELL

		if centerIndex == 0 then
			centerIndex = LuckyDrawModel.NUM_OUT_CELL
		end

		for i = 1, LuckyDrawModel.NUM_OUT_CELL do
			if i == centerIndex then
				self:_playSelect(i)
			end
		end
	end, function()
		self._curIndex = terminal
		self._outTween = nil

		GameUtil.callBack(finishCallback)
	end, self, TweenEase)
end

function LuckyDrawView:_playSelect(index)
	self._cells[index].canvasGroup.alpha = 1
end

function LuckyDrawView:_fadeOut()
	for i = 1, LuckyDrawModel.NUM_OUT_CELL do
		local canvasG = self._cells[i].canvasGroup
		local alpha = canvasG.alpha

		if alpha > 0 then
			canvasG.alpha = alpha - 0.1
		end
	end
end

function LuckyDrawView:_outDIff(a, b)
	local diff = b - a

	if diff < 0 then
		diff = diff + LuckyDrawModel.NUM_OUT_CELL
	end

	return diff
end

function LuckyDrawView:showCIPrize()
	LuckyDrawController.instance:showMonopolyCI()
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialPopEnd, self._showLuckyValueTip, self)
	self:_setRunning(false)
	removetimer(self._fadeOut, self)
	removetimer(self.showCIPrize, self)
end

function LuckyDrawView:_showLuckyValueTip()
	local addValue = LuckyDrawModel.instance:getAddLuckyScore()

	if addValue < 0 then
		FloatWordMgr.instance:show("恭喜你！本次抽中了大奖，幸运值将重置哦！")
	else
		local luckyScore = LuckyDrawModel.instance:getCurLuckyScore()

		if luckyScore >= MAX_LUCKY_VAL then
			self:_showEffect()
		else
			FloatWordMgr.instance:show(langPara("恭喜你！本次抽奖幸运值增加了%s点！", addValue))
		end
	end

	self:_refresh()
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialPopEnd, self._showLuckyValueTip, self)
end

function LuckyDrawView:_buyRes()
	self:_sendDraw()
end

function LuckyDrawView:_clickTip()
	UIStateManager.instance:push(ViewName.RulesView, "luckydrawviewRule")
end

function LuckyDrawView:_showEffect()
	if self._centerEffect then
		UIEffectManager.instance:stopEffect(self._centerEffect)
	end

	local path = "fx_ui_xingyunjifen/fx_ui_xingyunzhiman.prefab"

	self._centerEffect = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, false, nil, nil, function(finishHandlerTarget, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
	end)

	self._centerEffect:setParent(self._effect.transform)
	self._centerEffect:setScale(1)

	self._centerEffect.hideEffWhileNotOnTop = true
end

function LuckyDrawView:_runningTip()
	if self._isRunning then
		FloatWordMgr.instance:show("请稍等")
	end
end

function LuckyDrawView:_setRunning(torf)
	self._isRunning = torf

	goutil.setActive(self._mask, torf)
end

return LuckyDrawView
