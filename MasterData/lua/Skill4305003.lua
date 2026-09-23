-- 强势反击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4305003 = oo.class(SkillBase)
function Skill4305003:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4305003:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337103
	self:AddBuff(SkillEffect[337103], caster, self.card, data, 337103)
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
function Skill4305003:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337103
	self:AddBuff(SkillEffect[337103], caster, self.card, data, 337103)
end
-- 攻击结束
function Skill4305003:OnAttackOver(caster, target, data)
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
	-- 4305003
	self:AddBuff(SkillEffect[4305003], caster, self.card, data, 4305003)
end
