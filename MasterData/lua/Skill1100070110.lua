-- 多队战斗日月队关卡1buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070110 = oo.class(SkillBase)
function Skill1100070110:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100070110:OnBefourHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 1100070103
	if SkillJudger:IsUltimate(self, caster, target, false) then
	else
		return
	end
	-- 1100070101
	self:AddTempAttr(SkillEffect[1100070101], caster, caster, data, "damage",-0.1)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
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
	-- 1100070102
	self:AddTempAttr(SkillEffect[1100070102], caster, self.card, data, "bedamage",0.1)
end
