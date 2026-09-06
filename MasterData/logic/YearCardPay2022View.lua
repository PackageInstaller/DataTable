-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCard2022/YearCardPay2022View.lua

module("logic.extensions.yearcard.view.2022.YearCardPay2022View", package.seeall)

local YearCardPay2022View = class("YearCardPay2022View", ViewComponent)

function YearCardPay2022View:buildUI()
	YearCardPay2022View.super.buildUI(self)

	self._btnSure = self:getBtn("reward/btnSure")
	self._markActive = self:getGo("reward/markActive")
	self._btnList = {}

	for i = 1, 5 do
		local cell = {}
		local path = "reward/bottom/btnList/item_" .. i

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

	self._sldProgress = self:getSlider("reward/bottom/sldProgress")
	self._btnInstallment = self:getBtn("reward/btnInstallment")
	self._markActive2 = self:getGo("reward/mark")
	self._btnShowAll = self:getBtn("reward/btnShowAll")
	self._goPrice = self:getGo("reward/price")
	self._txtPrice = goutil.findChildTextComponent(self._goPrice, "txt")
	self._txtCurPrice = self:getTxt("reward/btnSure/txt")
	self._btn2011 = self:getBtn("btn2011")
	self._btn2011Copy = self:getBtn("btn2011Copy")
	self._txtProgress = self:getTxt("reward/bottom/progress/txtProgress")
	self._txtNum = self:getTxt("txtNum")
	self._redPoint = self:getGo("btn2011/redpoint")
	self.rare = self:getGo("petInfo/rare")
	self.btnInfo = self:getGo("petInfo/btnInfo")
	self.btnSkill = self:getGo("petInfo/btnSkill")
end

function YearCardPay2022View:bindEvents()
	YearCardPay2022View.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickSure, self)
	self._btnInstallment:AddClickListener(self._onClickInstallment, self)
	self._btnShowAll:AddClickListener(self._onClickShowAll, self)

	for i = 1, 5 do
		GameUtil.addClickHandler(self._btnList[i].btn, GameUtil.handler(self._onClickGainPrize, self, i))
	end

	self._btn2011:AddClickListener(self._onClick2011, self)
	self._btn2011Copy:AddClickListener(self._onClick2011Copy, self)
	GameUtil.addClickHandler(self.btnInfo, self.onClickInfo, self)
	GameUtil.addClickHandler(self.btnSkill, self.onClickSkill, self)
end

function YearCardPay2022View:unbindEvents()
	YearCardPay2022View.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
	self._btnInstallment:RemoveClickListener()
	self._btnShowAll:RemoveClickListener()

	for i = 1, 5 do
		GameUtil.rmClickHandler(self._btnList[i].btn)
	end

	self._btn2011:RemoveClickListener()
	self._btn2011Copy:RemoveClickListener()
	GameUtil.rmClickHandler(self.btnInfo)
	GameUtil.rmClickHandler(self.btnSkill)
end

function YearCardPay2022View:onEnter()
	YearCardPay2022View.super.onEnter(self)

	self._curActId = YearCardModel.instance:getCurAnnuityId()
	self._curTotalGiftCfg = YearCardConfig.instance:getTotalGiftCfg(self._curActId)
	self._progressCfgs = YearCardConfig.instance:getProgressCfg(self._curActId)

	self:setViewByCfg()
	GlobalDispatcher:addListener(GlobalNotify.AnnuityInfoChange, self._refreshView, self)
	self:_refreshView()

	local effPath = "20211217/nianfei/aoqi/fx_ui_zhizunnianfei_mianban.prefab"

	self:_createEff(effPath, self.mainGO, "mainEff", true)
	RedPointController.instance:regRedPoint(self._redPoint, RedPointModel.ID_YEAR)

	self.skinId = 16001

	MaterialMgr.setCell(MatType.Rare, self.skinId, self.rare)
end

function YearCardPay2022View:onExit()
	YearCardPay2022View.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.AnnuityInfoChange, self._refreshView, self)

	for i = 1, 5 do
		MaterialMgr.clearIcon(self._btnList[i].con)
	end

	self:_removeAllEffect()
	RedPointController.instance:unregRedPoint(self._redPoint)
	MaterialMgr.resetAll(self.rare)
end

function YearCardPay2022View:_onClickSure()
	if YearCardModel.instance:isActiveAnnuity(self._curActId) then
		FloatWordMgr.instance:show(lang("已激活该年费"))

		return
	elseif self._actInfo then
		if not self._actInfo.money then
			local money = 0

			if money > 0 then
				local showTip = lang("您已经分期购买年费，请在分期购买界面继续激活年费，若直接花费198元激活年费，之前分期的金额会按1元：10钻等比例钻石通过邮件返还")

				TipsFacade.instance:openPopupWindow(lang("提示"), showTip, function()
					YearCardController.instance:payGiftId(self._curActId, self._curTotalGiftCfg.giftId)
				end, nil, lang("确定"), lang("取消"))
			else
				YearCardController.instance:payGiftId(self._curActId, self._curTotalGiftCfg.giftId)
			end
		end
	end
end

function YearCardPay2022View:_onClickInstallment()
	local isAbleToBuy, isDateMatch, isButTimeLimit, isActive = YearCardModel.instance:isAbleToBuyGiftId(self._curActId, 1)

	if isActive then
		FloatWordMgr.instance:show(lang("已激活该年费"))

		return
	end

	if not isDateMatch then
		FloatWordMgr.instance:show(lang("12月31日5点后开启分期购买"))

		return
	end

	UIStateManager.instance:push(ViewName.YearCardInstallmentView)
end

function YearCardPay2022View:_onClickShowAll()
	UIStateManager.instance:push(ViewName.YearCardShowAllView)
end

function YearCardPay2022View:setViewByCfg()
	for i = 1, 5 do
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
	end
end

function YearCardPay2022View:_refreshView()
	self._actInfo = YearCardModel.instance:getAnnuityInfo(self._curActId)
	self._txtNum.text = langPara("至尊年费人数：%s", self._actInfo.activeCount)

	self:_setPrizeState()
	self:_setSldValue()
	self:_setBtnSureState()
	self:_setBtnInstallmentState()
	goutil.setActive(self._btn2011.gameObject, YearCardModel.instance:getEndTime(8001) > ServerTime.now())
end

function YearCardPay2022View:_setPrizeState()
	for i = 1, 5 do
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
end

function YearCardPay2022View:_setSldValue()
	if self._actInfo then
		if not self._actInfo.money then
			local money = 0
			local val = 0
			local stepVal = 0.25

			for i = 1, 4 do
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

function YearCardPay2022View:_setBtnSureState()
	if YearCardModel.instance:isActiveAnnuity(self._curActId) then
		GameUtil.SetGray(self._btnSure, true)
		goutil.setActive(self._markActive, true)
	else
		GameUtil.SetGray(self._btnSure, false)
		goutil.setActive(self._markActive, false)
	end

	self._txtPrice.text = langPara("%s元", PayConfig.instance:getPayMoneyYuan(self._curTotalGiftCfg.payGoodsId))

	if GameUtil.checkIsInTimePeriod(self._curTotalGiftCfg.discountStartTime, self._curTotalGiftCfg.discountEndTime) then
		goutil.setActive(self._goPrice, true)

		self._txtCurPrice.text = langPara("%s元", PayConfig.instance:getPayMoneyYuan(self._curTotalGiftCfg.discountPayGoodsId))
		self._btnList[5].txtPrice.text = self._txtCurPrice.text
	else
		goutil.setActive(self._goPrice, false)

		self._txtCurPrice.text = self._txtPrice.text
	end
end

function YearCardPay2022View:_setBtnInstallmentState()
	local isAbleToBuy, isDateMatch, isButTimeLimit, isActive = YearCardModel.instance:isAbleToBuyGiftId(self._curActId, 1)

	goutil.setActive(self._markActive2, isActive)
	GameUtil.SetGray(self._btnInstallment, isActive or not isDateMatch)
end

function YearCardPay2022View:_onClickGainPrize(id)
	local cell = self._btnList[id]

	if cell.isAbleToGet then
		AnnuityAgent.instance:sendPM_AnnuityGainProgressPrizeReq(self._curActId, id)
		YearCardModel.instance:setProgressPrizeId(self._curActId, id)
	else
		CommonTipsMgr.instance:openTipsByConfStr(cell.go, cell.cfg.prize)
	end
end

function YearCardPay2022View:_onClick2011()
	UIStateManager.instance:push(ViewName.YearCardMainView)
end

function YearCardPay2022View:_onClick2011Copy()
	UIStateManager.instance:push(ViewName.NianfeicopyView)
end

function YearCardPay2022View:_createEff(effPath, effParent, effKey, isLoop)
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

function YearCardPay2022View:_removeAllEffect()
	if self._exictEffs then
		for _, eff in pairs(self._exictEffs) do
			UIEffectManager.instance:stopEffect(eff)
		end

		self._exictEffs = nil
	end
end

function YearCardPay2022View:_removeEffect(key)
	if self._exictEffs then
		if self._exictEffs then
			UIEffectManager.instance:stopEffect(self._exictEffs)

			self._exictEffs[key] = nil
		end
	end
end

function YearCardPay2022View:onClickInfo()
	PetbookController.instance:openPetinfoView(self.skinId)
end

function YearCardPay2022View:onClickSkill()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(self.skinId)

	if cfg then
		PetbookController.instance:previewBattle(cfg.raceId, self.skinId)
	end
end

return YearCardPay2022View
