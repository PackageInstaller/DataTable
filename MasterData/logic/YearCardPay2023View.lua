-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2023/main/YearCardPay2023View.lua

module("logic.extensions.yearcard.view.yearcard2023.main.YearCardPay2023View", package.seeall)

local YearCardPay2023View = class("YearCardPay2023View", ViewComponent)

function YearCardPay2023View:buildUI()
	YearCardPay2023View.super.buildUI(self)

	self._btnList = {}

	for i = 1, 4 do
		local cell = {}
		local path = "reward/btnList/item_" .. i

		cell.go = self:getGo(path)
		cell.btn = goutil.findChild(cell.go, "btn")
		cell.con = goutil.findChild(cell.btn, "con")
		cell.mask = goutil.findChild(cell.go, "mask")
		cell.txtPrice = goutil.findChildTextComponent(cell.go, "txtPrice")
		cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
		cell.effPos = goutil.findChild(cell.go, "effPos")
		cell.cfg = nil
		cell.isAbleToGet = false
		self._btnList[i] = cell
	end

	self._sldProgress = self:getSlider("reward/sldProgress")
	self._txtProgress = self:getTxt("reward/progress/txtProgress")
	self._btn2022 = self:getGo("btn2022")
	self._redPoint2022 = goutil.findChild(self._btn2022, "redpoint")
	self._txtNum = self:getTxt("peopleNum/txtNum")
	self._btnShowAll = self:getGo("btnShowAll")
	self._btnInstallment = self:getGo("btnInstallment")
	self._markInstallment = self:getGo("markInstallment")
	self._btnGetAdvancePrize = self:getGo("btnGetAdvancePrize")
	self._markGetAdvancePrize = goutil.findChild(self._btnGetAdvancePrize, "mark")
	self._btnPay198 = self:getGo("btnPay198")
	self._txtPay198 = goutil.findChildTextComponent(self._btnPay198, "txt")
	self._mark198 = self:getGo("mark198")
	self._btnPay328 = self:getGo("btnPay328")
	self._txtPay328 = goutil.findChildTextComponent(self._btnPay328, "txt")
	self._mark328 = self:getGo("mark328")
	self.skinId = 16010
	self._rare = self:getGo("petInfo/rare")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._txtName = self:getTxt("petInfo/txtName")
	self._showItem1 = self:getGo("annualfee/awaken/item_1")
	self._showItem2 = self:getGo("annualfee/awaken/item_2")
	self._showItem3 = self:getGo("annualfee/cultivate/item_1")
	self._showItem4 = self:getGo("annualfee/cultivate/item_2")
	self._leftGiftId = 3
	self._rightGiftId = 4
end

function YearCardPay2023View:bindEvents()
	YearCardPay2023View.super.bindEvents(self)

	for i = 1, 4 do
		GameUtil.addClickHandler(self._btnList[i].btn, GameUtil.handler(self._onClickGainPrize, self, i))
	end

	GameUtil.addClickHandler(self._btn2022, self._onClick2022, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnShowAll, self._onClickShowAll, self)
	GameUtil.addClickHandler(self._btnInstallment, self._onClickInstallment, self)
	GameUtil.addClickHandler(self._btnGetAdvancePrize, self._onClickGetAdvancePrize, self)
	GameUtil.addClickHandler(self._btnPay198, GameUtil.handler(self._onClickPay, self, self._leftGiftId))
	GameUtil.addClickHandler(self._btnPay328, GameUtil.handler(self._onClickPay, self, self._rightGiftId))
end

function YearCardPay2023View:unbindEvents()
	YearCardPay2023View.super.unbindEvents(self)

	for i = 1, 4 do
		GameUtil.rmClickHandler(self._btnList[i].btn)
	end

	GameUtil.rmClickHandler(self._btn2022)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnShowAll)
	GameUtil.rmClickHandler(self._btnInstallment)
	GameUtil.rmClickHandler(self._btnGetAdvancePrize)
	GameUtil.rmClickHandler(self._btnPay198)
	GameUtil.rmClickHandler(self._btnPay328)
end

function YearCardPay2023View:onEnter()
	YearCardPay2023View.super.onEnter(self)
	self:_refreshViewByCfg()
	self:_refreshViewByInfo()
	GlobalDispatcher:addListener(GlobalNotify.AnnuityInfoChange, self._refreshViewByInfo, self)
	MaterialMgr.setCellByCfg("1004:1152:1", self._showItem1)
	MaterialMgr.setCellByCfg("1004:1154:1", self._showItem2)
	MaterialMgr.setCellByCfg("1004:1153:1", self._showItem3)
	MaterialMgr.setCellByCfg("1004:1154:1", self._showItem4)

	local effPath = "20221223/2023nianfei/fx_ui_2023nianfei.prefab"

	self:_createEff(effPath, self.mainGO, "mainEff", true)
end

function YearCardPay2023View:onExit()
	YearCardPay2023View.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.AnnuityInfoChange, self._refreshViewByInfo, self)

	for i = 1, 4 do
		MaterialMgr.clearIcon(self._btnList[i].con)
	end

	RedPointController.instance:unregRedPoint(self._redPoint2022)
	MaterialMgr.resetAll(self._rare)
	MaterialMgr.resetAll(self._showItem1)
	MaterialMgr.resetAll(self._showItem2)
	MaterialMgr.resetAll(self._showItem3)
	MaterialMgr.resetAll(self._showItem4)
	self:_removeAllEffect()
end

function YearCardPay2023View:_refreshViewByCfg()
	self._curActId = YearCardModel.instance:getCurAnnuityId()
	self._curTotalGiftCfg = self:_getTotalGiftCfg()
	self._progressCfgs = YearCardConfig.instance:getProgressCfg(self._curActId)

	MaterialMgr.setCell(MatType.Rare, self.skinId, self._rare)

	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(self.skinId)

	self._txtName.text = skinCfg.name

	for i = 1, 4 do
		local cell = self._btnList[i]

		cell.cfg = self._progressCfgs[i]

		if cell.cfg then
			goutil.setActive(cell.go, true)

			cell.txtPrice.text = langPara("%s元", cell.cfg.progressReq / 100)
			cell.txtName.text = cell.cfg.showTip

			MaterialMgr.clearIcon(cell.con)

			if not string.nilorempty(cell.cfg.prize) then
				local matType, id, matNum = MaterialMgr.getMatParams(cell.cfg.prize)

				MaterialMgr.setIcon(cell.con, matType, id)
			end
		else
			goutil.setActive(cell.go, false)
		end

		goutil.setActive(cell.mask, false)
	end

	self._txtNum.text = langPara("全服已有%s人激活年费", 0)

	self._sldProgress:SetValue(0)

	self._txtProgress.text = ""

	goutil.setActive(self._markInstallment, false)
	goutil.setActive(self._mark198, false)
	goutil.setActive(self._mark328, false)
	GameUtil.SetGray(self._btnInstallment, false)
	GameUtil.SetGray(self._btnPay198, false)
	GameUtil.SetGray(self._btnPay328, false)
	self:_setPay198Text()
	self:_setPay328Text()

	local aid = self:_getLastAnnuityId()
	local yearCard2022cfg = PayShopConfig.instance:getAnnuityCfgById(aid)

	goutil.setActive(self._redPoint2022, false)
	RedPointController.instance:regRedPoint(self._redPoint2022, (yearCard2022cfg or nil) and (yearCard2022cfg.redPointId or ""))
end

function YearCardPay2023View:_refreshViewByInfo()
	self._actInfo = YearCardModel.instance:getAnnuityInfo(self._curActId)

	if self._actInfo then
		self._txtNum.text = langPara("全服已有%s人激活年费", self._actInfo.activeCount)

		self:_setProgressState()
		self:_setMarkState()

		local cfg = PayShopConfig.instance:getAnnuityCfgById(self._curActId)
		local curTimeType = GameUtil.getTimePeriodType(cfg.forwardPayOpenTime, cfg.forwardPayEndTime)
		local isInTime = curTimeType == GameUtil.inTimePeriod

		goutil.setActive(self._btnGetAdvancePrize, isInTime)
		goutil.setActive(self._markGetAdvancePrize, self._actInfo.hasGainForwardPayPrize)
		self:_removeEffect("advanceEff")

		if YearCardModel.instance:isAbleToGetForwardPayPrize(self._curActId) then
			self:_createEff("fx_ui_tequan/fx_ui_tequan_kuang.prefab", self._btnGetAdvancePrize, "advanceEff", true)
		end
	end

	self:_setBtn2022State()
end

function YearCardPay2023View:_setProgressState()
	for i = 1, 4 do
		local cell = self._btnList[i]

		goutil.setActive(cell.mask, YearCardModel.instance:getProgressPrizeIdState(self._curActId, i))

		cell.isAbleToGet = YearCardModel.instance:getIsAbleToGetProgressPrizeId(self._curActId, i)

		local effPath = "fx_ui_shouchong/fx_ui_leichong_shouchong.prefab"
		local effKey = "gainEff" .. i

		if cell.isAbleToGet then
			self:_createEff(effPath, cell.con, effKey, true)
		else
			self:_removeEffect(effKey)
		end
	end

	if self._actInfo then
		if not self._actInfo.money then
			local money = 0
			local val = 0
			local stepVal = 0.3333333333333333

			for i = 1, 3 do
				local cfg = self._progressCfgs[i]
				local nextcfg = self._progressCfgs[i + 1]

				if money < cfg.progressReq then
					break
				elseif money >= nextcfg.progressReq then
					val = val + stepVal
				else
					local valAdd = stepVal * (money - cfg.progressReq) / (nextcfg.progressReq - cfg.progressReq)

					val = val + valAdd
				end
			end

			self._sldProgress:SetValue(val)

			self._txtProgress.text = YearCardModel.instance:isActiveAnnuity(self._curActId) and "" or money / 100
		end
	end
end

function YearCardPay2023View:_setMarkState()
	local isActive = YearCardModel.instance:isActiveAnnuity(self._curActId)

	goutil.setActive(self._markInstallment, isActive)
	goutil.setActive(self._mark198, isActive and self._actInfo.activeProgress == self:_getGiftProgressGain(self._leftGiftId))
	goutil.setActive(self._mark328, isActive and self._actInfo.activeProgress == self:_getGiftProgressGain(self._rightGiftId))
	GameUtil.SetGray(self._btnInstallment, isActive)
	GameUtil.SetGray(self._btnPay198, isActive)
	GameUtil.SetGray(self._btnPay328, isActive)

	if isActive then
		goutil.setActive(self._btnPay198, self._actInfo.activeProgress == self:_getGiftProgressGain(self._leftGiftId))
		goutil.setActive(self._btnPay328, self._actInfo.activeProgress == self:_getGiftProgressGain(self._rightGiftId))
	else
		goutil.setActive(self._btnPay198, true)
		goutil.setActive(self._btnPay328, true)
	end
end

function YearCardPay2023View:_onClick2022()
	UIStateManager.instance:push(ViewName.YearCardMain2022View)
end

function YearCardPay2023View:_onClickInfo()
	PetbookController.instance:openPetinfoView(self.skinId)
end

function YearCardPay2023View:_onClickSkill()
	UIStateManager.instance:push(ViewName.PetcollegeView, 39)
end

function YearCardPay2023View:_onClickShowAll()
	local isAbleToGetPrize = false

	if isAbleToGetPrize then
		-- block empty
	else
		UIStateManager.instance:push(ViewName.YearCardPoster2023View, 3)
	end
end

function YearCardPay2023View:_onClickInstallment()
	local isAbleToBuy, isDateMatch, isButTimeLimit, isActive = YearCardModel.instance:isAbleToBuyGiftId(self._curActId, 1)

	if isActive then
		FloatWordMgr.instance:show(lang("已激活该年费"))

		return
	end

	if not isDateMatch then
		FloatWordMgr.instance:show(lang("分期付款功能将于12月30号5点后开放，敬请期待"))

		return
	end

	UIStateManager.instance:push(ViewName.YearCardInstallment2023View)
end

function YearCardPay2023View:_onClickPay(giftId)
	local giftCfg = self:_getGiftCfg(giftId)

	if not giftCfg.isActiveAnnuityCanBuy and YearCardModel.instance:isActiveAnnuity(self._curActId) then
		FloatWordMgr.instance:show(lang("已激活该年费"))

		return
	else
		local curTryPayMoney = PayConfig.instance:getPayMoneyYuan(giftCfg.payGoodsId)

		if self._actInfo then
			if not self._actInfo.money then
				local money = 0

				if money > 0 then
					local showTip = langPara("您已经分期购买年费，请在分期购买界面继续激活年费，若直接花费%s元激活年费，之前分期的金额会按1元：10钻等比例神钻通过邮件返还", curTryPayMoney)

					TipsFacade.instance:openPopupWindow(lang("提示"), showTip, function()
						YearCardController.instance:payGiftId(self._curActId, giftId)
					end, nil, lang("确定"), lang("取消"))
				else
					YearCardController.instance:payGiftId(self._curActId, giftId)
				end
			end
		end
	end
end

function YearCardPay2023View:_onClickGainPrize(id)
	local cell = self._btnList[id]

	if cell.isAbleToGet then
		AnnuityAgent.instance:sendPM_AnnuityGainProgressPrizeReq(self._curActId, id)
		YearCardModel.instance:setProgressPrizeId(self._curActId, id)
	else
		CommonTipsMgr.instance:openTipsByConfStr(cell.go, cell.cfg.prize)
	end
end

function YearCardPay2023View:_onClickGetAdvancePrize()
	if YearCardModel.instance:isAbleToGetForwardPayPrize(self._curActId) then
		YearCardController.instance:gainForwardPayPrize(self._curActId)
	else
		UIStateManager.instance:push(ViewName.YearCardPoster2023View, 1)
	end
end

function YearCardPay2023View:_createEff(effPath, effParent, effKey, isLoop)
	self._exictEffs = self._exictEffs or {}

	if not effParent then
		return
	end

	local exictEff = self._exictEffs[effKey]

	if exictEff then
		UIEffectManager.instance:stopEffect(exictEff)

		self._exictEffs[effKey] = nil
	end

	self._exictEffs[effKey] = UIEffectManager.instance:playEffect(self, effPath, effParent.transform, 0, 0, isLoop, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(effParent.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)
		eff:setClipping(effParent:GetComponent(goutil.Type_RectTransform))
	end)
end

function YearCardPay2023View:_removeAllEffect()
	if self._exictEffs then
		for _, eff in pairs(self._exictEffs) do
			UIEffectManager.instance:stopEffect(eff)
		end

		self._exictEffs = nil
	end
end

function YearCardPay2023View:_removeEffect(key)
	if self._exictEffs then
		if self._exictEffs then
			UIEffectManager.instance:stopEffect(self._exictEffs)

			self._exictEffs[key] = nil
		end
	end
end

function YearCardPay2023View:_getGiftCfg(giftId)
	return YearCardConfig.instance:getGiftCfg(self._curActId, giftId)
end

function YearCardPay2023View:_getTotalGiftCfg()
	return YearCardConfig.instance:getTotalGiftCfg(self._curActId)
end

function YearCardPay2023View:_setPay328Text()
	local giftCfg = self:_getGiftCfg(self._rightGiftId)

	self._txtPay328.text = langPara("%s元", PayConfig.instance:getPayMoneyYuan(giftCfg.payGoodsId))
end

function YearCardPay2023View:_setPay198Text()
	local giftCfg = self:_getGiftCfg(self._leftGiftId)

	self._txtPay198.text = langPara("%s元", PayConfig.instance:getPayMoneyYuan(giftCfg.payGoodsId))
end

function YearCardPay2023View:_getLastAnnuityId()
	return 8002
end

function YearCardPay2023View:_getGiftProgressGain(giftId)
	local cfg = YearCardConfig.instance:getGiftCfg(self._curActId, giftId)

	return cfg.progressGain
end

function YearCardPay2023View:_setBtn2022State()
	goutil.setActive(self._btn2022, YearCardModel.instance:getEndTime(self:_getLastAnnuityId()) > ServerTime.now())
end

return YearCardPay2023View
