-- 阵地构造
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703400301 = oo.class(SkillBase)
function Skill703400301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill703400301:DoSkill(caster, target, data)
	-- 703400301
	self.order = self.order + 1
	self:AddBuff(SkillEffect[703400301], caster, target, data, 2181,3)
end
