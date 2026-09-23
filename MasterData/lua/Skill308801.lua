-- 天赋效果308801
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill308801 = oo.class(SkillBase)
function Skill308801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill308801:OnBefourHurt(caster, target, data)
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
	-- 8431
	local count31 = SkillApi:BuffCount(self, caster, target,2,4,3002)
	-- 8114
	if SkillJudger:Greater(self, caster, self.card, true,count31,0) then
	else
		return
	end
	-- 308801
	self:AddTempAttr(SkillEffect[308801], caster, caster, data, "damage",0.06)
end
