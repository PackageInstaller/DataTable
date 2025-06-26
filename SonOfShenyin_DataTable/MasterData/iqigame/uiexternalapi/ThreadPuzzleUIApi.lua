-- chunkname: @IQIGame\\UIExternalApi\\ThreadPuzzleUIApi.lua

ThreadPuzzleUIApi = BaseLangApi:Extend()

function ThreadPuzzleUIApi:GetStepSuccessText()
	return self:GetCfgText(7000017)
end

function ThreadPuzzleUIApi:GetStepFailText()
	return self:GetCfgText(7000018)
end

function ThreadPuzzleUIApi:GetStartCluePuzzleText()
	return self:GetCfgText(7000019)
end

function ThreadPuzzleUIApi:GetStartImagePuzzleText()
	return self:GetCfgText(7000020)
end

function ThreadPuzzleUIApi:GetImagePuzzleSuccessText()
	return self:GetCfgText(7000021)
end
