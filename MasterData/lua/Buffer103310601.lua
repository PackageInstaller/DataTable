-- 103310601_Buff_name##
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer103310601 = oo.class(BuffBase)
function Buffer103310601:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer103310601:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1001
	self:LimitDamage2(BufferEffect[1001], self.caster, target or self.owner, nil,0.05,1)
end
