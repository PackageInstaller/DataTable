-- 迅拍
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200100204 = oo.class(SkillBase)
function Skill200100204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200100204:DoSkill(caster, target, data)
	-- 200100204
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200100204], caster, target, data, 200100204)
	-- 200100206
	self.order = self.order + 1
	self:AddProgress(SkillEffect[200100206], caster, target, data, 1010)
end
