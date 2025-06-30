-- chunkname: @IQIGame\\UIExternalApi\\MagicTowerMainUIApi.lua

MagicTowerMainUIApi = BaseLangApi:Extend()

function MagicTowerMainUIApi:Init()
	self:RegisterApi("HpLabel", self.GetHpLabel)
	self:RegisterApi("AtkLabel", self.GetAtkLabel)
	self:RegisterApi("DefLabel", self.GetDefLabel)
	self:RegisterApi("DefaultItemIcon", self.GetDefaultItemIcon)
	self:RegisterApi("EquipName", self.GetEquipName)
end

function MagicTowerMainUIApi:GetHpLabel()
	return "HP"
end

function MagicTowerMainUIApi:GetAtkLabel()
	return "ATK"
end

function MagicTowerMainUIApi:GetDefLabel()
	return "DEF"
end

function MagicTowerMainUIApi:GetDefaultItemIcon()
	return UIGlobalApi.GetImagePath("/Common/ComFrame/ComFrame_289.png")
end

function MagicTowerMainUIApi:GetEquipName(name, type)
	if name == nil then
		if type == 1 then
			return "暂无武器"
		elseif type == 2 then
			return "暂无防具"
		else
			return "Unknown equip"
		end
	end

	return name
end

MagicTowerMainUIApi:Init()
