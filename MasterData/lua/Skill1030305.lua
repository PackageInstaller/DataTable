-- 极速冷却
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1030305 = oo.class(SkillBase)
function Skill1030305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1030305:DoSkill(caster, target, data)
	-- 1030305
	self.order = self.order + 1
	self:DelBuff(SkillEffect[1030305], caster, target, data, 3003,1)
end
