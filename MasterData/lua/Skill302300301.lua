-- 汲能光束
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill302300301 = oo.class(SkillBase)
function Skill302300301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill302300301:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
-- 行动结束2
function Skill302300301:OnActionOver2(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8474
	local count74 = SkillApi:GetAttr(self, caster, target,2,"sp")
	-- 302300301
	self:AddSp(SkillEffect[302300301], caster, target, data, -math.min(count74,20))
	-- 302300302
	self:AddSp(SkillEffect[302300302], caster, self.card, data, math.min(count74,20))
end
-- 伤害前
function Skill302300301:OnBefourHurt(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8669
	local count669 = SkillApi:GetAttr(self, caster, target,2,"sp")
	-- 8878
	if SkillJudger:Less(self, caster, target, true,count669,20) then
	else
		return
	end
	-- 302300303
	self:AddTempAttr(SkillEffect[302300303], caster, self.card, data, "damage",0.2)
end
