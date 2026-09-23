-- 高卡萨斯3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill502500302 = oo.class(SkillBase)
function Skill502500302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill502500302:DoSkill(caster, target, data)
	-- 11005
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11005], caster, target, data, 0.2,5)
end
-- 伤害前
function Skill502500302:OnBefourHurt(caster, target, data)
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
	-- 502500301
	self:AddTempAttrPercent(SkillEffect[502500301], caster, target, data, "defense",-0.3)
end
-- 攻击结束
function Skill502500302:OnAttackOver(caster, target, data)
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
	-- 502500302
	self:AddProgress(SkillEffect[502500302], caster, target, data, -300)
end
