-- 支援妨碍
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1040304 = oo.class(SkillBase)
function Skill1040304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1040304:DoSkill(caster, target, data)
	-- 1040304
	self.order = self.order + 1
	self:AddBuff(SkillEffect[1040304], caster, target, data, 1040304)
end
