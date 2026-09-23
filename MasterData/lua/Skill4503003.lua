-- 刺蝽
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4503003 = oo.class(SkillBase)
function Skill4503003:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill4503003:OnAfterHurt(caster, target, data)
	-- 4503043
	self:tFunc_4503043_4503003(caster, target, data)
	self:tFunc_4503043_4503033(caster, target, data)
end
-- 伤害前
function Skill4503003:OnBefourHurt(caster, target, data)
	-- 4503063
	self:tFunc_4503063_4503013(caster, target, data)
	self:tFunc_4503063_4503053(caster, target, data)
end
-- 暴击伤害前(OnBefourHurt之前)
function Skill4503003:OnBefourCritHurt(caster, target, data)
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
	-- 4503023
	self:AddTempAttr(SkillEffect[4503023], caster, caster, data, "crit",0.24)
end
function Skill4503003:tFunc_4503043_4503003(caster, target, data)
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
	-- 4503003
	self:HitAddBuff(SkillEffect[4503003], caster, target, data, 3000,1003,2)
end
function Skill4503003:tFunc_4503063_4503053(caster, target, data)
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
	-- 4503053
	if self:Rand(4000) then
		self:AlterBufferByID(SkillEffect[4503053], caster, target, data, 1051,1)
	end
end
function Skill4503003:tFunc_4503043_4503033(caster, target, data)
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
	-- 4503033
	self:HitAddBuff(SkillEffect[4503033], caster, target, data, 3000,1051,2)
end
function Skill4503003:tFunc_4503063_4503013(caster, target, data)
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
	-- 4503013
	if self:Rand(4000) then
		self:AlterBufferByID(SkillEffect[4503013], caster, target, data, 1003,1)
	end
end
