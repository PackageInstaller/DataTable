-- chunkname: @IQIGame\\UIExternalApi\\EndlessMazeRuneLockUIApi.lua

EndlessMazeRuneLockUIApi = BaseLangApi:Extend()

function EndlessMazeRuneLockUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("TipText", self.GetTipText)
	self:RegisterApi("CloseBtnText", self.GetCloseBtnText)
	self:RegisterApi("UnlockEffect", self.GetUnlockEffect)
end

function EndlessMazeRuneLockUIApi:GetTitleText(isUnlock)
	if isUnlock == false then
		return self:GetCfgText(2200040)
	else
		return self:GetCfgText(2200041)
	end
end

function EndlessMazeRuneLockUIApi:GetTipText(isUnlock)
	if isUnlock == false then
		return self:GetCfgText(2200042)
	else
		return ""
	end
end

function EndlessMazeRuneLockUIApi:GetCloseBtnText()
	return self:GetCfgText(2000003)
end

function EndlessMazeRuneLockUIApi:GetUnlockEffect(quality)
	if quality == 1 then
		return 9001638
	elseif quality == 2 then
		return 9001639
	elseif quality == 3 then
		return 9001640
	end

	return 9001638
end

EndlessMazeRuneLockUIApi:Init()
