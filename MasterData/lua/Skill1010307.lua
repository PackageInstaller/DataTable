-- 能源支援
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1010307 = oo.class(SkillBase)
function Skill1010307:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1010307:DoSkill(caster, target, data)
	-- 1010307
	self.order = self.order + 1
	self:AddBuff(SkillEffect[1010307], caster, target, data, 1010307)
end
