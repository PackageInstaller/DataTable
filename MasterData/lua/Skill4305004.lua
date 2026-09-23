-- 强势反击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4305004 = oo.class(SkillBase)
function Skill4305004:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4305004:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337104
	self:AddBuff(SkillEffect[337104], caster, self.card, data, 337104)
	-- 8725
	local count725 = SkillApi:SkillLevel(self, caster, target,3,3050002)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4305006
	self:CallSkillEx(SkillEffect[4305006], caster, self.card, data, 305000200+count725)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4305004:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337104
	self:AddBuff(SkillEffect[337104], caster, self.card, data, 337104)
end
-- 攻击结束
function Skill4305004:OnAttackOver(caster, target, data)
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
	-- 8244
	if SkillJudger:IsBeatBack(self, caster, target, true) then
	else
		return
	end
	-- 4305004
	self:AddBuff(SkillEffect[4305004], caster, self.card, data, 4305004)
end
