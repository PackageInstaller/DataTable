-- 蜘蛛召唤物2技能1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill914400101 = oo.class(SkillBase)
function Skill914400101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill914400101:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
-- 入场时
function Skill914400101:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 914400203
	self:CallSkillEx(SkillEffect[914400203], caster, self.card, data, 914400201)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9144002031
	self:CallSkillEx(SkillEffect[9144002031], caster, self.card, data, 914400202)
end
