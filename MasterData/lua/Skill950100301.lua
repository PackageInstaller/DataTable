-- 离魂者技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill950100301 = oo.class(SkillBase)
function Skill950100301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill950100301:CanSummon()
	return self.card:CanSummon(10000222,3,{1,3},{progress=300},nil,nil)
end
function Skill950100301:CanSummon()
	return self.card:CanSummon(10000221,3,{1,2},{progress=200},nil,nil)
end
function Skill950100301:CanSummon()
	return self.card:CanSummon(10000220,3,{1,1},{progress=100},nil,nil)
end
-- 执行技能
function Skill950100301:DoSkill(caster, target, data)
	-- 950100301
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[950100301], caster, self.card, data, 10000220,3,{1,1},{progress=100},nil,nil)
	-- 950100302
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[950100302], caster, self.card, data, 10000221,3,{1,2},{progress=200},nil,nil)
	-- 950100303
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[950100303], caster, self.card, data, 10000222,3,{1,3},{progress=300},nil,nil)
end
