-- 破裂
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill932900601 = oo.class(SkillBase)
function Skill932900601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill932900601:OnAfterHurt(caster, target, data)
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
	-- 932900601
	self:HitAddBuff(SkillEffect[932900601], caster, target, data, 2500,5106,2)
	-- 8451
	local count51 = SkillApi:BuffCount(self, caster, target,2,4,22)
	-- 8129
	if SkillJudger:Greater(self, caster, target, true,count51,0) then
	else
		return
	end
	-- 932900602
	self:HitAddBuff(SkillEffect[932900602], caster, target, data, 2500,1003,2)
end
