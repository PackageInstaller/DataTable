-- 身上有加速buff時，提升20%傷害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010030 = oo.class(BuffBase)
function Buffer1000010030:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer1000010030:OnBefourHurt(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000010031
	if SkillJudger:HasBuff(self, self.caster, target, true,1,1000010010) then
	else
		return
	end
	-- 1000010030
	self:AddAttrPercent(BufferEffect[1000010030], self.caster, self.card, nil, "damage",0.25)
end
