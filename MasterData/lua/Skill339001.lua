-- 利兹4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill339001 = oo.class(SkillBase)
function Skill339001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill339001:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8259
	if SkillJudger:IsLive(self, caster, target, true) then
	else
		return
	end
	-- 8754
	local count754 = SkillApi:BuffCount(self, caster, target,2,4,304500201)
	-- 4304530
	if SkillJudger:Greater(self, caster, target, true,count754,0) then
	else
		return
	end
	-- 339001
	self:Cure(SkillEffect[339001], caster, target, data, 6,0.01)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 9752
	if SkillJudger:IsTargetMech(self, caster, target, true,3) then
	else
		return
	end
	-- 8755
	local count755 = SkillApi:SkillLevel(self, caster, target,3,3045002)
	-- 339006
	if self:Rand(1000) then
		self:AddBuff(SkillEffect[339006], caster, target, data, 304500200+count755)
	end
end
