-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/partysummary/view/PartyFoodView.lua

module("logic.extensions.partysummary.view.PartyFoodView", package.seeall)

local PartyFoodView = class("PartyFoodView", TableViewComponent)

function PartyFoodView:ctor()
	PartyFoodView.super.ctor(self)

	self._choiActId = nil
	self._supTime = nil
	self._tipsStr = nil
	self._isOpenPre = nil
end

function PartyFoodView:onExit()
	PartyFoodView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.Party_UpdataPartyFoodInfo, self._updataPartyFoodInfo, self)
	removetimer(self._calculationSurplusTime, self)

	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)
	end

	self.pmEff = nil
	self._choiActId = nil
	self._supTime = nil
	self._tipsStr = nil
	self._isOpenPre = nil
end

function PartyFoodView:destroyUI()
	PartyFoodView.super.destroyUI(self)
end

function PartyFoodView:bindEvents()
	PartyFoodView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "partyfood")
	end, self)
	self._prizeBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.PartyFoodPrize, self._choiActId)
	end, self)
	self._gotoBtn:AddClickListener(self._onClickGotoBtn, self)
end

function PartyFoodView:unbindEvents()
	PartyFoodView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._prizeBtn:RemoveClickListener()
	self._gotoBtn:RemoveClickListener()
end

function PartyFoodView:buildUI()
	PartyFoodView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._timeTxt = self:getTxt("timeGo/timeTxt")
	self._prizeBtn = self:getBtn("prizeBtn")
	self._gotoBtn = self:getBtn("gotoBtn")
	self._tipsTxt = self:getTxt("tipsImaGo/tipsTxt")
	self._timeTxt.text = ""
	self._tipsTxt.text = ""
end

function PartyFoodView:onEnter()
	PartyFoodView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.Party_UpdataPartyFoodInfo, self._updataPartyFoodInfo, self)

	self._choiActId = checknumber(self:getFirstParam())

	if self._choiActId <= 0 then
		self._choiActId = PartySummaryConfig.instance:getPartyFoodActivityId()
	end

	if self._choiActId <= 0 then
		printError("sr--- 爬梯美食      PartyFoodView:onEnter()       时间未到怎么打开了？")
		self:close()

		return
	end

	local actCfg = PartySummaryConfig.instance:getFoodActivityCfg(self._choiActId)

	if actCfg == nil or string.nilorempty(actCfg.timeDesc) then
		self._timeTxt.text = ""

		printError("sr--- 爬梯美食      PartyFoodView:onEnter()       策划未配置 = " .. self._choiActId)
	else
		self._timeTxt.text = actCfg.timeDesc
	end

	self._supTime = 0
	self._tipsStr = ""

	self:_updataFoodPrizeItemShow()
	self:_startActivityTimer()

	local effPath = "20220930/paiduishengyan_jm/fx_ui_paiduishengyan_jm.prefab"

	self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self.pmEff:setParent(self.mainGO.transform)
	self.pmEff:setLocalPos(0, 0, 0)
	self.pmEff:setScale(1)
	PartySummaryController.instance:csGetPotluckDinnerInfoReq()
end

function PartyFoodView:_updataFoodPrizeItemShow()
	self._isOpenPre = false

	local cfg, count = PartySummaryModel.instance:getOpenPartyFoodTermCfg(self._choiActId)

	self._curViewDatas = {}

	if cfg == nil or count == 0 then
		self._supTime = 0
		self._tipsTxt.text = "本轮活动已结束"

		self._tableview:ReloadData()
	else
		local sts = string.split(cfg.startTime, "T")
		local ets = string.split(cfg.endTime, "T")
		local endTime = GameUtil.string2time(cfg.endTime)
		local startTime = GameUtil.string2time(cfg.startTime)
		local value = endTime - startTime
		local str = value >= 3600 and math.ceil(value / 3600) .. "小时" or math.ceil(value / 60) .. "分钟"
		local nowTime = ServerTime.now()

		if cfg.preTime > 0 and nowTime < startTime then
			self._isOpenPre = true
			self._tipsStr = string.format("本轮派对%s--%s开启，每%s一轮\n本轮欲开", sts[2], ets[2], str)
			self._tipsStr = self._tipsStr .. "%s"
			self._supTime = startTime + 1 - nowTime
		else
			self._tipsStr = string.format("本轮派对%s--%s开启，每%s一轮\n本轮", sts[2], ets[2], str)
			self._tipsStr = self._tipsStr .. "%s，后续还有" .. count .. "轮"
			self._supTime = endTime + 1 - nowTime
		end

		self._curTermCfg = cfg

		self:_updataPartyFoodInfo()
	end

	if self._supTime <= 0 then
		self._tipsTxt.text = "本轮活动已结束"

		removetimer(self._calculationSurplusTime, self)
	end
end

function PartyFoodView:_updataPartyFoodInfo()
	local partyFoodInfo = PartySummaryModel.instance:getPartyFoodInfo(actId)

	if partyFoodInfo then
		self._typeInfo = partyFoodInfo.typeInfo or {}
	end

	self._curViewDatas = PartySummaryModel.instance:getPartyFoodListCfgs(self._choiActId, true)

	self._tableview:ReloadData()
end

function PartyFoodView:_startActivityTimer()
	removetimer(self._calculationSurplusTime, self)
	self:_showActivityTimer()

	if self._supTime > 0 then
		settimer(1, self._calculationSurplusTime, self, true)
	end
end

function PartyFoodView:_calculationSurplusTime()
	self._supTime = self._supTime - 1

	self:_showActivityTimer()
end

function PartyFoodView:_showActivityTimer()
	if self._supTime < 0 or string.nilorempty(self._tipsStr) then
		self:_updataFoodPrizeItemShow()

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(self._supTime)

	self._tipsTxt.text = day > 0 and string.format(self._tipsStr, langPara("text_suo_timer_1", day, hour, min)) or string.format(self._tipsStr, langPara("text_suo_timer_2", hour, min, sec))
end

function PartyFoodView:_onClickGotoBtn()
	if self._curTermCfg == nil or self._curTermCfg.sceneId < 1 or checknumber(self._supTime) <= 0 then
		FloatWordMgr.instance:show("本轮活动已结束")

		return
	end

	if self._isOpenPre then
		local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(self._supTime)
		local str = langPara("text_countdown_notips_second", hour, min, sec)

		FloatWordMgr.instance:show(str .. "后开启")

		return
	end

	TipsFacade.instance:openTipWindow("提示", "圣主派对正在火热开启，快在本场景中寻找美食，领取奖励吧！", function()
		UIStateManager.instance:clear(true)
		SceneFacade.instance:enterCityFromThisScene(self._curTermCfg.sceneId)
	end, "知道了", UnityEngine.TextAnchor.MiddleCenter)
end

function PartyFoodView:_getPath()
	return {
		cellPath = "prizeItem",
		viewPath = "prizeItemSR"
	}
end

function PartyFoodView:_cellSize()
	return 706, 140
end

function PartyFoodView:_updateCell(view, cell, data)
	local iconImaIsc = goutil.findChild(cell, "iconIma"):GetComponent("UIImageSpriteChange")
	local iconGo = goutil.findChild(cell, "iconGo")
	local goodsGo = goutil.findChild(cell, "goodsGo")
	local descTxt = goutil.findChildTextComponent(cell, "descTxt")
	local viewContent = goutil.findChild(cell, "goodsSR/Viewport/Content").transform
	local viewLayout = goutil.findChild(cell, "goodsSR/Viewport/Content/items"):GetComponent(ComponentType.UILayoutSingleLine)

	MaterialMgr.resetAll(iconGo)
	GameUtil.SetActive(goodsGo, false)
	iconImaIsc:SetState(cell.data == 1 and 0 or 1)

	local info = self._typeInfo[data.foodType]
	local ownSup = info and math.max(data.dailyTimes - checknumber(info.ownCount), 0) or data.dailyTimes

	if data.allAreaLimit > 0 then
		local areaSup = info and math.max(data.allAreaLimit - checknumber(info.areaCount), 0) or data.allAreaLimit

		descTxt.text = string.format("<color=#D4EBFDFF>本轮全服剩余</color>\n<color=#20B376>%s个</color>\n<color=#FAF2E9FF>今日还可领取</color>\n<color=#20B376>%s个</color>", areaSup, ownSup)
	else
		descTxt.text = string.format("<color=#FAF2E9FF>今日还可领取</color>\n<color=#20B376>%s个</color>", ownSup)
	end

	uGuiUtil.setSpriteToImage(iconGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(data.icon))

	local goodsCfgs = {}

	if self._curTermCfg and self._curTermCfg.foodPrizePlanId > 0 then
		goodsCfgs = PartySummaryModel.instance:getPartyFoodItemPrizes(self._curTermCfg.foodPrizePlanId, data.foodType)
	end

	local childCount = viewLayout.transform.childCount

	if goodsCfgs then
		if not #goodsCfgs then
			local goodsCount = 0

			while childCount < goodsCount do
				local go = UGUIToolHelper.AddChild(viewLayout.gameObject, goodsGo)

				childCount = childCount + 1
			end

			for i = 1, goodsCount do
				local go = viewLayout.transform:GetChild(i - 1).gameObject

				GameUtil.SetActive(go, true)

				local posGo = goutil.findChild(go, "posGo")

				MaterialMgr.resetAll(posGo)

				local proxy = MaterialMgr.setCellByCfg(goodsCfgs[i].prize, posGo)

				if proxy then
					proxy.binder:setEffStatus(false)
				end

				local proTxt = goutil.findChildTextComponent(go, "proTxt")

				proTxt.text = PartySummaryModel.instance:getPartyFoodProbability(goodsCfgs[i])
			end

			for i = goodsCount + 1, childCount do
				GameUtil.SetActive(viewLayout.transform:GetChild(i - 1), false)
			end

			viewLayout:Layout()

			local sizeDelta = viewContent.sizeDelta

			sizeDelta.x = goodsCount * 90
			viewContent.sizeDelta = sizeDelta
		end
	end
end

return PartyFoodView
