-- 水瓶座召唤技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984700501 = oo.class(SkillBase)
function Skill984700501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill984700501:CanSummon()
	return self.card:CanSummon(160105548,3,{1,3},{progress=300})
end
function Skill984700501:CanSummon()
	return self.card:CanSummon(160105536,3,{1,2},{progress=200})
end
function Skill984700501:CanSummon()
	return self.card:CanSummon(160105524,3,{1,1},{progress=100})
end
-- 执行技能
function Skill984700501:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 984700501
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[984700501], caster, self.card, data, 160105524,3,{1,1},{progress=100})
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 984700502
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[984700502], caster, self.card, data, 160105536,3,{1,2},{progress=200})
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 984700503
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[984700503], caster, self.card, data, 160105548,3,{1,3},{progress=300})
end
