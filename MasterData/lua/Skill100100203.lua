-- 护盾构筑
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill100100203 = oo.class(SkillBase)
function Skill100100203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill100100203:DoSkill(caster, target, data)
	-- 2133
	self.order = self.order + 1
	self:AddBuff(SkillEffect[2133], caster, target, data, 2133)
end
