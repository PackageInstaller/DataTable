-- 冕羽4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill300600403 = oo.class(SkillBase)
function Skill300600403:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill300600403:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
-- 伤害前
function Skill300600403:OnBefourHurt(caster, target, data)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
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
	-- 300600401
	self:AddTempAttrPercent(SkillEffect[300600401], caster, target, data, "defense",-1)
end
-- 回合结束时
function Skill300600403:OnRoundOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8080
	if SkillJudger:CasterPercentHp(self, caster, target, true,0.5) then
	else
		return
	end
	-- 300600402
	self:ChangeSkill(SkillEffect[300600402], caster, self.card, data, 1,300600101)
end
