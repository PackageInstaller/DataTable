-- 协助防御
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill100200204 = oo.class(SkillBase)
function Skill100200204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill100200204:DoSkill(caster, target, data)
	-- 100200204
	self.order = self.order + 1
	self:AddBuff(SkillEffect[100200204], caster, target, data, 100200204)
end
