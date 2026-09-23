-- 断罪
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4201204 = oo.class(SkillBase)
function Skill4201204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4201204:OnAttackOver(caster, target, data)
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
	-- 4201204
	self:HitAddBuff(SkillEffect[4201204], caster, target, data, 7000,4201201)
end
