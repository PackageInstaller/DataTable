-- 能源支援
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1010309 = oo.class(SkillBase)
function Skill1010309:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1010309:DoSkill(caster, target, data)
	-- 1010309
	self.order = self.order + 1
	self:AddBuff(SkillEffect[1010309], caster, target, data, 1010309)
end
