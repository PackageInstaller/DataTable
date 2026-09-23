-- 普通攻击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill90030001 = oo.class(SkillBase)
function Skill90030001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 暴击
function Skill90030001:OnCrit(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 84001
	self:AddXp(SkillEffect[84001], caster, target, data, -1)
end
-- 执行技能
function Skill90030001:DoSkill(caster, target, data)
	-- 11001
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11001], caster, target, data, 1,1)
end
