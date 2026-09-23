-- 夜暝
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4704501 = oo.class(SkillBase)
function Skill4704501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4704501:OnActionOver(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 4704501
	if self:Rand(1000) then
		self:AddNp(SkillEffect[4704501], caster, self.card, data, 10)
	end
end
-- 伤害后
function Skill4704501:OnAfterHurt(caster, target, data)
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
	-- 4704511
	self:HitAddBuffCount(SkillEffect[4704511], caster, target, data, 2200,704500101,1,9)
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
