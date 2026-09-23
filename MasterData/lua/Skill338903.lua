-- 利兹2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill338903 = oo.class(SkillBase)
function Skill338903:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill338903:OnBefourHurt(caster, target, data)
	-- 338903
	self:tFunc_338903_338908(caster, target, data)
	self:tFunc_338903_338913(caster, target, data)
end
function Skill338903:tFunc_338903_338908(caster, target, data)
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
	-- 338908
	self:AddTempAttr(SkillEffect[338908], caster, caster, data, "damage",0.15)
end
function Skill338903:tFunc_338903_338913(caster, target, data)
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
	-- 338913
	self:AddTempAttr(SkillEffect[338913], caster, caster, data, "damage2",0.15)
end
