-- 坚不可摧（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill101101304 = oo.class(SkillBase)
function Skill101101304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill101101304:DoSkill(caster, target, data)
	-- 101101304
	self.order = self.order + 1
	self:AddBuff(SkillEffect[101101304], caster, target, data, 101101304)
end
