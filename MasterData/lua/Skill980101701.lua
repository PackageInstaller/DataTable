-- 暴虐碎星被动4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill980101701 = oo.class(SkillBase)
function Skill980101701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill980101701:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 980101701
	if self:Rand(6000) then
		local targets = SkillFilter:Group(self, caster, target, 4,7)
		for i,target in ipairs(targets) do
			self:AddBuff(SkillEffect[980101701], caster, target, data, 980101701)
		end
	end
end
-- 攻击结束
function Skill980101701:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8241
	if SkillJudger:IsCasterMech(self, caster, self.card, true,7) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 8203
	if SkillJudger:IsSingle(self, caster, target, false) then
	else
		return
	end
	-- 980101702
	self:AddBuff(SkillEffect[980101702], caster, caster, data, 980101703)
end
