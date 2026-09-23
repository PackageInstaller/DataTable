-- 摩羯座被动技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill983600601 = oo.class(SkillBase)
function Skill983600601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill983600601:OnBefourHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 914100302
	if SkillJudger:IsUltimate(self, caster, target, false) then
	else
		return
	end
	-- 983600601
	self:AddTempAttr(SkillEffect[983600601], caster, self.card, data, "bedamage",(1-count76)*0.2)
end
