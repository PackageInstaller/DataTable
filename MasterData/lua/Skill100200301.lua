-- 绝对壁垒
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill100200301 = oo.class(SkillBase)
function Skill100200301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill100200301:DoSkill(caster, target, data)
	-- 100200301
	self.order = self.order + 1
	self:AddBuff(SkillEffect[100200301], caster, target, data, 4604)
	-- 100201306
	self.order = self.order + 1
	self:OwnerAddBuffCount(SkillEffect[100201306], caster, target, data, 3404,1,2)
	-- 92013
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[92013], caster, target, data, 2,2)
end
