-- 折光之钥
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill601900304 = oo.class(SkillBase)
function Skill601900304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill601900304:DoSkill(caster, target, data)
	-- 601900301
	self.order = self.order + 1
	self:AddBuff(SkillEffect[601900301], caster, target, data, 601900301)
	-- 601900302
	self.order = self.order + 1
	self:ChangeSkill(SkillEffect[601900302], caster, target, data, 3,601900401)
end
