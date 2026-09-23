-- 夜暝核心技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill941900401 = oo.class(SkillBase)
function Skill941900401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill941900401:OnAfterHurt(caster, target, data)
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
	-- 941900401
	self:HitAddBuffCount(SkillEffect[941900401], caster, target, data, 5000,941900401,1,9)
	-- 8711
	local count711 = SkillApi:GetCount(self, caster, target,2,704500101)
	-- 8923
	if SkillJudger:Greater(self, caster, target, true,count711,8) then
	else
		return
	end
	-- 4704516
	self:LimitDamage(SkillEffect[4704516], caster, target, data, 0.05,1.2)
	-- 4704517
	self:AddBuffCount(SkillEffect[4704517], caster, target, data, 704500101,-1,9)
end
