-- chunkname: @IQIGame\\UIExternalApi\\ShopUIApi.lua

ShopUIApi = BaseLangApi:Extend()

function ShopUIApi:Init()
	self:RegisterApi("goBtnRefreshTxt", self.GetBtnRefreshTxt)
	self:RegisterApi("goCostNum", self.GetCostNum)
	self:RegisterApi("GetMoneyTxt", self.GetMoneyTxt)
	self:RegisterApi("moneyPayNum", self.GetMoneyPayNum)
	self:RegisterApi("goRefreshTime", self.GetRefreshTime)
	self:RegisterApi("goRefreshTimeDesc", self.GetRefreshTimeDesc)
	self:RegisterApi("GetLastRefreshCountTxt", self.GetLastRefreshCountTxt)
	self:RegisterApi("MoneyOverLabTxt", self.GetMoneyOverLabTxt)
	self:RegisterApi("MoneyFreeTxt", self.GetMoneyFreeTxt)
	self:RegisterApi("RefreshCostTitleTxt", self.GetRefreshCostTitleTxt)
	self:RegisterApi("RefreshCostTitleTxt", self.GetRefreshCostTitleTxt)
	self:RegisterApi("goTabName", self.GetTabName)
	self:RegisterApi("goTitle", self.GetTitle)
	self:RegisterApi("goSellOutDesc", self.GetSellOutDesc)
	self:RegisterApi("GetEvilErosionShopFrame", self.GetEvilErosionShopFrame)
	self:RegisterApi("GetCVDelay", self.GetCVDelay)
end

function ShopUIApi:GetSellOutDesc()
	return self:GetCfgText(1140031)
end

function ShopUIApi:GetTabName(name)
	return name
end

function ShopUIApi:GetTitle()
	return self:GetCfgText(1140017)
end

function ShopUIApi:GetBtnRefreshTxt()
	return self:GetCfgText(1140002)
end

function ShopUIApi:GetLastRefreshCountTxt(totalCnt, curCnt)
	local lastCnt = totalCnt - curCnt

	return self:GetCfgText(1140033, lastCnt)
end

function ShopUIApi:GetCostNum(goodsCostNum, goodsBagNum)
	return goodsCostNum .. "/" .. goodsBagNum
end

function ShopUIApi:GetGoodsRefreshPayNumTxt(goodsCostNum, goodsBagNum)
	return goodsCostNum .. "/" .. goodsBagNum
end

function ShopUIApi:GetMoneyPayNum(moneyNum)
	return moneyNum
end

function ShopUIApi:GetRefreshTime(countDownTime)
	return getTimeDurationText2(countDownTime)
end

function ShopUIApi:GetRefreshTimeDesc()
	return self:GetCfgText(1140032)
end

function ShopUIApi:GetMoneyOverLabTxt(countDownTime)
	return self:GetCfgText(1140004)
end

function ShopUIApi:GetMoneyFreeTxt(countDownTime)
	return self:GetCfgText(1140001)
end

function ShopUIApi:GetRefreshCostTitleTxt(countDownTime)
	return self:GetCfgText(1140003)
end

function ShopUIApi:GetMoneyTxt(moneyNum)
	return moneyNum
end

function ShopUIApi:GetEvilErosionShopFrame(quality)
	if quality == 2 then
		return self:GetResUrl(1103001)
	elseif quality == 3 then
		return self:GetResUrl(1103002)
	elseif quality == 4 then
		return self:GetResUrl(1103003)
	elseif quality == 5 then
		return self:GetResUrl(1103004)
	else
		return self:GetResUrl(1103001)
	end
end

function ShopUIApi:GetCVDelay()
	return 20
end

ShopUIApi:Init()
