-- chunkname: @IQIGame\\UIExternalApi\\BagItemCellApi.lua

BagItemCellApi = BaseLangApi:Extend()

function BagItemCellApi:Init()
	self:RegisterApi("goName", self.GetItemName)
	self:RegisterApi("ItemNumText", self.GetItemNumText)
end

function BagItemCellApi:GetItemName(name)
	return name
end

function BagItemCellApi:GetItemNumText(num)
	return self:GetCfgText(1234001) .. num
end

BagItemCellApi:Init()
