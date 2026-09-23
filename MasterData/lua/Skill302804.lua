-- 天赋效果302804
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill302804 = oo.class(SkillBase)
function Skill302804:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill302804:OnAttackOver(caster, target, data)
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
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 8459
	local count59 = SkillApi:GetAttr(self, caster, target,2,"defense")
	-- 8319
	self:AddValue(SkillEffect[8319], caster, self.card, data, "fy1",count59)
	-- 302804
	self:RelevanceBuff(SkillEffect[302804], caster, target, data, 8502,8512,3,4500)
	-- 8320
	self:DelValue(SkillEffect[8320], caster, self.card, data, "fy1")
end
