-- 全体5段
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill932900501 = oo.class(SkillBase)
function Skill932900501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill932900501:DoSkill(caster, target, data)
	-- 12005
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12005], caster, target, data, 0.2,5)
end
-- 攻击结束
function Skill932900501:OnAttackOver(caster, target, data)
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
	-- 932900501
	self:AddProgress(SkillEffect[932900501], caster, target, data, -300)
end
