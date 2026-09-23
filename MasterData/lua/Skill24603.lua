-- 限制III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill24603 = oo.class(SkillBase)
function Skill24603:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill24603:OnAfterHurt(caster, target, data)
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
	-- 24603
	self:HitAddBuff(SkillEffect[24603], caster, target, data, 4500,5104)
	-- 246010
	self:ShowTips(SkillEffect[246010], caster, self.card, data, 2,"限制",true,246010)
end
-- 行动结束
function Skill24603:OnActionOver(caster, target, data)
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
	-- 8451
	local count51 = SkillApi:BuffCount(self, caster, target,2,4,22)
	-- 8129
	if SkillJudger:Greater(self, caster, target, true,count51,0) then
	else
		return
	end
	-- 24613
	self:HitAddBuff(SkillEffect[24613], caster, target, data, 4500,3202)
end
