-- 追击III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill23803 = oo.class(SkillBase)
function Skill23803:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill23803:OnAfterHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8423
	local count23 = SkillApi:GetAttr(self, caster, target,3,"defense")
	-- 8450
	local count50 = SkillApi:GetAttr(self, caster, target,2,"maxhp")
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
	-- 23803
	self:AddHp(SkillEffect[23803], caster, target, data, -math.min(count23*1.5,count50*0.06))
end
-- 行动开始
function Skill23803:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 238010
	self:ShowTips(SkillEffect[238010], caster, self.card, data, 2,"战神",true,238010)
end
