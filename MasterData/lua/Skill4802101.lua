-- 炎躯
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4802101 = oo.class(SkillBase)
function Skill4802101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill4802101:OnAfterHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8428
	local count28 = SkillApi:BuffCount(self, caster, target,2,3,1002)
	-- 8823
	if SkillJudger:Less(self, caster, self.card, true,count28,1) then
	else
		return
	end
	-- 4802101
	self:HitAddBuff(SkillEffect[4802101], caster, target, data, 3000,1002,2)
end
-- 攻击结束
function Skill4802101:OnAttackOver(caster, target, data)
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
	-- 4802102
	self:OwnerHitAddBuff(SkillEffect[4802102], caster, caster, data, 10000,1002,3)
end
-- 伤害前
function Skill4802101:OnBefourHurt(caster, target, data)
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
	-- 4802103
	self:AddTempAttr(SkillEffect[4802103], caster, caster, data, "damage",-0.2)
end
