-- chunkname: @IQIGame\\UIExternalApi\\EquipStrengthUIApi.lua

EquipStrengthUIApi = BaseLangApi:Extend()

function EquipStrengthUIApi:Init()
	return
end

function EquipStrengthUIApi:GetQualityAttr(str, quality)
	if quality == 1 then
		return self.PropQualityLang[1] .. str .. self.PropQualityLang[0]
	elseif quality == 2 then
		return self.PropQualityLang[2] .. str .. self.PropQualityLang[0]
	elseif quality == 3 then
		return self.PropQualityLang[3] .. str .. self.PropQualityLang[0]
	elseif quality == 4 then
		return self.PropQualityLang[4] .. str .. self.PropQualityLang[0]
	elseif quality == 5 then
		return self.PropQualityLang[5] .. str .. self.PropQualityLang[0]
	end

	return str
end

function EquipStrengthUIApi:GetConditionText(lv)
	return string.format("灵契强化至 +%s解锁", lv)
end

function EquipStrengthUIApi:GetCostText(haveNum, needNum)
	if needNum < haveNum then
		return string.format(self.TextColor[4] .. "%s" .. self.TextColor[0] .. "/%s", haveNum, needNum)
	end

	return string.format(self.TextColor[2] .. "%s" .. self.TextColor[0] .. "/%s", haveNum, needNum)
end

function EquipStrengthUIApi:GetPropertyItemText(name, canWash)
	if canWash then
		return self.TextColor[4] .. name .. self.TextColor[0]
	end

	return self.TextColor[9] .. name .. self.TextColor[0]
end

function EquipStrengthUIApi:GetDescText(cid, attrName)
	if cid == 210 then
		return string.format("可随机获得 <b>新随机词条</b> 并进行替换")
	elseif cid == 211 then
		return string.format("可随机 <b>%s</b> 并进行替换", attrName)
	end

	return ""
end

EquipStrengthUIApi:Init()
