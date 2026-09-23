-- 有加速詞條時，附加30%額外傷害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010190 = oo.class(BuffBase)
function Buffer1000010190:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击开始
function Buffer1000010190:OnAttackBegin(caster, target)
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
	-- 1000010190
	self:AddAttrPercent(BufferEffect[1000010190], self.caster, self.card, nil, "damage",0.30)
end
