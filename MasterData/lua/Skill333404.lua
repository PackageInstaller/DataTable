-- 刺蝽2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill333404 = oo.class(SkillBase)
function Skill333404:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill333404:OnBefourHurt(caster, target, data)
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
	-- 8222
	if SkillJudger:IsDamageType(self, caster, target, true,1) then
	else
		return
	end
	-- 333404
	self:AddTempAttr(SkillEffect[333404], caster, caster, data, "damage",-0.25)
end
-- 死亡时
function Skill333404:OnDeath(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8072
	if SkillJudger:TargetIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 333414
	if self:Rand(8000) then
		self:ExtraRound(SkillEffect[333414], caster, self.card, data, nil)
	end
end
