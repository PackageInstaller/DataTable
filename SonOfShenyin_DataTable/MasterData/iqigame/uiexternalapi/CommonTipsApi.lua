-- chunkname: @IQIGame\\UIExternalApi\\CommonTipsApi.lua

CommonTipsApi = BaseLangApi:Extend()

function CommonTipsApi:Init()
	CommonTipsApi.ItemTypeDesc = {
		[0] = {
			[0] = self:GetCfgText(1000101),
			self:GetCfgText(1000102),
			self:GetCfgText(1000103),
			self:GetCfgText(1000104),
			self:GetCfgText(1000105),
			self:GetCfgText(1000106),
			self:GetCfgText(1000107),
			self:GetCfgText(1000108),
			self:GetCfgText(1000109),
			self:GetCfgText(1000110),
			self:GetCfgText(1000111),
			self:GetCfgText(1000112),
			self:GetCfgText(1000113),
			self:GetCfgText(1000147),
			self:GetCfgText(1000150),
			(self:GetCfgText(1000151))
		},
		{
			[0] = self:GetCfgText(1000114),
			self:GetCfgText(1000115),
			self:GetCfgText(1000116),
			self:GetCfgText(1000117),
			self:GetCfgText(1000148),
			(self:GetCfgText(1000149))
		},
		{
			[0] = self:GetCfgText(1000118)
		},
		{
			self:GetCfgText(1000119),
			self:GetCfgText(1000120),
			self:GetCfgText(1000121),
			self:GetCfgText(1000122),
			self:GetCfgText(1000123),
			(self:GetCfgText(1000124))
		},
		{
			self:GetCfgText(1000125),
			self:GetCfgText(1000126),
			(self:GetCfgText(1000127))
		},
		{
			self:GetCfgText(1000128),
			(self:GetCfgText(1000129))
		},
		{
			self:GetCfgText(1000130),
			self:GetCfgText(1000131),
			self:GetCfgText(1000132),
			self:GetCfgText(1000133),
			(self:GetCfgText(1000133))
		},
		{
			self:GetCfgText(1000134),
			self:GetCfgText(1000135),
			self:GetCfgText(1000136),
			(self:GetCfgText(1000137))
		},
		{
			(self:GetCfgText(1000138))
		},
		[17] = {
			[0] = self:GetCfgText(1000139)
		},
		[18] = {
			self:GetCfgText(1000140),
			self:GetCfgText(1000141),
			(self:GetCfgText(1000142))
		},
		[19] = {
			[0] = self:GetCfgText(1000143),
			(self:GetCfgText(1000144))
		},
		[20] = {
			[0] = self:GetCfgText(1000145),
			(self:GetCfgText(1000146))
		},
		[22] = {
			self:GetCfgText(1000145),
			(self:GetCfgText(1000145))
		}
	}
end

function CommonTipsApi:GetItemTypeText(type, subType)
	local typeTable = self.ItemTypeDesc[type]

	if typeTable == nil then
		logError("CommonTipsApi.ItemTypeDesc 未配置对应的道具类型 " .. tostring(type))

		return ""
	end

	local result = typeTable[subType]

	if result == nil then
		logError("CommonTipsApi.ItemTypeDesc 未配置大类型 【" .. tostring(type) .. "】 对应的子类型 " .. tostring(subType))

		return ""
	end

	return result
end

function CommonTipsApi:GetQualityBackground(quality)
	return string.format(self:GetResUrl(2100), quality)
end

function CommonTipsApi:GetUserButtonText()
	return self:GetCfgText(5100003)
end

function CommonTipsApi:GetSellButtonText()
	return self:GetCfgText(120014)
end

function CommonTipsApi:GetMonthCardRewardTypeText(type)
	if type == 1 then
		return self:GetCfgText(1400066)
	else
		return self:GetCfgText(1400067)
	end

	return ""
end

CommonTipsApi:Init()
