-- 逆流
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100070127 = oo.class(BuffBase)
function Buffer1100070127:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始处理完成后
function Buffer1100070127:OnAfterRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1100070127
	self:LimitDamage3(BufferEffect[1100070127], self.caster, target or self.owner, nil,0.1,0.75)
end
