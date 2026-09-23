-- 振奋士气
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200200204 = oo.class(SkillBase)
function Skill200200204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200200204:DoSkill(caster, target, data)
	-- 200200204
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200200204], caster, target, data, 200200204)
end
