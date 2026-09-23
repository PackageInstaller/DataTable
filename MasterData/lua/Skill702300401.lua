-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill702300401 = oo.class(SkillBase)
function Skill702300401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill702300401:CanSummon()
	return self.card:CanSummon(10000001,1,{0,1},{progress=600})
end
-- 执行技能
function Skill702300401:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:Summon(SkillEffect[40001], caster, target, data, 10000001,1,{0,1},{progress=600})
end
