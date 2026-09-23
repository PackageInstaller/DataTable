-- 角色造成的反擊攻擊傷害提高26%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000070030 = oo.class(BuffBase)
function Buffer1000070030:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer1000070030:OnBefourHurt(caster, target)
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
	-- 8244
	if SkillJudger:IsBeatBack(self, self.caster, target, true) then
	else
		return
	end
	-- 1000070030
	self:AddTempAttrPercent(BufferEffect[1000070030], self.caster, self.card, nil, "damage",0.32)
end
