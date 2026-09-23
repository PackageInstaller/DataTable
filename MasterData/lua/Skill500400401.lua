-- 数据同调
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500400401 = oo.class(SkillBase)
function Skill500400401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500400401:DoSkill(caster, target, data)
	-- 50002
	self.order = self.order + 1
	self:Unite(SkillEffect[50002], caster, target, data, 50041,{progress=1010})
end
