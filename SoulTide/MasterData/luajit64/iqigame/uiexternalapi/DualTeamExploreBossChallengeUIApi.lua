-- chunkname: @IQIGame\\UIExternalApi\\DualTeamExploreBossChallengeUIApi.lua

DualTeamExploreBossChallengeUIApi = BaseLangApi:Extend()

function DualTeamExploreBossChallengeUIApi:Init()
	self:RegisterApi("TextBtnTitle", self.GetTextBtnTitle)
	self:RegisterApi("TextChallenge", self.GetTextChallenge)
	self:RegisterApi("TextNeedNum", self.GetTextNeedNum)
	self:RegisterApi("TextBtnShop", self.GetTextBtnShop)
	self:RegisterApi("TextBtnChallenge", self.GetTextBtnChallenge)
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextBossName", self.GetTextBossName)
	self:RegisterApi("UnLockEntityID", self.GetUnLockEntityID)
	self:RegisterApi("UnLockScale", self.GetUnLockScale)
	self:RegisterApi("UnLockPosition", self.GetUnLockPosition)
end

function DualTeamExploreBossChallengeUIApi:GetUnLockPosition()
	return Vector3.New(-20, -80, 0)
end

function DualTeamExploreBossChallengeUIApi:GetUnLockScale()
	return Vector3.New(50, 50, 1)
end

function DualTeamExploreBossChallengeUIApi:GetUnLockEntityID(openCount)
	if openCount == 1 then
		return 60301413
	elseif openCount == 2 then
		return 60301414
	elseif openCount == 3 then
		return 60301413
	end

	return 60301413
end

function DualTeamExploreBossChallengeUIApi:GetTextBtnTitle()
	return self:GetCfgText(3410501)
end

function DualTeamExploreBossChallengeUIApi:GetTextChallenge(isFree, unlock)
	if unlock then
		return self:GetCfgText(3100401)
	elseif isFree then
		return self:GetCfgText(3100403)
	end

	return self:GetCfgText(3100402)
end

function DualTeamExploreBossChallengeUIApi:GetTextNeedNum()
	return "x1011"
end

function DualTeamExploreBossChallengeUIApi:GetTextBtnShop()
	return self:GetCfgText(3410502)
end

function DualTeamExploreBossChallengeUIApi:GetTextBtnChallenge()
	return self:GetCfgText(3410503)
end

function DualTeamExploreBossChallengeUIApi:GetTextTitle(openCount)
	return self:GetCfgText(2000053)
end

function DualTeamExploreBossChallengeUIApi:GetTextBossName(name, isUnlock)
	if isUnlock then
		return name
	end

	return "?????    "
end

DualTeamExploreBossChallengeUIApi:Init()
