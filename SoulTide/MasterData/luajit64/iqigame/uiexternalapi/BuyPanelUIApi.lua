-- chunkname: @IQIGame\\UIExternalApi\\BuyPanelUIApi.lua

BuyPanelUIApi = BaseLangApi:Extend()

function BuyPanelUIApi:Init()
	self:RegisterApi("goDesc", self.GetDesc)
	self:RegisterApi("goPackageDesc", self.GetPackageDesc)
	self:RegisterApi("goTitle", self.GetTitle)
	self:RegisterApi("goBuyBtn", self.GetBuyBtnTxt)
	self:RegisterApi("costMoney", self.GetCostMoney)
	self:RegisterApi("goItemName", self.GetItemName)
	self:RegisterApi("goSellNum", self.GetSellNum)
	self:RegisterApi("goQualityLinePath", self.GetQualityLinePath)
	self:RegisterApi("goBuyTimes", self.GetBuyTimes)
	self:RegisterApi("barProgress", self.GetBarProgress)
	self:RegisterApi("rechargeWaitTipTxt", self.GetRechargeWaitTipTxt)
	self:RegisterApi("btnMinTxt", self.GetBtnMinTxt)
	self:RegisterApi("btnMaxTxt", self.GetBtnMaxTxt)
end

function BuyPanelUIApi:GetBtnMinTxt()
	return self:GetCfgText(1140106)
end

function BuyPanelUIApi:GetBtnMaxTxt()
	return self:GetCfgText(1140105)
end

function BuyPanelUIApi:GetRechargeWaitTipTxt()
	return self:GetCfgText(1140021)
end

function BuyPanelUIApi:GetBuyTimes(value)
	return value
end

function BuyPanelUIApi:GetQualityLinePath(quality)
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

function BuyPanelUIApi:GetSellNum(num)
	return "x" .. num
end

function BuyPanelUIApi:GetItemName(name)
	return name
end

function BuyPanelUIApi:GetCostMoney(cost, own, type)
	if cost == 0 then
		return self:GetCfgText(1140001)
	end

	if type == Constant.Mall_SellType.RMB then
		return cost
	end

	if cost <= own then
		return cost
	else
		return self.TextColor[28] .. cost .. self.TextColor[0]
	end
end

function BuyPanelUIApi:GetBarProgress(progress)
	return progress
end

function BuyPanelUIApi:GetBuyBtnTxt(isFree)
	if isFree then
		return self:GetCfgText(1140022)
	end

	return self:GetCfgText(1140018)
end

function BuyPanelUIApi:GetDesc(desc)
	return desc
end

function BuyPanelUIApi:GetPackageDesc(names, nums)
	local desc = "<size=22>" .. self:GetCfgText(1140019) .. "</size>"

	for i, v in ipairs(names) do
		desc = desc .. "\n" .. self:Space(2) .. v .. self:Space(1) .. "x" .. tostring(nums[i])
	end

	return desc
end

function BuyPanelUIApi:GetTitle()
	return self:GetCfgText(1140018)
end

BuyPanelUIApi:Init()
