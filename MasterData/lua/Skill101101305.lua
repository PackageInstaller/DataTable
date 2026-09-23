-- 坚不可摧（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill101101305 = oo.class(SkillBase)
function Skill101101305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill101101305:DoSkill(caster, target, data)
	-- 101101305
	self.order = self.order + 1
	self:AddBuff(SkillEffect[101101305], caster, target, data, 101101305)
end
