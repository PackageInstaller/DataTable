-- chunkname: @IQIGame\\UIExternalApi\\JewelryStrengthenUIApi.lua

JewelryStrengthenUIApi = BaseLangApi:Extend()

function JewelryStrengthenUIApi:Init()
	self:RegisterApi("goCostNum", self.GetGoCostNum)
	self:RegisterApi("goOwnNum", self.GetGoOwnNum)
end

function JewelryStrengthenUIApi:GetGoOwnNum(num, enough)
	if enough then
		CountColor = 30
	else
		CountColor = 28
	end

	return self.TextColor[CountColor] .. num .. self.TextColor[0]
end

function JewelryStrengthenUIApi:GetGoCostNum(num, enough)
	return self.TextColor[12] .. string.format("/%s", num) .. self.TextColor[0]
end

JewelryStrengthenUIApi:Init()
