-- 调节2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill980100902 = oo.class(SkillBase)
function Skill980100902:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 暴击伤害前(OnBefourHurt之前)
function Skill980100902:OnBefourCritHurt(caster, target, data)
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
	-- 980100903
	if self:Rand(7000) then
		self:AddTempAttr(SkillEffect[980100903], caster, caster, data, "crit_rate",-0.4)
	end
end
-- 攻击结束
function Skill980100902:OnAttackOver(caster, target, data)
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
	-- 8580
	local count101 = SkillApi:BuffCount(self, caster, target,1,2,2)
	-- 984000604
	if SkillJudger:Greater(self, caster, target, true,count101,4) then
	else
		return
	end
	-- 980100902
	self:OwnerAddBuffCount(SkillEffect[980100902], caster, self.card, data, 980100902,50,1)
end
