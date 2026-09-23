-- 解体技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500410501 = oo.class(SkillBase)
function Skill500410501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500410501:DoSkill(caster, target, data)
	-- 4500419
	self.order = self.order + 1
	self:OwnerAddBuff(SkillEffect[4500419], caster, target, data, 4500404)
end
