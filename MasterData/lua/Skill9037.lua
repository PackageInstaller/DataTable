-- 助战（2角色助战）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9037 = oo.class(SkillBase)
function Skill9037:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill9037:CanSummon()
	return self.card:CanSummon(10000013,2,{3,3},{progress=900},nil,10054)
end
function Skill9037:CanSummon()
	return self.card:CanSummon(10000009,2,{1,1},{progress=900},10051,10052)
end
-- 回合开始时
function Skill9037:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8499
	local count99 = SkillApi:BuffCount(self, caster, target,3,4,9037)
	-- 8197
	if SkillJudger:Equal(self, caster, target, true,count99,0) then
	else
		return
	end
	-- 9037
	self:SummonTeammate(SkillEffect[9037], caster, self.card, data, 10000009,2,{1,1},{progress=900},10051,10052)
	-- 9040
	self:SummonTeammate(SkillEffect[9040], caster, self.card, data, 10000013,2,{3,3},{progress=900},nil,10054)
end
