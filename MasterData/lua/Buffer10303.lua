-- 暴擊強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10303 = oo.class(BuffBase)
function Buffer10303:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10303:OnCreate(caster, target)
	-- 4303
	self:AddAttr(BufferEffect[4303], self.caster, target or self.owner, nil,"crit_rate",0.15)
end
