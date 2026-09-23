-- 护盾构筑
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill100100204 = oo.class(SkillBase)
function Skill100100204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill100100204:DoSkill(caster, target, data)
	-- 2134
	self.order = self.order + 1
	self:AddBuff(SkillEffect[2134], caster, target, data, 2134)
end
