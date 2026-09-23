-- 庆典演出（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill201101304 = oo.class(SkillBase)
function Skill201101304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill201101304:DoSkill(caster, target, data)
	-- 201101304
	self.order = self.order + 1
	self:AddBuff(SkillEffect[201101304], caster, target, data, 201101304)
end
