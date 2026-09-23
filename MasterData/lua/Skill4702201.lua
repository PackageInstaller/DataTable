-- 炎护
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4702201 = oo.class(SkillBase)
function Skill4702201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill4702201:OnAfterHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8428
	local count28 = SkillApi:BuffCount(self, caster, target,2,3,1002)
	-- 8823
	if SkillJudger:Less(self, caster, self.card, true,count28,1) then
	else
		return
	end
	-- 4702201
	self:HitAddBuff(SkillEffect[4702201], caster, target, data, 1500,1002)
end
-- 入场时
function Skill4702201:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4702206
	self:CallSkillEx(SkillEffect[4702206], caster, self.card, data, 702200501)
end
