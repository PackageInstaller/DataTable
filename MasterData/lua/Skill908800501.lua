-- 轰炸攻击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill908800501 = oo.class(SkillBase)
function Skill908800501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill908800501:DoSkill(caster, target, data)
	-- 12008
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12008], caster, target, data, 0.125,8)
end
-- 攻击结束
function Skill908800501:OnAttackOver(caster, target, data)
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
	-- 908800501
	self:HitAddBuff(SkillEffect[908800501], caster, target, data, 2500,3004,1)
end
