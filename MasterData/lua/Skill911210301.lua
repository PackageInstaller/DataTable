-- 克拉肯-狂暴
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill911210301 = oo.class(SkillBase)
function Skill911210301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill911210301:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
-- 攻击结束
function Skill911210301:OnAttackOver(caster, target, data)
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
	-- 911210301
	self:HitAddBuff(SkillEffect[911210301], caster, target, data, 10000,5204)
	-- 911210302
	self:HitAddBuff(SkillEffect[911210302], caster, target, data, 1200,3004)
	-- 911210303
	self:DelBufferGroup(SkillEffect[911210303], caster, target, data, 2,2)
end
