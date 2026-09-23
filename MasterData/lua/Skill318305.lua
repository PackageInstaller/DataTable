-- 受击转化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill318305 = oo.class(SkillBase)
function Skill318305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill318305:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 318311
	self:AddBuff(SkillEffect[318311], caster, self.card, data, 1021)
end
-- 攻击结束
function Skill318305:OnAttackOver(caster, target, data)
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
	-- 318305
	self:AddBuff(SkillEffect[318305], caster, self.card, data, 318305)
end
