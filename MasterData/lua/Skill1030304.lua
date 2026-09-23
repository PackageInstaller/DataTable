-- 极速冷却
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1030304 = oo.class(SkillBase)
function Skill1030304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1030304:DoSkill(caster, target, data)
	-- 1030304
	self.order = self.order + 1
	self:DelBuff(SkillEffect[1030304], caster, target, data, 3003,1)
end
