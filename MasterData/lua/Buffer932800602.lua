-- 堅甲
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer932800602 = oo.class(BuffBase)
function Buffer932800602:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer932800602:OnBefourHurt(caster, target)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8263
	if SkillJudger:IsCallSkill(self, self.caster, target, false) then
	else
		return
	end
	-- 932800602
	self:AddTempAttr(BufferEffect[932800602], self.caster, self.card, nil, "bedamage",-0.08*self.nCount)
end
