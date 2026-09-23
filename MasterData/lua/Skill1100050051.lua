-- 肉鸽虫洞阵营敌方每存在1个负面效果时，角色输出时增加15%攻击力,15%暴击伤害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100050051 = oo.class(SkillBase)
function Skill1100050051:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100050051:OnBefourHurt(caster, target, data)
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
	-- 1100050052
	self:AddTempAttrPercent(SkillEffect[1100050052], caster, self.card, data, "attack",0.15*count16)
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
	-- 1100050053
	self:AddTempAttr(SkillEffect[1100050053], caster, self.card, data, "crit",0.15*count16)
end
