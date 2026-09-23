-- 能源支援
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1010306 = oo.class(SkillBase)
function Skill1010306:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1010306:DoSkill(caster, target, data)
	-- 1010306
	self.order = self.order + 1
	self:AddBuff(SkillEffect[1010306], caster, target, data, 1010306)
end
