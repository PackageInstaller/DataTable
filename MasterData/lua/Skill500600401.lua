-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500600401 = oo.class(SkillBase)
function Skill500600401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill500600401:CanSummon()
	return self.card:CanSummon(10000005,1,{0,2},{progress=600,arrRelevance={{id=10000006,pos={0,1},data={speed=1}},{id=10000006,pos={0,3},data={speed=1}}}})
end
-- 执行技能
function Skill500600401:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:Summon(SkillEffect[40004], caster, target, data, 10000005,1,{0,2},{progress=600,arrRelevance={{id=10000006,pos={0,1},data={speed=1}},{id=10000006,pos={0,3},data={speed=1}}}})
end
