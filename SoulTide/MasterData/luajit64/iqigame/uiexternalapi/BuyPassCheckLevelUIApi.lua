-- chunkname: @IQIGame\\UIExternalApi\\BuyPassCheckLevelUIApi.lua

BuyPassCheckLevelUIApi = BaseLangApi:Extend()

function BuyPassCheckLevelUIApi:Init()
	self:RegisterApi("title", self.GetTitle)
	self:RegisterApi("goDesc", self.GetDesc)
	self:RegisterApi("goLvCur", self.GetLvCur)
	self:RegisterApi("goLvTarget", self.GetLvTarget)
	self:RegisterApi("btnBuyTxt", self.GetBtnBuyTxt)
	self:RegisterApi("cost", self.GetCost)
end

function BuyPassCheckLevelUIApi:GetCost(ownCount, value)
	if ownCount < value then
		return self.TextColor[28] .. value .. self.TextColor[0]
	end

	return value
end

function BuyPassCheckLevelUIApi:GetBtnBuyTxt()
	return self:GetCfgText(3501300)
end

function BuyPassCheckLevelUIApi:GetLvCur(lv)
	return lv
end

function BuyPassCheckLevelUIApi:GetLvTarget(lv)
	return lv
end

function BuyPassCheckLevelUIApi:GetTitle()
	return self:GetCfgText(3501301)
end

function BuyPassCheckLevelUIApi:GetDesc()
	return self:GetCfgText(3501302)
end

BuyPassCheckLevelUIApi:Init()
