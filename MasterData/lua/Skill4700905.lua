-- 战意
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4700905 = oo.class(SkillBase)
function Skill4700905:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4700905:OnBefourHurt(caster, target, data)
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
	-- 4700905
	self:AddTempAttr(SkillEffect[4700905], caster, caster, data, "damage",-count18*0.005)
	-- 4700907
	self:ShowTips(SkillEffect[4700907], caster, self.card, data, 2,"战意",true,4700907)
end
-- 攻击结束
function Skill4700905:OnAttackOver(caster, target, data)
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
	-- 4700946
	if self:Rand(7000) then
		self:BeatBack(SkillEffect[4700946], caster, self.card, data, nil,3)
	end
end
-- 行动结束2
function Skill4700905:OnActionOver2(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4700908
	self:AddSp(SkillEffect[4700908], caster, self.card, data, 10)
end
