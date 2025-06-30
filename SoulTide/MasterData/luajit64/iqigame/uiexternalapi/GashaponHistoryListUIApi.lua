-- chunkname: @IQIGame\\UIExternalApi\\GashaponHistoryListUIApi.lua

GashaponHistoryListUIApi = BaseLangApi:Extend()

function GashaponHistoryListUIApi:Init()
	self:RegisterApi("title", self.GetTitle)
	self:RegisterApi("desc", self.GetDesc)
	self:RegisterApi("cellName", self.GetCellName)
	self:RegisterApi("cellSignGot", self.GetCellSignGot)
end

function GashaponHistoryListUIApi:GetCellSignGot()
	return self:GetCfgText(3201010)
end

function GashaponHistoryListUIApi:GetCellName(name)
	return name
end

function GashaponHistoryListUIApi:GetDesc()
	return self:GetCfgText(3201011)
end

function GashaponHistoryListUIApi:GetTitle()
	return self:GetCfgText(3201012)
end

GashaponHistoryListUIApi:Init()
