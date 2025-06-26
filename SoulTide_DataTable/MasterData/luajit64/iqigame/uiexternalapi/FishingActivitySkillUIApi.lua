-- chunkname: @IQIGame\\UIExternalApi\\FishingActivitySkillUIApi.lua

FishingActivitySkillUIApi = BaseLangApi:Extend()

function FishingActivitySkillUIApi:Init()
	self:RegisterApi("TextSkillLv", self.GetTextSkillLv)
	self:RegisterApi("UpgradeSkillCost", self.GetUpgradeSkillCost)
	self:RegisterApi("ArmStrength", self.GetArmStrength)
	self:RegisterApi("ActionDes", self.GetActionDes)
	self:RegisterApi("ActionCost", self.GetActionCost)
	self:RegisterApi("TextSpend", self.GetTextSpend)
end

function FishingActivitySkillUIApi:GetTextSpend(num, isSufficient)
	if isSufficient then
		return self.TextColor[27] .. num .. self.TextColor[0]
	end

	return self.TextColor[105] .. num .. self.TextColor[0]
end

function FishingActivitySkillUIApi:GetActionCost(num, isSufficient)
	if isSufficient then
		return self.TextColor[27] .. num .. self.TextColor[0]
	end

	return self.TextColor[105] .. num .. self.TextColor[0]
end

function FishingActivitySkillUIApi:GetActionDes(strDes)
	return string.format("技能效果:%s", strDes)
end

function FishingActivitySkillUIApi:GetArmStrength(num)
	return string.format("%s kp", num)
end

function FishingActivitySkillUIApi:GetUpgradeSkillCost(num, isSufficient)
	if isSufficient then
		return self.TextColor[27] .. num .. self.TextColor[0]
	end

	return self.TextColor[105] .. num .. self.TextColor[0]
end

function FishingActivitySkillUIApi:GetTextSkillLv(lv)
	return lv
end

FishingActivitySkillUIApi:Init()
