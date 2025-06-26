-- chunkname: @IQIGame\\UIExternalApi\\PlayerAccusationUIApi.lua

PlayerAccusationUIApi = BaseLangApi:Extend()

function PlayerAccusationUIApi:Init()
	self:RegisterApi("title", self.GetTitle)
	self:RegisterApi("btnSendTxt", self.GetBtnSendTxt)
	self:RegisterApi("toggleName", self.GetToggleName)
	self:RegisterApi("inputContent", self.GetInputContent)
	self:RegisterApi("defaultInputTxt", self.GetDefaultInputTxt)
end

function PlayerAccusationUIApi:GetDefaultInputTxt()
	return self:GetCfgText(3504001)
end

function PlayerAccusationUIApi:GetTitle()
	return self:GetCfgText(3504002)
end

function PlayerAccusationUIApi:GetBtnSendTxt()
	return self:GetCfgText(3504003)
end

function PlayerAccusationUIApi:GetToggleName(index)
	if index == 1 then
		return self:GetCfgText(3504004)
	elseif index == 2 then
		return self:GetCfgText(3504005)
	elseif index == 3 then
		return self:GetCfgText(3504006)
	elseif index == 4 then
		return self:GetCfgText(3504007)
	elseif index == 5 then
		return self:GetCfgText(3504008)
	else
		return self:GetCfgText(3504009)
	end
end

function PlayerAccusationUIApi:GetInputContent(content)
	return content
end

PlayerAccusationUIApi:Init()
