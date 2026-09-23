-- 夜暝4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill336004 = oo.class(SkillBase)
function Skill336004:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill336004:OnBefourHurt(caster, target, data)
	-- 8241
	if SkillJudger:IsCasterMech(self, caster, self.card, true,7) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8711
	local count711 = SkillApi:GetCount(self, caster, target,2,704500101)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 336004
	self:AddTempAttr(SkillEffect[336004], caster, target, data, "bedamage",0.025*count711)
end
