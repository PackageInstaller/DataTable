-- 饥呃逆
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill302600403 = oo.class(SkillBase)
function Skill302600403:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill302600403:DoSkill(caster, target, data)
	-- 302600403
	self.order = self.order + 1
	self:AddProgress(SkillEffect[302600403], caster, target, data, 200)
end
