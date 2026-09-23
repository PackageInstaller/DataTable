-- 修复禁止
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1040303 = oo.class(SkillBase)
function Skill1040303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1040303:DoSkill(caster, target, data)
	-- 1040303
	self.order = self.order + 1
	self:AddBuff(SkillEffect[1040303], caster, target, data, 1040303)
end
