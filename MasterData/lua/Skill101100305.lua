-- 坚不可摧
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill101100305 = oo.class(SkillBase)
function Skill101100305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill101100305:DoSkill(caster, target, data)
	-- 101100305
	self.order = self.order + 1
	self:AddBuff(SkillEffect[101100305], caster, target, data, 101100305)
end
