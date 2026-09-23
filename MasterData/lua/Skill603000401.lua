-- 数据同调
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill603000401 = oo.class(SkillBase)
function Skill603000401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill603000401:DoSkill(caster, target, data)
	-- 50005
	self.order = self.order + 1
	self:Unite(SkillEffect[50005], caster, target, data, 60301,{progress=1010})
end
