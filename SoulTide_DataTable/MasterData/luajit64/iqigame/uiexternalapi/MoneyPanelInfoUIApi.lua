-- chunkname: @IQIGame\\UIExternalApi\\MoneyPanelInfoUIApi.lua

MoneyPanelInfoUIApi = BaseLangApi:Extend()

function MoneyPanelInfoUIApi:Init()
	self:RegisterApi("TextEnergyCd", self.GetTextEnergyCd)
	self:RegisterApi("TextMaxEnergyCd", self.GetTextMaxEnergyCd)
end

function MoneyPanelInfoUIApi:GetTextEnergyCd(timeStr, isFull)
	if isFull then
		return self:GetCfgText(2900202)
	end

	return string.format(self:GetCfgText(2900200) .. "：" .. "\n%s", timeStr)
end

function MoneyPanelInfoUIApi:GetTextMaxEnergyCd(timeStr, isFull)
	if isFull then
		return self:GetCfgText(2900202)
	end

	return string.format(self:GetCfgText(2900201) .. "：" .. "\n%s", timeStr)
end

MoneyPanelInfoUIApi:Init()
