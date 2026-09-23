-- 数据同调
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill304300401 = oo.class(SkillBase)
function Skill304300401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill304300401:DoSkill(caster, target, data)
	-- 50003
	self.order = self.order + 1
	self:Unite(SkillEffect[50003], caster, target, data, 30431,{progress=1010})
end
