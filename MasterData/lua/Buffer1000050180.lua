-- 對擁有【弱化】效果的單位可以造成額外30%傷害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000050180 = oo.class(BuffBase)
function Buffer1000050180:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer1000050180:OnBefourHurt(caster, target)
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
	-- 1000050092
	if SkillJudger:HasBuff(self, self.caster, target, true,2,1000050091) then
	else
		return
	end
	-- 1000050180
	self:AddTempAttrPercent(BufferEffect[1000050180], self.caster, self.card, nil, "damage",0.67)
end
