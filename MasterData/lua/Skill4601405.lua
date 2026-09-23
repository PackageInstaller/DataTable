-- 碎盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4601405 = oo.class(SkillBase)
function Skill4601405:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4601405:OnBefourHurt(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8440
	local count40 = SkillApi:BuffCount(self, caster, target,2,1,14)
	-- 8123
	if SkillJudger:Greater(self, caster, self.card, true,count40,0) then
	else
		return
	end
	-- 4601405
	self:LimitDamage(SkillEffect[4601405], caster, target, data, 0.08,0.96)
	-- 4601406
	self:ShowTips(SkillEffect[4601406], caster, self.card, data, 2,"碎盾",true,4601406)
end
