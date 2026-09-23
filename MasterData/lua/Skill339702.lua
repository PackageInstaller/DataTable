-- 蓝羚2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill339702 = oo.class(SkillBase)
function Skill339702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill339702:OnBefourHurt(caster, target, data)
	-- 339702
	self:tFunc_339702_339707(caster, target, data)
	self:tFunc_339702_339712(caster, target, data)
end
function Skill339702:tFunc_339702_339712(caster, target, data)
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
	-- 8775
	local count775 = SkillApi:BuffCount(self, caster, target,1,4,303000201)
	-- 339716
	if SkillJudger:Greater(self, caster, target, true,count775,0) then
	else
		return
	end
	-- 8965
	if SkillJudger:IsCallSkill(self, caster, target, false) then
	else
		return
	end
	-- 339712
	self:AddTempAttr(SkillEffect[339712], caster, caster, data, "damage",-0.15)
end
function Skill339702:tFunc_339702_339707(caster, target, data)
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
	-- 8775
	local count775 = SkillApi:BuffCount(self, caster, target,1,4,303000201)
	-- 339716
	if SkillJudger:Greater(self, caster, target, true,count775,0) then
	else
		return
	end
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 339707
	self:AddTempAttr(SkillEffect[339707], caster, caster, data, "damage",0.15)
end
