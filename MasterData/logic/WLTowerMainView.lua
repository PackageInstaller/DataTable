-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/WLTowerMainView.lua

module("logic.extensions.waterdraktower.view.WLTowerMainView", package.seeall)

local WLTowerMainView = class("WLTowerMainView", TableViewComponent)

function WLTowerMainView:ctor()
	WLTowerMainView.super.ctor(self)

	self._tierIndex = nil
	self._baseItemList = nil
	self._specialItemList = nil
	self._itemCount = 5
	self._itemHeight = 108
	self._offsetPos = 50
	self._levelMaxPos = 50
	self._intervalRanges = nil
	self._conHalfH = nil
end

function WLTowerMainView:bindEvents()
	WLTowerMainView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "wltowermain")
	end, self)
	self._rankBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.WLTowerRank)
	end, self)
	self._rewardBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.WLTowerReward)
	end, self)
	self._challBtn:AddClickListener(self._onClickChallengeBtn, self)
	self._countAddBtn:AddClickListener(self._onClickCountAddBtn, self)
	self._tableview:AddOnScrollValueChanged(self._onCellUpdatePosition, self)
	GameUtil.asBtn(self._buffBtnGo):AddClickListener(function()
		WaterdraktowerModel.instance:setWLTowerRedpoint()
		self:_updataWLTowerBuffRedpoint()
		ViewMgr.instance:open(ViewName.WLTowerBuff, {
			isMainOpen = true,
			buffPlanId = self._actCfg.buffPlanId
		})
	end, self)
end

function WLTowerMainView:unbindEvents()
	WLTowerMainView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._rankBtn:RemoveClickListener()
	self._rewardBtn:RemoveClickListener()
	self._challBtn:RemoveClickListener()
	self._countAddBtn:RemoveClickListener()
	self._tableview:UnRegisterAllCallbacks()
	GameUtil.asBtn(self._buffBtnGo):RemoveClickListener()
end

function WLTowerMainView:onExit()
	WLTowerMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.WaterDarkTowerGetInfo, self._updataWaterDarkStages, self)
	GlobalDispatcher:removeListener(GlobalNotify.WaterDarkTowerBuyTimes, self._setChallengeCountShow, self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self._pmEff = nil

	for _, go in pairs(self._baseItemList or {}) do
		if go then
			MaterialMgr.resetAll(go)
		end
	end

	for _, go in pairs(self._specialItemList or {}) do
		if go then
			MaterialMgr.resetAll(go)
		end
	end

	self._tierIndex = nil
	self._cacheItemIma = nil

	MaterialMgr.resetAll(self._rewardGoods)
end

function WLTowerMainView:destroyUI()
	WLTowerMainView.super.destroyUI(self)

	self._baseItemList = nil
	self._specialItemList = nil
end

function WLTowerMainView:buildUI()
	WLTowerMainView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._rankBtn = self:getBtn("rankBtn")
	self._rewardBtn = self:getBtn("rewardBtn")
	self._timerTxt = goutil.findChildTextComponent(self.mainGO, "timerGo/timerTxt")
	self._goldBarConGo = self:getGo("goldBarCon")
	self._spriteRawGo = self:getGo("spriteRawIma")

	local leftInfoGo = self:getGo("leftInfoGo")

	self._weakenGo = goutil.findChild(leftInfoGo, "weakenGo")
	self._challBtn = Framework.ButtonAdapter.GetFrom(leftInfoGo, "challBtn")
	self._challPassGo = goutil.findChild(leftInfoGo, "challPassGo")
	self._challCountGo = goutil.findChild(leftInfoGo, "challCountGo")
	self._countAddBtn = Framework.ButtonAdapter.GetFrom(self._challCountGo, "countAddBtn")
	self._countDescTxt = goutil.findChildTextComponent(self._challCountGo, "countDescTxt")
	self._specialTxt = goutil.findChildTextComponent(leftInfoGo, "specialGo/specialTxt")
	self._stageNameTxt = goutil.findChildTextComponent(leftInfoGo, "stageNameTxt")
	self._baseItemList = {
		goutil.findChild(leftInfoGo, "baseGoods_1"),
		goutil.findChild(leftInfoGo, "baseGoods_2"),
		goutil.findChild(leftInfoGo, "baseGoods_3"),
		goutil.findChild(leftInfoGo, "baseGoods_4")
	}
	self._extraTxt = goutil.findChildTextComponent(leftInfoGo, "extraTxt")
	self._extraGoods = goutil.findChild(leftInfoGo, "extraGoods")
	self._specialItemList = {
		goutil.findChild(leftInfoGo, "specialGoods_1"),
		goutil.findChild(leftInfoGo, "specialGoods_2"),
		goutil.findChild(leftInfoGo, "specialGoods_3"),
		goutil.findChild(leftInfoGo, "specialGoods_4")
	}
	self._rewardGo = self:getGo("rewardGo")
	self._rewardTxt = goutil.findChildTextComponent(self._rewardGo, "rewardTxt")
	self._rewardGoods = goutil.findChild(self._rewardGo, "rewardGoods")
	self._bubbleGo = self:getGo("bubbleGo")
	self._bubbleTxt = goutil.findChildTextComponent(self._bubbleGo, "bubbleTxt")
	self._buffBtnGo = self:getGo("buffBtnGo")
	self._redpointGo = goutil.findChild(self._buffBtnGo, "redpointGo")
	self._timerTxt.text = ""

	self._weakenGo:SetActive(false)
	self._challPassGo:SetActive(false)

	self._countDescTxt.text = ""
	self._specialTxt.text = ""
	self._stageNameTxt.text = ""

	GameUtil.SetActive(self._redpointGo, false)

	self._extraTxt.text = ""

	GameUtil.SetActive(self._extraGoods, false)
end

function WLTowerMainView:onEnter()
	WLTowerMainView.super.onEnter(self)
	WaterdraktowerConfig.instance:getOpenTowerActivityId()
	GlobalDispatcher:addListener(GlobalNotify.WaterDarkTowerGetInfo, self._updataWaterDarkStages, self)
	GlobalDispatcher:addListener(GlobalNotify.WaterDarkTowerBuyTimes, self._setChallengeCountShow, self)

	self._actType = WaterdraktowerModel.instance.openActType

	WaterdraktowerModel.instance:setWLTowerRedpoint(true)
	self:_updataWaterDarkStages()

	local btnList = {
		{
			showAdd = true,
			id = GameEnum.GoldType.Diamond
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarConGo, self._viewPresentor, btnList, false)

	self._bubbleTxt.text = lang("text_wltower_desc_12")

	if self._actCfg and not string.nilorempty(self._actCfg.bigPrize) then
		GameUtil.SetActive(self._rewardGo, true)

		self._rewardTxt.text = lang("text_wltower_desc_13")

		MaterialMgr.setCellByCfg(self._actCfg.bigPrize, self._rewardGoods)
	else
		MaterialMgr.resetAll(self._rewardGoods)
		GameUtil.SetActive(self._rewardGo, false)
	end

	self:_updataWLTowerBuffRedpoint()

	local stime, etime = ActivityDefineController.instance:getStartTimeAndEndTime(self._actType, WaterdraktowerModel.instance.openActId)
	local sdate = GameUtil.time2date(stime)
	local sStr = langPara("text_wltower_desc_1", sdate.year, sdate.month, sdate.day)
	local edate = GameUtil.time2date(etime)
	local eStr = langPara("text_wltower_desc_1", edate.year, edate.month, edate.day)

	self._timerTxt.text = string.format("%s - %s", sStr, eStr)

	local endInfo = WaterdraktowerModel.instance:getWaterEndFightInfo(false)

	if endInfo and checknumber(endInfo.newTier) > 0 then
		UIStateManager.instance:push(ViewName.WLTowerTips, endInfo.newTier)
	end

	WaterdraktowerModel.instance:getWaterEndFightInfo(true)
	WaterdraktowerController.instance:csGetWaterDarkTowerGetInfoReq()

	local effPath = "20211126/fx_ui_guanganta_daiji.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

function WLTowerMainView:_updataWaterDarkStages()
	self._actCfg = WaterdraktowerConfig.instance:getTierCommCfg(WaterdraktowerModel.instance.openActId)
	self._baseInfo = WaterdraktowerModel.instance:getWaterDarkTowerInfo()
	self._curViewDatas, self._openIndex, self._isAllPass = WaterdraktowerModel.instance:getTierStageIndexAndList()

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		self._intervalRanges = nil

		return
	end

	if #self._curViewDatas > self._itemCount then
		self._intervalRanges = {}

		local allH = #self._curViewDatas * (self._itemHeight + 10) - 10

		self._conHalfH = allH / 2

		local leftPos = -math.ceil(self._itemCount / 2) * self._offsetPos

		for i = 1, self._itemCount + 1 do
			self._intervalRanges[i] = {}
			self._intervalRanges[i].startY = i <= 1 and self._conHalfH + self._itemHeight / 2 + 10 or self._intervalRanges[i - 1].endY - 1
			self._intervalRanges[i].endY = self._conHalfH - (i - 1) * (self._itemHeight + 10) - self._itemHeight / 2 + 1
			self._intervalRanges[i].startOff = leftPos + self._levelMaxPos + (i - 1) * self._offsetPos

			if self._intervalRanges[i].startOff > self._levelMaxPos then
				self._intervalRanges[i].startOff = self._levelMaxPos - (i - 1) * self._offsetPos - leftPos
			end
		end
	end

	self:_onClickLeftStgeItemBtn(nil, self._openIndex, nil, true)
	self._tableview:ReloadData()
	self:_setChallengeCountShow()
end

function WLTowerMainView:_setChallengeCountShow()
	self._baseInfo = WaterdraktowerModel.instance:getWaterDarkTowerInfo()

	local supTimes = self._actCfg.dailyTimes - self._baseInfo.clgTimes + self._baseInfo.buyTimes

	self._countDescTxt.text = langPara("text_wltower_desc_2", supTimes, self._actCfg.dailyTimes)
end

function WLTowerMainView:_onClickLeftStgeItemBtn(itemIma, index, newStar, isForce)
	index = checknumber(index)

	if not isForce and (index <= 0 or index == checknumber(self._tierIndex)) then
		return
	end

	for _, go in pairs(self._baseItemList or {}) do
		if go then
			MaterialMgr.resetAll(go)
		end
	end

	MaterialMgr.resetAll(self._extraGoods)

	for _, go in pairs(self._specialItemList or {}) do
		if go then
			MaterialMgr.resetAll(go)
		end
	end

	self._tierIndex = index

	local cfg = self._curViewDatas[self._tierIndex]

	if cfg == nil then
		return
	end

	if newStar == nil or newStar <= 0 then
		newStar = self:_setStageItemHard(cfg.cutDownPlanId, cfg.level)
	end

	self._weakenGo:SetActive(newStar < cfg.level)

	if self._cacheItemIma and self._cacheItemIma.gameObject and self._cacheItemIma.gameObject.activeSelf then
		self._cacheItemIma:SetState(0)
	end

	if itemIma then
		itemIma:SetState(1)

		self._cacheItemIma = itemIma
	end

	self._stageNameTxt.text = cfg.name

	if cfg.prize and #cfg.prize > 0 then
		for i = 1, #cfg.prize do
			if cfg.prize[i] and self._baseItemList[i] then
				MaterialMgr.setCellByCfg(cfg.prize[i], self._baseItemList[i])
			end
		end
	end

	if string.nilorempty(cfg.extraPrize) then
		self._extraTxt.text = ""

		GameUtil.SetActive(self._extraGoods, false)
	else
		self._extraTxt.text = "圣骑奖励"

		GameUtil.SetActive(self._extraGoods, true)
		MaterialMgr.setCellByCfg(cfg.extraPrize, self._extraGoods)
	end

	local sGoodsList, maxNum = WaterdraktowerModel.instance:getTierSpecialPrize(self._actCfg.prizePlanId, cfg.tier)

	if sGoodsList and #sGoodsList > 0 and cfg.prize and #sGoodsList > 0 then
		for i = 1, #sGoodsList do
			if sGoodsList[i] and self._specialItemList[i] then
				MaterialMgr.setCellByCfg(sGoodsList[i], self._specialItemList[i])
			end
		end
	end

	local str = math.max(checknumber(maxNum) - self._baseInfo.specialPrizeNum, 0) .. "/" .. checknumber(maxNum)

	self._specialTxt.text = langPara("text_wltower_desc_3", str)

	local isPass = cfg.tier < self._baseInfo.tier or cfg.tier == self._baseInfo.tier and cfg.stage <= self._baseInfo.stage

	GameUtil.SetActive(self._challBtn, not isPass)
	GameUtil.SetActive(self._challPassGo, isPass)
	GameUtil.SetActive(self._challCountGo, not isPass)
end

function WLTowerMainView:_onClickChallengeBtn()
	if self._isAllPass then
		FloatWordMgr.instance:show(lang("text_wltower_desc_4"))

		return
	end

	local cfg = self._curViewDatas[self._tierIndex]

	if cfg == nil then
		return
	end

	if self._tierIndex > self._openIndex then
		FloatWordMgr.instance:show(lang("text_wltower_desc_5"))

		return
	end

	local supTimes = self._actCfg.dailyTimes - self._baseInfo.clgTimes + self._baseInfo.buyTimes

	if supTimes <= 0 then
		FloatWordMgr.instance:show(lang("text_wltower_desc_6"))

		return
	end

	local params = {}

	params.actId = WaterdraktowerModel.instance.openActId
	params.planId = self._actCfg.challengePlanId
	params.towerType = WaterdraktowerModel.instance.openTowerType
	params.tier = self._baseInfo.tier
	params.stage = self._baseInfo.stage + 1
	params.formCondition = 0
	params.buffPlanId = self._actCfg.buffPlanId

	local teamCfg = WaterdraktowerConfig.instance:getTierChallengeCfgByStage(self._actCfg.challengePlanId, WaterdraktowerModel.instance.openTowerType, self._baseInfo.tier, self._baseInfo.stage + 1)

	if teamCfg and teamCfg.formCondition > 0 then
		params.formCondition = teamCfg.formCondition
	end

	UIStateManager.instance:push(ViewName.WLTowerMission, params)
end

function WLTowerMainView:_onClickCountAddBtn()
	local supTimes = self._actCfg.dailyTimes - self._baseInfo.clgTimes + self._baseInfo.buyTimes

	if supTimes > 0 then
		FloatWordMgr.instance:show(lang("text_wltower_desc_7"))

		return
	end

	local buyCfg = WaterdraktowerConfig.instance:getBuyTowerChallCount(self._actCfg.buyTimesPlanId, self._baseInfo.dailyBuyTimes + 1)

	if not buyCfg or string.nilorempty(buyCfg.cost) then
		FloatWordMgr.instance:show(lang("text_lottery_desc_26"))

		return
	end

	local allBuyCfg = WaterdraktowerConfig.instance:getBuyTowerChallCount(self._actCfg.buyTimesPlanId)

	if allBuyCfg then
		if not #allBuyCfg then
			local allTimes = 0
			local arr = string.split(buyCfg.cost, ":")
			local matType = checknumber(arr[1])
			local matId = checknumber(arr[2])
			local matNum = checknumber(arr[#arr])
			local costNum = MaterialFacade.instance:getGoodCost(matType, matId, matNum)
			local content = langPara("text_wltower_desc_8", costNum, MaterialMgr.getMaterialsName(matType, matId), allTimes, allTimes - self._baseInfo.dailyBuyTimes)

			local function sureFunc()
				WaterdraktowerController.instance:csGetWaterDarkTowerBuyTimesReq()
			end

			if MatType.Diamond_Consume == matType or matType == MatType.Diamond then
				TipsFacade.instance:openPopupCostDiamondView(costNum, content, sureFunc)
			else
				FloatWordMgr.instance:show("不是说好只能用砖石买吗")
			end
		end
	end
end

function WLTowerMainView:_updataWLTowerBuffRedpoint()
	local value = GameUtil.getUserDayData("WLTowerBuff_Redpoint_" .. LoginModel.instance.userId)

	GameUtil.SetActive(self._redpointGo, checknumber(value) ~= 1)
end

function WLTowerMainView:_getPath()
	return {
		cellPath = "stageItem",
		viewPath = "stageListSR"
	}
end

function WLTowerMainView:_cellSize()
	return 440, self._itemHeight
end

function WLTowerMainView:_updateCell(view, cell, data)
	local itemGo = goutil.findChild(cell, "itemBgGo")
	local itemIma = itemGo:GetComponent("UIImageSpriteChange")
	local lockGo = goutil.findChild(itemGo, "lockGo")
	local passGo = goutil.findChild(itemGo, "passGo")
	local starsList = {
		goutil.findChild(itemGo, "starsGo/star_1"),
		goutil.findChild(itemGo, "starsGo/star_2"),
		goutil.findChild(itemGo, "starsGo/star_3"),
		goutil.findChild(itemGo, "starsGo/star_4"),
		goutil.findChild(itemGo, "starsGo/star_5")
	}
	local levelTxt = goutil.findChildTextComponent(itemGo, "levelTxt")

	if self._tierIndex == cell.data then
		itemIma:SetState(1)

		self._cacheItemIma = itemIma
	else
		itemIma:SetState(0)
	end

	local starNum = 1

	if data.level > 1 then
		starNum = self:_setStageItemHard(data.cutDownPlanId, data.level)
	end

	for i = 1, #starsList do
		if starsList[i] then
			GameUtil.SetActive(starsList[i], i <= starNum)
		end
	end

	lockGo:SetActive(cell.data > self._openIndex)

	if self._isAllPass then
		passGo:SetActive(true)
	else
		passGo:SetActive(cell.data < self._openIndex)
	end

	levelTxt.text = langPara("text_wltower_desc_9", data.name, ConstString.ChineseNumber[data.tier], data.stage)

	GameUtil.asBtn(itemGo):AddClickListener(function()
		if cell.data > self._openIndex then
			FloatWordMgr.instance:show(lang("text_wltower_desc_5"))

			return
		end

		if cell.data < self._openIndex then
			FloatWordMgr.instance:show(lang("已通关无法查看上一关卡"))

			return
		end

		self:_onClickLeftStgeItemBtn(itemIma, cell.data, starNum)
	end, self)
end

function WLTowerMainView:_setStageItemHard(planId, star)
	local cfgs = WaterdraktowerConfig.instance:getCutDownPlanCfgs(planId)
	local stime = ActivityDefineController.instance:getStartTimeAndEndTime(self._actType, WaterdraktowerModel.instance.openActId)
	local curHardStar = star
	local newTime = ServerTime.nowServerLook()

	for i = #cfgs, 1, -1 do
		if self._baseInfo.specialPrizeNum >= cfgs[i].personNum or newTime >= stime + cfgs[i].cutDownTime * 86400 then
			curHardStar = math.max(curHardStar - cfgs[i].stall, 1)

			break
		end
	end

	return curHardStar
end

function WLTowerMainView:_onReloadFinish()
	if self._openIndex > 5 then
		local index = (math.ceil(self._openIndex / 5) - 1) * 5 + 1

		self._tableview:MoveCellToCebter(index - 1, 236)
	end

	self:_onCellUpdatePosition()
end

function WLTowerMainView:_onCellUpdatePosition(pos)
	if self._intervalRanges == nil or #self._intervalRanges <= self._itemCount then
		return
	end

	local count = self._tableview:GetVisibleCount()

	if count < self._itemCount then
		return
	end

	for i = 1, count do
		local subCell = self._tableview:GetCellByIndex(i - 1)

		if subCell then
			local subGo = goutil.findChild(subCell, "itemBgGo")
			local cellPosY = subCell.transform.localPosition.y

			self:_calculationLocalPosition(subCell.data, cellPosY, subGo)
		end
	end
end

function WLTowerMainView:_calculationLocalPosition(cellIndex, cellPosY, subGo)
	if subGo == nil then
		return
	end

	local conPosY = self._tableview:GetContent().transform.localPosition.y
	local tempPos = conPosY + checknumber(self._conHalfH) + cellPosY
	local index = 0

	for i = 1, #self._intervalRanges do
		if self._intervalRanges[i] and tempPos <= self._intervalRanges[i].startY and tempPos > self._intervalRanges[i].endY then
			index = i

			break
		end
	end

	if index <= 0 or index > self._itemCount + 1 then
		return
	end

	local pos = 0

	if tempPos == self._intervalRanges[index].startY then
		pos = self._intervalRanges[index].startOff
	else
		local ratio = (tempPos - self._intervalRanges[index].startY) / (self._intervalRanges[index].endY - self._intervalRanges[index].startY)

		pos = ratio * (((self._intervalRanges[index + 1] and self._intervalRanges[index].startOff < self._intervalRanges[index + 1].startOff or nil) and self._intervalRanges[index].startOff + self._offsetPos) - self._intervalRanges[index].startOff) + self._intervalRanges[index].startOff
	end

	Framework.TransformUtil.SetLocalPos(subGo.transform, pos, 0, 0)
end

return WLTowerMainView
