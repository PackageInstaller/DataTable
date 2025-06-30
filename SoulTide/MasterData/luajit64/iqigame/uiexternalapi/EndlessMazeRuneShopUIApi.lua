-- chunkname: @IQIGame\\UIExternalApi\\EndlessMazeRuneShopUIApi.lua

EndlessMazeRuneShopUIApi = BaseLangApi:Extend()

function EndlessMazeRuneShopUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("RuneDiscountText", self.GetRuneDiscountText)
	self:RegisterApi("SoldOutText", self.GetSoldOutText)
	self:RegisterApi("RunePriceText", self.GetRunePriceText)
	self:RegisterApi("RuneSuitLabel", self.GetRuneSuitLabel)
	self:RegisterApi("GoodsLabel", self.GetGoodsLabel)
	self:RegisterApi("RefreshBtnText", self.GetRefreshBtnText)
end

function EndlessMazeRuneShopUIApi:GetTitleText()
	return self:GetCfgText(2200059)
end

function EndlessMazeRuneShopUIApi:GetRuneDiscountText(discount)
	if discount == 10 then
		return ""
	end

	return string.format(self:GetCfgText(2200060), discount)
end

function EndlessMazeRuneShopUIApi:GetSoldOutText()
	return self:GetCfgText(1109002)
end

function EndlessMazeRuneShopUIApi:GetRunePriceText(price, isEnough)
	local color

	color = isEnough and "#4C4C4C" or "#e33533"

	return "<color=" .. color .. ">" .. price .. "</color>"
end

function EndlessMazeRuneShopUIApi:GetRuneSuitLabel()
	return self:GetCfgText(2200061)
end

function EndlessMazeRuneShopUIApi:GetGoodsLabel()
	return self:GetCfgText(2200010)
end

function EndlessMazeRuneShopUIApi:GetRefreshBtnText()
	return self:GetCfgText(81)
end

EndlessMazeRuneShopUIApi:Init()
