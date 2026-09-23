-- 攻击妨碍
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1040107 = oo.class(SkillBase)
function Skill1040107:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1040107:DoSkill(caster, target, data)
	-- 1040107
	self.order = self.order + 1
	self:AddBuff(SkillEffect[1040107], caster, target, data, 1040107)
end
