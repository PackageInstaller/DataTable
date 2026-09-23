-- 追加猛擊-等級2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10021 = oo.class(BuffBase)
function Buffer10021:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer10021:OnBefourHurt(caster, target)
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
	-- 8262
	if SkillJudger:IsCallSkill(self, self.caster, target, true) then
	else
		return
	end
	-- 4030
	self:AddTempAttr(BufferEffect[4030], self.caster, self.card, nil, "damage",0.2)
end
