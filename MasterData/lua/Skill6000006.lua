-- 连锁阵线第一期怪物buff3（针对群体辅助）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6000006 = oo.class(SkillBase)
function Skill6000006:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill6000006:OnBefourHurt(caster, target, data)
	-- 8414
	local count14 = SkillApi:BuffCount(self, caster, target,2,2,1)
	-- 60000062
	if SkillJudger:Greater(self, caster, target, true,count14,3) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 60000061
	self:AddTempAttr(SkillEffect[60000061], caster, self.card, data, "damage",0.6)
end
