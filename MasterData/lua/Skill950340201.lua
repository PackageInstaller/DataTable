-- 凯2技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill950340201 = oo.class(SkillBase)
function Skill950340201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill950340201:DoSkill(caster, target, data)
	-- 4505
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4505], caster, target, data, 4505)
end
