-- chunkname: @IQIGame\\UIExternalApi\\SoulMarryVideoUIApi.lua

SoulMarryVideoUIApi = BaseLangApi:Extend()

function SoulMarryVideoUIApi:Init()
	self:RegisterApi("PanelTitle", self.GetPanelTitle)
	self:RegisterApi("PassTime", self.GetPassTime)
	self:RegisterApi("SelectTimeLabel", self.GetSelectTimeLabel)
end

function SoulMarryVideoUIApi:GetSelectTimeLabel(num)
	if num == 0 then
		return self:GetCfgText(1239201)
	end

	return string.format(self:GetCfgText(1239202), num)
end

function SoulMarryVideoUIApi:GetPassTime(str)
	return string.format(self:GetCfgText(1239203), str)
end

function SoulMarryVideoUIApi:GetPanelTitle()
	return self:GetCfgText(1239204)
end

SoulMarryVideoUIApi:Init()
