-- chunkname: @IQIGame\\UIExternalApi\\SingleWeakTowerFloorDetailUIApi.lua

SingleWeakTowerFloorDetailUIApi = BaseLangApi:Extend()

function SingleWeakTowerFloorDetailUIApi:Init()
	self:RegisterApi("TextTitleType", self.GetTextTitleType)
	self:RegisterApi("RecommendPowerText", self.GetRecommendPowerText)
	self:RegisterApi("TextPower", self.GetTextPower)
	self:RegisterApi("WeakImgPath", self.GetWeakImgPath)
end

function SingleWeakTowerFloorDetailUIApi:GetWeakImgPath(type)
	local path = UIGlobalApi.GetImagePath("/MainCity/ChallengeTower/ChallengeTowerChallengeUI/ChallengeTowerChallenge_Weak_04.png")

	if type == 1 then
		path = UIGlobalApi.GetImagePath("/MainCity/ChallengeTower/ChallengeTowerChallengeUI/ChallengeTowerChallenge_Weak_01.png")
	elseif type == 2 then
		path = UIGlobalApi.GetImagePath("/MainCity/ChallengeTower/ChallengeTowerChallengeUI/ChallengeTowerChallenge_Weak_04.png")
	elseif type == 3 then
		path = UIGlobalApi.GetImagePath("/MainCity/ChallengeTower/ChallengeTowerChallengeUI/ChallengeTowerChallenge_Weak_02.png")
	elseif type == 4 then
		path = UIGlobalApi.GetImagePath("/MainCity/ChallengeTower/ChallengeTowerChallengeUI/ChallengeTowerChallenge_Weak_05.png")
	elseif type == 5 then
		path = UIGlobalApi.GetImagePath("/MainCity/ChallengeTower/ChallengeTowerChallengeUI/ChallengeTowerChallenge_Weak_03.png")
	end

	return path
end

function SingleWeakTowerFloorDetailUIApi:GetTextPower(power, needPower)
	local rate = needPower / power

	if rate >= 1.25 then
		return self.TextColor[203] .. power .. self.TextColor[0]
	elseif rate >= 1.05 then
		return self.TextColor[218] .. power .. self.TextColor[0]
	elseif rate >= 0.95 then
		return self.TextColor[206] .. power .. self.TextColor[0]
	elseif rate >= 0.75 then
		return self.TextColor[201] .. power .. self.TextColor[0]
	else
		return self.TextColor[219] .. power .. self.TextColor[0]
	end
end

function SingleWeakTowerFloorDetailUIApi:GetRecommendPowerText(recommendPower)
	return self:GetCfgText(2100005) .. "：" .. recommendPower
end

function SingleWeakTowerFloorDetailUIApi:GetTextTitleType(type)
	local typeName = ""

	if type == 1 then
		typeName = self:GetCfgText(9101501)
	elseif type == 2 then
		typeName = self:GetCfgText(9101502)
	elseif type == 3 then
		typeName = self:GetCfgText(9101503)
	elseif type == 4 then
		typeName = self:GetCfgText(9101504)
	elseif type == 5 then
		typeName = self:GetCfgText(9101505)
	end

	return typeName
end

SingleWeakTowerFloorDetailUIApi:Init()
