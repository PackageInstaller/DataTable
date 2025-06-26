-- chunkname: @IQIGame\\UIExternalApi\\ShopBuyPanelUIApi.lua

ShopBuyPanelUIApi = BaseLangApi:Extend()

function ShopBuyPanelUIApi:Init()
	self:RegisterApi("goTitle", self.GetTitle)
	self:RegisterApi("goBtnBuyTxt", self.goBtnBuyTxt)
	self:RegisterApi("goName", self.GetName)
	self:RegisterApi("goCount", self.GetCount)
	self:RegisterApi("goDesc", self.GetDesc)
	self:RegisterApi("goCost", self.GetCost)
end

function ShopBuyPanelUIApi:GetTitle()
	return self:GetCfgText(1140015)
end

function ShopBuyPanelUIApi:goBtnBuyTxt()
	return self:GetCfgText(1140016)
end

function ShopBuyPanelUIApi:GetName(name)
	return name
end

function ShopBuyPanelUIApi:GetCount(count)
	return "x" .. count
end

function ShopBuyPanelUIApi:GetDesc(desc)
	return desc
end

function ShopBuyPanelUIApi:GetCost(cost, ownCount)
	if ownCount < cost then
		return self.TextColor[28] .. cost .. self.TextColor[0]
	else
		return cost
	end
end

ShopBuyPanelUIApi:Init()
