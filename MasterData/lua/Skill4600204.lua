-- 剑境
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4600204 = oo.class(SkillBase)
function Skill4600204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4600204:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4600214
	self:CallSkillEx(SkillEffect[4600214], caster, target, data, 600200404)
end
-- 伤害后
function Skill4600204:OnAfterHurt(caster, target, data)
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
	-- 8429
	local count29 = SkillApi:BuffCount(self, caster, target,2,3,1003)
	-- 8822
	if SkillJudger:Less(self, caster, self.card, true,count29,1) then
	else
		return
	end
	-- 4600206
	self:HitAddBuff(SkillEffect[4600206], caster, target, data, 3000,1003,2)
end
