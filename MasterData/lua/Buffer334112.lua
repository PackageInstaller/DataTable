-- 不顯示
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer334112 = oo.class(BuffBase)
function Buffer334112:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer334112:OnBefourHurt(caster, target)
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
	-- 8246
	if SkillJudger:IsTargetMech(self, self.caster, target, true,10) then
	else
		return
	end
	-- 334112
	self:AddTempAttr(BufferEffect[334112], self.caster, self.card, nil, "damage",0.10)
end
