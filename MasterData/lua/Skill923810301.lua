-- 指定坐标
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill923810301 = oo.class(SkillBase)
function Skill923810301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill923810301:DoSkill(caster, target, data)
	-- 4304
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4304], caster, target, data, 4304)
end
