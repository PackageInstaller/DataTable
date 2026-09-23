-- 紧急修复
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill901800101 = oo.class(SkillBase)
function Skill901800101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill901800101:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 901800101
	self.order = self.order + 1
	self:Cure(SkillEffect[901800101], caster, target, data, 1,0.2)
end
