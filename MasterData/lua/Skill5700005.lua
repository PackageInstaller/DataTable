-- 怪物群攻模组技能buff1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5700005 = oo.class(SkillBase)
function Skill5700005:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill5700005:OnDeath(caster, target, data)
	-- 8246
	if SkillJudger:IsTargetMech(self, caster, target, true,10) then
	else
		return
	end
	-- 8467
	local count67 = SkillApi:GetAttr(self, caster, target,2,"hp")
	-- 8190
	if SkillJudger:Less(self, caster, target, true,count67,1) then
	else
		return
	end
	-- 5700051
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddHp(SkillEffect[5700051], caster, target, data, -999999999)
	end
end
