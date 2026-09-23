-- 战意
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4701005 = oo.class(SkillBase)
function Skill4701005:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4701005:OnBefourHurt(caster, target, data)
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
	-- 4701003
	self:AddTempAttr(SkillEffect[4701003], caster, caster, data, "damage",-count18*0.005)
	-- 4701007
	self:ShowTips(SkillEffect[4701007], caster, self.card, data, 2,"战意",true,4701007)
end
-- 攻击结束
function Skill4701005:OnAttackOver(caster, target, data)
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
	-- 8170
	if SkillJudger:Greater(self, caster, self.card, true,count18,80) then
	else
		return
	end
	-- 8220
	if SkillJudger:IsCanHurt(self, caster, target, true) then
	else
		return
	end
	-- 4701006
	if self:Rand(7000) then
		self:BeatBack(SkillEffect[4701006], caster, self.card, data, nil,3)
	end
end
