-- chunkname: @IQIGame\\UIExternalApi\\MoneyGridApi.lua

MoneyGridApi = BaseLangApi:Extend()

function MoneyGridApi:Init()
	self:RegisterApi("ValueText", self.GetValueText)
	self:RegisterApi("ValueMaxValueText", self.GetValueMaxValueText)
	self:RegisterApi("MoneyCellIconPath", self.GetMoneyCellIconPath)
end

function MoneyGridApi:GetMoneyCellIconPath(cid)
	if cid == 1 then
		return self:GetResUrl(2100001)
	elseif cid == 2 then
		return self:GetResUrl(2100002)
	elseif cid == 5 then
		return self:GetResUrl(2100003)
	elseif cid == 104 then
		return self:GetResUrl(2100004)
	elseif cid == 106 then
		return self:GetResUrl(2100005)
	elseif cid == 115 then
		return self:GetResUrl(2100006)
	elseif cid == 10005 then
		return self:GetResUrl(2100007)
	elseif cid == 10006 then
		return self:GetResUrl(2100008)
	elseif cid == 10012 then
		return self:GetResUrl(2100009)
	elseif cid == 10014 then
		return self:GetResUrl(2100010)
	elseif cid == 10030 then
		return self:GetResUrl(2100010)
	end

	return ""
end

function MoneyGridApi:GetValueText(count)
	if count >= 0 then
		return self:ShortNum(count, 2)
	elseif count < 0 then
		return self.TextColor[203] .. self:ShortNum(count, 2) .. self.TextColor[0]
	end
end

function MoneyGridApi:GetValueMaxValueText(count, maxCount)
	if count >= 0 then
		return count .. "/" .. maxCount
	elseif count < 0 then
		return self.TextColor[203] .. count .. self.TextColor[0] .. "/" .. maxCount
	end
end

MoneyGridApi:Init()
