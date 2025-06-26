-- chunkname: @IQIGame\\UIExternalApi\\BaseLangApi.lua

BaseLangApi = {
	langApiFuncList = {}
}

function BaseLangApi:Extend()
	local cls

	cls = Clone(self)
	cls.__index = cls

	setmetatable(cls, getmetatable(self))

	if cls.__childInit and type(cls.__childInit) == "function" then
		cls:__childInit()
	end

	return cls
end

function BaseLangApi.New()
	return Clone(BaseLangApi)
end

function BaseLangApi:RegisterApi(uiName, func)
	self.langApiFuncList[uiName] = func
end

function BaseLangApi:GetString(refName, ...)
	local func = self.langApiFuncList[refName]

	if func == nil then
		log(refName)
	end

	return func(self, ...)
end

function BaseLangApi:ReplacePlaceholder(args, str)
	local ret = str

	for i, v in ipairs(args) do
		ret = string.gsub(ret, "%%s", i, 1)
	end

	return ret
end

function BaseLangApi:GetCfgText(cfgID, ...)
	return getTipText(cfgID, ...)
end

function BaseLangApi:GetResUrl(cfgID)
	return CfgResourceTable[cfgID].Url
end

function BaseLangApi:GetAttrName(id)
	return self:GetCfgText(100 + id)
end

function BaseLangApi:GetAttrEngName(id)
	return self:GetCfgText(1000 + id)
end

function BaseLangApi:Space(num)
	local space = " "

	num = num - 1

	for i = 1, num do
		space = space .. space
	end

	return space
end

function BaseLangApi:FontSize(desc, size)
	return "<size=" .. size .. ">" .. desc .. "</size>"
end

function BaseLangApi:Blank(desc, num)
	local countLimit = SubStringGetTotalIndex(desc)
	local blankDesc

	for timeCount = 1, countLimit do
		if timeCount == countLimit then
			desc1 = SubStringUTF8(desc, timeCount, timeCount)
		else
			desc1 = SubStringUTF8(desc, timeCount, timeCount) .. self:Space(num)
		end

		if timeCount == 1 then
			blankDesc = desc1
		else
			blankDesc = blankDesc .. desc1
		end

		timeCount = timeCount + 1
	end

	return blankDesc
end

function BaseLangApi:SkillValueColor(Desc, ColorNum)
	if ColorNum == nil or type(ColorNum) ~= "number" then
		return Desc
	end

	Desc = string.gsub(Desc, "%$[+-]?[0-9]*%.?[0-9]*%%?", self.TextColor[ColorNum] .. "%1" .. self.TextColor[0])
	Desc = string.gsub(Desc, "%$*([+-]?[0-9]*%.?[0-9]*%%?)", "%1")

	return Desc
end

function BaseLangApi:SkillValueSplit(desc, ColorNum)
	if ColorNum == nil then
		return desc
	end

	local Num = string.find(desc, "+") or string.find(desc, "-")
	local SkillDesc = string.sub(desc, 1, Num - 1)
	local SkillValue = string.sub(desc, Num, string.len(desc))

	return SkillDesc .. self.TextColor[ColorNum] .. SkillValue .. self.TextColor[0]
end

function BaseLangApi:Anonymous(desc, Num)
	return SubStringUTF8(desc, 1, Num) .. "***" .. SubStringUTF8(desc, SubStringGetTotalIndex(desc) - Num + 1, -1)
end

function BaseLangApi:FirstLarge(desc, split, size1, size2)
	local desc1 = SubStringUTF8(desc, 1, split)
	local desc2 = SubStringUTF8(desc, split + 1, -1)

	desc1 = "<size=" .. size1 .. ">" .. desc1 .. "</size>"

	if size2 ~= nil then
		desc2 = "<size=" .. size2 .. ">" .. desc2 .. "</size>"
	end

	desc = desc1 .. desc2

	return desc
end

function BaseLangApi:GetTimeDurationText(second, index)
	return getTimeDurationText(second, index)
end

function SubStringUTF8(str, startIndex, endIndex)
	if startIndex < 0 then
		startIndex = SubStringGetTotalIndex(str) + startIndex + 1
	end

	if endIndex ~= nil and endIndex < 0 then
		endIndex = SubStringGetTotalIndex(str) + endIndex + 1
	end

	if endIndex == nil then
		return string.sub(str, SubStringGetTrueIndex(str, startIndex))
	else
		return string.sub(str, SubStringGetTrueIndex(str, startIndex), SubStringGetTrueIndex(str, endIndex + 1) - 1)
	end
end

function SubStringGetTotalIndex(str)
	local curIndex = 0
	local i = 1
	local lastCount = 1

	repeat
		lastCount = SubStringGetByteCount(str, i)
		i = i + lastCount
		curIndex = curIndex + 1
	until lastCount == 0

	return curIndex - 1
end

function SubStringGetTrueIndex(str, index)
	local curIndex = 0
	local i = 1
	local lastCount = 1

	repeat
		lastCount = SubStringGetByteCount(str, i)
		i = i + lastCount
		curIndex = curIndex + 1
	until index <= curIndex

	return i - lastCount
end

function SubStringGetByteCount(str, index)
	local curByte = string.byte(str, index)
	local byteCount = 1

	if curByte == nil then
		byteCount = 0
	elseif curByte > 0 and curByte <= 127 then
		byteCount = 1
	elseif curByte >= 192 and curByte <= 223 then
		byteCount = 2
	elseif curByte >= 224 and curByte <= 239 then
		byteCount = 3
	elseif curByte >= 240 and curByte <= 247 then
		byteCount = 4
	end

	return byteCount
end

BaseLangApi.SkillAttrColor = {
	[0] = "</color>",
	"<color=#FF0000>"
}
BaseLangApi.EquipQualityLang = {
	[0] = "</color>",
	"<color=#afafaf>",
	"<color=#abc845>",
	"<color=#5cbcff>",
	"<color=#ca86ff>",
	"<color=#ff944d>"
}
BaseLangApi.EquipQualityColor = {
	Color(0.685, 0.685, 0.685, 1),
	Color(0.67, 0.785, 0.27, 1),
	Color(0.36, 0.737, 1, 1),
	Color(0.792, 0.525, 1, 1),
	(Color(1, 0.58, 0.301, 1))
}
BaseLangApi.SoulQualityLang = {
	[0] = "</color>",
	"<color=#afafaf>",
	"<color=#abc845>",
	"<color=#5cbcff>",
	"<color=#ca86ff>",
	"<color=#ff944d>"
}
BaseLangApi.SkillQualityLang = {
	[0] = "</color>",
	"<color=#afafaf>",
	"<color=#abc845>",
	"<color=#5cbcff>",
	"<color=#ca86ff>",
	"<color=#ff944d>"
}
BaseLangApi.PropQualityLang = {
	[0] = "</color>",
	"<color=#afafaf>",
	"<color=#abc845>",
	"<color=#5cbcff>",
	"<color=#ca86ff>",
	"<color=#ff944d>"
}
BaseLangApi.BodyQualityLang = {
	[0] = "</color>",
	"<color=#afafaf>",
	"<color=#abc845>",
	"<color=#5cbcff>",
	"<color=#ca86ff>",
	"<color=#ff944d>"
}
BaseLangApi.CurrencyQualityLang = {
	[0] = "</color>",
	"<color=#afafaf>",
	"<color=#abc845>",
	"<color=#5cbcff>",
	"<color=#ca86ff>",
	"<color=#ff944d>"
}
BaseLangApi.PieceQualityLang = {
	[0] = "</color>",
	"<color=#afafaf>",
	"<color=#abc845>",
	"<color=#5cbcff>",
	"<color=#ca86ff>",
	"<color=#ff944d>"
}
BaseLangApi.PuppetQualityLang = {
	[0] = "</color>",
	"<color=#afafaf>",
	"<color=#abc845>",
	"<color=#5cbcff>",
	"<color=#ca86ff>",
	"<color=#ff944d>"
}
BaseLangApi.PuppetTitleQualityLang = {
	[0] = "</color>",
	"<color=#afafaf>",
	"<color=#abc845>",
	"<color=#5cbcff>",
	"<color=#ca86ff>",
	"<color=#ff944d>"
}
BaseLangApi.ChallengeLang = {
	[0] = "</color>",
	"<color=#ff9595>",
	"<color=#d7a5fd>",
	"<color=#95dbff>",
	"<color=#ffdd8a>"
}
BaseLangApi.TextColor = {
	[0] = "</color>",
	"<color=#FF0000>",
	"<color=#FF7676>",
	"<color=#e04a37>",
	"<color=#FFFFFF>",
	"<color=#6F6F6F>",
	"<color=#ffe329>",
	"<color=#ff9844>",
	"<color=#ff7676>",
	"<color=#000000>"
}
BaseLangApi.ActivityPassUI = {
	activityTypeNoSelect = "<color=#FFFFFF>%s</color>",
	activityTypeSelect = "<color=#000000>%s</color>"
}
