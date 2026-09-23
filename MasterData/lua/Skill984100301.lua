-- 巨蟹座普通形态技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984100301 = oo.class(SkillBase)
function Skill984100301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill984100301:CanSummon()
	return self.card:CanSummon(10000225,3,{1,3},{progress=300},nil,nil)
end
function Skill984100301:CanSummon()
	return self.card:CanSummon(10000224,3,{1,2},{progress=200},nil,nil)
end
function Skill984100301:CanSummon()
	return self.card:CanSummon(10000223,3,{1,1},{progress=100},nil,nil)
end
-- 执行技能
function Skill984100301:DoSkill(caster, target, data)
	-- 984100301
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[984100301], caster, self.card, data, 10000223,3,{1,1},{progress=100},nil,nil)
	-- 984100302
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[984100302], caster, self.card, data, 10000224,3,{1,2},{progress=200},nil,nil)
	-- 984100303
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[984100303], caster, self.card, data, 10000225,3,{1,3},{progress=300},nil,nil)
end
