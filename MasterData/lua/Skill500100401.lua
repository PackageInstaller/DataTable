-- 数据同调
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500100401 = oo.class(SkillBase)
function Skill500100401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500100401:DoSkill(caster, target, data)
	-- 50001
	self.order = self.order + 1
	self:Unite(SkillEffect[50001], caster, target, data, 50011,{progress=1010})
end
