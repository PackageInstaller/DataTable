-- 解除控制後，該單位下次攻擊時增加30%傷害,持續1回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010070 = oo.class(BuffBase)
function Buffer1000010070:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击结束
function Buffer1000010070:OnAttackOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000010070
	self:AddBuffCount(BufferEffect[1000010070], self.caster, target or self.owner, nil,1000010071,1,1)
end
