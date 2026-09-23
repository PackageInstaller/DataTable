-- 庆典演出（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill201101303 = oo.class(SkillBase)
function Skill201101303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill201101303:DoSkill(caster, target, data)
	-- 201101303
	self.order = self.order + 1
	self:AddBuff(SkillEffect[201101303], caster, target, data, 201101303)
end
