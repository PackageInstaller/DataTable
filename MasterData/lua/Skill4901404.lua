-- 灼烧特性
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4901404 = oo.class(SkillBase)
function Skill4901404:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4901404:OnAttackOver(caster, target, data)
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
	-- 4901404
	self:HitAddBuff(SkillEffect[4901404], caster, caster, data, 3000,1002,3)
end
-- 入场时
function Skill4901404:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4901411
	self:AddBuff(SkillEffect[4901411], caster, self.card, data, 4901411)
end
