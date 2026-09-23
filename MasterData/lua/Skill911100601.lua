-- 触手
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill911100601 = oo.class(SkillBase)
function Skill911100601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill911100601:OnAttackOver(caster, target, data)
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 8246
	if SkillJudger:IsTargetMech(self, caster, target, true,10) then
	else
		return
	end
	-- 8467
	local count67 = SkillApi:GetAttr(self, caster, target,2,"hp")
	-- 8190
	if SkillJudger:Less(self, caster, target, true,count67,1) then
	else
		return
	end
	-- 911100601
	self:AddHp(SkillEffect[911100601], caster, self.card, data, -count49)
end
