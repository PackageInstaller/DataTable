-- 角色使用大招後，使攻擊力提高8%，持續2回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000050080 = oo.class(BuffBase)
function Buffer1000050080:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击结束
function Buffer1000050080:OnAttackOver(caster, target)
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
	-- 1000050080
	self:OwnerAddBuff(BufferEffect[1000050080], self.caster, self.card, nil, 1000050081)
end
