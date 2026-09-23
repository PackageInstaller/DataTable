-- 协助防御
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill100200205 = oo.class(SkillBase)
function Skill100200205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill100200205:DoSkill(caster, target, data)
	-- 100200205
	self.order = self.order + 1
	self:AddBuff(SkillEffect[100200205], caster, target, data, 100200205)
end
