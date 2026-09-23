-- 弱点锁定
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1000206 = oo.class(SkillBase)
function Skill1000206:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1000206:DoSkill(caster, target, data)
	-- 1000206
	self.order = self.order + 1
	self:AddBuff(SkillEffect[1000206], caster, target, data, 1000206)
end
