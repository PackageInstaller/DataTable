-- 火力全开
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1030207 = oo.class(SkillBase)
function Skill1030207:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1030207:DoSkill(caster, target, data)
	-- 1030207
	self.order = self.order + 1
	self:AddBuff(SkillEffect[1030207], caster, target, data, 1030207)
end
