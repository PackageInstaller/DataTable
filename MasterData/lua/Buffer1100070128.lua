-- 限制返還
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100070128 = oo.class(BuffBase)
function Buffer1100070128:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 战斗开始
function Buffer1100070128:OnStart(caster, target)
	do
		-- 1100070128
		self:LimitAddStep(BufferEffect[1100070128], self.caster, target or self.owner, nil,20)
	end
end
