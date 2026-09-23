-- 全体光盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill302100402 = oo.class(SkillBase)
function Skill302100402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill302100402:DoSkill(caster, target, data)
	-- 8378
	self.order = self.order + 1
	self:AddBuff(SkillEffect[8378], caster, target, data, 2103)
end
-- 伤害前
function Skill302100402:OnBefourHurt(caster, target, data)
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
	-- 302100301
	self:DelBuffQuality(SkillEffect[302100301], caster, target, data, 1,2)
end
