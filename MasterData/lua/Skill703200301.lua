-- 召唤
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703200301 = oo.class(SkillBase)
function Skill703200301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill703200301:CanSummon()
	return self.card:CanSummon(10000202,3,{1,3},{progress=700},nil,nil)
end
function Skill703200301:CanSummon()
	return self.card:CanSummon(10000201,3,{1,1},{progress=700},nil,nil)
end
-- 执行技能
function Skill703200301:DoSkill(caster, target, data)
	-- 703200301
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[703200301], caster, self.card, data, 10000201,3,{1,1},{progress=700},nil,nil)
	-- 703200302
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[703200302], caster, self.card, data, 10000202,3,{1,3},{progress=700},nil,nil)
end
-- 攻击结束
function Skill703200301:OnAttackOver(caster, target, data)
	-- 8061
	if SkillJudger:CasterIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 703200304
	self:Help(SkillEffect[703200304], caster, target, data, 2)
end
-- 行动结束2
function Skill703200301:OnActionOver2(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 703200303
	local targets = SkillFilter:All(self, caster, target, 1)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[703200303], caster, target, data, 4004,2)
	end
end
