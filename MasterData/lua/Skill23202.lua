-- 特防II级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill23202 = oo.class(SkillBase)
function Skill23202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill23202:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 23202
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[23202], caster, target, data, "LimitDamage",-0.2,-0.5,0)
	end
end
-- 攻击结束
function Skill23202:OnAttackOver(caster, target, data)
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
	-- 23212
	if self:Rand(2000) then
		self:AddNp(SkillEffect[23212], caster, caster, data, -5)
	end
end
