-- 机神传送
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703600502 = oo.class(SkillBase)
function Skill703600502:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill703600502:CanSummon()
	return self.card:CanSummon(10314112,1,{4,1},{progress=1001})
end
-- 执行技能
function Skill703600502:DoSkill(caster, target, data)
	-- 703600502
	self.order = self.order + 1
	self:Summon(SkillEffect[703600502], caster, self.card, data, 10314112,1,{4,1},{progress=1001})
end
-- 入场时
function Skill703600502:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 703600503
	self:AddBuff(SkillEffect[703600503], caster, self.card, data, 6111)
end
-- 行动结束2
function Skill703600502:OnActionOver2(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 8106
	if SkillJudger:Less(self, caster, self.card, true,count20,2) then
	else
		return
	end
	-- 8424
	local count24 = SkillApi:BuffCount(self, caster, target,3,3,6111)
	-- 8107
	if SkillJudger:Greater(self, caster, self.card, true,count24,0) then
	else
		return
	end
	-- 703600504
	self:ExtraRound(SkillEffect[703600504], caster, self.card, data, nil)
end
-- 回合开始时
function Skill703600502:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 8106
	if SkillJudger:Less(self, caster, self.card, true,count20,2) then
	else
		return
	end
	-- 8424
	local count24 = SkillApi:BuffCount(self, caster, target,3,3,6111)
	-- 8107
	if SkillJudger:Greater(self, caster, self.card, true,count24,0) then
	else
		return
	end
	-- 703600507
	self:Custom(SkillEffect[703600507], caster, self.card, data, "play_plot",{id=10051})
	-- 92017
	self:DelBufferForce(SkillEffect[92017], caster, self.card, data, 6111,2)
	-- 703600505
	self:AddSp(SkillEffect[703600505], caster, self.card, data, 100)
	-- 703600506
	self:Cure(SkillEffect[703600506], caster, self.card, data, 2,1)
end
