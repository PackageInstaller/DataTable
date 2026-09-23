-- 暴擊強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200201303 = oo.class(BuffBase)
function Buffer200201303:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer200201303:OnCreate(caster, target)
	-- 200201303
	self:AddAttr(BufferEffect[200201303], self.caster, target or self.owner, nil,"crit_rate",0.30)
end
