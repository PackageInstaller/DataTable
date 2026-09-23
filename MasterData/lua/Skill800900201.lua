-- 屏障护壁
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill800900201 = oo.class(SkillBase)
function Skill800900201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill800900201:DoSkill(caster, target, data)
	-- 2109
	self.order = self.order + 1
	self:AddBuff(SkillEffect[2109], caster, target, data, 2109)
end
