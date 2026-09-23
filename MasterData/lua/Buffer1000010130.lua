-- 攻擊時可以降低目標速度，可疊層
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010130 = oo.class(BuffBase)
function Buffer1000010130:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击结束
function Buffer1000010130:OnAttackOver(caster, target)
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
	-- 1000010130
	self:AddBuffCount(BufferEffect[1000010130], self.caster, self.card, nil, 1000010131,1,5)
end
