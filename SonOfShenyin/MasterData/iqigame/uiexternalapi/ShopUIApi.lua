-- chunkname: @IQIGame\\UIExternalApi\\ShopUIApi.lua

ShopUIApi = BaseLangApi:Extend()

function ShopUIApi:GetTapSoulStoneDes()
	return self:GetCfgText(1400012)
end

function ShopUIApi:GetTapGiftBagDes()
	return self:GetCfgText(1400013)
end

function ShopUIApi:GetTapResourceDes()
	return self:GetCfgText(1400014)
end

function ShopUIApi:GetTapTokenDes()
	return self:GetCfgText(1400015)
end

function ShopUIApi:GetFreeRefreshDes()
	return self:GetCfgText(1400023)
end

function ShopUIApi:GetTipsRecyclingRulesDes()
	return self:GetCfgText(1400003)
end

function ShopUIApi:GetTipsRecyclingDebris()
	return self:GetCfgText(1400029)
end

function ShopUIApi:GetRuleQuality()
	return self:GetCfgText(1400030)
end

function ShopUIApi:GetTapSoulStoneDes2()
	return self:GetCfgText(1400034)
end

function ShopUIApi:GetTipsRecyclingDebrisDes()
	return self:GetCfgText(1400035)
end

function ShopUIApi:GetRecyclingRuleExchange()
	return self:GetCfgText(1400036)
end

function ShopUIApi:GetRecyclingRuleCanel()
	return self:GetCfgText(3060003)
end

function ShopUIApi:GetTaptokentapLast()
	return self:GetCfgText(1400001)
end

function ShopUIApi:GetTaptokentapNext()
	return self:GetCfgText(1400002)
end

function ShopUIApi:GetSkillQuality()
	return self:GetCfgText(1400039)
end

function ShopUIApi:FirstRechargeDouble()
	return self:GetCfgText(1400017)
end

function ShopUIApi:EndAfterDay(num)
	return string.format(ShopUIApi:GetCfgText(1400022), num)
end

function ShopUIApi:GetTipsTheRefresh()
	return self:GetCfgText(1400023)
end

function ShopUIApi:GetFreeRefreshTimes()
	return string.format(self:GetCfgText(1400024), 0, ShopModule.curShopDataData.shopCfgData.FreeFlushed)
end

function ShopUIApi:GetResideRefrehTimes()
	return string.format(ShopUIApi:GetCfgText(1400025), ShopModule.curShopDataData.shopConfig.flushTime, ShopModule.curShopDataData.shopCfgData.FlushedTime)
end

function ShopUIApi:DayFixationResetRefreshTimes()
	return string.format(self:GetCfgText(1400026), ShopModule.limitCyclicTime)
end

function ShopUIApi:AfterDayRefresh(DayTime)
	return string.format(self:GetCfgText(1400027), DayTime)
end

function ShopUIApi:GetRoleForTimes()
	return self:GetCfgText(1400031)
end

function ShopUIApi:GetRoleForTimesToTimes()
	return self:GetCfgText(1400032)
end

function ShopUIApi:GetRoleForTimesAddOnceTimes()
	return self:GetCfgText(1400033)
end

function ShopUIApi:GetSkillForTimes()
	return self:GetCfgText(1400037)
end

function ShopUIApi:GetSkillAfterForTimes()
	return self:GetCfgText(1400038)
end

function ShopUIApi:GetShopBuyIconPath(id)
	return UIGlobalApi.IconPath .. CfgItemTable[id].SmallIcon
end

function ShopUIApi:GetBottomFrameImagePath(quality)
	return string.format(self:GetResUrl(4002), quality)
end

function ShopUIApi:GetShopRoleHeadImagePath(sex)
	return string.format(self:GetResUrl(4001), sex)
end

function ShopUIApi:GetDiscountText(offset, isOverseas)
	local Value = string.format("%.0f", offset)

	if isOverseas == true then
		Value = "-" .. 100 - Value .. "%"
	else
		Value = Value .. "%"
	end

	return Value
end

function ShopUIApi:ShowShopNum(num)
	return string.format(self:GetCfgText(1400040), num)
end

function ShopUIApi:PurchaseLimitation(curNum, limitNum)
	return string.format(ColorCfg.ShopUI.PriceWhite, string.format(self:GetCfgText(1400021), limitNum - curNum, limitNum))
end

function ShopUIApi:PurchaseLimitation1(curNum, limitNum)
	return string.format(ColorCfg.ShopUI.PriceWhite, string.format(self:GetCfgText(1400021), limitNum - curNum, limitNum))
end

function ShopUIApi:GetZeroLimitation(curNum, limitNum)
	return string.format(ColorCfg.ShopUI.LimitBuyTextZero, string.format(self:GetCfgText(1400021), curNum, limitNum))
end

function ShopUIApi:ActiveStartTime(startMonth, startDay, endMmonth, endDay)
	return string.format(self:GetCfgText(1400043), startMonth, startDay, endMmonth, endDay)
end

function ShopUIApi:GetTipsTheResidue(num)
	return string.format(self:GetCfgText(1400028), num)
end

function ShopUIApi:OneDayDes(num)
	return string.format(self:GetCfgText(1400020), num)
end

function ShopUIApi:ExtraMultipleX(num)
	return string.format(self:GetCfgText(1400041), num)
end

function ShopUIApi:ExtraResidueTimes(num)
	return string.format(self:GetCfgText(1400019), num)
end

function ShopUIApi:ExtraGiveSoulStone(num)
	return string.format(self:GetCfgText(1400018), num)
end

function ShopUIApi:GetSoulNumText(num)
	return "魂石 X " .. tostring(num)
end

function ShopUIApi:CommonIndex(num)
	return string.format(self:GetCfgText(1400042), num)
end

function ShopUIApi:GetTokenRecycleGetRoleFirst(times)
	return string.format(ShopUIApi:GetRoleForTimes(), times)
end

function ShopUIApi:GetTokenRecycleGetRoleContinuous(First, NTimes)
	return string.format(ShopUIApi:GetRoleForTimesToTimes(), First, NTimes)
end

function ShopUIApi:GetTokenRecycleGetRoleTimesAdd(NTimes)
	return string.format(ShopUIApi:GetRoleForTimesAddOnceTimes(), NTimes)
end

function ShopUIApi:GetTokenRecycleGetSkillTimes(NTimes)
	return string.format(ShopUIApi:GetSkillForTimes(), NTimes)
end

function ShopUIApi:GetTokenRecycleGetSkillAfterTimes(NTimes)
	return string.format(ShopUIApi:GetSkillAfterForTimes(), NTimes)
end

function ShopUIApi:GetBuyShopItemNoEnoughTips()
	NoticeModule.ShowNotice(20004)
end

function ShopUIApi:TipNoBuyNum()
	NoticeModule.ShowNoticeByType(Constant.NoticeType.FloatTips, self:GetCfgText(1400057))
end

function ShopUIApi:GetCommodityPriceText(type, str)
	if type == 1 then
		return string.format(ColorCfg.ShopUI.PriceWhite, str)
	else
		return string.format(ColorCfg.ShopUI.PriceBlack, str)
	end
end

function ShopUIApi:GetRecommendTagChooseText()
	return string.format(ColorCfg.ShopUI.firstTagChoose, self:GetCfgText(1400058))
end

function ShopUIApi:GetRecommendTagNonChooseText()
	return string.format(ColorCfg.ShopUI.firstTagNonChoose, self:GetCfgText(1400058))
end

function ShopUIApi:GetRecommendText()
	return self:GetCfgText(1400051)
end

function ShopUIApi:GetFreeText()
	return self:GetCfgText(1400052)
end

function ShopUIApi:GetMonthCardText()
	return self:GetCfgText(1400053)
end

function ShopUIApi:GetMonthCardResetTimeText(str)
	return self:GetCfgText(1400054) .. str .. self:GetCfgText(1400055)
end

function ShopUIApi:GetTimeDayText(day, hour, minute, second)
	if day > 0 then
		return day .. self:GetCfgText(1400055) .. hour .. self:GetCfgText(1400056)
	else
		return hour .. ":" .. minute .. ":" .. second
	end
end

function ShopUIApi:GetDescribeDayText()
	return self:GetCfgText(1400044)
end

function ShopUIApi:GetDescribeGetText()
	return self:GetCfgText(1400045)
end

function ShopUIApi:GetMonthCardRuleText()
	return CfgHelpTipsTable[1010000].Text
end

function ShopUIApi:GetResourceItemQualityPath(qualityNum)
	local cfg = CfgResourceTable

	return string.format(cfg[1100032].Url, qualityNum)
end

function ShopUIApi:TextLimitDay()
	return self:GetCfgText(1400062)
end

function ShopUIApi:TextLimitWeekly()
	return self:GetCfgText(1400063)
end

function ShopUIApi:TextLimitMonth()
	return self:GetCfgText(1400064)
end

function ShopUIApi:TextLimitNormal()
	return self:GetCfgText(1400065)
end

function ShopUIApi:GetCommodityTypeImg(type)
	return string.format(self:GetResUrl(4003), type)
end

function ShopUIApi:GetDiscountPercentText(commodityCfg)
	local discount = 0
	local isOverseas = CfgDiscreteDataTable[10002].Data[1] == 0

	if not isOverseas then
		discount = commodityCfg.DiscountRate
	else
		discount = commodityCfg.DiscountRate
	end

	return ShopUIApi:GetDiscountText(discount, isOverseas)
end
