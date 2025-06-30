-- chunkname: @IQIGame\\UIExternalApi\\LoadingUIApi.lua

LoadingUIApi = BaseLangApi:Extend()

function LoadingUIApi:Init()
	self:RegisterApi("goProgressTxt", self.GetProgressText)
	self:RegisterApi("goLabeledProgressTxt", self.GetLabeledProgressText)
	self:RegisterApi("TextArea", self.GetTextArea)
	self:RegisterApi("Message1", self.GetMessage1)
	self:RegisterApi("Message2", self.GetMessage2)
	self:RegisterApi("Message3", self.GetMessage3)
	self:RegisterApi("Message4", self.GetMessage4)
	self:RegisterApi("Message5", self.GetMessage5)
	self:RegisterApi("Message6", self.GetMessage6)
	self:RegisterApi("Message8", self.GetMessage8)
	self:RegisterApi("Loading", self.GetLoading)
	self:RegisterApi("NormalTitleText", self.GetNormalTitleText)
	self:RegisterApi("NormalLoadingLabel", self.GetNormalLoadingLabel)
end

function LoadingUIApi:GetNormalTitleText()
	return self:GetCfgText(1236010)
end

function LoadingUIApi:GetLoading(index)
	if index == 1 then
		return self:GetCfgText(1236011)
	elseif index == 2 then
		return self:GetCfgText(1236012)
	end

	return self:GetCfgText(1236013)
end

function LoadingUIApi:GetMessage8(monsterCid)
	return self:GetCfgText(1236001)
end

function LoadingUIApi:GetMessage6(monsterCid)
	return self:GetCfgText(1236003)
end

function LoadingUIApi:GetMessage5(monsterCid)
	return self:GetCfgText(1236004)
end

function LoadingUIApi:GetMessage4(monsterCid)
	return self:GetCfgText(1236005)
end

function LoadingUIApi:GetMessage3(monsterCid)
	return self:GetCfgText(1236006)
end

function LoadingUIApi:GetMessage2(monsterCid)
	return self:GetCfgText(1236007)
end

function LoadingUIApi:GetMessage1(monsterCid)
	return self:GetCfgText(1236008)
end

function LoadingUIApi:GetTextArea(nam1, name2)
	return nam1 .. " - " .. name2
end

function LoadingUIApi:GetProgressText(progress)
	return math.ceil(progress * 100) .. "%"
end

function LoadingUIApi:GetLabeledProgressText(text, progress, monsterCid)
	return text .. math.ceil(progress * 100) .. "%"
end

function LoadingUIApi:GetNormalLoadingLabel(progress, index)
	local labelText

	if index == 1 then
		labelText = self:GetCfgText(1236011)
	elseif index == 2 then
		labelText = self:GetCfgText(1236012)
	else
		labelText = self:GetCfgText(1236013)
	end

	return math.floor(progress * 100) .. "%" .. labelText
end

LoadingUIApi:Init()
