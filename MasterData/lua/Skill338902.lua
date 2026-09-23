-- 利兹2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill338902 = oo.class(SkillBase)
function Skill338902:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill338902:OnBefourHurt(caster, target, data)
	-- 338902
	self:tFunc_338902_338907(caster, target, data)
	self:tFunc_338902_338912(caster, target, data)
end
function Skill338902:tFunc_338902_338912(caster, target, data)
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
	-- 8753
	local count753 = SkillApi:BuffCount(self, caster, target,1,4,304500201)
	-- 4304508
	if SkillJudger:Greater(self, caster, target, true,count753,0) then
	else
		return
	end
	-- 9410
	if SkillJudger:TargetType(self, caster, target, true,10) then
	else
		return
	end
	-- 8233
	if SkillJudger:IsCasterMech(self, caster, self.card, true,3) then
	else
		return
	end
	-- 338912
	self:AddTempAttr(SkillEffect[338912], caster, caster, data, "damage2",0.1)
end
function Skill338902:tFunc_338902_338907(caster, target, data)
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
	-- 8753
	local count753 = SkillApi:BuffCount(self, caster, target,1,4,304500201)
	-- 4304508
	if SkillJudger:Greater(self, caster, target, true,count753,0) then
	else
		return
	end
	-- 8246
	if SkillJudger:IsTargetMech(self, caster, target, true,10) then
	else
		return
	end
	-- 8233
	if SkillJudger:IsCasterMech(self, caster, self.card, true,3) then
	else
		return
	end
	-- 338907
	self:AddTempAttr(SkillEffect[338907], caster, caster, data, "damage",0.1)
end
