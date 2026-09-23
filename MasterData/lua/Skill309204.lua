-- 天赋效果309204
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill309204 = oo.class(SkillBase)
function Skill309204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill309204:OnBefourHurt(caster, target, data)
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
	-- 8435
	local count35 = SkillApi:BuffCount(self, caster, target,2,3,3006)
	-- 8118
	if SkillJudger:Greater(self, caster, self.card, true,count35,0) then
	else
		return
	end
	-- 309204
	self:AddTempAttr(SkillEffect[309204], caster, caster, data, "damage",0.25)
end
