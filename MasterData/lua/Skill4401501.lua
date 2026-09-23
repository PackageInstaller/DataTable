-- 光学反射
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4401501 = oo.class(SkillBase)
function Skill4401501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束2
function Skill4401501:OnActionOver2(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8618
	local count618 = SkillApi:GetBeDamageLight(self, caster, target,3)
	-- 4401516
	self:AddValue(SkillEffect[4401516], caster, self.card, data, "c618",count618)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8618
	local count618 = SkillApi:GetBeDamageLight(self, caster, target,3)
	-- 8818
	if SkillJudger:Greater(self, caster, target, true,count618,0) then
	else
		return
	end
	-- 4401501
	self:BeatBack(SkillEffect[4401501], caster, self.card, data, 401500401,5)
end
