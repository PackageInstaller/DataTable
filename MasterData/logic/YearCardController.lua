-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/controller/YearCardController.lua

module("logic.extensions.yearcard.controller.YearCardController", package.seeall)

local YearCardController = class("YearCardController", BaseController)
local json = require("cjson")

YearCardController.NewTypeActId = 8004
YearCardController.YearCard2024_AniKey = "yearcard2024_anikey"
YearCardController.YearCard2025_AniKey = "yearcard2025_anikey"
YearCardController.YearCard2026_AniKey = "yearcard2026_anikey"

function YearCardController:ctor()
	return
end

function YearCardController:onInit()
	self:onReset()
end

function YearCardController:onReset()
	self._rootIdx = 0
	self._leafIdx = 0
end

function YearCardController:getRootIdx()
	return self._rootIdx
end

function YearCardController:setRootIdx(idx)
	self._rootIdx = idx or 0
end

function YearCardController:getLeafIdx()
	return self._leafIdx
end

function YearCardController:setLeafIdx(idx)
	self._leafIdx = idx or 0
end

function YearCardController:isCanGet(activityId, cfg)
	if cfg then
		local startTimestamp = GameUtil.string2time(cfg.startTime)
		local curTimestamp = ServerTime.now()
		local endTimestamp = YearCardModel.instance:getEndTime(activityId)

		if startTimestamp <= curTimestamp and curTimestamp <= endTimestamp then
			return true
		else
			return false
		end
	else
		return false
	end
end

function YearCardController:gainWeeklyPrize(annuityId, handler)
	AnnuityAgent.instance:sendPM_AnnuityGainWeeklyPrizeReq(annuityId, function(msg)
		YearCardModel.instance:setHasGainWeeklyPrize(annuityId, true)
		GameUtil.callBack(handler)
		GlobalDispatcher:dispatch(GlobalNotify.UpdatePayShopRedDot)
		GlobalDispatcher:dispatch(GlobalNotify.AnnuityInfoChange)
	end)
end

function YearCardController:gainFixedPrize(annuityId, handler)
	return
end

function YearCardController:getUserAnnuityInfo(callback)
	AnnuityAgent.instance:sendPM_GetUserAnnuityInfoReq(function(msg)
		forcePrint("=====RoleDataRequestor:_loadYearCardInfo===back")
		YearCardModel.instance:setAnnuityInfo(msg.annuityInfo)
		GameUtil.callBack(callback, msg)
		GlobalDispatcher:dispatch(GlobalNotify.AnnuityInfoChange)
	end)
end

function YearCardController:getIfBuyAnnuity(callback)
	local annuityId = YearCardModel.instance:getCurAnnuityId()

	if annuityId and FuncOpenModel.instance:getFuncIsOpen(119) then
		if YearCardModel.instance:getIfGetAnnuityInfo(annuityId) then
			local data = YearCardModel.instance:getAnnuityInfo(annuityId)
			local torf = data and data.active

			GameUtil.callBack(callback, torf)
		else
			local function callback2(msg)
				local res = msg:HasField("annuityInfo")

				GameUtil.callBack(callback, res)
			end

			self:getUserAnnuityInfo(callback2)
			YearCardModel.instance:setIfGetAnnuityInfo(true)
		end
	else
		GameUtil.callBack(callback, false)
	end
end

function YearCardController:activateAnnuity(activityId, callback)
	AnnuityAgent.instance:sendPM_ActivateAnnuityReq(activityId, function(msg)
		FloatWordMgr.instance:show("年费卡购买成功，特权已生效")
		YearCardModel.instance:setCurAnnuityId(activityId)
		YearCardModel.instance:setActivateAnnuity(activityId)

		if msg:HasField("annuityInfo") then
			printInfo("test activateAnnuity")
			YearCardModel.instance:setSingleAnnuityInfo(msg.annuityInfo)
		end

		GlobalDispatcher:dispatch(GlobalNotify.AnnuityInfoChange)
		GameUtil.callBack(callback, msg)
	end)
end

function YearCardController:getCurMonthCfg(activityId)
	local curTimestamp = ServerTime.now()
	local cfgs = YearCardConfig.instance:getMonthRewardCfgs(activityId)

	if cfgs then
		local targetCfg
		local endTimestamp = YearCardModel.instance:getEndTime(activityId)

		for i, v in ipairs(cfgs) do
			local startTimestamp = GameUtil.string2time(v.startTime)

			if startTimestamp <= curTimestamp and curTimestamp <= endTimestamp and v.month >= 9 then
				targetCfg = v
			end
		end

		return targetCfg
	end

	return nil
end

function YearCardController:getNextMonthCfg(activityId, curMonthCfg)
	if curMonthCfg and curMonthCfg.month < 12 then
		local cfgs = YearCardConfig.instance:getMonthRewardCfgs(activityId)

		if cfgs then
			local nextMonth = curMonthCfg.month + 1

			for i, v in ipairs(cfgs) do
				if v.month == nextMonth then
					return v
				end
			end
		else
			return nil
		end
	else
		return nil
	end
end

function YearCardController:getPassedMonthCfgs(activityId, curMonthCfg)
	local cfgs = YearCardConfig.instance:getMonthRewardCfgs(activityId)

	if curMonthCfg then
		local resultCfgs = {}

		for i, v in ipairs(cfgs) do
			if v.prizeId < curMonthCfg.prizeId then
				table.insert(resultCfgs, v)
			end
		end

		return resultCfgs
	else
		return cfgs
	end
end

function YearCardController:_addCurMonthTab()
	if self._curMonthCfg then
		local tabItem = {}

		tabItem.index = self._index
		tabItem.isCurMonth = true
		tabItem.isShowView = true
		tabItem.isSelect = self._isSelect
		tabItem.textName = self._curMonthCfg.month .. "月可领"
		tabItem.viewName = ViewName.YearCardPerMonthView
		tabItem.cfg = self._curMonthCfg

		table.insert(self._tabList, tabItem)

		self._isSelect = false
		self._index = self._index + 1
	end
end

function YearCardController:_addNextMonthTab(activityId)
	local nextMonthCfg = self:getNextMonthCfg(activityId, self._curMonthCfg)

	if nextMonthCfg then
		local tabItem = {}

		tabItem.index = self._index
		tabItem.isCurMonth = false
		tabItem.isShowView = true
		tabItem.isSelect = self._isSelect
		tabItem.textName = nextMonthCfg.month .. "月可领"
		tabItem.viewName = ViewName.YearCardPerMonthView
		tabItem.cfg = nextMonthCfg
		tabItem.isNotice = true

		table.insert(self._tabList, tabItem)

		self._isSelect = false
		self._index = self._index + 1
	end
end

function YearCardController:_addBeYearTab()
	local tabItem = {}

	tabItem.index = self._index
	tabItem.isCurMonth = false
	tabItem.isShowView = true
	tabItem.isSelect = self._isSelect
	tabItem.textName = "成为年费"
	tabItem.viewName = ViewName.YearCardBeYearView
	tabItem.cfg = nil

	table.insert(self._tabList, tabItem)

	self._index = self._index + 1
	self._isSelect = false
end

function YearCardController:_addPassedMonthTab(activityId)
	local cfgs = self:getPassedMonthCfgs(activityId, self._curMonthCfg)

	if cfgs and #cfgs > 0 then
		for i, v in ipairs(cfgs) do
			local tabItem = {}

			tabItem.index = self._index
			self._index = self._index + 1
			tabItem.isCurMonth = false
			tabItem.isShowView = true
			tabItem.isSelect = false
			tabItem.textName = v.month == 5 and "5&6月可领" or v.month .. "月可领"
			tabItem.viewName = ViewName.YearCardPerMonthView
			tabItem.cfg = v

			table.insert(self._tabList, tabItem)
		end
	end
end

function YearCardController:getShowList(activityId)
	self._tabList = {}
	self._curMonthCfg = self:getCurMonthCfg(activityId)
	self._isSelect = true
	self._index = 1

	if YearCardModel.instance:isActiveAnnuity(activityId) then
		self:_addCurMonthTab()
		self:_addNextMonthTab(activityId)
		self:_addBeYearTab()
		self:_addPassedMonthTab(activityId)
	else
		self:_addBeYearTab()
		self:_addPassedMonthTab(activityId)
		self:_addCurMonthTab()
		self:_addNextMonthTab(activityId)
	end

	return self._tabList
end

function YearCardController:onClickWeekReward(activityId)
	if YearCardModel.instance:isActiveAnnuity(activityId) then
		if YearCardModel.instance:getHasGainWeeklyPrize(activityId) then
			FloatWordMgr.instance:show("本周已领取，下周再来吧")
		else
			self:gainWeeklyPrize(activityId)
		end
	else
		FloatWordMgr.instance:show("你还未激活该年费卡")
	end
end

function YearCardController:isFuncOpen(activityId)
	if not YearCardModel.instance:isActiveAnnuity(activityId) then
		return nil
	else
		local endTimestamp = YearCardModel.instance:getEndTime(activityId)

		return endTimestamp >= ServerTime.now()
	end
end

function YearCardController:onClikcMainUIHud()
	local res = self:_onClikcMainUIHudInNextYearCard()

	if res then
		return
	end

	local curActId = YearCardModel.instance:getCurActIdByServerTime()

	if curActId then
		local actCfg = PayShopConfig.instance:getAnnuityCfgById(curActId)
		local perheatDateCfg = self:getpreheatDateCfgById(curActId)

		if actCfg then
			if perheatDateCfg then
				UIStateManager.instance:push(perheatDateCfg.preheatview, perheatDateCfg.perheatId)

				return
			end

			UIStateManager.instance:push(actCfg.mainview)

			return
		end
	end

	UIStateManager.instance:push(ViewName.YearCardMainView)
end

function YearCardController:_initConstTime()
	self._currActId = YearCardConfig.instance:getCurrActId()
	self._nextActId = YearCardConfig.instance:getNextActId()

	local activityId = YearCardConfig.instance:getCurrActId()

	self._nextAnnuityStartTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.FirstCharge, self._nextActId)

	local perheatDateCfg = self:getpreheatDateCfgById(self._nextActId)

	if perheatDateCfg then
		self._nextAnnuityPerheatTime = GameUtil.string2time(perheatDateCfg.startTime)
		self._nextAnnuityBuyTime = GameUtil.string2time(perheatDateCfg.endTime)
	else
		self._nextAnnuityPerheatTime = 0
		self._nextAnnuityBuyTime = 0
	end
end

function YearCardController:_onClikcMainUIHudInNextYearCard()
	self:_initConstTime()

	if self._nextAnnuityPerheatTime <= 0 or self._nextAnnuityBuyTime <= 0 then
		return false
	end

	local nowTime = ServerTime.now()

	if nowTime >= self._nextAnnuityStartTime and nowTime < self._nextAnnuityPerheatTime then
		local actCfg = PayShopConfig.instance:getAnnuityCfgById(self._currActId)

		if actCfg then
			UIStateManager.instance:push(actCfg.mainview)

			return true
		end
	end

	if nowTime >= self._nextAnnuityPerheatTime and nowTime < self._nextAnnuityBuyTime then
		local perheatDateCfg = self:getpreheatDateCfgById(self._nextActId)

		if perheatDateCfg then
			UIStateManager.instance:push(perheatDateCfg.preheatview, perheatDateCfg.perheatId)

			return true
		end
	end

	if nowTime >= self._nextAnnuityBuyTime then
		local actCfg = PayShopConfig.instance:getAnnuityCfgById(self._nextActId)

		if actCfg then
			UIStateManager.instance:push(actCfg.mainview)

			return true
		end
	end
end

function YearCardController:getTopName()
	self:_initConstTime()

	local nowTime = ServerTime.now()

	if nowTime >= self._nextAnnuityStartTime and nowTime < self._nextAnnuityPerheatTime then
		return YearCardConfig.instance:getYearcardCommonValue("LastWeekTopName")
	end

	if nowTime >= self._nextAnnuityPerheatTime and nowTime < self._nextAnnuityBuyTime then
		return YearCardConfig.instance:getYearcardCommonValue("NextActPreHeatTopName")
	end

	if nowTime >= self._nextAnnuityBuyTime then
		return YearCardConfig.instance:getYearcardCommonValue("NextActActiveTopName")
	end

	return nil
end

function YearCardController:payGiftId(Id, giftId)
	local isAble, isDateMatch, isBuyTimeLimit, isActive, isInPreoderTime, isUnlockCondition, isPreoderLimit = YearCardModel.instance:isAbleToBuyGiftId(Id, giftId)

	if isAble then
		if Id < YearCardController.NewTypeActId then
			local giftCfg = YearCardConfig.instance:getGiftCfg(Id, giftId)
			local para = {
				actId = Id
			}

			json.encode(para)
			PayController.instance:pay((GameUtil.checkIsInTimePeriod(giftCfg.discountStartTime, giftCfg.discountEndTime) or nil) and giftCfg.discountPayGoodsId, GameEnum.PaySubGoodsType.Pay_YearCardGift, giftId, json.encode(para))
		else
			local giftCfg = YearCardConfig.instance:getNewGiftCfg(Id, giftId)
			local goodsId = giftCfg.payGoodsId
			local para = {
				actId = Id
			}

			json.encode(para)
			PayController.instance:pay(goodsId, GameEnum.PaySubGoodsType.Pay_YearCardGiftNew, giftId, json.encode(para))
		end
	else
		if not isDateMatch then
			FloatWordMgr.instance:show(lang("1月1日5点后开启购买"))

			return
		end

		if isBuyTimeLimit then
			FloatWordMgr.instance:show(lang("次数已达到购买上限"))

			return
		end

		if not isUnlockCondition then
			FloatWordMgr.instance:show("购买条件不满足")

			return
		end
	end
end

function YearCardController:sendRankReq(actId, space)
	AnnuityAgent.instance:sendPM_AnnuityGetRankInfoReq(actId, space)
end

function YearCardController:onGetRankInfo(msg)
	YearCardModel.instance:onGetRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.AnnuityInfoChange)
end

function YearCardController:gainForwardPayPrize(actId)
	AnnuityAgent.instance:sendPM_AnnuityGainForwardPayPrizeReq(actId)
end

function YearCardController:gainSpaceProgressPrize(actId, prizeId)
	AnnuityAgent.instance:sendPM_AnnuityGainSpaceProgressPrizeReq(actId, prizeId)
end

function YearCardController:handleGainSpaceProgressPrize(msg)
	YearCardModel.instance:onGainSpaceProgressPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.AnnuityInfoChange)
end

function YearCardController:isGainSpaceProgress(actId, prizeId)
	return YearCardModel.instance:isGainSpaceProgress(actId, prizeId)
end

function YearCardController:isCanGainSpaceProgress(actId, prizeId)
	if self:isGainSpaceProgress(actId, prizeId) then
		return false
	end

	local info = YearCardModel.instance:getAnnuityInfo(actId)

	if not info then
		return false
	end

	local cfg = YearCardConfig.instance:getSpaceProgressPrizeCfg(actId, prizeId)

	return info.activeCount >= cfg.progress
end

function YearCardController:isInYearCardpreorderTime()
	local activityId = 8005
	local cfgs = YearCardConfig.instance:getNewGiftCfgs(activityId)
	local appointmentCfg

	for i, v in ipairs(cfgs) do
		if not string.nilorempty(v.preorderStartTime) then
			appointmentCfg = v

			break
		end
	end

	if not appointmentCfg then
		return false
	end

	local endTime = GameUtil.string2time(appointmentCfg.preorderEndTime)

	return endTime > ServerTime.now()
end

function YearCardController:payAppointment(activityId)
	local info = YearCardModel.instance:getAnnuityInfo(activityId)

	if not info then
		return
	end

	local cfgs = YearCardConfig.instance:getNewGiftCfgs(activityId)
	local appointmentCfg

	for i, v in ipairs(cfgs) do
		if not string.nilorempty(v.preorderStartTime) then
			appointmentCfg = v

			break
		end
	end

	if appointmentCfg then
		local isAbleToBuy, isDateMatch, isBuyTimeLimit, isActive, isInPreoderTime, isUnlockCondition, isPreoderLimit = YearCardModel.instance:isAbleToBuyGiftId(activityId, appointmentCfg.giftId)

		if isActive then
			FloatWordMgr.instance:show("年费已激活")

			return
		end

		if isInPreoderTime and isPreoderLimit then
			FloatWordMgr.instance:show("已成功预购，无需重复参与")

			return
		end

		if not isUnlockCondition then
			FloatWordMgr.instance:show("购买礼包条件不足")

			return
		end

		if isBuyTimeLimit then
			FloatWordMgr.instance:show("购买次数不足")

			return
		end

		if not isInPreoderTime and not isDateMatch then
			FloatWordMgr.instance:show("未到购买时间")

			return
		end

		local goodsId = appointmentCfg.payGoodsId
		local para = {
			actId = activityId
		}

		PayController.instance:pay(goodsId, GameEnum.PaySubGoodsType.Pay_YearCardGiftNew, appointmentCfg.giftId, json.encode(para))
	end
end

function YearCardController:getpreheatDateCfgById(activityId)
	local dateCfgs = YearCardConfig.instance:getPreheatCfgs(activityId)

	if dateCfgs then
		for _, v in pairs(dateCfgs) do
			if GameUtil.checkIsInTimePeriod(v.startTime, v.endTime) then
				return v
			end
		end
	end
end

function YearCardController:isOverLastYearCard()
	self:_initConstTime()

	if ServerTime.now() >= self._nextAnnuityPerheatTime then
		return true
	end
end

YearCardController.instance = YearCardController.New()

return YearCardController
