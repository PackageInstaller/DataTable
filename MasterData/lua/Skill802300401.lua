-- 全体护盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill802300401 = oo.class(SkillBase)
function Skill802300401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill802300401:DoSkill(caster, target, data)
	-- 2119
	self.order = self.order + 1
	self:AddBuff(SkillEffect[2119], caster, target, data, 2119)
end
