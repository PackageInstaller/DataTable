-- 天使猎杀（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill303101303 = oo.class(SkillBase)
function Skill303101303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill303101303:DoSkill(caster, target, data)
	-- 12705
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12705], caster, target, data, 0.25,2)
	-- 12706
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[12706], caster, target, data, 0.17,3)
end
-- 攻击结束
function Skill303101303:OnAttackOver(caster, target, data)
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
	-- 303100301
	self:HitAddBuff(SkillEffect[303100301], caster, target, data, 10000,5106)
	-- 303100302
	self:HitAddBuff(SkillEffect[303100302], caster, target, data, 10000,1001,2)
end
