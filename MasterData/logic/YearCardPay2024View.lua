-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2024/main/YearCardPay2024View.lua

module("logic.extensions.yearcard.view.yearcard2024.main.YearCardPay2024View", package.seeall)

local YearCardPay2024View = class("YearCardPay2024View", YearCardPay2023View)
local json = require("cjson")

function YearCardPay2024View:buildUI()
	YearCardPay2024View.super.buildUI(self)

	self._itemGo = self:getGo("appointment/item")
	self._txtDesc = self:getTxt("appointment/txtDesc")
	self._appointmentGo = self:getGo("appointment")
	self._appointmentMarkGo = self:getGo("appointment/mark")
	self._petCon2Raw = self:getGo("bg/petCon2"):GetComponent(typeof(UnityEngine.UI.RawImage))
	self._petCon1_1Raw = self:getGo("bg/petCon1_1"):GetComponent(typeof(UnityEngine.UI.RawImage))
	self._petCon1_2Raw = self:getGo("bg/petCon1_1/petCon1_2"):GetComponent(typeof(UnityEngine.UI.RawImage))
	self._leftGiftId = 4
	self._rightGiftId = 6
	self._roleList = {
		{
			skinId = 18001,
			rawImgs = {
				self._petCon1_1Raw,
				self._petCon1_2Raw
			}
		},
		[0] = {
			skinId = 14022,
			rawImgs = {
				self._petCon2Raw
			}
		}
	}
	self.skinId = 14022
	self._yearCardChangeRole = YearCardChangeRole.New()

	self._yearCardChangeRole:setData(self._roleList)
	self._yearCardChangeRole:setTxtName(self._txtName)
	self._yearCardChangeRole:setView(self)
	self:_setBtnClickInterval()
end

function YearCardPay2024View:onExit()
	YearCardPay2024View.super.onExit(self)
	self._yearCardChangeRole:onExit()
end

function YearCardPay2024View:onEnter()
	self:_refreshViewByCfg()
	self:_refreshViewByInfo()
	GlobalDispatcher:addListener(GlobalNotify.AnnuityInfoChange, self._refreshViewByInfo, self)
	MaterialMgr.setCellByCfg("4:90425:1", self._showItem1)
	MaterialMgr.setCellByCfg("1004:1336:1", self._showItem2)
	MaterialMgr.setCellByCfg("1004:1335:1", self._showItem3)

	local effPath = "20231222/nianfei24nian/fx_ui_aojiunianfei_fw.prefab"

	self:_createEff(effPath, self.mainGO, "mainEff", true)
	self:_setAppointment()
	self._yearCardChangeRole:onEnter()
	self:_playAni()
end

function YearCardPay2024View:_getGiftCfg(giftId)
	return YearCardConfig.instance:getNewGiftCfg(self._curActId, giftId)
end

function YearCardPay2024View:_getTotalGiftCfg()
	return YearCardConfig.instance:getNewTotalGiftCfg(self._curActId)
end

function YearCardPay2024View:_onClick2022()
	UIStateManager.instance:push(ViewName.YearCardMain2023View)
end

function YearCardPay2024View:_setAppointment()
	local cfgs = YearCardConfig.instance:getNewGiftCfgs(self._curActId)
	local appointmentCfg

	for i, v in ipairs(cfgs) do
		if not string.nilorempty(v.preorderStartTime) then
			appointmentCfg = v

			break
		end
	end

	local isInTime = false

	if appointmentCfg then
		isInTime = GameUtil.checkIsInTimePeriod(appointmentCfg.preorderStartTime, appointmentCfg.preorderEndTime)
	end

	goutil.setActive(self._appointmentGo, isInTime)

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

function YearCardPay2024View:_onClickInstallment()
	local isAbleToBuy, isDateMatch, isButTimeLimit, isActive = YearCardModel.instance:isAbleToBuyGiftId(self._curActId, 1)

	if isActive then
		FloatWordMgr.instance:show(lang("已激活该年费"))

		return
	end

	if not isDateMatch then
		FloatWordMgr.instance:show(lang("分期付款功能将于2024年1月1号5点后开放，敬请期待"))

		return
	end

	UIStateManager.instance:push(ViewName.YearCardInstallment2024View)
end

function YearCardPay2024View:_setPay198Text()
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

function YearCardPay2024View:_getLastAnnuityId()
	return 8003
end

function YearCardPay2024View:_onClickShowAll()
	UIStateManager.instance:push(ViewName.YearCardPoster2024View, 2)
end

function YearCardPay2024View:_onClickGetAdvancePrize()
	if YearCardModel.instance:isAbleToGetForwardPayPrize(self._curActId) then
		YearCardController.instance:gainForwardPayPrize(self._curActId)
	else
		UIStateManager.instance:push(ViewName.YearCardPoster2024View, 1)
	end
end

function YearCardPay2024View:_getGiftProgressGain(giftId)
	local cfg = YearCardConfig.instance:getNewGiftCfg(self._curActId, giftId)

	return cfg.progressGain
end

function YearCardPay2024View:_onClickPay(giftId)
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

function YearCardPay2024View:_setMarkState()
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

function YearCardPay2024View:_setBtn2022State()
	local lastActId = self:_getLastAnnuityId()
	local endTime = YearCardModel.instance:getEndTime(lastActId)
	local show = endTime > ServerTime.now()

	goutil.setActive(self._btn2022, show)
end

function YearCardPay2024View:_onClickSkill()
	UIStateManager.instance:push(ViewName.PetcollegeView, 41)
end

function YearCardPay2024View:_playAni()
	local isPlay = GameUtil.getUserData(YearCardController.YearCard2024_AniKey)

	if isPlay then
		return
	end

	GameUtil.saveUserData(YearCardController.YearCard2024_AniKey, true)

	local animConfig = {
		animName = "fanerweisi_dengchang",
		animFinishCallback = self._aniFinish,
		callbackTarget = self
	}

	ViewMgr.instance:open(ViewName.AnimationPlaying, animConfig)
end

function YearCardPay2024View:_aniFinish()
	local animConfig = {
		animName = "yuanchushenglong_dengchang"
	}

	ViewMgr.instance:open(ViewName.AnimationPlaying, animConfig)
end

function YearCardPay2024View:_setBtnClickInterval()
	local time = 0.3
	local btnPay198 = self:getBtn("btnPay198")
	local btnPay328 = self:getBtn("btnPay328")

	btnPay198:SetClickInterval(time)
	btnPay328:SetClickInterval(time)
end

return YearCardPay2024View
