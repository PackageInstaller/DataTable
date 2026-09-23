-- 角色釋放大招後，若該次是非傷害技能，則提升自己提高50%傷害，持續1回合。最多疊加2次
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000020130 = oo.class(BuffBase)
function Buffer1000020130:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击结束
function Buffer1000020130:OnAttackOver(caster, target)
	-- 8219
	if SkillJudger:IsUltimate(self, self.caster, target, true) then
	else
		return
	end
	-- 8260
	if SkillJudger:IsCanHurt(self, self.caster, target, false) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000020130
	self:AddBuff(BufferEffect[1000020130], self.caster, self.card, nil, 1000020131)
end
