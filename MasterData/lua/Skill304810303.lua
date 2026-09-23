-- 解限齐射
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill304810303 = oo.class(SkillBase)
function Skill304810303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill304810303:DoSkill(caster, target, data)
	-- 11008
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11008], caster, target, data, 0.125,8)
end
-- 暴击伤害前(OnBefourHurt之前)
function Skill304810303:OnBefourCritHurt(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8684
	local count684 = SkillApi:GetCount(self, caster, target,3,304800101)
	-- 304810301
	self:AddTempAttr(SkillEffect[304810301], caster, self.card, data, "crit",0.05*count684)
end
