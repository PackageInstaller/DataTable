-- chunkname: @IQIGame\\UIExternalApi\\ItemTipsApi.lua

ItemTipsApi = BaseLangApi:Extend()

function ItemTipsApi:Init()
	self:RegisterApi("goBtnUse", self.GetBtnUseTxt)
	self:RegisterApi("goQualityImage", self.GetQualityImagePath)
	self:RegisterApi("goName", self.GetName)
	self:RegisterApi("goType", self.GetType)
	self:RegisterApi("goNum", self.GetNum)
	self:RegisterApi("goNumText", self.GetGoNumText)
	self:RegisterApi("goDesc", self.GetDesc)
	self:RegisterApi("goUseEffectTitle", self.GetUseEffectTitle)
	self:RegisterApi("goUseEffect", self.GetEffect)
	self:RegisterApi("goUseArea", self.GetUseArea)
	self:RegisterApi("goUseAreaTitle", self.GetUseAreaTitle)
	self:RegisterApi("goUseConditionTitle", self.GetUseConditionTitle)
	self:RegisterApi("goUseCondition", self.GetUseCondition)
	self:RegisterApi("goUseTimeTitle", self.GetUseTimeTitle)
	self:RegisterApi("goUseTime", self.GetUseTime)
	self:RegisterApi("goCDTitle", self.GetCDTitle)
	self:RegisterApi("goCD", self.GetCD)
	self:RegisterApi("goUseCostTitle", self.GetUseCostTitle)
	self:RegisterApi("goUseCost", self.GetUseCost)
	self:RegisterApi("goSourceTitle", self.GetSourceTitle)
	self:RegisterApi("goSource", self.GetSource)
	self:RegisterApi("goJumpBtnTxt", self.GetJumpBtnTxt)
end

function ItemTipsApi:GetJumpBtnTxt()
	return self:GetCfgText(1101009)
end

function ItemTipsApi:GetBtnUseTxt()
	return self:GetCfgText(1211002)
end

function ItemTipsApi:GetQualityImagePath(quality)
	if quality == 1 then
		return self:GetResUrl(1600001)
	elseif quality == 2 then
		return self:GetResUrl(1600002)
	elseif quality == 3 then
		return self:GetResUrl(1600003)
	elseif quality == 4 then
		return self:GetResUrl(1600004)
	elseif quality == 5 then
		return self:GetResUrl(1600005)
	end
end

function ItemTipsApi:GetName(name, quality)
	return name
end

function ItemTipsApi:GetType(type, subType)
	local itemType = ""

	if type == 1 then
		return itemType .. self:GetCfgText(1211016)
	elseif type == 2 then
		if subType == 0 then
			return itemType .. self:GetCfgText(1211017)
		elseif subType == 1 then
			return itemType .. self:GetCfgText(1211018)
		elseif subType == 2 then
			return itemType .. self:GetCfgText(1211019)
		elseif subType == 3 then
			return itemType .. self:GetCfgText(1211020)
		elseif subType == 4 then
			return itemType .. self:GetCfgText(1211021)
		elseif subType == 5 then
			return itemType .. self:GetCfgText(1211022)
		elseif subType == 6 then
			return itemType .. self:GetCfgText(1211023)
		elseif subType == 7 then
			return itemType .. self:GetCfgText(1211024)
		elseif subType == 8 then
			return itemType .. self:GetCfgText(1211025)
		elseif subType == 9 then
			return itemType .. self:GetCfgText(1211026)
		elseif subType == 10 then
			return itemType .. self:GetCfgText(1211027)
		elseif subType == 11 then
			return itemType .. self:GetCfgText(1211028)
		elseif subType == 12 then
			return itemType .. self:GetCfgText(1211029)
		elseif subType == 13 then
			return itemType .. self:GetCfgText(1211030)
		elseif subType == 14 then
			return itemType .. self:GetCfgText(1211031)
		elseif subType == 15 then
			return itemType .. self:GetCfgText(1211032)
		elseif subType == 16 then
			return itemType .. self:GetCfgText(1211033)
		elseif subType == 17 then
			return itemType .. self:GetCfgText(1211034)
		elseif subType == 18 then
			return itemType .. self:GetCfgText(1211035)
		elseif subType == 19 then
			return itemType .. self:GetCfgText(1211058)
		elseif subType == 20 then
			return itemType .. self:GetCfgText(1211066)
		elseif subType == 21 then
			return itemType .. self:GetCfgText(1211067)
		elseif subType == 22 then
			return itemType .. self:GetCfgText(1211077)
		elseif subType == 23 then
			return ""
		elseif subType == 31 then
			return itemType .. self:GetCfgText(1211068)
		elseif subType == 32 then
			return itemType .. self:GetCfgText(1211069)
		elseif subType == 33 then
			return itemType .. self:GetCfgText(1211070)
		elseif subType == 34 then
			return itemType .. self:GetCfgText(1211071)
		elseif subType == 35 then
			return ""
		elseif subType == 36 then
			return itemType .. self:GetCfgText(1211078)
		elseif subType == 37 then
			return itemType .. self:GetCfgText(1211079)
		elseif subType == 38 then
			return itemType .. self:GetCfgText(1211089)
		elseif subType == 39 then
			return self:GetCfgText(1211091)
		elseif subType == 40 then
			return itemType .. self:GetCfgText(1211015)
		elseif subType == 41 then
			return itemType .. self:GetCfgText(1211015)
		elseif subType == 42 then
			return itemType .. self:GetCfgText(1211015)
		elseif subType == 43 then
			return itemType .. self:GetCfgText(1211015)
		elseif subType == 44 then
			return itemType .. self:GetCfgText(1211015)
		elseif subType == 45 then
			return itemType .. self:GetCfgText(1211015)
		elseif subType == 46 then
			return itemType .. self:GetCfgText(1211015)
		elseif subType == 47 then
			return itemType .. self:GetCfgText(1211015)
		elseif subType == 100 then
			return itemType .. self:GetCfgText(1211080)
		elseif subType == 101 then
			return itemType .. self:GetCfgText(1211092)
		elseif subType == 901 then
			return itemType .. self:GetCfgText(1211059)
		elseif subType == 902 then
			return itemType .. self:GetCfgText(1211060)
		elseif subType == 903 then
			return itemType .. self:GetCfgText(1211061)
		elseif subType == 904 then
			return itemType .. self:GetCfgText(1211062)
		elseif subType == 905 then
			return itemType .. self:GetCfgText(1211063)
		elseif subType == 906 then
			return itemType .. self:GetCfgText(1211064)
		elseif subType == 907 then
			return itemType .. self:GetCfgText(1211065)
		elseif subType == 908 then
			return itemType .. self:GetCfgText(1211076)
		elseif subType == 999 then
			return itemType .. self:GetCfgText(1211090)
		else
			return itemType .. self:GetCfgText(1211015)
		end
	elseif type == 3 then
		if subType == 1 then
			return itemType .. self:GetCfgText(1211036)
		elseif subType == 2 then
			return itemType .. self:GetCfgText(1211037)
		elseif subType == 3 then
			return itemType .. self:GetCfgText(1211038)
		elseif subType == 4 then
			return itemType .. self:GetCfgText(1211039)
		elseif subType == 5 then
			return itemType .. self:GetCfgText(1211040)
		elseif subType == 6 then
			return itemType .. self:GetCfgText(1211041)
		else
			return itemType .. self:GetCfgText(1211042)
		end
	elseif type == 4 then
		if subType == 1 then
			return itemType .. self:GetCfgText(1211043)
		elseif subType == 2 then
			return itemType .. self:GetCfgText(1211044)
		elseif subType == 3 then
			return itemType .. self:GetCfgText(1211045)
		elseif subType == 4 then
			return itemType .. self:GetCfgText(1211046)
		elseif subType == 5 then
			return itemType .. self:GetCfgText(1211047)
		else
			return itemType .. self:GetCfgText(1211048)
		end
	elseif type == 5 then
		if subType == 1 then
			return itemType .. self:GetCfgText(1211049)
		elseif subType == 2 then
			return itemType .. self:GetCfgText(1211050)
		elseif subType == 3 then
			return itemType .. self:GetCfgText(1211051)
		elseif subType == 4 then
			return itemType .. self:GetCfgText(1211052)
		elseif subType == 5 then
			return itemType .. self:GetCfgText(1211053)
		elseif subType == 6 then
			return itemType .. self:GetCfgText(1211054)
		elseif subType == 7 then
			return itemType .. self:GetCfgText(1211055)
		elseif subType == 8 then
			return itemType .. self:GetCfgText(1211056)
		elseif subType == 9 then
			return itemType .. self:GetCfgText(1211072)
		elseif subType == 10 then
			return itemType .. self:GetCfgText(1211081)
		elseif subType == 11 then
			return itemType .. self:GetCfgText(1211082)
		elseif subType == 12 then
			return itemType .. self:GetCfgText(1211083)
		elseif subType == 13 then
			return itemType .. self:GetCfgText(1211084)
		elseif subType == 13 then
			return itemType .. self:GetCfgText(1211085)
		elseif subType == 15 then
			return itemType .. self:GetCfgText(1211086)
		elseif subType == 16 then
			return itemType .. self:GetCfgText(1211087)
		elseif subType == 17 then
			return itemType .. self:GetCfgText(1211093)
		elseif subType == 18 then
			return itemType .. self:GetCfgText(1211094)
		elseif subType == 19 then
			return itemType .. self:GetCfgText(1211095)
		elseif subType == 20 then
			return itemType .. self:GetCfgText(1211096)
		elseif subType == 21 then
			return itemType .. self:GetCfgText(1211097)
		elseif subType == 22 then
			return itemType .. self:GetCfgText(1211098)
		elseif subType == 23 then
			return itemType .. self:GetCfgText(1211099)
		elseif subType == 24 then
			return itemType .. self:GetCfgText(1211102)
		elseif subType == 25 then
			return itemType .. self:GetCfgText(1211103)
		elseif subType == 26 then
			return itemType .. self:GetCfgText(1211104)
		elseif subType == 27 then
			return itemType .. self:GetCfgText(1211105)
		elseif subType == 28 then
			return itemType .. self:GetCfgText(1211106)
		elseif subType == 29 then
			return itemType .. self:GetCfgText(1211107)
		elseif subType == 30 then
			return itemType .. self:GetCfgText(1211108)
		elseif subType == 31 then
			return itemType .. self:GetCfgText(1211109)
		elseif subType == 32 then
			return itemType .. self:GetCfgText(1211110)
		elseif subType == 99 then
			return itemType .. self:GetCfgText(1211015)
		else
			return itemType .. self:GetCfgText(1211015)
		end
	elseif type == 6 then
		if subType == 1 then
			return itemType .. self:GetCfgText(1211073)
		else
			return itemType .. self:GetCfgText(1211015)
		end
	elseif type == 8 then
		return itemType .. self:GetCfgText(1211057)
	else
		return itemType .. self:GetCfgText(1211015)
	end
end

function ItemTipsApi:GetGoNumText(Durability, MaxDurability)
	return string.format(self:GetCfgText(1211100), Durability, MaxDurability)
end

function ItemTipsApi:GetNum(num)
	return string.format(self:GetCfgText(1211088) .. " x%s", num)
end

function ItemTipsApi:GetDesc(desc)
	return desc
end

function ItemTipsApi:GetUseEffectTitle()
	return self:GetCfgText(1211006)
end

function ItemTipsApi:GetEffect(effect)
	return effect
end

function ItemTipsApi:GetUseArea(desc)
	return desc
end

function ItemTipsApi:GetUseAreaTitle()
	return self:GetCfgText(1211007)
end

function ItemTipsApi:GetUseConditionTitle()
	return self:GetCfgText(1211008)
end

function ItemTipsApi:GetUseCondition(condition)
	return condition
end

function ItemTipsApi:GetUseTimeTitle()
	return self:GetCfgText(1211009)
end

function ItemTipsApi:GetUseTime(time)
	return time
end

function ItemTipsApi:GetCDTitle()
	return self:GetCfgText(1211010)
end

function ItemTipsApi:GetCD(cd)
	return cd
end

function ItemTipsApi:GetUseCostTitle()
	return self:GetCfgText(1211011)
end

function ItemTipsApi:GetUseCost(name, count)
	return name .. ":x" .. count
end

function ItemTipsApi:GetSourceTitle()
	return self:GetCfgText(1211013)
end

function ItemTipsApi:GetSource(name)
	return name
end

ItemTipsApi:Init()
