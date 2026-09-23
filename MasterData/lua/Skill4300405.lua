-- 卡尼斯
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4300405 = oo.class(SkillBase)
function Skill4300405:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4300405:OnBefourHurt(caster, target, data)
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
	-- 300400315
	local count300400310 = SkillApi:GetCount(self, caster, target,2,300400310)
	-- 300400316
	local count300400311 = SkillApi:GetCount(self, caster, target,2,300400311)
	-- 300400317
	local count300400312 = SkillApi:GetCount(self, caster, target,2,300400312)
	-- 300400318
	local count300400313 = SkillApi:GetCount(self, caster, target,2,300400313)
	-- 300400319
	local count300400314 = SkillApi:GetCount(self, caster, target,2,300400314)
	-- 4300405
	self:AddTempAttr(SkillEffect[4300405], caster, self.card, data, "damage",0.12*(count300400310+count300400311+count300400312+count300400313+count300400314))
end
