-- 我方單位攻擊處於冰凍狀態的怪物時候，根據當前怪物處於的冰凍狀態層數進行增傷，每個狀態增傷8%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000060060 = oo.class(BuffBase)
function Buffer1000060060:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer1000060060:OnBefourHurt(caster, target)
	-- 8449
	local c49 = SkillApi:BuffCount(self, self.caster, target or self.owner,2,2,2)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 1000060060
	self:AddTempAttrPercent(BufferEffect[1000060060], self.caster, self.card, nil, "damage",0.32*c49)
end
