-- 祝咒
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer703200101 = oo.class(BuffBase)
function Buffer703200101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer703200101:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 703200101
	self:LimitDamage(BufferEffect[703200101], self.caster, target or self.owner, nil,0.03,1.5)
end
