-- 小怪被动：死亡时对全体伤害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill950100601 = oo.class(SkillBase)
function Skill950100601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill950100601:OnDeath(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 950100601
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddHp(SkillEffect[950100601], caster, target, data, -count49*0.3)
	end
end
