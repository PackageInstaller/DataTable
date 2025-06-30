-- chunkname: @IQIGame\\UIExternalApi\\CommonGiftTipsUIApi.lua

CommonGiftTipsUIApi = BaseLangApi:Extend()

function CommonGiftTipsUIApi:GetItemName(name, quality)
	return name
end

function CommonGiftTipsUIApi:GetPreviewTitle(giftSubType)
	if giftSubType == 1 then
		return self:GetCfgText(120009)
	elseif giftSubType == 2 then
		return self:GetCfgText(120010)
	elseif giftSubType == 3 then
		return self:GetCfgText(120011)
	elseif giftSubType == 4 then
		return self:GetCfgText(120012)
	elseif giftSubType == 5 then
		return ""
	end

	return self:GetCfgText(120013)
end

function CommonGiftTipsUIApi:GetPreviewItemName(name, quality)
	return name
end

function CommonGiftTipsUIApi:GetPreviewItemNum(num, quality)
	return num
end
