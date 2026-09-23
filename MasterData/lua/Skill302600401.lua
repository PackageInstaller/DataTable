-- 饥呃逆
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill302600401 = oo.class(SkillBase)
function Skill302600401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill302600401:DoSkill(caster, target, data)
	-- 302600401
	self.order = self.order + 1
	self:AddProgress(SkillEffect[302600401], caster, target, data, 100)
end
