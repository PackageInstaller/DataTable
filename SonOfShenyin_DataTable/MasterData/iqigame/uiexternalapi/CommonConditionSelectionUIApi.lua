-- chunkname: @IQIGame\\UIExternalApi\\CommonConditionSelectionUIApi.lua

CommonConditionSelectionUIApi = BaseLangApi:Extend()

function CommonConditionSelectionUIApi:Init()
	return
end

function CommonConditionSelectionUIApi:GetQualityTitle(quality)
	return string.format("选择%s星", quality)
end

function CommonConditionSelectionUIApi:GetColorTitle(quality)
	if quality == 1 then
		return self.PropQualityLang[1] .. "选取白色品质" .. self.PropQualityLang[0]
	elseif quality == 2 then
		return self.PropQualityLang[2] .. "选取绿色品质" .. self.PropQualityLang[0]
	elseif quality == 3 then
		return self.PropQualityLang[3] .. "选取蓝色品质" .. self.PropQualityLang[0]
	elseif quality == 4 then
		return self.PropQualityLang[4] .. "选取紫色品质" .. self.PropQualityLang[0]
	elseif quality == 5 then
		return self.PropQualityLang[5] .. "选取橙色品质" .. self.PropQualityLang[0]
	end

	return self.PropQualityLang[1] .. "选取白色品质" .. self.PropQualityLang[0]
end

CommonConditionSelectionUIApi:Init()
