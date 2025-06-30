-- chunkname: @IQIGame\\UIExternalApi\\EndlessMazeRuneLegendSuitTipUIApi.lua

EndlessMazeRuneLegendSuitTipUIApi = BaseLangApi:Extend()

function EndlessMazeRuneLegendSuitTipUIApi:Init()
	self:RegisterApi("NameText", self.GetNameText)
	self:RegisterApi("SuitEffectText", self.GetSuitEffectText)
end

function EndlessMazeRuneLegendSuitTipUIApi:GetNameText(num)
	return string.format(self:GetCfgText(2201001), num)
end

function EndlessMazeRuneLegendSuitTipUIApi:GetSuitEffectText(index, buffTexts)
	local text = "(" .. index .. ")"

	for i = 1, #buffTexts do
		text = text .. buffTexts[i]

		if i < #buffTexts then
			text = text .. ";"
		end
	end

	return text
end

EndlessMazeRuneLegendSuitTipUIApi:Init()
