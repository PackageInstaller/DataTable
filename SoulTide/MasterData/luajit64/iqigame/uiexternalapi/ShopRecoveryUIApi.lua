-- chunkname: @IQIGame\\UIExternalApi\\ShopRecoveryUIApi.lua

ShopRecoveryUIApi = BaseLangApi:Extend()

function ShopRecoveryUIApi:Init()
	self:RegisterApi("goTitle", self.GetTitle)
	self:RegisterApi("goCostDesc", self.GetCostDesc)
	self:RegisterApi("goTotalNum", self.GetTotalNum)
	self:RegisterApi("cellItemNum", self.GetCellItemNum)
	self:RegisterApi("btnRecoverTxt", self.GetBtnRecoverTxt)
end

function ShopRecoveryUIApi:GetBtnRecoverTxt()
	return self:GetCfgText(2300400)
end

function ShopRecoveryUIApi:GetTotalNum(num)
	return "x" .. num
end

function ShopRecoveryUIApi:GetTitle()
	return self:GetCfgText(2300401)
end

function ShopRecoveryUIApi:GetCostDesc()
	return self:GetCfgText(2300402) .. " |"
end

function ShopRecoveryUIApi:GetCellItemNum(num)
	return "X " .. tostring(num)
end

ShopRecoveryUIApi:Init()
