-- 努特4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill331603 = oo.class(SkillBase)
function Skill331603:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill331603:OnBefourHurt(caster, target, data)
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
	-- 8416
	local count16 = SkillApi:BuffCount(self, caster, target,2,2,2)
	-- 331603
	self:AddTempAttr(SkillEffect[331603], caster, target, data, "bedamage",0.02*count16)
end
