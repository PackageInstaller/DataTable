-- 限制I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill24601 = oo.class(SkillBase)
function Skill24601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill24601:OnAfterHurt(caster, target, data)
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
	-- 24601
	self:HitAddBuff(SkillEffect[24601], caster, target, data, 1500,5104)
	-- 246010
	self:ShowTips(SkillEffect[246010], caster, self.card, data, 2,"限制",true,246010)
end
-- 行动结束
function Skill24601:OnActionOver(caster, target, data)
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
	-- 24611
	self:HitAddBuff(SkillEffect[24611], caster, target, data, 1500,3202)
end
