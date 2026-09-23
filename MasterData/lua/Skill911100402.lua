-- 触手
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill911100402 = oo.class(SkillBase)
function Skill911100402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill911100402:OnDeath(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 911100402
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[911100402], caster, target, data, 911100402)
	end
end
