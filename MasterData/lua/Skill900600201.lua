-- 能量填充
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill900600201 = oo.class(SkillBase)
function Skill900600201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill900600201:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 900600201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[900600201], caster, self.card, data, 900600201)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 900600201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[900600201], caster, self.card, data, 900600201)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 900600201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[900600201], caster, self.card, data, 900600201)
end
