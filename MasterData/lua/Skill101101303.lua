-- 坚不可摧（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill101101303 = oo.class(SkillBase)
function Skill101101303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill101101303:DoSkill(caster, target, data)
	-- 101101303
	self.order = self.order + 1
	self:AddBuff(SkillEffect[101101303], caster, target, data, 101101303)
end
