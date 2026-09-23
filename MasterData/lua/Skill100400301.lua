-- 弧光壁垒
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill100400301 = oo.class(SkillBase)
function Skill100400301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill100400301:DoSkill(caster, target, data)
	-- 100400301
	self.order = self.order + 1
	self:AddLightShieldCount(SkillEffect[100400301], caster, target, data, 2309,2,10)
end
