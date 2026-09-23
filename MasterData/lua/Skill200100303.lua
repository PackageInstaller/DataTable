-- 乐驰音掣
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200100303 = oo.class(SkillBase)
function Skill200100303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200100303:DoSkill(caster, target, data)
	-- 200100303
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200100303], caster, target, data, 200100303)
end
