-- 阵地构造（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703401303 = oo.class(SkillBase)
function Skill703401303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill703401303:DoSkill(caster, target, data)
	-- 703401303
	self.order = self.order + 1
	self:AddBuff(SkillEffect[703401303], caster, target, data, 2188,3)
end
