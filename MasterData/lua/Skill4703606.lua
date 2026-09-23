-- 拉被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4703606 = oo.class(SkillBase)
function Skill4703606:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4703606:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4703609
	self:AddXp(SkillEffect[4703609], caster, self.card, data, 1)
	-- 8419
	local count19 = SkillApi:GetAttr(self, caster, target,3,"xp")
	-- 8153
	if SkillJudger:Greater(self, caster, self.card, true,count19,2) then
	else
		return
	end
	-- 4703610
	self:CallSkill(SkillEffect[4703610], caster, self.card, data, 703600401)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4703611
	self:AddXp(SkillEffect[4703611], caster, self.card, data, -2)
end
