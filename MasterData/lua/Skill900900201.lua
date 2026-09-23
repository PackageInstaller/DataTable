-- 能量填充
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill900900201 = oo.class(SkillBase)
function Skill900900201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill900900201:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 900900201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[900900201], caster, self.card, data, 900900201)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 900900201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[900900201], caster, self.card, data, 900900201)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 900900201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[900900201], caster, self.card, data, 900900201)
end
