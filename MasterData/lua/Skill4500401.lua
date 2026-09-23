-- 千羽
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4500401 = oo.class(SkillBase)
function Skill4500401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4500401:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4500406
	self:AddSp(SkillEffect[4500406], caster, self.card, data, 20)
end
-- 伤害后
function Skill4500401:OnAfterHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 4500401
	if self:Rand(3000) then
		self:AddBuff(SkillEffect[4500401], caster, target, data, 4500401)
	end
end
