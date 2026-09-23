-- 刺蝽
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4503002 = oo.class(SkillBase)
function Skill4503002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill4503002:OnAfterHurt(caster, target, data)
	-- 4503042
	self:tFunc_4503042_4503002(caster, target, data)
	self:tFunc_4503042_4503032(caster, target, data)
end
-- 伤害前
function Skill4503002:OnBefourHurt(caster, target, data)
	-- 4503062
	self:tFunc_4503062_4503012(caster, target, data)
	self:tFunc_4503062_4503052(caster, target, data)
end
-- 暴击伤害前(OnBefourHurt之前)
function Skill4503002:OnBefourCritHurt(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8429
	local count29 = SkillApi:BuffCount(self, caster, target,2,3,1003)
	-- 8112
	if SkillJudger:Greater(self, caster, self.card, true,count29,0) then
	else
		return
	end
	-- 4503022
	self:AddTempAttr(SkillEffect[4503022], caster, caster, data, "crit",0.16)
end
function Skill4503002:tFunc_4503062_4503052(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8429
	local count29 = SkillApi:BuffCount(self, caster, target,2,3,1003)
	-- 8112
	if SkillJudger:Greater(self, caster, self.card, true,count29,0) then
	else
		return
	end
	-- 4503052
	if self:Rand(3500) then
		self:AlterBufferByID(SkillEffect[4503052], caster, target, data, 1051,1)
	end
end
function Skill4503002:tFunc_4503042_4503032(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8429
	local count29 = SkillApi:BuffCount(self, caster, target,2,3,1003)
	-- 8112
	if SkillJudger:Greater(self, caster, self.card, true,count29,0) then
	else
		return
	end
	-- 8702
	local count702 = SkillApi:BuffCount(self, caster, target,2,3,1051)
	-- 8917
	if SkillJudger:Less(self, caster, target, true,count702,1) then
	else
		return
	end
	-- 4503032
	self:HitAddBuff(SkillEffect[4503032], caster, target, data, 2500,1051,2)
end
function Skill4503002:tFunc_4503042_4503002(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8429
	local count29 = SkillApi:BuffCount(self, caster, target,2,3,1003)
	-- 8822
	if SkillJudger:Less(self, caster, self.card, true,count29,1) then
	else
		return
	end
	-- 4503002
	self:HitAddBuff(SkillEffect[4503002], caster, target, data, 2500,1003,2)
end
function Skill4503002:tFunc_4503062_4503012(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8429
	local count29 = SkillApi:BuffCount(self, caster, target,2,3,1003)
	-- 8112
	if SkillJudger:Greater(self, caster, self.card, true,count29,0) then
	else
		return
	end
	-- 4503012
	if self:Rand(3500) then
		self:AlterBufferByID(SkillEffect[4503012], caster, target, data, 1003,1)
	end
end
