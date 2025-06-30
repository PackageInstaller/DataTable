-- chunkname: @IQIGame\\UIExternalApi\\EndlessMazeRuneSuitTipUIApi.lua

EndlessMazeRuneSuitTipUIApi = BaseLangApi:Extend()

function EndlessMazeRuneSuitTipUIApi:Init()
	self:RegisterApi("NameText", self.GetNameText)
	self:RegisterApi("SuitEffectText", self.GetSuitEffectText)
end

function EndlessMazeRuneSuitTipUIApi:GetNameText(name, partNum)
	return string.format(self:GetCfgText(2200101), name, partNum)
end

function EndlessMazeRuneSuitTipUIApi:GetSuitEffectText(needNum, isActive, buffText, attrNames, attrValues)
	local color

	color = isActive and "#ffffff" or "#afafaf"

	local text

	if buffText ~= nil then
		text = buffText
	else
		text = ""

		for i = 1, #attrNames do
			text = text .. attrNames[i]
			text = text .. "+"
			text = text .. attrValues[i]

			if i < #attrNames then
				text = text .. " "
			end
		end
	end

	return string.format("<color=%s>(%s)%s</color>", color, needNum, text)
end

EndlessMazeRuneSuitTipUIApi:Init()
