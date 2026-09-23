-- 圣域宣告（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill701301303 = oo.class(SkillBase)
function Skill701301303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill701301303:DoSkill(caster, target, data)
	-- 33028
	self.order = self.order + 1
	self:Cure(SkillEffect[33028], caster, target, data, 1,0.38)
end
