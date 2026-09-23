-- 刺蝽
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4503005 = oo.class(SkillBase)
function Skill4503005:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill4503005:OnAfterHurt(caster, target, data)
	-- 4503045
	self:tFunc_4503045_4503005(caster, target, data)
	self:tFunc_4503045_4503035(caster, target, data)
end
-- 伤害前
function Skill4503005:OnBefourHurt(caster, target, data)
	-- 4503065
	self:tFunc_4503065_4503015(caster, target, data)
	self:tFunc_4503065_4503055(caster, target, data)
end
-- 暴击伤害前(OnBefourHurt之前)
function Skill4503005:OnBefourCritHurt(caster, target, data)
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
	-- 4503025
	self:AddTempAttr(SkillEffect[4503025], caster, caster, data, "crit",0.40)
end
function Skill4503005:tFunc_4503045_4503005(caster, target, data)
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
	-- 4503005
	self:HitAddBuff(SkillEffect[4503005], caster, target, data, 4000,1003,2)
end
function Skill4503005:tFunc_4503065_4503015(caster, target, data)
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
	-- 4503015
	if self:Rand(5000) then
		self:AlterBufferByID(SkillEffect[4503015], caster, target, data, 1003,1)
	end
end
function Skill4503005:tFunc_4503065_4503055(caster, target, data)
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
	-- 4503055
	if self:Rand(5000) then
		self:AlterBufferByID(SkillEffect[4503055], caster, target, data, 1051,1)
	end
end
function Skill4503005:tFunc_4503045_4503035(caster, target, data)
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
	-- 4503035
	self:HitAddBuff(SkillEffect[4503035], caster, target, data, 4000,1051,2)
end
