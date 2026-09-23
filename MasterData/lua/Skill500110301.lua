-- 指令重装
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500110301 = oo.class(SkillBase)
function Skill500110301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500110301:DoSkill(caster, target, data)
	-- 12801
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12801], caster, target, data, 0.167,2)
	-- 12802
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[12802], caster, target, data, 0.166,4)
end
-- 攻击结束
function Skill500110301:OnAttackOver(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 500110301
	self:HitAddBuff(SkillEffect[500110301], caster, target, data, 10000,3010,1)
end
