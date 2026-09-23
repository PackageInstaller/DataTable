-- 使用大招時，概率獲得【強化】效果（強化：增加8%的攻擊力，可疊加）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000050020 = oo.class(BuffBase)
function Buffer1000050020:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击结束
function Buffer1000050020:OnAttackOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, self.caster, target, true) then
	else
		return
	end
	-- 1000050020
	self:OwnerAddBuff(BufferEffect[1000050020], self.caster, self.card, nil, 1000050021)
end
