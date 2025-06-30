-- chunkname: @IQIGame\\UIExternalApi\\GiftSalesTimePanelUIApi.lua

GiftSalesTimePanelUIApi = BaseLangApi:Extend()

function GiftSalesTimePanelUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("buyBtnLabel", self.GetBuyBtnLabel)
	self:RegisterApi("limitTimeText", self.GetLimitTimeText)
	self:RegisterApi("TimeCDText", self.GetTimeCDText)
	self:RegisterApi("goItemName", self.GetItemName)
	self:RegisterApi("goMoneyCost", self.GetMoneyCost)
	self:RegisterApi("goBuyTimes", self.GetBuyTimes)
	self:RegisterApi("goTime", self.GetTime)
end

function GiftSalesTimePanelUIApi:GetTime(value)
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

function GiftSalesTimePanelUIApi:GetBuyTimes(limitType, cur, total)
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

function GiftSalesTimePanelUIApi:GetMoneyCost(cost, own, isRMB, isFree)
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

function GiftSalesTimePanelUIApi:GetItemName(name)
	return name
end

function GiftSalesTimePanelUIApi:GetTimeCDText(timeStr)
	return string.format(self:GetCfgText(3501601), timeStr)
end

function GiftSalesTimePanelUIApi:GetLimitTimeText()
	return self:GetCfgText(3501602)
end

function GiftSalesTimePanelUIApi:GetBuyBtnLabel()
	return self:GetCfgText(3501603)
end

function GiftSalesTimePanelUIApi:GetTextTitle()
	return self:GetCfgText(3501604)
end

GiftSalesTimePanelUIApi:Init()
