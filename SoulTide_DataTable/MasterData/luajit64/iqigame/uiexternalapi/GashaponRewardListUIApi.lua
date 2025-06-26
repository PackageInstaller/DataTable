-- chunkname: @IQIGame\\UIExternalApi\\GashaponRewardListUIApi.lua

GashaponRewardListUIApi = BaseLangApi:Extend()

function GashaponRewardListUIApi:Init()
	self:RegisterApi("title", self.GetTitle)
	self:RegisterApi("tabName", self.GetTabName)
	self:RegisterApi("itemName", self.GetItemName)
	self:RegisterApi("itemProbability", self.GetItemProbability)
end

function GashaponRewardListUIApi:GetTitle()
	return self:GetCfgText(3201001)
end

function GashaponRewardListUIApi:GetTabName(name)
	return name
end

function GashaponRewardListUIApi:GetItemName(name)
	return name
end

function GashaponRewardListUIApi:GetItemProbability(value)
	return value * 100 .. "%"
end

GashaponRewardListUIApi:Init()
