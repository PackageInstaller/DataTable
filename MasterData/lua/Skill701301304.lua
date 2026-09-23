-- 圣域宣告（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill701301304 = oo.class(SkillBase)
function Skill701301304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill701301304:DoSkill(caster, target, data)
	-- 33029
	self.order = self.order + 1
	self:Cure(SkillEffect[33029], caster, target, data, 1,0.39)
end
