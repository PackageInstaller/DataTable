-- 圣愈
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200700405 = oo.class(SkillBase)
function Skill200700405:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200700405:DoSkill(caster, target, data)
	-- 8468
	local count68 = SkillApi:GetAttr(self, caster, target,2,"maxhp")
	-- 8467
	local count67 = SkillApi:GetAttr(self, caster, target,2,"hp")
	-- 200700202
	self.order = self.order + 1
	self:EnergyCure(SkillEffect[200700202], caster, target, data, (count68-count67)*0.3)
end
