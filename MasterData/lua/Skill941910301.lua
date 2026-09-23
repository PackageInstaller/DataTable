-- 夜瞑技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill941910301 = oo.class(SkillBase)
function Skill941910301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill941910301:DoSkill(caster, target, data)
	-- 12005
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12005], caster, target, data, 0.2,5)
end
-- 攻击开始
function Skill941910301:OnAttackBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 704500303
	self:HitAddBuff(SkillEffect[704500303], caster, target, data, 10000,5606,2)
end
