-- chunkname: @IQIGame\\UIExternalApi\\HomeLandFishBagUIApi.lua

HomeLandFishBagUIApi = BaseLangApi:Extend()

function HomeLandFishBagUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("EmptyViewText", self.GetEmptyViewText)
	self:RegisterApi("TabTexts", self.GetTabTexts)
	self:RegisterApi("BtnItemUseLabel", self.GetBtnItemUseLabel)
	self:RegisterApi("BtnAllSellLabel", self.GetBtnAllSellLabel)
end

function HomeLandFishBagUIApi:GetBtnAllSellLabel()
	return self:GetCfgText(1015710)
end

function HomeLandFishBagUIApi:GetBtnItemUseLabel(itemType, itemSubType)
	if itemType == 2 then
		if itemSubType == 40 then
			return self:GetCfgText(1015701)
		elseif itemSubType == 41 then
			return self:GetCfgText(1015702)
		elseif itemSubType == 42 then
			return self:GetCfgText(1015702)
		end
	end

	return self:GetCfgText(1015702)
end

function HomeLandFishBagUIApi:GetTitleText()
	return self:GetCfgText(1015708)
end

function HomeLandFishBagUIApi:GetTabTexts()
	return {
		self:GetCfgText(1015703),
		self:GetCfgText(1015704),
		self:GetCfgText(1015705),
		self:GetCfgText(1015706),
		self:GetCfgText(1015707)
	}
end

function HomeLandFishBagUIApi:GetEmptyViewText()
	return self:GetCfgText(1015709)
end

HomeLandFishBagUIApi:Init()
