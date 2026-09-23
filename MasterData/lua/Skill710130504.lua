-- 纯白反击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill710130504 = oo.class(SkillBase)
function Skill710130504:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill710130504:OnAttackOver(caster, target, data)
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
	-- 8220
	if SkillJudger:IsCanHurt(self, caster, target, true) then
	else
		return
	end
	-- 710130506
	if SkillJudger:IsSibling(self, caster, target, true,71013) then
	else
		return
	end
	-- 710130507
	if SkillJudger:HasBuff(self, caster, target, true,2,710130302) then
	else
		return
	end
	-- 710130504
	if self:Rand(4000) then
		self:BeatBack(SkillEffect[710130504], caster, self.card, data, nil,14)
	end
end
