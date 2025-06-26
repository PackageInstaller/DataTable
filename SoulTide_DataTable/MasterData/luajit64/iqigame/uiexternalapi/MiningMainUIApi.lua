-- chunkname: @IQIGame\\UIExternalApi\\MiningMainUIApi.lua

MiningMainUIApi = BaseLangApi:Extend()

function MiningMainUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("BtnShopLabel", self.GetBtnShopLabel)
	self:RegisterApi("BtnTipDes", self.GetBtnTipDes)
	self:RegisterApi("RewardNotice", self.GetRewardNotice)
	self:RegisterApi("TextDisplayTitle", self.GetTextDisplayTitle)
	self:RegisterApi("ElementTypeName", self.GetElementTypeName)
	self:RegisterApi("TargetRenderDes", self.GetTargetRenderDes)
end

function MiningMainUIApi:GetRewardNotice(content)
	return string.format(self:GetCfgText(3700515), content)
end

function MiningMainUIApi:GetBtnTipDes()
	return self:GetCfgText(3700520)
end

function MiningMainUIApi:GetTargetRenderDes(typeName, num)
	return string.format("%s : %s", typeName, num)
end

function MiningMainUIApi:GetElementTypeName(type)
	if type == 1 then
		return self:GetCfgText(3700501)
	elseif type == 2 then
		return self:GetCfgText(3700502)
	elseif type == 3 then
		return self:GetCfgText(3700503)
	elseif type == 4 then
		return self:GetCfgText(3700504)
	elseif type == 5 then
		return self:GetCfgText(3700505)
	elseif type == 6 then
		return self:GetCfgText(3700506)
	elseif type == 7 then
		return self:GetCfgText(3700507)
	elseif type == 8 then
		return self:GetCfgText(3700508)
	elseif type == 9 then
		return self:GetCfgText(3700509)
	elseif type == 10 then
		return self:GetCfgText(3700510)
	elseif type == 11 then
		return self:GetCfgText(3700511)
	end

	return ""
end

function MiningMainUIApi:GetBtnShopLabel()
	return self:GetCfgText(3700512)
end

function MiningMainUIApi:GetTextDisplayTitle()
	return self:GetCfgText(3700513)
end

function MiningMainUIApi:GetTextTitle(layer)
	return string.format(self:GetCfgText(3700514), layer)
end

MiningMainUIApi:Init()
