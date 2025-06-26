-- chunkname: @IQIGame\\UIExternalApi\\PuzzleUIApi.lua

PuzzleUIApi = BaseLangApi:Extend()

function PuzzleUIApi:GetInvestigateStepText()
	return self:GetCfgText(7000009)
end

function PuzzleUIApi:GetGainStepText()
	return self:GetCfgText(7000010)
end

function PuzzleUIApi:GetUpdateStepText()
	return self:GetCfgText(7000011)
end

function PuzzleUIApi:GetCombineStepText()
	return self:GetCfgText(7000012)
end
