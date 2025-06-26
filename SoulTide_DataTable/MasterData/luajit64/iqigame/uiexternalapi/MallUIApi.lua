-- chunkname: @IQIGame\\UIExternalApi\\MallUIApi.lua

MallUIApi = BaseLangApi:Extend()

function MallUIApi:Init()
	self:RegisterApi("tabTopIcon", self.GetTabTopIcon)
	self:RegisterApi("tabTopName", self.GetTabTopName)
	self:RegisterApi("tabLeftName", self.GetTabLeftName)
	self:RegisterApi("goTitle", self.GetTitle)
	self:RegisterApi("goCondition", self.GetCondition)
	self:RegisterApi("goItemName", self.GetItemName)
	self:RegisterApi("goQualityLinePath", self.GetQualityLinePath)
	self:RegisterApi("goQualityNumPath", self.GetQualityNumPath)
	self:RegisterApi("goSellNum", self.GetSellNum)
	self:RegisterApi("goDiscount", self.GetDiscount)
	self:RegisterApi("goMoneyCost", self.GetMoneyCost)
	self:RegisterApi("goTag", self.GetTag)
	self:RegisterApi("goBuyTimes", self.GetBuyTimes)
	self:RegisterApi("goTime", self.GetTime)
	self:RegisterApi("goClickTip", self.GetClickTip)
	self:RegisterApi("btnRewardTxt", self.GetBtnRewardTxt)
	self:RegisterApi("btnRechargeTxt", self.GetBtnRechargeTxt)
	self:RegisterApi("btnGashTxt", self.GetBtnGashTxt)
	self:RegisterApi("rechargeDesc", self.GetRechargeDesc)
	self:RegisterApi("tabResidueTime", self.GetTabResidueTime)
	self:RegisterApi("TimeCDText", self.GetTimeCDText)
	self:RegisterApi("GuildTip", self.GetGuildTip)
	self:RegisterApi("rechargeCellName", self.GetRechargedCellName)
	self:RegisterApi("rechargeCellDesc", self.GetRechargeCellDesc)
	self:RegisterApi("rechargeCellTopDesc", self.GetRechargeCellTopDesc)
	self:RegisterApi("rechargeCellMoney", self.GetRechargeCellMoney)
	self:RegisterApi("rechargeCellExtRewardCount", self.GetRechargeCellExtRewardCount)
	self:RegisterApi("rechargeCellExtRewardTitle", self.GetRechargeCellExtRewardTitle)
	self:RegisterApi("rewardCellTopDesc", self.GetRewardCellTopDesc)
	self:RegisterApi("rewardCellOverDesc", self.GetRewardCellOverDesc)
	self:RegisterApi("rewardCellBtnGetTxt", self.GetRewardCellBtnGetTxt)
	self:RegisterApi("rewardCellBottomDesc", self.GetRewardCellBottomDesc)
	self:RegisterApi("rewardCellName", self.GetRewardCellName)
	self:RegisterApi("rewardCellProgressCur", self.GetRewardCellProgressCur)
	self:RegisterApi("rewardCellProgressTotal", self.GetRewardCellProgressTotal)
	self:RegisterApi("monthViewBtnRightInfoTxt", self.GetMonthViewBtnRightInfoTxt)
	self:RegisterApi("monthViewDesc1", self.GetMonthViewDesc1)
	self:RegisterApi("monthViewDesc2", self.GetMonthViewDesc2)
	self:RegisterApi("monthViewDesc3", self.GetMonthViewDesc3)
	self:RegisterApi("monthViewDesc4", self.GetMonthViewDesc4)
	self:RegisterApi("monthViewMoneyCostCount", self.GetMonthViewMoneyCostCount)
	self:RegisterApi("monthViewBtnBuyTxt", self.GetMonthViewBtnBuyTxt)
	self:RegisterApi("monthViewBtnBuyTxtEng", self.GetMonthViewBtnBuyTxtEng)
	self:RegisterApi("monthViewTime", self.MonthViewTime)
	self:RegisterApi("MonthCardToggleText", self.GetMonthCardToggleText)
	self:RegisterApi("monthViewSignBoughtTxt", self.GetMonthViewSignBoughtTxt)
	self:RegisterApi("MonthCardPrefabPath", self.GetMonthCardPrefabPath)
	self:RegisterApi("MonthCardItemSubTypeList", self.GetMonthCardItemSubTypeList)
	self:RegisterApi("gashaponCellBtnBuyTxt", self.GetGashaponCellBtnBuyTxt)
	self:RegisterApi("gashaponCellBtnBatchBuyTxt", self.GetGashaponCellBtnBatchBuyTxt)
	self:RegisterApi("gashaponCellDesc", self.GetGashaponCellDesc)
end

function MallUIApi:GetGuildTip()
	return self:GetCfgText(9101212)
end

function MallUIApi:GetTimeCDText(timeStr)
	return string.format(self:GetCfgText(1109049), timeStr)
end

function MallUIApi:GetGashaponCellDesc()
	return self:GetCfgText(1109029)
end

function MallUIApi:GetGashaponCellBtnBuyTxt()
	return self:GetCfgText(1109060)
end

function MallUIApi:GetGashaponCellBtnBatchBuyTxt()
	return self:GetCfgText(1109061)
end

function MallUIApi:MonthViewTime(residueTime)
	if residueTime == 0 then
		return self:GetCfgText(1109062)
	elseif residueTime < 3600 then
		return self:GetCfgText(1315008) .. "-" .. getTimeDurationText(residueTime, 3)
	elseif residueTime >= 3600 and residueTime < 86400 then
		return self:GetCfgText(1315008) .. "-" .. getTimeDurationText(residueTime, 2)
	else
		return self:GetCfgText(1315008) .. "-" .. getTimeDurationText(residueTime, 1)
	end
end

function MallUIApi:GetTabResidueTime(residueTime)
	if residueTime < 3600 then
		return self:GetCfgText(1315008) .. "-" .. getTimeDurationText(residueTime, 3)
	elseif residueTime >= 3600 and residueTime < 86400 then
		return self:GetCfgText(1315008) .. "-" .. getTimeDurationText(residueTime, 2)
	else
		return self:GetCfgText(1315008) .. "-" .. getTimeDurationText(residueTime, 1)
	end
end

function MallUIApi:GetMonthViewBtnBuyTxtEng()
	return self:GetCfgText(1109063)
end

function MallUIApi:GetMonthViewBtnBuyTxt()
	return self:GetCfgText(1109006)
end

function MallUIApi:GetMonthViewMoneyCostCount(cost)
	return cost
end

function MallUIApi:GetMonthViewDesc1()
	return self:GetCfgText(1109064)
end

function MallUIApi:GetMonthViewDesc2(monthCardId)
	if monthCardId == 1 then
		return self:GetCfgText(1109041)
	elseif monthCardId == 2 then
		return self:GetCfgText(1109041)
	elseif monthCardId == 3 then
		return self:GetCfgText(1109070)
	elseif monthCardId == 4 then
		return self:GetCfgText(1109041)
	end
end

function MallUIApi:GetMonthViewDesc3(monthCardId)
	if monthCardId == 1 then
		return self:GetCfgText(1109042)
	elseif monthCardId == 2 then
		return self:GetCfgText(1109054)
	elseif monthCardId == 3 then
		return self:GetCfgText(1109071)
	elseif monthCardId == 4 then
		return self:GetCfgText(1109054)
	end
end

function MallUIApi:GetMonthViewDesc4()
	return self:GetCfgText(1109043)
end

function MallUIApi:GetMonthViewBtnRightInfoTxt()
	return self:GetCfgText(1109044)
end

function MallUIApi:GetMonthCardToggleText(itemSubType)
	if itemSubType == 15 then
		return self:GetCfgText(1109055)
	elseif itemSubType == 21 then
		return self:GetCfgText(1109056)
	elseif itemSubType == 27 then
		return self:GetCfgText(1109058)
	end

	return "???"
end

function MallUIApi:GetMonthViewSignBoughtTxt()
	return self:GetCfgText(1109057)
end

function MallUIApi:GetMonthCardPrefabPath(itemSubType)
	if itemSubType == 15 then
		return self:GetResUrl(1509003)
	elseif itemSubType == 21 then
		return self:GetResUrl(1509004)
	elseif itemSubType == 27 then
		return self:GetResUrl(1509005)
	end
end

function MallUIApi:GetMonthCardItemSubTypeList()
	return {
		21,
		27,
		15
	}
end

function MallUIApi:GetRewardCellProgressCur(value)
	return value
end

function MallUIApi:GetRewardCellProgressTotal(value)
	return "/" .. tostring(value)
end

function MallUIApi:GetRewardCellName(name)
	return name
end

function MallUIApi:GetRewardCellBottomDesc()
	return self:GetCfgText(1109065)
end

function MallUIApi:GetRewardCellBtnGetTxt()
	return self:GetCfgText(1109047)
end

function MallUIApi:GetRewardCellOverDesc()
	return self:GetCfgText(1109048)
end

function MallUIApi:GetRewardCellTopDesc()
	return self:GetCfgText(1109066)
end

function MallUIApi:GetBtnRewardTxt()
	return self:GetCfgText(1243003)
end

function MallUIApi:GetBtnRechargeTxt()
	return self:GetCfgText(1109045)
end

function MallUIApi:GetBtnGashTxt()
	return self:GetCfgText(1109067)
end

function MallUIApi:GetRechargeDesc()
	return self:GetCfgText(1109046)
end

function MallUIApi:GetRechargedCellName(name)
	return name
end

function MallUIApi:GetRechargeCellDesc(desc)
	return desc
end

function MallUIApi:GetRechargeCellTopDesc()
	return self:GetCfgText(1109068)
end

function MallUIApi:GetRechargeCellMoney(count)
	return count
end

function MallUIApi:GetRechargeCellExtRewardCount(count)
	return "x" .. count
end

function MallUIApi:GetRechargeCellExtRewardTitle()
	return self:GetCfgText(1233125)
end

function MallUIApi:GetCondition(desc, isOver)
	return desc
end

function MallUIApi:GetClickTip()
	return self:GetCfgText(1109031)
end

function MallUIApi:GetTabTopName(type, entryType)
	local title

	if entryType == 1 then
		if type == 1 then
			title = self:GetCfgText(1009029)
		elseif type == 2 then
			title = self:GetCfgText(1211086)
		elseif type == 3 then
			title = self:GetCfgText(1109033)
		elseif type == 4 then
			title = self:GetCfgText(1019041)
		elseif type == 5 then
			title = self:GetCfgText(1019043)
		elseif type == 6 then
			title = self:GetCfgText(1211018)
		elseif type == 7 then
			title = self:GetCfgText(1109032)
		elseif type == 8 then
			title = self:GetCfgText(1211031)
		elseif type == 9 then
			title = self:GetCfgText(1109034)
		elseif type == 10 then
			title = self:GetCfgText(1109039)
		else
			title = self:GetCfgText(1019206)
		end
	elseif entryType == 3 then
		if type == 1 then
			title = self:GetCfgText(2000076)
		else
			title = self:GetCfgText(1019206)
		end
	elseif entryType == 4 then
		title = self:GetCfgText(1019227)
	elseif entryType == 5 then
		title = self:GetCfgText(1019228)
	elseif entryType == 6 then
		title = self:GetCfgText(1109073)
	elseif entryType == 7 then
		title = self:GetCfgText(9000004)
	elseif entryType == 8 then
		if type == 1 then
			title = self:GetCfgText(1019237)
		elseif type == 2 then
			title = self:GetCfgText(1019241)
		end
	elseif entryType == 9 then
		title = self:GetCfgText(1019238)
	elseif entryType == 10 then
		if type == 1 then
			title = self:GetCfgText(1019240)
		elseif type == 2 then
			title = self:GetCfgText(1019239)
		end
	elseif entryType == 11 then
		title = self:GetCfgText(1109069)
	elseif entryType == 13 then
		title = self:GetCfgText(3420331)
	elseif entryType == 14 then
		title = self:GetCfgText(9101211)
	elseif entryType == 15 then
		if type == 1 then
			title = self:GetCfgText(9101217)
		elseif type == 2 then
			title = self:GetCfgText(9101222)
		end
	elseif entryType == 16 then
		if type == 1 then
			title = self:GetCfgText(9101218)
		elseif type == 2 then
			title = self:GetCfgText(9101219)
		end
	elseif entryType == 17 then
		title = self:GetCfgText(9101220)
	elseif entryType == 18 then
		title = self:GetCfgText(9101221)
	elseif entryType == 19 then
		title = self:GetCfgText(3830099)
	elseif entryType == 21 then
		title = self:GetCfgText(3430002)
	elseif entryType == 22 then
		title = self:GetCfgText(3430018)
	else
		title = self:GetCfgText(3420330)
	end

	return title
end

function MallUIApi:GetTabLeftName(name)
	return name
end

function MallUIApi:GetTabTopIcon(type)
	return self:GetResUrl(1509001)
end

function MallUIApi:GetTime(value)
	value = tonumber(value)

	if value < 0 then
		return self:GetCfgText(1109011)
	end

	local day = 86400
	local hour = 3600
	local minute = 60
	local txt

	if day <= value then
		txt = math.ceil(value / day) .. self:GetCfgText(1109012)
	elseif value < day and hour <= value then
		txt = math.ceil(value / hour) .. self:GetCfgText(1109013)
	else
		txt = math.ceil(value / minute) .. self:GetCfgText(1109014)
	end

	return self:GetCfgText(1109004) .. txt
end

function MallUIApi:GetBuyTimes(limitType, cur, total)
	if cur == 0 then
		cur = self.TextColor[41] .. self:FontSize(cur, 24) .. self.TextColor[0]
	else
		cur = self:FontSize(cur, 24)
	end

	if limitType == 1 then
		return self:GetCfgText(1109017) .. ":" .. cur .. "/" .. total
	elseif limitType == 2 then
		return self:GetCfgText(1109018) .. ":" .. cur .. "/" .. total
	elseif limitType == 3 then
		return self:GetCfgText(1109035) .. ":" .. cur .. "/" .. total
	elseif limitType == 4 then
		return self:GetCfgText(1109036) .. ":" .. cur .. "/" .. total
	end
end

function MallUIApi:GetTag(tag, price, discount)
	if tag == 1 then
		local rate = math.floor((1 - price / discount) * 100, 0)

		if rate > 99 then
			rate = 99
		elseif rate < 1 then
			rate = 1
		end

		return "-" .. rate .. "%"
	elseif tag == 2 then
		return self:GetCfgText(1109019)
	elseif tag == 3 then
		return self:GetCfgText(1109038)
	elseif tag == 4 then
		return self:GetCfgText(1317020)
	end
end

function MallUIApi:GetMoneyCost(cost, own, isRMB, isFree)
	if isRMB then
		return cost
	elseif isFree then
		return self.TextColor[219] .. self:GetCfgText(1109037) .. self.TextColor[0]
	elseif cost <= own then
		return cost
	else
		return self.TextColor[28] .. cost .. self.TextColor[0]
	end
end

function MallUIApi:GetDiscount(discount)
	return discount
end

function MallUIApi:GetQualityLinePath(quality)
	if quality == 1 then
		return self:GetResUrl(1500001)
	elseif quality == 2 then
		return self:GetResUrl(1500002)
	elseif quality == 3 then
		return self:GetResUrl(1500003)
	elseif quality == 4 then
		return self:GetResUrl(1500004)
	elseif quality == 5 then
		return self:GetResUrl(1500005)
	end

	return self:GetResUrl(1500001)
end

function MallUIApi:GetQualityNumPath(quality)
	return self:GetResUrl(1509002)
end

function MallUIApi:GetSellNum(num)
	if string.len(num) >= 10 then
		num = math.floor(num / math.pow(10, 9), 2) .. "B"
	elseif string.len(num) >= 7 then
		num = math.floor(num / math.pow(10, 6), 2) .. "M"
	elseif string.len(num) >= 4 then
		num = math.floor(num / math.pow(10, 3), 2) .. "K"
	end

	return "x" .. num
end

function MallUIApi:GetItemName(name)
	return name
end

function MallUIApi:GetTitle(type)
	if type == 1 then
		return self:GetCfgText(1109001)
	elseif type == 2 then
		return self:GetCfgText(1317013)
	elseif type == 3 then
		return self:GetCfgText(1109001)
	end

	return self:GetCfgText(1109001)
end

MallUIApi:Init()
