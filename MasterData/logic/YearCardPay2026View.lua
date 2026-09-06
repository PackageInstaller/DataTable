-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/main/YearCardPay2026View.lua

module("logic.extensions.yearcard.view.yearcard2026.main.YearCardPay2026View", package.seeall)

local YearCardPay2026View = class("YearCardPay2026View", YearCardPay2023View)
local json = require("cjson")

function YearCardPay2026View:buildUI()
	YearCardPay2026View.super.buildUI(self)

	self._itemGo = self:getGo("appointment/item")
	self._txtDesc = self:getTxt("appointment/txtDesc")
	self._appointmentGo = self:getGo("appointment")
	self._appointmentGoBg = self:getGo("appointmentbg")
	self._appointmentMarkGo = self:getGo("appointment/mark")
	self._leftGiftId = 4
	self._rightGiftId = 6
	self.skinId = YearCardConfig.instance:getYearcardCommonValue("RaceId_2026", true)

	self:_setBtnClickInterval()

	self._btnBuy = self:getBtn("btnBuy")
	self._tablecellGo = self:getGo("rewardnew/tablecell")
	self._tableviewGo = self:getGo("rewardnew/tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnGainPrize = self:getBtn("btnGainPrize")
end

function YearCardPay2026View:bindEvents()
	YearCardPay2026View.super.bindEvents(self)
	self._btnBuy:AddClickListener(self._onClickbtnBuy, self)
	self._btnGainPrize:AddClickListener(self._onClickbtnGainPrize, self)
end

function YearCardPay2026View:unbindEvents()
	YearCardPay2026View.super.unbindEvents(self)
	self._btnBuy:RemoveClickListener()
	self._btnGainPrize:RemoveClickListener()
end

function YearCardPay2026View:onExit()
	YearCardPay2026View.super.onExit(self)
	self._scrollerList:dispose()
end

function YearCardPay2026View:onEnter()
	self:_refreshViewByCfg()
	self:_refreshViewByInfo()
	GlobalDispatcher:addListener(GlobalNotify.AnnuityInfoChange, self._refreshViewByInfo, self)

	local matStr = YearCardConfig.instance:getYearcardCommonValue("YearCard2026")
	local list = string.split(matStr, "#")

	MaterialMgr.setCellByCfg(list[1], self._showItem1)
	MaterialMgr.setCellByCfg(list[2], self._showItem2)
	MaterialMgr.setCellByCfg(list[3], self._showItem3)

	local effPath = "20251219/26nianfei/fx_ui_nianfeijiemian_fw.prefab"

	self:_createEff(effPath, self.mainGO, "mainEff", true)
	self:_setAppointment()
	self:_playAni()
end

function YearCardPay2026View:_getGiftCfg(giftId)
	return YearCardConfig.instance:getNewGiftCfg(self._curActId, giftId)
end

function YearCardPay2026View:_getTotalGiftCfg()
	return YearCardConfig.instance:getNewTotalGiftCfg(self._curActId)
end

function YearCardPay2026View:_onClick2022()
	UIStateManager.instance:push(ViewName.YearCardMain2025View)
end

function YearCardPay2026View:_setAppointment()
	local cfgs = YearCardConfig.instance:getNewGiftCfgs(self._curActId)
	local appointmentCfg

	for i, v in ipairs(cfgs) do
		if not string.nilorempty(v.preorderStartTime) then
			appointmentCfg = v

			break
		end
	end

	local isInTime = false

	goutil.setActive(self._appointmentGo, isInTime)
	goutil.setActive(self._appointmentGoBg, isInTime)

	if isInTime then
		local isBuy = false

		goutil.setActive(self._appointmentMarkGo, isBuy)
	end

	if isInTime and appointmentCfg then
		local startTime = GameUtil.string2time(appointmentCfg.preorderStartTime)
		local endTime = GameUtil.string2time(appointmentCfg.preorderEndTime)
		local now = ServerTime.now()

		if now < startTime then
			local startDate = GameUtil.string2date(appointmentCfg.preorderStartTime)

			self._txtDesc.text = string.format("%s月%s日%s点\n可预约", startDate.month, startDate.day, startDate.hour)
		else
			local endDate = GameUtil.string2date(appointmentCfg.preorderEndTime)

			self._txtDesc.text = string.format("%s月%s日%s点前\n预约可得", endDate.month, endDate.day, endDate.hour + 1)
		end

		local arr = string.split(appointmentCfg.preorderPrize, "#")

		MaterialMgr.resetAll(self._itemGo)

		local proxy = MaterialMgr.setCellByCfg(arr[1], self._itemGo)
	end
end

function YearCardPay2026View:_onClickInstallment()
	local isAbleToBuy, isDateMatch, isButTimeLimit, isActive = YearCardModel.instance:isAbleToBuyGiftId(self._curActId, 1)

	if isActive then
		FloatWordMgr.instance:show(lang("已激活该年费"))

		return
	end

	if not isDateMatch then
		FloatWordMgr.instance:show(lang("分期付款功能将于2026年1月1号5点后开放，敬请期待"))

		return
	end

	UIStateManager.instance:push(ViewName.YearCardInstallment2026View)
end

function YearCardPay2026View:_setPay198Text()
	self._isprebuy = false

	local giftCfg
	local cfgs = YearCardConfig.instance:getNewGiftCfgs(self._curActId)
	local appointmentCfg

	for i, v in ipairs(cfgs) do
		if not string.nilorempty(v.preorderStartTime) then
			appointmentCfg = v

			break
		end
	end

	if appointmentCfg then
		local info = YearCardModel.instance:getAnnuityInfo(self._curActId)

		if not info.preorderBuyTimes[appointmentCfg.giftId] then
			if info.preorderBuyTimes[appointmentCfg.giftId] > 0 then
				self._isprebuy = true
				giftCfg = self:_getGiftCfg(5)
			else
				giftCfg = self:_getGiftCfg(4)
			end
		end
	end

	if giftCfg then
		self._txtPay198.text = langPara("%s元", PayConfig.instance:getPayMoneyYuan(giftCfg.payGoodsId))
	end
end

function YearCardPay2026View:_getLastAnnuityId()
	return YearCardConfig.instance:getCurrActId()
end

function YearCardPay2026View:_onClickShowAll()
	UIStateManager.instance:push(ViewName.YearCardPoster2026View, 3)
end

function YearCardPay2026View:_onClickGetAdvancePrize()
	if YearCardModel.instance:isAbleToGetForwardPayPrize(self._curActId) then
		YearCardController.instance:gainForwardPayPrize(self._curActId)
	else
		UIStateManager.instance:push(ViewName.YearCardPoster2026View, 1)
	end
end

function YearCardPay2026View:_getGiftProgressGain(giftId)
	local cfg = YearCardConfig.instance:getNewGiftCfg(self._curActId, giftId)

	return cfg.progressGain
end

function YearCardPay2026View:_onClickPay(giftId)
	local giftCfg = self:_getGiftCfg(giftId)

	if giftCfg.isActiveAnnuityCanBuy then
		local info = YearCardModel.instance:getAnnuityInfo(self._curActId)

		if not info.active then
			FloatWordMgr.instance:show("激活年费后即可购买年费极品养成")

			return
		end

		local giftCfg = YearCardConfig.instance:getNewGiftCfg(self._curActId, giftId)
		local goodsId = giftCfg.payGoodsId
		local para = {
			actId = self._curActId
		}

		json.encode(para)
		PayController.instance:pay(goodsId, GameEnum.PaySubGoodsType.Pay_YearCardGiftNew, giftId, json.encode(para))

		return
	end

	if giftId == 4 and self._isprebuy then
		giftId = 5
	end

	if not giftCfg.isActiveAnnuityCanBuy and YearCardModel.instance:isActiveAnnuity(self._curActId) then
		FloatWordMgr.instance:show(lang("已激活该年费"))

		return
	else
		local isAble, isDateMatch = YearCardModel.instance:isAbleToBuyGiftId(self._curActId, giftId)

		if not isAble and not isDateMatch then
			local date = GameUtil.string2date(giftCfg.giftStartTime)

			FloatWordMgr.instance:show(lang(string.format("%s月%s日%s点后开启购买", date.month, date.day, date.hour)))

			return
		end

		if giftId == 6 then
			YearCardController.instance:payGiftId(self._curActId, giftId)
		else
			local isInstallment = false

			for id, totalBuyTime in pairs(self._actInfo.annuityGifts) do
				local gcfg = self:_getGiftCfg(id)

				if gcfg.isInstallment then
					if not self._actInfo.preorderBuyTimes[id] then
						if totalBuyTime - self._actInfo.preorderBuyTimes[id] > 0 then
							isInstallment = true

							break
						end
					end
				end
			end

			if isInstallment then
				local curTryPayMoney = PayConfig.instance:getPayMoneyYuan(giftCfg.payGoodsId)
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

function YearCardPay2026View:_setMarkState()
	local isActive = YearCardModel.instance:isActiveAnnuity(self._curActId)
	local buy128 = (self._actInfo.annuityGifts[6] or 0) > 0

	goutil.setActive(self._markInstallment, isActive)
	goutil.setActive(self._mark198, isActive and self._actInfo.money >= self:_getGiftProgressGain(self._leftGiftId))
	goutil.setActive(self._mark328, isActive and buy128)
	GameUtil.SetGray(self._btnInstallment, isActive)
	GameUtil.SetGray(self._btnPay198, isActive)
	GameUtil.SetGray(self._btnPay328, not isActive or buy128)
	goutil.setActive(self._btnPay328, not buy128)
	goutil.setActive(self._btnPay198, not isActive or self._actInfo.activeProgress == self:_getGiftProgressGain(self._leftGiftId))
end

function YearCardPay2026View:_setBtn2022State()
	local lastActId = self:_getLastAnnuityId()
	local endTime = YearCardModel.instance:getEndTime(lastActId)
	local show = endTime > ServerTime.now()

	goutil.setActive(self._btn2022, show)
end

function YearCardPay2026View:_onClickSkill()
	UIStateManager.instance:push(ViewName.PetcollegeView, 60)
end

function YearCardPay2026View:_playAni()
	local isPlay = GameUtil.getUserData(YearCardController.YearCard2026_AniKey)

	if isPlay then
		return
	end

	GameUtil.saveUserData(YearCardController.YearCard2026_AniKey, true)

	local animConfig = {
		animName = "heichuang_dengchang",
		callbackTarget = self
	}

	ViewMgr.instance:open(ViewName.AnimationPlaying, animConfig)
end

function YearCardPay2026View:_setBtnClickInterval()
	local time = 0.3
	local btnPay198 = self:getBtn("btnPay198")
	local btnPay328 = self:getBtn("btnPay328")

	btnPay198:SetClickInterval(time)
	btnPay328:SetClickInterval(time)
end

function YearCardPay2026View:_onClickbtnBuy()
	local viewName = ViewName.YearCardMain2026View
	local presentor = ViewMgr.instance:getViewPresentor(viewName)
	local view = self:_getViewByViewName(presentor, viewName)

	if view then
		view:_onClickCell(8)
	end
end

function YearCardPay2026View:_getViewByViewName(presentor, viewName)
	if not presentor or not presentor._views or not viewName then
		return
	end

	for i = 1, #presentor._views do
		if presentor._views[i]._viewPresentor.viewName == viewName then
			return presentor._views[i]
		end
	end
end

function YearCardPay2026View:_refreshViewByCfg()
	self._curActId = YearCardConfig.instance:getNextActId()
	self._curTotalGiftCfg = self:_getTotalGiftCfg()
	self._progressCfgs = YearCardConfig.instance:getProgressCfg(self._curActId)

	MaterialMgr.setCell(MatType.Rare, self.skinId, self._rare)

	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(self.skinId)

	self._txtName.text = skinCfg.name

	self:_updateRewards(self._progressCfgs)

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

function YearCardPay2026View:_refreshViewByInfo()
	YearCardPay2026View.super._refreshViewByInfo(self)
	self:_checkCanGainPrize(self._progressCfgs)
end

function YearCardPay2026View:_updateRewards(progressCfgs)
	local prizeList = {}

	for i, v in ipairs(progressCfgs) do
		local arr = string.split(v.prize, "#")

		table.insertto(prizeList, arr)
	end

	self._scrollerList:reloadData(prizeList)
end

function YearCardPay2026View:_updateCell(view, cell, data, tag)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function YearCardPay2026View:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function YearCardPay2026View:_onClickbtnGainPrize()
	if self._progressCfgs then
		for i, v in ipairs(self._progressCfgs) do
			local canGain = YearCardModel.instance:getIsAbleToGetProgressPrizeId(self._curActId, i)

			AnnuityAgent.instance:sendPM_AnnuityGainProgressPrizeReq(self._curActId, i)
			YearCardModel.instance:setProgressPrizeId(self._curActId, i)
		end
	end
end

function YearCardPay2026View:_checkCanGainPrize(progressCfgs)
	local canGain = true

	for i, v in ipairs(progressCfgs) do
		canGain = YearCardModel.instance:getIsAbleToGetProgressPrizeId(self._curActId, i)

		if not canGain then
			break
		end
	end

	goutil.setActive(self._btnGainPrize.gameObject, canGain)
end

function YearCardPay2026View:_setProgressState()
	self:_checkCanGainPrize(self._progressCfgs)
end

return YearCardPay2026View
