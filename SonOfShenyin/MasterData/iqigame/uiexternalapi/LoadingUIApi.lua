-- chunkname: @IQIGame\\UIExternalApi\\LoadingUIApi.lua

LoadingUIApi = BaseLangApi:Extend()

function LoadingUIApi:GetNormalTitleText()
	return self:GetCfgText(1210013)
end

function LoadingUIApi:GetLoading(index)
	if index == 1 then
		return self:GetCfgText(4010002)
	elseif index == 2 then
		return self:GetCfgText(4010003)
	end

	return self:GetCfgText(4010004)
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
		labelText = self:GetCfgText(4010002)
	elseif index == 2 then
		labelText = self:GetCfgText(4010003)
	else
		labelText = self:GetCfgText(4010004)
	end

	return math.floor(progress * 100) .. "%" .. labelText
end
