-- 数据同调
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill103300501 = oo.class(SkillBase)
function Skill103300501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill103300501:DoSkill(caster, target, data)
	-- 50007
	self.order = self.order + 1
	self:Unite(SkillEffect[50007], caster, target, data, 10331,{progress=1010})
end
