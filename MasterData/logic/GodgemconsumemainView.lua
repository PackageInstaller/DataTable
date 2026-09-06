-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godgemconsume/view/GodgemconsumemainView.lua

module("logic.extensions.godgemconsume.view.GodgemconsumemainView", package.seeall)

local GodgemconsumemainView = class("GodgemconsumemainView", TableViewComponent)

function GodgemconsumemainView:ctor()
	GodgemconsumemainView.super.ctor(self)
end

function GodgemconsumemainView:unbindEvents()
	GodgemconsumemainView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnRecharge:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnConsume:RemoveClickListener()
	self._btnYinshi:RemoveClickListener()
	self._btnView:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnRankNew:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnGetReward)
end

function GodgemconsumemainView:bindEvents()
	GodgemconsumemainView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnRecharge:AddClickListener(self._onClickbtnRecharge, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnConsume:AddClickListener(self._onClickbtnConsume, self)
	self._btnYinshi:AddClickListener(self._onClickbtnYinshi, self)
	self._btnView:AddClickListener(self._onClickbtnView, self)
	self._btnRank:AddClickListener(self._onClickbtnRank, self)
	self._btnRankNew:AddClickListener(self._onClickbtnRankNew, self)
	GameUtil.addClickHandler(self._btnGetReward, self._onClickbtnGetReward, self)
end

function GodgemconsumemainView:buildUI()
	GodgemconsumemainView.super.buildUI(self)

	self._btnTip = self:getBtn("btnTip")
	self._btnRecharge = self:getBtn("btnRecharge")
	self._btnClose = self:getBtn("btnClose")
	self._btnConsume = self:getBtn("btnConsume")
	self._txtTip = goutil.findChildTextComponent(self.mainGO, "txtTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._btnGetReward = self:getBtn("btnGetReward")
	self._itemGroups = {}
	self._txtProgress = goutil.findChildTextComponent(self.mainGO, "txtProgress")
	self._txtLeftTime = goutil.findChildTextComponent(self.mainGO, "time/txtLeftTime")
	self._txtConsume = goutil.findChildTextComponent(self.mainGO, "txtConsume")
	self._txtConsumeTip = goutil.findChildTextComponent(self.mainGO, "txtConsumeTip")
	self._txtTip = goutil.findChildTextComponent(self.mainGO, "txtTip")
	self._slider = self:getSlider("slider")
	self._scrollRect = self:getGo("tableview"):GetComponent(ComponentType.ScrollRect)
	self._scrollRectTr = self:getGo("tableview"):GetComponent(goutil.Type_RectTransform)
	self._effectHandlers = {}
	self._officialRootGo = self:getGo("officialRoot")
	self._btnYinshi = self:getBtn("officialRoot/btnAddress")
	self._btnView = self:getBtn("officialRoot/btnView")
	self._txtBtnYinshi = goutil.findChildTextComponent(self.mainGO, "officialRoot/btnAddress/Text")
	self._txtGetProgress = goutil.findChildTextComponent(self.mainGO, "officialRoot/txtGetProgress")
	self._btnRank = self:getBtn("officialRoot/btnRank")
	self._redPointGo = self:getGo("officialRoot/btnAddress/redPoint")
	self._effectGo = self:getGo("effect")
	self._txtConsumeTip1 = goutil.findChildTextComponent(self.mainGO, "officialRoot/txtTip1")
	self._showcell = self:getGo("showcell")
	self._showcellTxtNum = goutil.findChildTextComponent(self._showcell, "txtNum")
	self._showcellItemcon = goutil.findChild(self._showcell, "itemcon")
	self._btnRankNew = self:getBtn("btnRankNew")
end

function GodgemconsumemainView:onExit()
	GodgemconsumemainView.super.onExit(self)
	GlobalDispatcher:removeListener(GodgemconsumeController.PM_GGACGetActivityInfoRes, self._updateView, self)
	GlobalDispatcher:removeListener(GodgemconsumeController.PM_GGACGainProgressPrizeRes, self._updateView, self)
	GlobalDispatcher:removeListener(GodgemconsumeController.PM_GGACChangeRecipientInfoRes, self._updateView, self)
	GlobalDispatcher:removeListener(GodgemconsumeController.PM_GGACOneKeyGainPrizeRes, self._updateView, self)
	removetimer(self._updateTimer, self)
	removetimer(self._autoGetInfoReq, self)
	UIEffectManager.instance:stopEffect(self._effectHandler)
	MaterialMgr.resetAll(self._showcellItemcon)
end

function GodgemconsumemainView:onEnter()
	GodgemconsumemainView.super.onEnter(self)

	self._showId = nil

	GlobalDispatcher:addListener(GodgemconsumeController.PM_GGACGetActivityInfoRes, self._updateView, self)
	GlobalDispatcher:addListener(GodgemconsumeController.PM_GGACGainProgressPrizeRes, self._updateView, self)
	GlobalDispatcher:addListener(GodgemconsumeController.PM_GGACChangeRecipientInfoRes, self._updateView, self)
	GlobalDispatcher:addListener(GodgemconsumeController.PM_GGACOneKeyGainPrizeRes, self._updateView, self)

	self._activityId = GodgemconsumeModel.instance:getCurrActivityId()
	self._activityType = GameEnum.ActivityType.Godgemconsume

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动已结束")
		self:close()

		return
	end

	local stime, etime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)

	self._actEndTime = etime

	GodGemAccConsumeAgent.instance:sendPM_GGACGetActivityInfoReq(self._activityId)

	self._actCfg = GodgemconsumeConfig.instance:getActCfg(self._activityId)
	self._curViewDatas = GodgemconsumeConfig.instance:getPrizeCfgs(self._activityId)

	self:_updateView()
	self:_setActLeftTime()
	self:_setConsomeTip()
	settimer(300, self._autoGetInfoReq, self, true)
	self:_playEffect()
end

function GodgemconsumemainView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("godgemconsumemainview")
end

function GodgemconsumemainView:_onClickbtnRecharge()
	local jumpTo = GodgemconsumeConfig.instance:getCommonValue("RECHARGE_JUMP")

	GotoMgr.gotoByString(jumpTo)
end

function GodgemconsumemainView:_onClickbtnClose()
	self:close()
end

function GodgemconsumemainView:_onClickbtnConsume()
	local jumpTo = GodgemconsumeConfig.instance:getCommonValue("CONSUME_JUMP")

	GotoMgr.gotoByString(jumpTo)
end

function GodgemconsumemainView:_onClickbtnGetReward()
	local prizeIds = GodgemconsumeModel.instance:canBeGainPrizeIds()

	if #prizeIds <= 0 then
		FloatWordMgr.instance:show("暂无可领取的奖励")

		return
	end

	GodGemAccConsumeAgent.instance:sendPM_GGACOneKeyGainPrizeReq(self._activityId, prizeIds)
end

function GodgemconsumemainView:_onClickbtnYinshi()
	local currConsume = GodgemconsumeModel.instance:getCurrConsumValue()

	if currConsume < self._actCfg.realityPrizeProgressReq then
		FloatWordMgr.instance:show("未达到领取条件")

		return
	end

	local info = GodgemconsumeModel.instance:getRecipientInfo()
	local getNum = GodgemconsumeModel.instance:getGainedRealityPrizeCount()

	if not info and getNum >= self._actCfg.realityPrizeLimit then
		FloatWordMgr.instance:show("来晚一步，银饰已领完哦")

		return
	end

	if not info then
		FloatWordMgr.instance:show("未获得银饰")

		return
	end

	if GodgemconsumeModel.instance:isNeedFillData() then
		UIStateManager.instance:push(ViewName.GodgemconsumegetyinshisuccessView)
	else
		UIStateManager.instance:push(ViewName.GodgemconsumerecordaddressView)
	end
end

function GodgemconsumemainView:_onClickbtnView()
	UIStateManager.instance:push(ViewName.GodgemconsumepictureView)
end

function GodgemconsumemainView:_onClickbtnRank()
	UIStateManager.instance:push(ViewName.GodgemconsumerankView)
end

function GodgemconsumemainView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function GodgemconsumemainView:_updateCell(view, cell, cfg)
	local goItem = goutil.findChild(cell.gameObject, "item")
	local goItemcon = goutil.findChild(cell.gameObject, "itemcon")
	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")
	local goReceive = goutil.findChild(cell.gameObject, "goReceive")
	local goEffect = goutil.findChild(cell.gameObject, "effect")
	local isGain = GodgemconsumeModel.instance:isGainPrize(cfg.prizeId)
	local isCanGain = GodgemconsumeModel.instance:checkCanGainPrize(cfg.prizeId)

	goutil.setActive(goReceive, isGain)
	goutil.setActive(goEffect, isCanGain)

	txtNum.text = cfg.progressReq

	local itemGroup = self._itemGroups[goItemcon]

	if not itemGroup then
		itemGroup = ItemGroup.New(goItemcon, goItem, nil, nil, true)
		self._itemGroups[goItemcon] = itemGroup
	end

	local mos = string.split(cfg.prize, "#")

	itemGroup:updateWithMoArray(mos, function(item, cfgStr)
		self:_updateRewardCell(item, cfgStr, cfg.prizeId)
	end)
	self:_refreshShowCell(self._tableview:GetCurrentIndex() + 1)
end

function GodgemconsumemainView:_clearTableview(cell)
	local goItemcon = goutil.findChild(cell.gameObject, "itemcon")
	local itemGroup = self._itemGroups[goItemcon]

	if itemGroup then
		itemGroup:dispose(function(item)
			local goodscon = goutil.findChild(item.mainGO, "goodscon")
			local goEffect = goutil.findChild(item.mainGO, "effect")

			MaterialMgr.resetAll(goodscon)

			if self._effectHandlers[goEffect] then
				UIEffectManager.instance:stopEffect(self._effectHandlers[goEffect])

				self._effectHandlers[goEffect] = nil
			end
		end)
	end
end

function GodgemconsumemainView:_refreshShowCell(dataId)
	if self._curViewDatas[dataId] then
		if self._showId ~= self._curViewDatas[dataId] then
			self._showId = self._curViewDatas[dataId]

			local data = self._curViewDatas[self._showId]

			if data then
				MaterialMgr.resetAll(self._showcellItemcon)
				MaterialMgr.setCellListByCfg(data.prize, self._showcellItemcon)

				self._showcellTxtNum.text = data.progressReq

				goutil.setActive(self._showcell, true)
			else
				goutil.setActive(self._showcell, false)
			end
		end
	end
end

function GodgemconsumemainView:_updateRewardCell(item, cfgStr, prizeId)
	local goodscon = goutil.findChild(item.mainGO, "goodscon")
	local goEffect = goutil.findChild(item.mainGO, "effect")
	local proxy = MaterialMgr.setCellByCfg(cfgStr, goodscon)
	local isGain = GodgemconsumeModel.instance:isGainPrize(prizeId)
	local isCanGain = GodgemconsumeModel.instance:checkCanGainPrize(prizeId)

	proxy.binder:setAutoTips(not isCanGain)

	local handler = self._effectHandlers[goEffect]

	if handler then
		UIEffectManager.instance:stopEffect(handler)

		handler = nil
	end

	if isCanGain then
		proxy.binder:setCallBack(function()
			GodGemAccConsumeAgent.instance:sendPM_GGACGainProgressPrizeReq(self._activityId, prizeId)
		end)

		local effName = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		handler = UIEffectManager.instance:playEffect(self, effName, goEffect, 0, 0, true, nil, nil, function()
			handler:setScrollRectClipping(self._scrollRect)
		end)

		handler:setParent(goEffect.transform)
		handler:setLocalPos(0, 0, 0)
		handler:setScale(1)

		handler.hideEffWhileNotOnTop = true
		self._effectHandlers[goEffect] = handler
	else
		proxy.binder:setCallBack(nil)
	end
end

function GodgemconsumemainView:_updateView()
	self:reloadData()
	self:_setCurrConsume()
	self:_setProgress()
	self:_setOfficialData()
	self:_checkRedDot()
end

function GodgemconsumemainView:_checkRedDot()
	local currConsume = GodgemconsumeModel.instance:getCurrConsumValue()

	goutil.setActive(self._redPointGo, GodgemconsumeModel.instance:isNeedFillData() and currConsume >= self._actCfg.realityPrizeProgressReq)
end

function GodgemconsumemainView:_setCurrConsume()
	local consumNum = GodgemconsumeModel.instance:getCurrConsumValue()

	self._txtConsume.text = string.format("当前消费\n<size=24><color=#7afb80>%s</color></size>", consumNum)
end

function GodgemconsumemainView:_setProgress()
	local consumNum = GodgemconsumeModel.instance:getCurrConsumValue()
	local cfgs = GodgemconsumeConfig.instance:getPrizeCfgs(self._activityId)
	local nextCfg

	for i, v in ipairs(cfgs) do
		if consumNum < v.progressReq then
			nextCfg = v

			break
		end
	end

	nextCfg = nextCfg or cfgs[#cfgs]

	if nextCfg.progressReq - consumNum > 0 then
		local needNum = nextCfg.progressReq - consumNum

		self._txtConsumeTip.text = string.format("距离下一档奖励还差：%s", needNum)
	else
		self._txtConsumeTip.text = ""
	end

	self._slider:SetValue(consumNum / nextCfg.progressReq)

	self._txtProgress.text = string.format("%s/%s", consumNum, nextCfg.progressReq)
end

function GodgemconsumemainView:_setActLeftTime()
	self._destTime = self._actEndTime

	if self._destTime > 0 then
		settimer(1, self._updateTimer, self, true)
		self:_updateTimer()
	else
		self:_actEndOp()
	end
end

function GodgemconsumemainView:_updateTimer()
	self._leftTime = self._destTime - ServerTime.nowServerLook()

	if self._leftTime > 0 then
		self._txtLeftTime.text = self._leftTime > 86400 and string.format("时间剩余：%s", GameUtil.FormatTimeWordsNoSec(self._leftTime)) or string.format("时间剩余：%s", GameUtil.FormatTimeWords(self._leftTime))
	else
		self:_actEndOp()
	end
end

function GodgemconsumemainView:_actEndOp()
	self._txtLeftTime.text = "活动已结束"

	removetimer(self._updateTimer, self)
end

function GodgemconsumemainView:_setOfficialData()
	local isOfficial = SDKManager.isOfficial() and self._actCfg.realityPrizeLimit > 0

	goutil.setActive(self._officialRootGo, isOfficial)

	if isOfficial then
		local getNum = GodgemconsumeModel.instance:getGainedRealityPrizeCount()

		self._txtGetProgress.text = string.format("全服已领 %s/%s", getNum, self._actCfg.realityPrizeLimit)

		self:_setBtnYinshiText()
	end
end

function GodgemconsumemainView:_setBtnYinshiText()
	local getNum = GodgemconsumeModel.instance:getGainedRealityPrizeCount()
	local info = GodgemconsumeModel.instance:getRecipientInfo()

	self._txtBtnYinshi.text = not info and "领取银饰" or GodgemconsumeModel.instance:isNeedFillData() and "领取银饰" or "修改收货地址"

	if not info and getNum >= self._actCfg.realityPrizeLimit then
		self._txtBtnYinshi.text = "银饰已领完"
	end
end

function GodgemconsumemainView:_autoGetInfoReq()
	local info = GodgemconsumeModel.instance:getRecipientInfo()

	if info then
		removetimer(self._autoGetInfoReq, self)

		return
	end

	GodGemAccConsumeAgent.instance:sendPM_GGACGetActivityInfoReq(self._activityId)
end

function GodgemconsumemainView:_playEffect()
	local effName = "20220401/choujiang/fx_ui_choujiangbg_shikonglong.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true, nil, nil, function(ref, eff)
		eff:setClipping(self.mainGO:GetComponent(goutil.Type_RectTransform))
	end)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

function GodgemconsumemainView:_setConsomeTip()
	local content = GodgemconsumeConfig.instance:getCommonValue("REALITYPRIZEPROGRESS_TIP")

	self._txtConsumeTip1.text = string.format(content, self._actCfg.realityPrizeProgressReq)
end

function GodgemconsumemainView:_onClickbtnRankNew()
	UIStateManager.instance:push(ViewName.ChargeCostRankView, 1, self._activityId)
end

return GodgemconsumemainView
