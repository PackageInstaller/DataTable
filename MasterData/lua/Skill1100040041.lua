-- 肉鸽角色攻击时无视速度*3的防御力，使用大招后有概率是怪物增加20%防御力
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100040041 = oo.class(SkillBase)
function Skill1100040041:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100040041:OnBefourHurt(caster, target, data)
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
	-- 8407
	local count7 = SkillApi:GetAttr(self, caster, target,1,"speed")
	-- 1100040041
	self:AddTempAttr(SkillEffect[1100040041], caster, target, data, "defense",-(count7*3))
end
-- 行动结束
function Skill1100040041:OnActionOver(caster, target, data)
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 1100040016
	if self:Rand(6000) then
		self:AddBuff(SkillEffect[1100040016], caster, target, data, 1100040016)
	end
end
