-- 天赋效果308905
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill308905 = oo.class(SkillBase)
function Skill308905:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill308905:OnBefourHurt(caster, target, data)
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
	-- 8432
	local count32 = SkillApi:BuffCount(self, caster, target,2,3,3003)
	-- 8115
	if SkillJudger:Greater(self, caster, self.card, true,count32,0) then
	else
		return
	end
	-- 308905
	self:AddTempAttr(SkillEffect[308905], caster, caster, data, "damage",0.15)
end
