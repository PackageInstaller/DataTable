-- 坍陨天赋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill330105 = oo.class(SkillBase)
function Skill330105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill330105:OnBefourHurt(caster, target, data)
	-- 330105
	self:tFunc_330105_330115(caster, target, data)
	self:tFunc_330105_330125(caster, target, data)
end
function Skill330105:tFunc_330105_330115(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8656
	local count656 = SkillApi:BuffCount(self, caster, target,2,4,4404001)
	-- 8862
	if SkillJudger:Greater(self, caster, target, true,count656,0) then
	else
		return
	end
	-- 330115
	self:AddTempAttr(SkillEffect[330115], caster, self.card, data, "damage",0.30)
end
function Skill330105:tFunc_330105_330125(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 8656
	local count656 = SkillApi:BuffCount(self, caster, target,2,4,4404001)
	-- 8862
	if SkillJudger:Greater(self, caster, target, true,count656,0) then
	else
		return
	end
	-- 330125
	self:AddTempAttr(SkillEffect[330125], caster, caster, data, "damage",0.30)
end
