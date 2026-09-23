-- 重型兵器
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill316903 = oo.class(SkillBase)
function Skill316903:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill316903:OnAfterHurt(caster, target, data)
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
	-- 8146
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.6) then
	else
		return
	end
	-- 316903
	self:AddUplimitBuff(SkillEffect[316903], caster, self.card, data, 3,3,316903,1,316903)
end
-- 行动结束
function Skill316903:OnActionOver(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8136
	if SkillJudger:OwnerPercentHp(self, caster, target, true,0.6) then
	else
		return
	end
	-- 316913
	self:DelBuff(SkillEffect[316913], caster, self.card, data, 316903)
end
