-- 致命猎刃
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill313402 = oo.class(SkillBase)
function Skill313402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill313402:OnDeath(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8201
	if SkillJudger:IsSingle(self, caster, target, true) then
	else
		return
	end
	-- 8447
	local count47 = SkillApi:GetOverDamageTotal(self, caster, target,2)
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 313402
	local targets = SkillFilter:MinAttr(self, caster, target, 2,"hp",1)
	for i,target in ipairs(targets) do
		self:AddHp(SkillEffect[313402], caster, target, data, -count47*0.2)
	end
end
