-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualactivity/view/GratefulPuzzleView.lua

module("logic.extensions.annualactivity.view.GratefulPuzzleView", package.seeall)

local GratefulPuzzleView = class("GratefulPuzzleView", ViewComponent)

function GratefulPuzzleView:ctor()
	GratefulPuzzleView.super.ctor(self)

	self._prizeItemsList = nil
	self._puzzleItemsList = nil
	self._viewInfo = nil
	self._prizeCfgList = nil
end

function GratefulPuzzleView:bindEvents()
	GratefulPuzzleView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "gratefulpuzzle")
	end, self)
	self._dailyBtn:AddClickListener(self._onTaskClick, self)
	self._skillBtn:AddClickListener(function()
		PetbookController.instance:previewBattle(10097, 1009703)
	end, self)

	if self._prizeItemsList and #self._prizeItemsList > 0 then
		for i = 1, #self._prizeItemsList do
			GameUtil.asBtn(self._prizeItemsList[i].clickGo):AddClickListener(function()
				self:_onClickPrizeBtn(i)
			end, self)
		end
	end

	if self._puzzleItemsList and #self._puzzleItemsList > 0 then
		for i = 1, #self._puzzleItemsList do
			GameUtil.asBtn(self._puzzleItemsList[i]):AddClickListener(function()
				self:_onClickPuzzleBtn(i)
			end, self)
		end
	end

	self._receiveBtn:AddClickListener(self._onClickFinalBtn, self)
	self._shopBtn:AddClickListener(self._onClickShopBtn, self)
end

function GratefulPuzzleView:unbindEvents()
	GratefulPuzzleView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._dailyBtn:RemoveClickListener()
	self._skillBtn:RemoveClickListener()

	for _, go in pairs(self._puzzleItemsList or {}) do
		if go then
			GameUtil.asBtn(go):RemoveClickListener()
		end
	end

	for _, go in pairs(self._prizeItemsList or {}) do
		if go and go.clickGo then
			GameUtil.asBtn(go.clickGo):RemoveClickListener()
		end
	end

	self._receiveBtn:RemoveClickListener()
	self._shopBtn:RemoveClickListener()
end

function GratefulPuzzleView:onExit()
	GratefulPuzzleView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.Grateful_UpdataGratefulPuzzleInfo, self._updataViewPuzzleShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.Grateful_UpdataGratefulPuzzleLight, self._setPuzzleItemShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.Grateful_UpdataGratefulPuzzlePrize, self._setRewardPrizeShow, self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self._pmEff = nil

	RedPointController.instance:unregRedPoint(self._redPoint)
end

function GratefulPuzzleView:destroyUI()
	GratefulPuzzleView.super.destroyUI(self)

	self._prizeItemsList = nil
	self._puzzleItemsList = nil
	self._viewInfo = nil
	self._prizeCfgList = nil
end

function GratefulPuzzleView:buildUI()
	GratefulPuzzleView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._dailyBtn = self:getBtn("dailyBtn")
	self._timeTxt = self:getTxt("timeGo/timeTxt")
	self._countTxt = self:getTxt("countGo/countTxt")
	self._descTxt = self:getTxt("descGo/descTxt")
	self._bubbleTxt = self:getTxt("bubbleGo/bubbleTxt")
	self._skillBtn = self:getBtn("petInfoGo/skillBtn")
	self._redPoint = self:getGo("dailyBtn/redPoint")

	local rewardGo = self:getGo("rewardGo")

	self._goodsTxt = goutil.findChildTextComponent(rewardGo, "goodsTxt")
	self._receiveBtn = Framework.ButtonAdapter.GetFrom(rewardGo, "receiveBtn")
	self._receiveTxt = goutil.findChildTextComponent(rewardGo, "receiveBtn/receiveTxt")
	self._buyInfoGo = goutil.findChild(rewardGo, "buyInfoGo")
	self._shopBtn = Framework.ButtonAdapter.GetFrom(self._buyInfoGo, "shopBtn")
	self._puzzleTran = self:getGo("puzzleTran").transform
	self._puzzleItemsList = {}

	for i = 1, self._puzzleTran.childCount do
		local go = self._puzzleTran:GetChild(i - 1).gameObject
		local strs = string.split(go.name, "_")

		self._puzzleItemsList[tonumber(strs[2])] = go
	end

	local rewardTran = self:getGo("rewardTran").transform

	self._prizeItemsList = {}

	for i = 1, rewardTran.childCount do
		local go = rewardTran:GetChild(i - 1).gameObject
		local strs = string.split(go.name, "_")

		self._prizeItemsList[tonumber(strs[2])] = {
			itemGo = go,
			nodeGo = goutil.findChild(go, "nodeGo"),
			effGo = goutil.findChild(go, "effGo"),
			getedGo = goutil.findChild(go, "getedGo"),
			clickGo = goutil.findChild(go, "clickGo")
		}
	end

	self._timeTxt.text = ""
	self._countTxt.text = ""
	self._descTxt.text = ""
	self._bubbleTxt.text = ""
end

function GratefulPuzzleView:onEnter()
	GratefulPuzzleView.super.onEnter(self)

	local actId = AnnualActivityConfig.instance:getGratefulOpenActivityId()

	if actId <= 0 then
		printError("sr---感恩拼图    GratefulPuzzleView:onEnter()    活动未开启！")

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.Grateful_UpdataGratefulPuzzleInfo, self._updataViewPuzzleShow, self)
	GlobalDispatcher:addListener(GlobalNotify.Grateful_UpdataGratefulPuzzleLight, self._setPuzzleItemShow, self)
	GlobalDispatcher:addListener(GlobalNotify.Grateful_UpdataGratefulPuzzlePrize, self._setRewardPrizeShow, self)
	self.addGEvent(self, GlobalNotify.OnMaterialCountChange, self._setPuzzleItemShow, self)

	self._actCfg = AnnualActivityConfig.instance:getGratefulActivityCfg(actId)

	self:_startShowView()

	local taskActivityId = checknumber(self._actCfg.taskActivityId)

	if taskActivityId > 0 then
		local cfg = EventTaskSummaryConfig.instance:getPlanCfg(taskActivityId)

		if cfg and checknumber(cfg.redPointId) ~= 0 then
			RedPointController.instance:regRedPoint(self._redPoint, cfg.redPointId)
		end
	end
end

function GratefulPuzzleView:_onTaskClick()
	local taskActivityId = checknumber(self._actCfg.taskActivityId)

	if taskActivityId > 0 then
		local cfg = EventTaskSummaryConfig.instance:getPlanCfg(taskActivityId)

		if cfg then
			UIStateManager.instance:push(ViewName.CommonGroupTaskMainView, taskActivityId)
		end
	end
end

function GratefulPuzzleView:_startShowView()
	self._viewInfo = {
		isFinalPrizeGain = false,
		lightTime = 0,
		activityId = self._actCfg.activityId,
		activePuzzleIds = {},
		hasGainGroupPrizeIds = {}
	}
	self._timeTxt.text = self._actCfg.timeDesc
	self._descTxt.text = langPara("text_grateful_desc_1", table.concat(self._actCfg.dailyActive or {}, "/"))
	self._bubbleTxt.text = self._actCfg.bubbleDesc

	local date = GameUtil.string2date(self._actCfg.finalPrizeTime)

	self._goodsTxt.text = string.format("完成所有拼图并在<color=#%s>%d月%d日 5:00后登陆</color>即可领取<color=#%s>皮肤</color>", ColorConst.Red, date.month, date.day, ColorConst.Red)
	self._countTxt.text = langPara("当前可使用画笔：%s", checknumber(self:getAllCount()))

	uGuiUtil.setSpriteToImage(self._puzzleTran.gameObject, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/picturepuzzle/%s.png", self._actCfg.icon))

	for _, go in pairs(self._puzzleItemsList or {}) do
		if go then
			GameUtil.SetActive(go, true)
		end
	end

	self._prizeCfgList = AnnualActivityConfig.instance:getGratefulPrizeCfgs(self._actCfg.prizePlanId)

	for i = 1, #self._prizeItemsList do
		if self._prizeCfgList and self._prizeCfgList[i] then
			GameUtil.SetActive(self._prizeItemsList[i].itemGo, true)
			MaterialMgr.setCellByCfg(self._prizeCfgList[i].prize, self._prizeItemsList[i].nodeGo)
			GameUtil.SetActive(self._prizeItemsList[i].getedGo, false)
			GameUtil.SetActive(self._prizeItemsList[i].clickGo, true)
		else
			GameUtil.SetActive(self._prizeItemsList[i].itemGo, false)
		end
	end

	self._receiveTxt.text = "点击领取"

	uGuiUtil.setTextGrayState(self._receiveTxt.gameObject, true)
	uGuiUtil.setImageGrayState(self._receiveBtn.gameObject, true)

	local effPath = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
	PuzzleLightAgent.instance:sendPM_GetPuzzleInfoReq(self._actCfg.activityId)
end

function GratefulPuzzleView:_updataViewPuzzleShow(data)
	if data == nil then
		return
	end

	self._viewInfo.activityId = data.activityId
	self._viewInfo.lightTime = data.lightTime
	self._viewInfo.isFinalPrizeGain = data.isFinalPrizeGain
	self._viewInfo.activePuzzleIds = {}
	self._viewInfo.hasGainGroupPrizeIds = {}

	for _, id in pairs(data.activePuzzleIds or {}) do
		if checknumber(id) > 0 then
			table.insert(self._viewInfo.activePuzzleIds, checknumber(id))
		end
	end

	for _, id in pairs(data.hasGainGroupPrizeIds or {}) do
		if checknumber(id) > 0 then
			table.insert(self._viewInfo.hasGainGroupPrizeIds, checknumber(id))
		end
	end

	self:_checkAllPrizeItems()
end

function GratefulPuzzleView:getAllCount()
	local matCount = 0
	local lightTime = 0

	if not string.nilorempty(self._actCfg.cost) then
		matCount = MaterialMgr.getMatCount(self._actCfg.cost)
	elseif self._viewInfo then
		lightTime = checknumber(self._viewInfo.lightTime)
	end

	return lightTime + matCount
end

function GratefulPuzzleView:_checkAllPrizeItems()
	self._countTxt.text = langPara("当前可使用画笔：%s", self:getAllCount())

	if self._viewInfo.isFinalPrizeGain then
		self:_receiveRewardPrizeShow()
	else
		self:_setRewardPrizeSate()
	end

	if self._puzzleItemsList and #self._puzzleItemsList > 0 then
		for i = 1, #self._puzzleItemsList do
			if self._viewInfo.activePuzzleIds and table.indexof(self._viewInfo.activePuzzleIds, i) then
				GameUtil.SetActive(self._puzzleItemsList[i], false)
			else
				GameUtil.SetActive(self._puzzleItemsList[i], true)
			end
		end
	end

	if self._prizeItemsList and #self._prizeItemsList > 0 then
		for i = 1, #self._prizeItemsList do
			if self._viewInfo.hasGainGroupPrizeIds and table.indexof(self._viewInfo.hasGainGroupPrizeIds, i) then
				self:_receiveRewardPrizeShow(i)
			else
				self:_setRewardPrizeSate(i)
			end
		end
	end
end

function GratefulPuzzleView:_setRewardPrizeShow(prizeId)
	prizeId = checknumber(prizeId)

	if prizeId <= 0 then
		self._viewInfo.isFinalPrizeGain = true
	else
		self._viewInfo.hasGainGroupPrizeIds = self._viewInfo.hasGainGroupPrizeIds or {}

		if not table.indexof(self._viewInfo.hasGainGroupPrizeIds, prizeId) then
			table.insert(self._viewInfo.hasGainGroupPrizeIds, prizeId)
		end
	end

	self:_receiveRewardPrizeShow(prizeId)
end

function GratefulPuzzleView:_receiveRewardPrizeShow(prizeId)
	prizeId = checknumber(prizeId)

	if prizeId <= 0 then
		self._receiveTxt.text = "已领取"

		uGuiUtil.setTextGrayState(self._receiveTxt.gameObject, true)
		uGuiUtil.setImageGrayState(self._receiveBtn.gameObject, true)
	elseif self._prizeItemsList and self._prizeItemsList[prizeId] then
		GameUtil.SetActive(self._prizeItemsList[prizeId].getedGo, true)
		GameUtil.SetActive(self._prizeItemsList[prizeId].clickGo, false)

		if self._prizeItemsList[prizeId].itemEff then
			UIEffectManager.instance:stopEffect(self._prizeItemsList[prizeId].itemEff)

			self._prizeItemsList[prizeId].itemEff = nil
		end
	end
end

function GratefulPuzzleView:_setRewardPrizeSate(prizeId)
	prizeId = checknumber(prizeId)

	local isCan = self:_isPrizeCanReceive(prizeId)

	if prizeId <= 0 then
		self._receiveTxt.text = "点击领取"

		uGuiUtil.setTextGrayState(self._receiveTxt.gameObject, not isCan)
		uGuiUtil.setImageGrayState(self._receiveBtn.gameObject, not isCan)
	else
		if self._prizeItemsList[prizeId].itemEff then
			UIEffectManager.instance:stopEffect(self._prizeItemsList[prizeId].itemEff)

			self._prizeItemsList[prizeId].itemEff = nil
		end

		GameUtil.SetActive(self._prizeItemsList[prizeId].getedGo, false)

		if isCan then
			local function loadedHandler(handlerTarget, eff)
				eff:setClipping(self._prizeItemsList[prizeId].effGo:GetComponent(goutil.Type_RectTransform))
				eff:setParent(self._prizeItemsList[prizeId].effGo.transform)
				eff:setLocalPos(0, 0, 0)
				eff:setScale(1, 1, 1)

				eff.hideEffWhileNotOnTop = true
			end

			self._prizeItemsList[prizeId].itemEff = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", self._prizeItemsList[prizeId].effGo, 0, 0, true, false, nil, loadedHandler, nil)

			GameUtil.SetActive(self._prizeItemsList[prizeId].clickGo, true)
		else
			GameUtil.SetActive(self._prizeItemsList[prizeId].clickGo, false)
		end
	end
end

function GratefulPuzzleView:_isPrizeCanReceive(prizeId, isTips)
	if self._viewInfo == nil then
		if isTips then
			FloatWordMgr.instance:show("不可领取")
		end

		return false
	end

	prizeId = checknumber(prizeId)

	if prizeId <= 0 then
		if self._viewInfo.isFinalPrizeGain then
			if isTips then
				FloatWordMgr.instance:show("奖励已领取")
			end

			return false
		end

		for i = 1, #self._puzzleItemsList do
			if #self._viewInfo.activePuzzleIds == 0 or not table.indexof(self._viewInfo.activePuzzleIds, i) then
				if isTips then
					FloatWordMgr.instance:show(self._goodsTxt.text)
				end

				return false
			end
		end
	else
		if self._prizeCfgList == nil or self._prizeCfgList[prizeId] == nil then
			if isTips then
				FloatWordMgr.instance:show("不可领取")
			end

			return false
		end

		if #self._viewInfo.hasGainGroupPrizeIds > 0 and table.indexof(self._viewInfo.hasGainGroupPrizeIds, prizeId) then
			if isTips then
				FloatWordMgr.instance:show("奖励已领取")
			end

			return false
		end

		for _, id in pairs(self._prizeCfgList[prizeId].needPointIds) do
			if #self._viewInfo.activePuzzleIds == 0 or not table.indexof(self._viewInfo.activePuzzleIds, id) then
				if isTips then
					FloatWordMgr.instance:show("完成对应点亮拼图可领取奖励")
				end

				return false
			end
		end
	end

	return true
end

function GratefulPuzzleView:_setPuzzleItemShow(puzzleId)
	self._viewInfo.activePuzzleIds = self._viewInfo.activePuzzleIds or {}

	if string.nilorempty(self._actCfg.cost) then
		self._viewInfo.lightTime = self._viewInfo.lightTime - 1
	end

	table.insert(self._viewInfo.activePuzzleIds, puzzleId)
	self:_checkAllPrizeItems()
end

function GratefulPuzzleView:_onClickFinalBtn(prizeId)
	local curTime = ServerTime.now()
	local startTime = GameUtil.string2time(self._actCfg.finalPrizeTime)

	printInfo("test ", curTime, startTime, self._actCfg.finalPrizeTime, curTime < startTime)

	if curTime < startTime then
		FloatWordMgr.instance:show("未到领取时间")

		return
	end

	prizeId = checknumber(prizeId)

	if not self:_isPrizeCanReceive(prizeId, true) then
		return
	end

	if prizeId <= 0 then
		PuzzleLightAgent.instance:sendPM_GainBigPrizeReq(self._viewInfo.activityId)
	else
		PuzzleLightAgent.instance:sendPM_GainGroupPrizeReq(self._viewInfo.activityId, prizeId)
	end
end

function GratefulPuzzleView:_onClickPrizeBtn(prizeId)
	prizeId = checknumber(prizeId)

	if not self:_isPrizeCanReceive(prizeId, true) then
		return
	end

	if prizeId <= 0 then
		PuzzleLightAgent.instance:sendPM_GainBigPrizeReq(self._viewInfo.activityId)
	else
		PuzzleLightAgent.instance:sendPM_GainGroupPrizeReq(self._viewInfo.activityId, prizeId)
	end
end

function GratefulPuzzleView:_onClickPuzzleBtn(puzzleId)
	if self:getAllCount() <= 0 then
		FloatWordMgr.instance:show(lang("text_grateful_desc_3"))

		return
	end

	PuzzleLightAgent.instance:sendPM_ActivatePuzzleReq(self._viewInfo.activityId, puzzleId)
end

function GratefulPuzzleView:_onClickShopBtn()
	if not PayShopModel.instance:getPayShopGoodsCanBuyById(self._actCfg.shopId) then
		FloatWordMgr.instance:show("商品已售馨")

		return
	end

	local planId = PayShopModel.instance:getBestDiscountPlanIdByGoodsDefineId(self._actCfg.shopId)
	local data = {
		id = self._actCfg.shopId,
		times = PayShopModel.instance:getMibaoBuyTimesById(self._actCfg.shopId)
	}

	UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, data, true, planId)
end

function GratefulPuzzleView:_getShopDiscountGoods(shopCfg)
	if shopCfg == nil then
		return "8:17:388"
	end

	if shopCfg.discountPlans and #shopCfg.discountPlans > 0 then
		local cfg = PayShopConfig.instance:getDiscountPlanCfg(shopCfg.discountPlans[1])

		if cfg == nil or not GameUtil.checkTimeStr(cfg.discountTime) then
			return shopCfg.discountPrice
		end
	end

	if not string.nilorempty(shopCfg.discountGoodsId) then
		return shopCfg.discountGoodsId
	end

	return "8:17:388"
end

return GratefulPuzzleView
