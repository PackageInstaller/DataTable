-- chunkname: @IQIGame\\UIExternalApi\\SoulMarryConfirmUIApi.lua

SoulMarryConfirmUIApi = BaseLangApi:Extend()

function SoulMarryConfirmUIApi:Init()
	self:RegisterApi("TextPanelTitle", self.GetTextPanelTitle)
	self:RegisterApi("BtnOathsLabel", self.GetBtnOathsLabel)
	self:RegisterApi("TextSpend", self.GetTextSpend)
	self:RegisterApi("TextMsg", self.GetTextMsg)
	self:RegisterApi("TextTip", self.GetTextTip)
	self:RegisterApi("TextTime", self.GetTextTime)
end

function SoulMarryConfirmUIApi:GetTextTime(str, value, state)
	if state == 1 then
		return self:GetCfgText(1190016) .. "·" .. str
	elseif state == 2 then
		return self:GetCfgText(1190017) .. "·" .. str
	elseif state == 3 then
		return self:GetCfgText(1190018) .. "·" .. str
	elseif state == 4 then
		return self:GetCfgText(1190019) .. "·" .. str
	elseif state == 5 then
		return self:GetCfgText(1190020) .. "·" .. str
	end

	return str
end

function SoulMarryConfirmUIApi:GetTextTip()
	return self:GetCfgText(1239100)
end

function SoulMarryConfirmUIApi:GetTextMsg(num)
	return string.format(self:GetCfgText(1239101), self.TextColor[204] .. " " .. num .. " " .. self.TextColor[0])
end

function SoulMarryConfirmUIApi:GetTextSpend(name, needNum, top)
	if top then
		return self:GetCfgText(1014036) .. BaseLangApi.TextColor[202] .. string.format("%s x%s", name, needNum) .. BaseLangApi.TextColor[0]
	end

	return self:GetCfgText(1014036) .. BaseLangApi.TextColor[203] .. string.format("%s x%s", name, needNum) .. BaseLangApi.TextColor[0]
end

function SoulMarryConfirmUIApi:GetBtnOathsLabel(top)
	if top then
		return self:GetCfgText(1239102)
	end

	return self:GetCfgText(1239103)
end

function SoulMarryConfirmUIApi:GetTextPanelTitle()
	return self:GetCfgText(1239103)
end

SoulMarryConfirmUIApi:Init()
