-- 攻击妨碍
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1040109 = oo.class(SkillBase)
function Skill1040109:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1040109:DoSkill(caster, target, data)
	-- 1040109
	self.order = self.order + 1
	self:AddBuff(SkillEffect[1040109], caster, target, data, 1040109)
end
