-- 灼燒
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1002 = oo.class(BuffBase)
function Buffer1002:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始处理完成后
function Buffer1002:OnAfterRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1002
	self:LimitDamage2(BufferEffect[1002], self.caster, target or self.owner, nil,0.1,1.5)
end
