-- 战意
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4700901 = oo.class(SkillBase)
function Skill4700901:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4700901:OnBefourHurt(caster, target, data)
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
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 8223
	if SkillJudger:IsDamageType(self, caster, target, true,2) then
	else
		return
	end
	-- 4700901
	self:AddTempAttr(SkillEffect[4700901], caster, caster, data, "damage",-count18*0.001)
	-- 4700907
	self:ShowTips(SkillEffect[4700907], caster, self.card, data, 2,"战意",true,4700907)
end
-- 攻击结束
function Skill4700901:OnAttackOver(caster, target, data)
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
	-- 8220
	if SkillJudger:IsCanHurt(self, caster, target, true) then
	else
		return
	end
	-- 4700906
	if self:Rand(3000) then
		self:BeatBack(SkillEffect[4700906], caster, self.card, data, nil,3)
	end
end
-- 行动结束2
function Skill4700901:OnActionOver2(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4700908
	self:AddSp(SkillEffect[4700908], caster, self.card, data, 10)
end
