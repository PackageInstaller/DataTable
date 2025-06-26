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

	space = string.gsub(space, " ", "\\u00A0")

	return space
end

function BaseLangApi:FontSize(desc, size)
	return "<size=" .. size .. ">" .. desc .. "</size>"
end

function BaseLangApi:Blank(desc, num)
	local countLimit = self:SubStringGetTotalIndex(desc)
	local blankDesc

	for timeCount = 1, countLimit do
		if timeCount == countLimit then
			desc1 = self:SubStringUTF8(desc, timeCount, timeCount)
		else
			desc1 = self:SubStringUTF8(desc, timeCount, timeCount) .. self:Space(num)
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

function BaseLangApi:Anonymous(desc, Num)
	return self:SubStringUTF8(desc, 1, Num) .. "***" .. self:SubStringUTF8(desc, self:SubStringGetTotalIndex(desc) - Num + 1, -1)
end

function BaseLangApi:FirstLarge(desc, split, size1, size2)
	local desc1 = self:SubStringUTF8(desc, 1, split)
	local desc2 = self:SubStringUTF8(desc, split + 1, -1)

	desc1 = "<size=" .. size1 .. ">" .. desc1 .. "</size>"

	if size2 ~= nil then
		desc2 = "<size=" .. size2 .. ">" .. desc2 .. "</size>"
	end

	desc = desc1 .. desc2

	return desc
end

function BaseLangApi:ShortNum(count, num)
	if num == nil then
		num = 0
	end

	if string.len(count) >= 13 then
		count = math.floor(count * math.pow(10, num) / math.pow(10, 12)) / math.pow(10, num) .. "T"
	elseif string.len(count) >= 10 then
		count = math.floor(count * math.pow(10, num) / math.pow(10, 9)) / math.pow(10, num) .. "B"
	elseif string.len(count) >= 7 then
		count = math.floor(count * math.pow(10, num) / math.pow(10, 6)) / math.pow(10, num) .. "M"
	elseif string.len(count) >= 4 then
		count = math.floor(count * math.pow(10, num) / math.pow(10, 3)) / math.pow(10, num) .. "K"
	end

	return count
end

function BaseLangApi:SubStringUTF8(str, startIndex, endIndex)
	if startIndex < 0 then
		startIndex = self:SubStringGetTotalIndex(str) + startIndex + 1
	end

	if endIndex ~= nil and endIndex < 0 then
		endIndex = self:SubStringGetTotalIndex(str) + endIndex + 1
	end

	if endIndex == nil then
		return string.sub(str, self:SubStringGetTrueIndex(str, startIndex))
	else
		return string.sub(str, self:SubStringGetTrueIndex(str, startIndex), self:SubStringGetTrueIndex(str, endIndex + 1) - 1)
	end
end

function BaseLangApi:SubStringGetTotalIndex(str)
	local curIndex = 0
	local i = 1
	local lastCount = 1

	repeat
		lastCount = self:SubStringGetByteCount(str, i)
		i = i + lastCount
		curIndex = curIndex + 1
	until lastCount == 0

	return curIndex - 1
end

function BaseLangApi:SubStringGetTrueIndex(str, index)
	local curIndex = 0
	local i = 1
	local lastCount = 1

	repeat
		lastCount = self:SubStringGetByteCount(str, i)
		i = i + lastCount
		curIndex = curIndex + 1
	until index <= curIndex

	return i - lastCount
end

function BaseLangApi:SubStringGetByteCount(str, index)
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
BaseLangApi.ColorValue = {
	"#544a40",
	"#544a40",
	"#4a3a30",
	"#fff7cc",
	"#4a3a30",
	"#fff1d7",
	"#48230f",
	"#48230f",
	"#4c3928",
	"#4c3928",
	"#331a04",
	"#ffffff",
	"#183621",
	"#50ff79",
	"#2d2115",
	"#ffe27e",
	"#24130a",
	"#e16a0a",
	"#521707",
	"#ff5757",
	"#521707",
	"#ffc851",
	"#521707",
	"#fd9846",
	"#7bb6ff",
	"#737272",
	"#378837",
	"#db0a10",
	"#6bccfe",
	"#26d26b",
	"#000000",
	"#40d4ff",
	"#85fefe",
	"#aaaaaa",
	"#b1080b",
	"#6c6c6c",
	"#434343",
	"#ffe329",
	"#ff6969",
	"#54D086",
	"#e33535",
	nil,
	"#226fb7",
	"#ff5353",
	"#66ccff",
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	"#4ffc78",
	"#4ffc78",
	"#ffed1f",
	"#ffed1f",
	"#ff5757",
	"#ff5757",
	"#ffa650",
	"#ffa650",
	"#ffe5cb",
	"#ffe5cb",
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	"#56d88a",
	"#17a851",
	"#e33533",
	"#8e4cbd",
	"#ffecd5",
	"#ffe329",
	"#40d4ff",
	"#3bb7fe",
	"#ff69b0",
	"#ff89db",
	"#85fefe",
	"#e0fa1d",
	"#afafaf",
	"#4c4c4c",
	"#808080",
	"#616161",
	"#d1ff6f",
	"#fe9228",
	"#65e4ff",
	"#30a9fb",
	"#a5ff63",
	[1001] = "#60004f",
	[1000] = "#fffdea"
}
BaseLangApi.TextColor = {
	[0] = "</color>",
	"<color=#544a40>",
	"<color=#544a40>",
	"<color=#4a3a30>",
	"<color=#fff7cc>",
	"<color=#4a3a30>",
	"<color=#fff1d7>",
	"<color=#48230f>",
	"<color=#48230f>",
	"<color=#4c3928>",
	"<color=#4c3928>",
	"<color=#331a04>",
	"<color=#ffffff>",
	"<color=#183621>",
	"<color=#50ff79>",
	"<color=#2d2115>",
	"<color=#ffe27e>",
	"<color=#24130a>",
	"<color=#e16a0a>",
	"<color=#521707>",
	"<color=#ff5757>",
	"<color=#521707>",
	"<color=#ffc851>",
	"<color=#521707>",
	"<color=#fd9846>",
	"<color=#7bb6ff>",
	"<color=#737272>",
	"<color=#378837>",
	"<color=#db0a10>",
	"<color=#6bccfe>",
	"<color=#26d26b>",
	"<color=#000000>",
	"<color=#40d4ff>",
	"<color=#85fefe>",
	"<color=#aaaaaa>",
	"<color=#b1080b>",
	"<color=#6c6c6c>",
	"<color=#434343>",
	"<color=#ffe329>",
	"<color=#ff6969>",
	"<color=#54D086>",
	"<color=#e33535>",
	nil,
	"<color=#226fb7>",
	"<color=#ff5353>",
	"<color=#66ccff>",
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	"<color=#4ffc78>",
	"<color=#4ffc78>",
	"<color=#ffed1f>",
	"<color=#ffed1f>",
	"<color=#ff5757>",
	"<color=#ff5757>",
	"<color=#ffa650>",
	"<color=#ffa650>",
	"<color=#ffe5cb>",
	"<color=#ffe5cb>",
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	"<color=#56d88a>",
	"<color=#17a851>",
	"<color=#e33533>",
	"<color=#8e4cbd>",
	"<color=#ffecd5>",
	"<color=#ffe329>",
	"<color=#40d4ff>",
	"<color=#3bb7fe>",
	"<color=#ff69b0>",
	"<color=#ff89db>",
	"<color=#85fefe>",
	"<color=#e0fa1d>",
	"<color=#afafaf>",
	"<color=#4c4c4c>",
	"<color=#808080>",
	"<color=#616161>",
	"<color=#d1ff6f>",
	"<color=#fe9228>",
	"<color=#65e4ff>",
	"<color=#30a9fb>",
	"<color=#a5ff63>",
	"<color=#333333>",
	[1001] = "<color=#60004f>",
	[1000] = "<color=#fffdea>"
}
