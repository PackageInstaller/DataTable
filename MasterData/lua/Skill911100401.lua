-- 触手
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill911100401 = oo.class(SkillBase)
function Skill911100401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill911100401:OnDeath(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 911100401
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[911100401], caster, target, data, 5902)
	end
end
