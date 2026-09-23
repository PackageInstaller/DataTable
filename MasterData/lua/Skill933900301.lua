-- 复活
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill933900301 = oo.class(SkillBase)
function Skill933900301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill933900301:DoSkill(caster, target, data)
	-- 703600201
	self.order = self.order + 1
	self:Revive(SkillEffect[703600201], caster, target, data, 1,0.30,{progress=600})
end
