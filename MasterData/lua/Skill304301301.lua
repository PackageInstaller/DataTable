-- 数据剥离（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill304301301 = oo.class(SkillBase)
function Skill304301301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill304301301:DoSkill(caster, target, data)
	-- 12008
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12008], caster, target, data, 0.125,8)
end
-- 攻击结束
function Skill304301301:OnAttackOver(caster, target, data)
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
	-- 304310301
	self:HitAddBuff(SkillEffect[304310301], caster, target, data, 10000,5006,2)
end
