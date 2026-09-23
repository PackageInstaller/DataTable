-- 狂暴2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4906114 = oo.class(SkillBase)
function Skill4906114:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4906114:OnActionOver(caster, target, data)
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
	-- 8145
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.5) then
	else
		return
	end
	-- 4906115
	self:AddUplimitBuff(SkillEffect[4906115], caster, self.card, data, 3,3,4906114,1,4906114)
end
-- 攻击结束
function Skill4906114:OnAttackOver(caster, target, data)
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
	-- 8145
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.5) then
	else
		return
	end
	-- 4906111
	self:AddProgress(SkillEffect[4906111], caster, self.card, data, 100)
end
