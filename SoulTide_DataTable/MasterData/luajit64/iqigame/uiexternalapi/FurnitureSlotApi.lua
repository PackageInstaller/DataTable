-- chunkname: @IQIGame\\UIExternalApi\\FurnitureSlotApi.lua

FurnitureSlotApi = BaseLangApi:Extend()

function FurnitureSlotApi:Init()
	self:RegisterApi("TextColorName", self.GetTextColorName)
end

function FurnitureSlotApi:GetTextColorName(name, Quality)
	if Quality == 1 then
		return BaseLangApi.PropQualityLang[1] .. tostring(name) .. BaseLangApi.PropQualityLang[0]
	elseif Quality == 2 then
		return BaseLangApi.PropQualityLang[2] .. tostring(name) .. BaseLangApi.PropQualityLang[0]
	elseif Quality == 3 then
		return BaseLangApi.PropQualityLang[3] .. tostring(name) .. BaseLangApi.PropQualityLang[0]
	elseif Quality == 4 then
		return BaseLangApi.PropQualityLang[4] .. tostring(name) .. BaseLangApi.PropQualityLang[0]
	elseif Quality == 5 then
		return BaseLangApi.PropQualityLang[5] .. tostring(name) .. BaseLangApi.PropQualityLang[0]
	end

	return tostring(name)
end

FurnitureSlotApi:Init()
