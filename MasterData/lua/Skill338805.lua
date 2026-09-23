-- 瑞泽4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill338805 = oo.class(SkillBase)
function Skill338805:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill338805:OnBefourHurt(caster, target, data)
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
	-- 9727
	local count816 = SkillApi:GetAttr(self, caster, target,1,"defense")
	-- 338805
	self:AddTempAttr(SkillEffect[338805], caster, caster, data, "damage",math.floor(count816/100)*0.02)
end
